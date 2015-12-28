-------------------------------------------------------------------------------------------
-- GRAPHICS.LUA
-- Samuel Cardoso

-- MODULES
Utils = require 'game.core.utils'

Graphics = {}

-- CONST
local GROUND_HEIGHT = 100	-- Ground Height for the physic

-- Get game dimensions
gameWidth,gameHeight = love.graphics.getDimensions()

-- Assets
local imgBackground = love.graphics.newImage('/assets/img/background.png')
local imgGround = love.graphics.newImage('/assets/img/ground.png')
local imgFlowers = love.graphics.newImage('/assets/img/flowers.png')
local imgSun = love.graphics.newImage('/assets/img/sun.png')

-- Calculate how many times we have to draw the background
-- and return a map of x,y coordinates to draw the backgroud
function Graphics:getBackgroundDrawMap()
	bkgdDrawMap = {}

	imgWidth = imgBackground:getWidth()
	imgHeight = imgBackground:getHeight()

	tmpWidth = gameWidth / imgWidth
	tmpHeight = gameHeight / imgHeight

	nbrBackgroundWidth = Utils:round(tmpWidth)
	nbrBackgroundHeight = Utils:round(tmpHeight)
	
	tmpX = 0
	tmpY = 0

	for i=1,nbrBackgroundHeight do
		for j=1,nbrBackgroundWidth do
			bkgdDraw = {}
			bkgdDraw.X = tmpX
			bkgdDraw.Y = tmpY
			table.insert(bkgdDrawMap,bkgdDraw)
			tmpX = tmpX + imgWidth
		end
		tmpX = 0
		tmpY = tmpY + imgHeight
	end

	return bkgdDrawMap
end

-- Calculate how many times we have to draw the ground
-- and return a map of x,y coordinates to draw the ground
function Graphics:getGroundDrawMap()
	grdDrawMap = {}

	imgWidth = imgGround:getWidth()
	imgHeight = imgGround:getHeight()

	tmpY = gameHeight - imgGround:getHeight()
	tmpX = 0

	nbrGroundWidth = Utils:round(gameWidth / imgGround:getWidth())

	for i=1,nbrGroundWidth do
		grdDraw = {}
		grdDraw.X = tmpX
		grdDraw.Y = tmpY
		table.insert(grdDrawMap,grdDraw)
		tmpX = tmpX + imgWidth
	end

	return grdDrawMap
end

function Graphics:getGroundColisionLimit()
	grdLimit = {}

	grdLimit.x1 = 0
	grdLimit.y1 = gameHeight - GROUND_HEIGHT
	grdLimit.x2 = gameWidth
	grdLimit.y2 = gameHeight - GROUND_HEIGHT

	return grdLimit
end

function Graphics:drawBackground(drawMap)
	for i,d in pairs(drawMap) do
		love.graphics.draw(imgBackground,d.X,d.Y)
	end
		love.graphics.draw(imgSun,gameWidth-imgSun:getWidth(),50)
end

function Graphics:drawGround(drawMap)
	for _,d in pairs(drawMap) do
		love.graphics.draw(imgGround,d.X,d.Y)
		love.graphics.draw(imgFlowers,d.X,d.Y)
	end
end

return Graphics