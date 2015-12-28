-------------------------------------------------------------------------------------------
-- NOTE.LUA
-- Samuel Cardoso

local TEsound = require 'lib.TEsound'

local Note = {}
local width, height = love.graphics.getDimensions()

local nbrNote = {}

local ActionZoneX = width - 450
local ActionZoneY = 80

local TapeZoneX = 150
local TapeZoneY = 200

local PHBODYMODE = "kinematic"

-- Create a note
--- PARAMETERS
-- id : 	id of the note
-- x1 : 	first x coordinate
-- x2 : 	second x coordinate
-- y1 : 	first y coordinate
-- y2 : 	second y coordinate
-- shape :	the shape of the note
-- note :	the note choosed by the user
-- world : 	the physic world where the note belongs
--- RETURN > Object
function Note:create(id,x1,y1,x2,y2,shape,note,world)
	
	local nt = {}

	nt.x1 = x1 or 0
	nt.y1 = y1 or 0
	nt.x2 = x2 or 0
	nt.y2 = y2 or 0
	nt.type = shape
	nt.body = Note:fixBody(world,shape,x1,y1)
	nt.dragging = { active = false, diffX = 0, diffY = 0 }
	nt.shape = Note:fixShape(nt.body,shape,nt.x1,nt.y1,nt.x2,nt.y2)
	nt.fixture = love.physics.newFixture(nt.body, nt.shape)
	nt.fixture:setRestitution(1)
	nt.fixture:setFriction(0)
	nt.fixture:setUserData(note)

	-- Increment the note counter
	--nbrNote = nbrNote + 1;

	return nt
end

-- Create the right physic shape for the shape 
-- to be fixed to is body
--- PARAMETERS
-- shape :	the shape of the note
-- x1 : 	first x coordinate
-- x2 : 	second x coordinate
-- y1 : 	first y coordinate
-- y2 : 	second y coordinate
--- RETURN > Physic Shape
function Note:fixShape(body,shape,x1,y1,x2,y2)
	phShape = {}

	if shape == 'square' then
		phShape = love.physics.newRectangleShape(20,20)
	elseif shape == 'circle' then
		phShape = love.physics.newCircleShape(10)
	elseif shape == 'line' then
		phShape = love.physics.newEdgeShape(x1,y1,x2,y2)
	end

	return phShape
end

function Note:fixBody(world,shape,x1,y1)
	phBody = {}

	if shape == 'square' or shape == 'circle' then
		phBody = love.physics.newBody(world,x1,y1,PHBODYMODE)
	elseif shape == 'line' then
		phBody = love.physics.newBody(world,0,0,PHBODYMODE)
	end

	return phBody
end

function Note:IsDrawable(x,y)
	IsDrawable = {}

	if y > ActionZoneY or x < ActionZoneX then
		if y > TapeZoneY or x > TapeZoneX then
			IsDrawable = true
		else
			IsDrawable = false
		end
	else
		IsDrawable = false
	end

	return IsDrawable
end

function Note:PlayNote(note)
	local soundData = {}
	soundData = love.sound.newSoundData("/assets/sounds/"..note..".ogg")
	TEsound.play(soundData)
end


return Note