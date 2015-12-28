-------------------------------------------------------------------------------------------
-- MAIN.LUA
-- Samuel Cardoso

-- THIRD-PARTY LIBRARY
require 'lib.AnAL' 												-- Animation Library

-- MODULES
Note = require 'game.objects.note'
Droplet = require 'game.objects.droplet'
UI = require 'game.core.ui'
Graphics = require 'game.core.graphics'

-- DEBUG
io.stdout:setvbuf("no")
	
-- CONST
local SHAPES = { 'line', 'square', 'circle'}
local NOTES = { 'c', 'cs', 'd', 'ds', 'e', 'f', 'fs', 'g', 'gs', 'a', 'as', 'b'}
local DEBITSPEED = 10 											-- seconds
	
-- VARS
selected = { shape = {}, note = {} }							-- User note and shape selection
local list = { notes = {}, droplets = {} } 						-- list of all notes and droplets in the game
local mouse = { selected = {}, selection = { active = false } }	-- all the mouse related variables
local world = {} 												-- Physic World
local initTime = love.timer.getTime()							-- Countdown between dropplet creation
local firstCoordinate = { stored = false, x = {}, y = {} }		-- Firstcoordinate of the line object
local bckgXYMap = {}											-- Map of xy coordinates to draw the background
local gdXYMap = {}												-- Map of xy coordinates to draw the ground

-- Assets
local imgDroplet = love.graphics.newImage("/assets/img/droplet.png")
local imgWaterTape = love.graphics.newImage("/assets/img/watertape.png")

function love.load()
	-- INIT
	selected.note = NOTES[1] 									-- Current selected note
	selected.shape = SHAPES[2]
	nbrNote = 0													-- Count all the notes created on the game
	drawdroplet = false 										-- Toggle the draw of a new dropplet

	-- UI
	UI:create()

	-- GRAPHICS
	-- Generate the x,y 				map for the background and the ground
	bckgXYMap = Graphics:getBackgroundDrawMap()
	gdXYMap = Graphics:getGroundDrawMap()

	-- Water Tape
	watertapeAnim = newAnimation(imgWaterTape, 100, 67, 0.1, 0)

	--- Droplet
	dropletAnim = newAnimation(imgDroplet, 18, 25, 0.1, 0)

	-- Create a world and set the physic of the world
	love.physics.setMeter(64) --- one meter in the real world is 64px for us
	world = love.physics.newWorld(0, 9.81*64, true)

	-- Set callback
	world:setCallbacks(beginContact, endContact, preSolve, postSolve)

	-- Create the first droplet
	obj = Droplet:create(world)
	drawdroplet = false
	table.insert(list.droplets,obj)

	-- Create the ground colision
	GroundPhysic = {}
	grdLimit = {}
	phBody = {}

	grdLimit = Graphics:getGroundColisionLimit()

	phBody = love.physics.newBody(world,0,0,'static')
	print(grdLimit.x1,grdLimit.y1,grdLimit.x2,grdLimit.y2)
	phShape = love.physics.newEdgeShape(grdLimit.x1,grdLimit.y1,grdLimit.x2,grdLimit.y2)
	GroundPhysic.fixture = love.physics.newFixture(phBody, phShape)
	GroundPhysic.fixture:setUserData("Ground")
	GroundPhysic.shape = 'line'
	table.insert(list.notes,GroundPhysic)
end

function love.draw()
	--- GRAPHICS
	Graphics:drawBackground(bckgXYMap)
	Graphics:drawGround(gdXYMap)
	-- UI
	UI:draw()
	-- GAME list
	-- the watertape
	watertapeAnim:draw(0,100)
	-- the droplets
	for _,d in pairs(list.droplets) do
		dropletAnim:draw(d.body:getX(),d.body:getY())
	end

	if drawdroplet then
		obj = Droplet:create(world)
		table.insert(list.droplets,obj)
		drawdroplet = false
		initTime = love.timer.getTime()
	end

	-- Set color of the NOTES
	love.graphics.setColor(0,0,0,100)

	-- the notes
	for id,n in pairs(list.notes) do
		if n.type == 'square' then
			love.graphics.polygon("fill", n.body:getWorldPoints(n.shape:getPoints()))
		elseif n.type == 'circle' then 
			love.graphics.circle("line",n.shape.getWorldPoints(n.shape:getPoints()),n.shape.getRadius())
		elseif n.type == 'line' then
			love.graphics.setLineWidth(3)
			love.graphics.line(n.shape:getPoints())
		end
	end

	-- line
	if firstCoordinate.stored == true then
		mx, my = love.mouse.getPosition()
		love.graphics.setLineWidth(1)
		love.graphics.line(firstCoordinate.x, firstCoordinate.y, mx, my)
	end

	-- reset
	love.graphics.reset()
