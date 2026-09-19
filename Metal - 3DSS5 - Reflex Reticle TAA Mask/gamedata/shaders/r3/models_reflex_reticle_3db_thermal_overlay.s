function normal(shader, t_base, t_second, t_detail)
	shader:begin("models_reflex_reticle", "models_reflex_reticle_3db")
	: fog(true)
	: zb(true, false)
	-- [elseform] Premultiplied alpha: every render target blends by its own output alpha.
	-- The pixel shader outputs colour as (rgb * a, 0), identical to the old additive look, and
	-- HUD motion vectors with alpha = reticle coverage, so they replace the world's vectors only
	-- under the visible reticle instead of being added onto them.
	: blend(true, blend.one, blend.invsrcalpha)
	: aref(true, 1)
	: sorting(2, true)
	: distort(true)
	: scopelense(3)
	shader:dx10texture("s_base", t_base)
	shader:dx10sampler("smp_rtlinear")
end
