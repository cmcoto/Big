module(..., package.seeall)

AudioEnabled = true

-----------------------------------------------------------------------------------------------------------------------------------------
--
-- Scene touch panning handler
--
function sceneTouchPanning(_scene, event)
	if (event.phase == "began") then
		if (_scene.current_focus == nil) then
			_scene.touch_pos_x = event.x
			_scene.touch_pos_y = event.y
		end
	elseif (event.phase == "moved") then
		if (_scene.current_focus == nil) then
			if (_scene.pan_x) then
				_scene.vx = -(_scene.touch_pos_x - event.x)
				_scene.cam_x = _scene.cam_x + _scene.vx
				_scene.touch_pos_x = event.x
			end
			if (_scene.pan_y) then
				_scene.vy = -(_scene.touch_pos_y - event.y)
				_scene.cam_y = _scene.cam_y + _scene.vy
				_scene.touch_pos_y = event.y
			end
--			if (_scene.pan_x or _scene.pan_y) then
--				keepCameraInsideExtents(_scene)
--				sceneUpdateCamera(_scene)
--			end
			_scene.dragging=true
		else
			-- Drag focus object
			local _actor = _scene.current_focus
			if (_actor.dockx == nil) then
				_actor.x = _actor.x + (event.x - _actor.x * _scene.xScale) - _actor.touch_start_dx
				_actor.ox = _actor.x + _scene.cam_x
			end
			if (_actor.docky == nil) then
				_actor.y = _actor.y + (event.y - _actor.y * _scene.yScale) - _actor.touch_start_dy
				_actor.oy = _actor.y + _scene.cam_y
			end
		end
	elseif (event.phase == "ended") then
		if (_scene.dragging) then
			_scene.vx = _scene.vx * 60
			_scene.vy = _scene.vy * 60
		end
		_scene.current_focus = nil
		_scene.dragging=false
	end
end

--
-- Scene follow target
--
function sceneFollowTarget(_scene)
	if (_scene.targetx ~= nil) then
		local cx = _scene.virtual_width / 2
		if (_scene.follow_speedx == 0) then
			_scene.cam_x = (-_scene.targetx.x + cx)
			_scene.vx = 0
		else
			_scene.vx = _scene.vx + ((-_scene.targetx.x + cx) - _scene.cam_x / _scene.xScale) * _scene.follow_speedx
		end
	end
	if (_scene.targety ~= nil) then
		local cy = _scene.virtual_height / 2
		if (_scene.follow_speedy == 0) then
			_scene.cam_y = (-_scene.targety.y + cy)
			_scene.vy = 0
		else
			_scene.vy = _scene.vy + ((-_scene.targety.y + cy) - _scene.cam_y / _scene.yScale) * _scene.follow_speedy
		end
	end
end

--
-- Scene update camera handler
--
function sceneUpdateCamera(_scene)
	for index,actor in ipairs(_scene.statics) do
		actor.x = actor.ox - _scene.cam_x / _scene.xScale
		actor.y = actor.oy - _scene.cam_y / _scene.yScale
	end
	local cx = director.displayWidth / 2
	local cy = director.displayHeight / 2
	for index,actor in ipairs(_scene.dobs) do
		local ooa = 1 / actor.depth
		actor.xScale = actor.oxScale * ooa
		actor.yScale = actor.oyScale * ooa
		actor.x = (actor.ox + _scene.cam_x - cx) * ooa + cx - _scene.cam_x
		actor.y = (actor.oy + _scene.cam_y - cy) * ooa + cy - _scene.cam_y
	end
end

--
-- Keep camera within scene extents
--
function keepCameraInsideExtents(_scene)
	if (_scene.virtual_width <= _scene.extents[3] and _scene.virtual_height <= _scene.extents[4]) then
		local cx = director.displayWidth / 2
		local left = _scene.extents[1] * _scene.xScale + cx
		local right = (_scene.extents[1] + _scene.extents[3]) * _scene.xScale - cx
		if (_scene.cam_x < left) then
			_scene.cam_x = left
			_scene.vx = 0
		end
		if (_scene.cam_x > right) then
			_scene.cam_x = right
			_scene.vx = 0
		end
		local cy = director.displayHeight / 2
		local top = _scene.extents[2] * _scene.yScale + cy
		local bottom = (_scene.extents[2] + _scene.extents[4]) * _scene.yScale - cy
		if (_scene.cam_y < top) then
			_scene.cam_y = top
			_scene.vy = 0
		end
		if (_scene.cam_y > bottom) then
			_scene.cam_y = bottom
			_scene.vy = 0
		end
	end
end

