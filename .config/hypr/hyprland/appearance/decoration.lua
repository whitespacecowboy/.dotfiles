hl.config({
	general = {
		gaps_in          = 2,
		gaps_out         = 1,
		border_size      = 1,

		col              = {
			active_border   = {
				colors = { "rgb(ffffff)" },
				angle = 45
			},
			inactive_border = "rgba(595959aa)",
		},

		resize_on_border = false,
		allow_tearing    = false,
		layout           = "master",
	},


	decoration = {
		rounding         = 1,
		rounding_power   = 1,

		active_opacity   = 1.0,
		inactive_opacity = 1.0,

		shadow           = {
			enabled      = true,
			range        = 4,
			render_power = 3,
			color        = 0xee1a1a1a,
		},

		blur             = {
			enabled  = true,
			size     = 3,
			passes   = 3,
			vibrancy = 1 -- 0.1696,
		},
	},

})
