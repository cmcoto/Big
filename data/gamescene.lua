module(..., package.seeall)


-- Create the scene
gamescene = director:createScene()
gamescene.name = "gamescene"
gamescene.extents = {0,0,0,0}
gamescene.statics={}	-- Static objects
gamescene.dobs={}	-- Depth objects
-- Calculate CanvasFit scaling factors
gamescene.virtual_width=1024
gamescene.virtual_height=768
local _xs_=director.displayWidth / gamescene.virtual_width
local _ys_=director.displayHeight / gamescene.virtual_height
if (_xs_ < _ys_) then _ys_ = _xs_ else _xs_ = _ys_ end
gamescene.cam_x=-620
gamescene.cam_y=20
gamescene.xScale=1 * _xs_
gamescene.yScale=1 * _ys_
gamescene.vx=0
gamescene.vy=0
gamescene.ignore_actors=true
gamescene.follow_speedx=1
gamescene.follow_speedy=1
gamescene.velocity_dampingx=0.2
gamescene.velocity_dampingy=0.2
gamescene.dragging=false
function gamescene:touch(event)
	goji_quick.sceneTouchPanning(self, event)
end
system:addEventListener("touch", gamescene)
function gamescene:update(event)
	goji_quick.sceneUpdate(self)
end
system:addEventListener("update", gamescene)
physics:setScale(50)
physics:setGravity(0,-500)
physics:setTimeScale(0.999999999999999)
physics:setAllowSleeping(true)

-- Create scene resources
player = director:createRectangle({name="player", strokeWidth=0, x=166, y=374, w=32, h=32, xAnchor=0.5, yAnchor=0.5, color={255,215,0}, isTouchable="false"})
function player:collision(event)
print(event.phase)
	if (event.phase == "began") then
		tween:to(player, { yScale=3, time=0.6, delay=0.1, mode="clamp", easing=ease.expIn} )
	elseif (event.phase == "ended") then
		tween:to(player, { yScale=1, time=0.5, delay=0.2, mode="clamp", easing=ease.expIn} )
	end
