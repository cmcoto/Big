require("gamescene")

times = 2

function gamescene.gamescene:touch(event)
--	goji_quick.sceneTouchPanning(self, event)
	if (goji_quick ~= null) then
		if (event.phase == "ended") then
			local physics = gamescene.player.physics
			--if (event.x < gamescene.gamescene.virtual_width / 2) then
				--physics:setLinearVelocity(-400, 700)
			--else
				physics:setLinearVelocity(200, 500)
			--end
		end
	end
end