function fullscreen(event)
	hl.on(event, function(_)
		local workspace = hl.get_active_workspace()
		if workspace == nil then return end
		if workspace.windows == 1 then
			hl.dispatch(hl.dsp.window.fullscreen())
		end
	end)
end

local events = {
	"window.open",
	"window.destroy",
}

for _, event in ipairs(events) do
	fullscreen(event)
end

-- hl.on("window.move_to_workspace", function(_, workspace_to)
-- 	-- local workspace_from = hl.get_active_workspace()
-- 	-- if workspace_from == nil then return end
-- 	local win = hl.get_active_window()
-- 	if workspace_to == nil then return end
-- 	hl.notification.create({
-- 		text = workspace_to.windows .. " win name: " .. win.stable_id,
-- 		timeout = 4000
-- 	})
-- 	if workspace_to.windows == 0 then
-- 		-- hl.notification.create({
-- 		-- 	text = "executes",
-- 		-- 	THIS ON EXCECUTES
-- 		-- 	timeout = 4000
-- 		-- })
-- 		hl.dispatch(hl.dsp.window.fullscreen({
-- 			window = win
-- 		}))
-- 	end
-- end)