end
player:addEventListener("collision", player)
physics:addNode(player, { type="dynamic", density=1, restitution=0.2, friction=0.1})
player.physics:setLinearDamping(1)
tierra = director:createRectangle({name="tierra", strokeWidth=0, x=113, y=106, w=450, h=80, xAnchor=0.5, yAnchor=0.5, color={220,20,60}, isTouchable="false"})
physics:addNode(tierra, { type="static", density=1, restitution=0.1, friction=0.1})
tierra.physics:setLinearDamping(1)
tierra5 = director:createRectangle({name="tierra5", strokeWidth=0, x=553, y=656, w=450, h=80, xAnchor=0.5, yAnchor=0.5, color={220,20,60}, isTouchable="false"})
physics:addNode(tierra5, { type="static", density=1, restitution=0.1, friction=0.1})
tierra5.physics:setLinearDamping(1)
tierra13 = director:createRectangle({name="tierra13", strokeWidth=0, x=3243, y=656, w=450, h=80, xAnchor=0.5, yAnchor=0.5, color={220,20,60}, isTouchable="false"})
physics:addNode(tierra13, { type="static", density=1, restitution=0.1, friction=0.1})
tierra13.physics:setLinearDamping(1)
tierra8 = director:createRectangle({name="tierra8", strokeWidth=0, x=1903, y=656, w=450, h=80, xAnchor=0.5, yAnchor=0.5, color={220,20,60}, isTouchable="false"})
physics:addNode(tierra8, { type="static", density=1, restitution=0.1, friction=0.1})
tierra8.physics:setLinearDamping(1)
tierra3 = director:createRectangle({name="tierra3", strokeWidth=0, x=1453, y=106, w=450, h=80, xAnchor=0.5, yAnchor=0.5, color={220,20,60}, isTouchable="false"})
physics:addNode(tierra3, { type="static", density=1, restitution=0.1, friction=0.1})
tierra3.physics:setLinearDamping(1)
tierra16 = director:createRectangle({name="tierra16", strokeWidth=0, x=2793, y=106, w=450, h=80, xAnchor=0.5, yAnchor=0.5, color={220,20,60}, isTouchable="false"})
physics:addNode(tierra16, { type="static", density=1, restitution=0.1, friction=0.1})
tierra16.physics:setLinearDamping(1)
tierra19 = director:createRectangle({name="tierra19", strokeWidth=0, x=4143, y=106, w=450, h=80, xAnchor=0.5, yAnchor=0.5, color={220,20,60}, isTouchable="false"})
physics:addNode(tierra19, { type="static", density=1, restitution=0.1, friction=0.1})
tierra19.physics:setLinearDamping(1)
tierra2 = director:createRectangle({name="tierra2", strokeWidth=0, x=1003, y=106, w=450, h=80, xAnchor=0.5, yAnchor=0.5, color={65,105,225}, isTouchable="false"})
physics:addNode(tierra2, { type="static", density=1, restitution=0.1, friction=0.1})
tierra2.physics:setLinearDamping(1)
tierra10 = director:createRectangle({name="tierra10", strokeWidth=0, x=2353, y=106, w=450, h=80, xAnchor=0.5, yAnchor=0.5, color={65,105,225}, isTouchable="false"})
physics:addNode(tierra10, { type="static", density=1, restitution=0.1, friction=0.1})
tierra10.physics:setLinearDamping(1)
tierra18 = director:createRectangle({name="tierra18", strokeWidth=0, x=3693, y=106, w=450, h=80, xAnchor=0.5, yAnchor=0.5, color={65,105,225}, isTouchable="false"})
physics:addNode(tierra18, { type="static", density=1, restitution=0.1, friction=0.1})
tierra18.physics:setLinearDamping(1)
tierra4 = director:createRectangle({name="tierra4", strokeWidth=0, x=113, y=656, w=450, h=80, xAnchor=0.5, yAnchor=0.5, color={65,105,225}, isTouchable="false"})
physics:addNode(tierra4, { type="static", density=1, restitution=0.1, friction=0.1})
tierra4.physics:setLinearDamping(1)
tierra12 = director:createRectangle({name="tierra12", strokeWidth=0, x=2793, y=656, w=450, h=80, xAnchor=0.5, yAnchor=0.5, color={65,105,225}, isTouchable="false"})
physics:addNode(tierra12, { type="static", density=1, restitution=0.1, friction=0.1})
tierra12.physics:setLinearDamping(1)
tierra7 = director:createRectangle({name="tierra7", strokeWidth=0, x=1453, y=656, w=450, h=80, xAnchor=0.5, yAnchor=0.5, color={65,105,225}, isTouchable="false"})
physics:addNode(tierra7, { type="static", density=1, restitution=0.1, friction=0.1})
tierra7.physics:setLinearDamping(1)
tierra15 = director:createRectangle({name="tierra15", strokeWidth=0, x=4143, y=656, w=450, h=80, xAnchor=0.5, yAnchor=0.5, color={65,105,225}, isTouchable="false"})
physics:addNode(tierra15, { type="static", density=1, restitution=0.1, friction=0.1})
tierra15.physics:setLinearDamping(1)
tierra1 = director:createRectangle({name="tierra1", strokeWidth=0, x=553, y=106, w=450, h=80, xAnchor=0.5, yAnchor=0.5, color={154,205,50}, isTouchable="false"})
physics:addNode(tierra1, { type="static", density=1, restitution=0.1, friction=0.1})
tierra1.physics:setLinearDamping(1)
tierra9 = director:createRectangle({name="tierra9", strokeWidth=0, x=1903, y=106, w=450, h=80, xAnchor=0.5, yAnchor=0.5, color={154,205,50}, isTouchable="false"})
physics:addNode(tierra9, { type="static", density=1, restitution=0.1, friction=0.1})
tierra9.physics:setLinearDamping(1)
tierra17 = director:createRectangle({name="tierra17", strokeWidth=0, x=3243, y=106, w=450, h=80, xAnchor=0.5, yAnchor=0.5, color={154,205,50}, isTouchable="false"})
physics:addNode(tierra17, { type="static", density=1, restitution=0.1, friction=0.1})
tierra17.physics:setLinearDamping(1)
tierra6 = director:createRectangle({name="tierra6", strokeWidth=0, x=1003, y=656, w=450, h=80, xAnchor=0.5, yAnchor=0.5, color={154,205,50}, isTouchable="false"})
physics:addNode(tierra6, { type="static", density=1, restitution=0.1, friction=0.1})
tierra6.physics:setLinearDamping(1)
tierra14 = director:createRectangle({name="tierra14", strokeWidth=0, x=3693, y=656, w=450, h=80, xAnchor=0.5, yAnchor=0.5, color={154,205,50}, isTouchable="false"})
physics:addNode(tierra14, { type="static", density=1, restitution=0.1, friction=0.1})
tierra14.physics:setLinearDamping(1)
tierra11 = director:createRectangle({name="tierra11", strokeWidth=0, x=2353, y=656, w=450, h=80, xAnchor=0.5, yAnchor=0.5, color={154,205,50}, isTouchable="false"})
physics:addNode(tierra11, { type="static", density=1, restitution=0.1, friction=0.1})
tierra11.physics:setLinearDamping(1)
wall1 = director:createRectangle({name="wall1", strokeWidth=0, x=512, y=384, w=32, h=280, xAnchor=0.5, yAnchor=0.5, color={105,105,105}, isTouchable="false"})
physics:addNode(wall1, { type="static", density=1, restitution=0.1, friction=0.1})
wall1.physics:setLinearDamping(1)
wall2 = director:createRectangle({name="wall2", strokeWidth=0, x=776, y=286, w=32, h=280, xAnchor=0.5, yAnchor=0.5, color={105,105,105}, isTouchable="false"})
physics:addNode(wall2, { type="static", density=1, restitution=0.1, friction=0.1})
wall2.physics:setLinearDamping(1)
gamescene.targetx=player
gamescene.targety=player
