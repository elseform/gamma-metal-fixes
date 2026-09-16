#include "common.h"
#include "skin.h"
#include "screenspace_mvectors.h"

//////////////////////////////////////////////////////////////////////////////////////////
// Self-illumination pass.
//
// models_selflight.s pairs this vertex shader with accum_emissive.ps, whose
// input is p_flat. The pass is deliberately minimal -- no gbuffer attributes,
// no motion vectors -- but accum_emissive.ps samples tbase(I.tcdh), so
// TEXCOORD0 has to be written. The upstream shader returns v2p_shadow_direct,
// which carries SV_Position only, leaving that input unwritten.
//
// D3D11 tolerates a pixel-shader input the vertex shader never writes (the
// value is undefined), so this is invisible under DXVK and Metal. Metal
// refuses to create the pipeline at all:
//
//   Fragment input(s) `user(reg0_0)` mismatching vertex shader output type(s)
//   or not written by vertex shader
//
// which loses the whole self-lit pass. Writing tcdh, and nothing else, keeps
// the pass as light as upstream intended while making the interface valid.
// tcdh matches p_flat's declaration, including its static-sun variant.
//////////////////////////////////////////////////////////////////////////////////////////

struct	v2p_selflight
{
#if defined(USE_R2_STATIC_SUN) && !defined(USE_LM_HEMI)
	float4	tcdh	: TEXCOORD0;	// Texture coordinates,         w=sun_occlusion
#else
	float2	tcdh	: TEXCOORD0;	// Texture coordinates
#endif
	float4	hpos	: SV_Position;	// Clip-space position         (for rasterization)
};

//////////////////////////////////////////////////////////////////////////////////////////
// Vertex
v2p_selflight _main( v_model	I )
{
	v2p_selflight O;
	float4 hpos = mul( m_WVP, I.P );

	O.hpos = hpos;
	O.hpos.xy = ssfx_taa_jitter(O.hpos);

#if defined(USE_R2_STATIC_SUN) && !defined(USE_LM_HEMI)
	O.tcdh = float4( I.tc.xyyy );	// w unused by accum_emissive
#else
	O.tcdh = I.tc;
#endif

 	return O;
}

/////////////////////////////////////////////////////////////////////////
#ifdef 	SKIN_NONE
v2p_selflight 	main(v_model v) 			{ return _main(v); }
#endif

#ifdef 	SKIN_0
v2p_selflight 	main(v_model_skinned_0 v) 	{ return _main(skinning_0(v)); }
#endif

#ifdef	SKIN_1
v2p_selflight 	main(v_model_skinned_1 v) 	{ return _main(skinning_1(v)); }
#endif

#ifdef	SKIN_2
v2p_selflight 	main(v_model_skinned_2 v) 	{ return _main(skinning_2(v)); }
#endif

#ifdef	SKIN_3
v2p_selflight 	main(v_model_skinned_3 v) 	{ return _main(skinning_3(v)); }
#endif

#ifdef	SKIN_4
v2p_selflight 	main(v_model_skinned_4 v) 	{ return _main(skinning_4(v)); }
#endif

FXVS;
