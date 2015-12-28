-------------------------------------------------------------------------------------------
-- DROPLET.LUA
-- Samuel Cardoso

Droplet = {}

function Droplet:create(world)
	droplet = {}

	droplet.body = love.physics.newBody(world,87,170,"dynamic")
	droplet.shape = love.physics.newCircleShape(10)
	droplet.fixture = love.physics.newFixture(droplet.body,droplet.shape,1)
	droplet.fixture:setRestitution(0.9)
	droplet.fixture:setUserData("Droplet")
	
	return droplet
end

return Droplet