--
-- Update the scene
--
function sceneUpdate(_scene)
	local dt = system.deltaTime
	if (_scene.dragging == false) then
		local update_camera = false
		sceneFollowTarget(_scene)
		update_camera = true
		if (_scene.vx ~= 0) then
			_scene.cam_x = _scene.cam_x + _scene.vx * dt
			_scene.vx = _scene.vx * _scene.velocity_dampingx
			update_camera = true
		end
		if (_scene.vy ~= 0) then
			_scene.cam_y = _scene.cam_y + _scene.vy * dt
			_scene.vy = _scene.vy * _scene.velocity_dampingy
			update_camera = true
		end
--		keepCameraInsideExtents(_scene)
--		if (update_camera) then
--			sceneUpdateCamera(_scene)
--		end
	else
		if (_scene.vx ~= 0) then
			_scene.cam_x = _scene.cam_x + _scene.vx * dt
			_scene.vx = _scene.vx * _scene.velocity_dampingx
		end
		if (_scene.vy ~= 0) then
			_scene.cam_y = _scene.cam_y + _scene.vy * dt
			_scene.vy = _scene.vy * _scene.velocity_dampingy
		end
--		sceneUpdateCamera(_scene)
	end
	keepCameraInsideExtents(_scene)
	sceneUpdateCamera(_scene)
	_scene.x = _scene.cam_x + (director.displayWidth - (_scene.virtual_width * _scene.xScale)) / 2
	_scene.y = _scene.cam_y + (director.displayHeight - (_scene.virtual_height * _scene.yScale)) / 2
end

--
-- Draggable actor handler
--
function actorUpdateDraggable(_actor, _scene, event)
	if (_scene.ignore_actors) then
		return
	end
	if (event.phase == "began") then
		_scene.current_focus = _actor
		_actor.touch_start_dx = (event.x - _actor.x * _scene.xScale)
		_actor.touch_start_dy = (event.y - _actor.y * _scene.yScale)
	elseif (event.phase == "moved") then
	elseif (event.phase == "ended") then
	end
end

--
-- Actor physics handler
--
function actorUpdatePhysics(_actor, _scene)
	if (_actor.clipping) then
		-- Update clipping so that it follows the actor
		_actor.clipX = _actor.x - (_actor.w / 2) + _actor.clip_marginx + _scene.cam_x
		_actor.clipY = _actor.y - (_actor.h / 2) + _actor.clip_marginy + _scene.cam_y
	end
	if (_actor.physics == nil) then
		-- Apply velocities
		local dt = system.deltaTime
		if (_actor.vr ~= nil) then
			_actor.rotation = _actor.rotation + _actor.vr * dt
			_actor.vr = _actor.vr * _actor.vrDamping
		end
		if (_actor.vx ~= nil) then
			_actor.x = _actor.x + _actor.vx * dt
			_actor.vx = _actor.vx * _actor.vxDamping
		end
		if (_actor.vy ~= nil) then
			_actor.y = _actor.y + _actor.vy * dt
			_actor.vy = _actor.vy * _actor.vyDamping
		end
	end
	if (_actor.wrap_position) then
		-- Wrap position with extents of scene
		local cx = _scene.virtual_width / 2
		local cy = _scene.virtual_height / 2
		local left = _scene.extents[1] + cx
		local right = (left + _scene.extents[3])
		local top = -_scene.extents[2] + cy
		local bottom = (top - _scene.extents[4])
		if (_actor.x < left) then
			_actor.x = right
		elseif (_actor.x > right) then
			_actor.x = left
		end
		if (_actor.y > top) then
			_actor.y = bottom
		elseif (_actor.y < bottom) then
			_actor.y = top
		end
	end
end

--
-- Basic test to see if sprites overlap
--
function spritesOverlap(s1, s2)
	local w1 = s1.w
	local h1 = s1.h
	local w2 = s2.w
	local h2 = s2.h
	-- TODO: Fix for origin
	local x1 = s1.x - w1 / 2
	local y1 = s1.y - h1 / 2
	local x2 = s2.x - w2 / 2
	local y2 = s2.y - h2 / 2
	return not ((y1 + h1 < y2) or (y1 > y2 + h2) or (x1 > x2 + w2) or (x1 + w1 < x2))
end

--
-- reverse a shape
--
function reverseShape(shp)
    local size = #shp
    local nt = {}
	local src = size - 1
	local dst = 1
	for index=1,size / 2 do
		nt[dst] = shp[src]
		nt[dst+1] = shp[src+1]
		dst = dst + 2
		src = src - 2
	end

    return nt
end

--
-- convert to lines
--
function convertToLines(geom)
    local nt = {}
	for k,v in ipairs(geom) do
		nt[k] = v
	end
	table.insert(nt, geom[1])
	table.insert(nt, geom[2])
    return nt
end

