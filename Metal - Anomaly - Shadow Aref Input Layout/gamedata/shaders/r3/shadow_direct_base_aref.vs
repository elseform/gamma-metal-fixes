#include "common.h"

struct 	a2v
{
	float4	P	: POSITION;		// Object-space position
 	int2	tc0	: TEXCOORD0;	// Texture coordinates
};

// [elseform] Input struct narrowed to the fields this shader actually reads.
//
// Upstream takes `v_static`, which declares NORMAL, TANGENT, BINORMAL,
// TEXCOORD0 (and TEXCOORD1 under USE_LM_HEMI) alongside POSITION, but the body
// only reads P, tc, T.w and B.w -- the normal is never touched. FXC keeps a
// declared vertex input in the signature whether or not it is read, so the
// compiled shader demands NORMAL_0, which the element descriptors for this
// draw do not carry. Under DXMT that makes CreateInputLayout fail:
//
//   warn: CreateInputLayout: Vertex shader expects NORMAL_0 but it's not in
//         input layout element descriptors
//
// X-Ray does not check that HRESULT, so no input layout is bound, and the
// pipeline is later built with stage-in attributes and no vertex descriptor:
//
//   Failed to create PSO: "Vertex function has input attributes but no vertex
//   descriptor was set."
//
// The pass is then lost. Declaring only what the draw supplies keeps the
// signature satisfiable, and a layout carrying elements the shader does not
// declare is harmless -- only missing ones fail.
//
// Two iterations were needed, because DXMT reports only the first missing
// semantic per check: removing the unread NORMAL surfaced TANGENT_0 next. The
// draw carries neither, so TANGENT and BINORMAL are gone too, leaving POSITION
// and TEXCOORD0.
//
// Cost of that second trim: unpack_tc_base's du/dv came from T.w and B.w, the
// sub-texel offsets packed alongside the tangent frame. Without them the base
// texture coordinate loses an offset below one part in 1024 of the tile
// (the unpack scale is 32.0/32768.0) -- irrelevant to an alpha test, which is
// all this pass uses tc for.
//
// Which geometry produces a layout with neither semantic is not yet
// identified. Detail objects match the shape but are ruled out here:
// r2_sun_details is off, deliberately, because Screen Space Shaders 23 owns
// grass and its shadowing. If this trim makes the pass draw in the wrong place
// rather than correctly, the pairing itself is wrong and this override should
// be reverted so the DXMT draw guard keeps suppressing it.
struct	v_shadow_aref_in
{
	int2	tc		:TEXCOORD0;	// (u,v)
	float4	P		:POSITION;	// (float,float,float,1)
};

//////////////////////////////////////////////////////////////////////////////////////////
// Vertex
v2p_shadow_direct_aref main ( v_shadow_aref_in I )
{
	v2p_shadow_direct_aref 		O;
	O.hpos 	= mul				(m_WVP,	I.P		);
	O.tc0 	= unpack_tc_base	(I.tc,0,0		);	// copy tc; du/dv unavailable, see header
#ifndef USE_HWSMAP
	O.depth = O.hpos.z;
#endif
 	return	O;
}
FXVS;