end

function love.update(dt)
	
	-- CAMERA
	--local dx,dy = .x - cam.x, player.y - cam.y
    --cam:move(dx/2, dy/2)
	
	-- UI
	UI:update(dt)

	-- Le débit, débile...
	local currentTime = love.timer.getTime()

	if currentTime - initTime > DEBITSPEED then
		drawdroplet = true
	end

	-- If the selection is active and the object selected is valid
	-- then we move the object
	if mouse.selection.active and mouse.selected then
		for _,n in pairs(list.notes) do
			if mouse.selected == n.id then
		    	n.body:setX(love.mouse.getX() - n.dragging.diffX)
		    	n.body:setY(love.mouse.getY() - n.dragging.diffY)
	    	end
    	end
  	end

	-- Update the world (Physic)
	world:update(dt)
end

function love.mousepressed(x, y, button)
	UI:mousepressed(x, y, button)
	-- Left click
	-- If the user is selecting an object and dragging him, move it
	if button == "r" then
		for _,n in pairs(list.notes) do
			if x > n.body:getX() and x < n.body:getX() + 20
			and y > n.body:getY() and y < n.body:getY() + 20
			then
				mouse.selection.active = true
				mouse.selected = n.id
			    n.dragging.active = true
			    n.dragging.diffX = x - n.body:getX()
			    n.dragging.diffY = y - n.body:getY()
			end
		end
	else
		if Note:IsDrawable(x,y) then
			-- Left click
			-- if the user was note moving an object then he wants to create an object
			-- Create a circle or a square if it's a line we store the values
			-- waiting for the second coordinate
			if selected.shape == 'square' then
				-- Inc the note counter
				-- Create the note
				nbrNote = nbrNote + 1
				note = Note:create(nbrNote,x,y,0,0,selected.shape,selected.note,world)
			    table.insert(list.notes, note)
			elseif selected.shape == 'circle' then
				-- Inc the note counter
				-- Create the note
				nbrNote = nbrNote + 1
				note = Note:create(nbrNote,x,y,0,0,selected.shape,selected.note,world)
			    table.insert(list.notes, note)
			elseif selected.shape == 'line' and not firstCoordinate.stored then
				-- Store the first coordinate of the line and
				-- notify that we have store the first coordinate
				firstCoordinate.x = x
				firstCoordinate.y = y
				firstCoordinate.stored = true
			end
		end
	end
end

function love.mousereleased(x, y, button)
	UI:mousereleased(x,y,button)
	-- If the user was movin an ob+ject since he has
	-- released the mouse we reset all our variables
	if mouse.selection.active and mouse.selected then
		mouse.selection.active = false
		mouse.selected = nil
  	end

  	-- Draw a line if the firstcoordinate has been stored
  	if firstCoordinate.stored == true and Note:IsDrawable(x,y) then
		nbrNote = nbrNote + 1
		note = Note:create(nbrNote,firstCoordinate.x,firstCoordinate.y,x,y,selected.shape,selected.note,world)
		table.insert(list.notes, note)

		-- Reset
		firstCoordinate.x = 0
		firstCoordinate.y = 0
		firstCoordinate.stored = false
	end
end

function love.quit()
 	print("Thanks for playing! Come back soon!")
end

-- PHYSICS CALLBACKS

function beginContact(a, b, coll)
	if a:getUserData() == 'Ground' then
		-- ANIMATION GROUND
	elseif a:getUserData() == "Droplet" then
		-- Droplet
	else
		Note:PlayNote(a:getUserData())
	end
	
end
 
function endContact(a, b, coll)
 
end
 
function preSolve(a, b, coll)
 
end
 
function postSolve(a, b, coll, normalimpulse1, tangentimpulse1, normalimpulse2, tangentimpulse2)
 
end