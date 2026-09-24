#include "common.h"
#include "skin.h"
// [elseform] SSS motion-vector helpers (m_wvp_prev, ssfx_jitter).
#include "screenspace_mvectors.h"

struct vf
{
	float4 hpos : SV_Position;
    float2 tc0 : TEXCOORD0;
	float3 T : TEXCOORD1;
	float3 B : TEXCOORD2;
	float3 N : TEXCOORD3;
	float3 P : TEXCOORD4;
	// [elseform] Current/previous clip positions for HUD motion vectors.
	float4 vel_curr : TEXCOORD5;
	float4 vel_prev : TEXCOORD6;
};

vf     _main (v_model v)
{
    vf o;

	o.hpos = mul(m_WVP, v.P);
    o.tc0 = v.tc.xy;
	o.T = mul(m_W, v.T).xyz;
	o.B = mul(m_W, v.B).xyz;
	o.N = mul(m_W, v.N).xyz;
	o.P = mul(m_W, v.P).xyz;

	// [elseform] Jitter like other HUD geometry and pass clip positions for motion vectors,
	// the same way models_reflex_reticle.vs does in this entry.
	o.vel_curr = o.hpos;
	o.vel_prev = mul(m_wvp_prev, v.P);
	o.hpos.xy = ssfx_taa_jitter(o.hpos);

    return o;
}

// Skinning
#ifdef SKIN_NONE
vf main(v_model v) { return _main(v); }
#endif

#ifdef SKIN_0
vf main(v_model_skinned_0 v) { return _main(skinning_0(v)); }
#endif

#ifdef SKIN_1
vf main(v_model_skinned_1 v) { return _main(skinning_1(v)); }
#endif

#ifdef SKIN_2
vf main(v_model_skinned_2 v) { return _main(skinning_2(v)); }
#endif

#ifdef SKIN_3
vf main(v_model_skinned_3 v) { return _main(skinning_3(v)); }
#endif

#ifdef SKIN_4
vf main(v_model_skinned_4 v) { return _main(skinning_4(v)); }
#endif
