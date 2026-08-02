local mainMod = "MOD1"

hl.config({
	master = {
		mfact = 0.5
	}
})

hl.bind(
	mainMod .. " + semicolon",
	hl.dsp.layout("rollnext"),
	{ repeating = true }
)

hl.bind(
	mainMod .. " + comma",
	hl.dsp.layout("rollprev"),
	{ repeating = true }
)

hl.bind(
	mainMod .. " + O",
	hl.dsp.submap("Orientation"),
	{ submap_universal = true }
)

hl.define_submap("Orientation", function ()
	hl.bind("H", hl.dsp.layout("orientationleft"))
	hl.bind("J", hl.dsp.layout("orientationbottom"))
	hl.bind("K", hl.dsp.layout("orientationtop"))
	hl.bind("L", hl.dsp.layout("orientationright"))
	hl.bind("C", hl.dsp.layout("orientationcenter"))
	hl.bind("N", hl.dsp.layout("orientationnext"))
	hl.bind("SHIFT + N", hl.dsp.layout("orientationprev"))

	hl.bind("catchall", hl.dsp.submap("Orientation"))
	hl.bind("I", hl.dsp.submap("reset"))
end)
