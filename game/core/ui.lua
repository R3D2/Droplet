-------------------------------------------------------------------------------------------
-- UI.LUA
-- Samuel Cardoso

-- Third-Party library
local loveframes = require 'lib.loveframes' -- GUI Library
--

local UI = {}

local width, height = love.graphics.getDimensions()

-- CONST
local BUTTON_TYPE = "imagebutton"
local IMG_BUTTON = "/assets/img/button.png"
local IMG_WHITENOTE = "/assets/img/whitenote.png"
local IMG_BLACKNOTE = "/assets/img/blacknote.png"
local IMG_YCOORDINATE = 10
local IMG_YCOORDINATE_BN = 8
local SHAPES = { 'line', 'square', 'circle'}
local NOTES = { 'c', 'cs', 'd', 'ds', 'e', 'f', 'fs', 'g', 'gs', 'a', 'as', 'b'}

function UI:create()
	-- UI
	width, height = love.window.getDimensions()

	local imagebutton = loveframes.Create(BUTTON_TYPE)
	imagebutton:SetImage(IMG_BUTTON)
	imagebutton:SetPos(width-60, IMG_YCOORDINATE)
	imagebutton:SetText("Circle")
	imagebutton:SetClickable(true)
	imagebutton:SizeToImage()
	imagebutton.OnClick = function(object)
    	selected.shape = SHAPES[3]
	end

	local imagebutton = loveframes.Create(BUTTON_TYPE)
	imagebutton:SetImage(IMG_BUTTON)
	imagebutton:SetPos(width-120, IMG_YCOORDINATE)
	imagebutton:SetText("Square")
	imagebutton:SetClickable(true)
	imagebutton:SizeToImage()
	imagebutton.OnClick = function(object)
    	selected.shape = SHAPES[2]
	end

	local imagebutton = loveframes.Create(BUTTON_TYPE)
	imagebutton:SetImage(IMG_BUTTON)
	imagebutton:SetPos(width-180, IMG_YCOORDINATE)
	imagebutton:SetText("Line")
	imagebutton:SetClickable(true)
	imagebutton:SizeToImage()
	imagebutton.OnClick = function(object)
    	selected.shape = SHAPES[1]
	end

	-- B
	local imagebutton = loveframes.Create(BUTTON_TYPE)
	imagebutton:SetImage(IMG_WHITENOTE)
	imagebutton:SetPos(width-240, IMG_YCOORDINATE)
	imagebutton:SetText("")
	imagebutton:SetClickable(true)
	imagebutton:SizeToImage()
	imagebutton.OnClick = function(object)
    	selected.note = NOTES[12]
	end

	-- A
	local imagebutton = loveframes.Create(BUTTON_TYPE)
	imagebutton:SetImage(IMG_WHITENOTE)
	imagebutton:SetPos(width-267, IMG_YCOORDINATE)
	imagebutton:SetText("")
	imagebutton:SetClickable(true)
	imagebutton:SizeToImage()
	imagebutton.OnClick = function(object)
    	selected.note = NOTES[IMG_YCOORDINATE]
	end

	-- G
	local imagebutton = loveframes.Create(BUTTON_TYPE)
	imagebutton:SetImage(IMG_WHITENOTE)
	imagebutton:SetPos(width-294, IMG_YCOORDINATE)
	imagebutton:SetText("")
	imagebutton:SetClickable(true)
	imagebutton:SizeToImage()
	imagebutton.OnClick = function(object)
    	selected.note = NOTES[IMG_YCOORDINATE_BN]
	end

	-- F
	local imagebutton = loveframes.Create(BUTTON_TYPE)
	imagebutton:SetImage(IMG_WHITENOTE)
	imagebutton:SetPos(width-321, IMG_YCOORDINATE)
	imagebutton:SetText("")
	imagebutton:SetClickable(true)
	imagebutton:SizeToImage()
	imagebutton.OnClick = function(object)
    	selected.note = NOTES[6]
	end

	-- E
	local imagebutton = loveframes.Create(BUTTON_TYPE)
	imagebutton:SetImage(IMG_WHITENOTE)
	imagebutton:SetPos(width-348, IMG_YCOORDINATE)
	imagebutton:SetText("")
	imagebutton:SetClickable(true)
	imagebutton:SizeToImage()
	imagebutton.OnClick = function(object)
    	selected.note = NOTES[5]
	end

	-- D	
	local imagebutton = loveframes.Create(BUTTON_TYPE)
	imagebutton:SetImage(IMG_WHITENOTE)
	imagebutton:SetPos(width-375, IMG_YCOORDINATE)
	imagebutton:SetText("")
	imagebutton:SetClickable(true)
	imagebutton:SizeToImage()
	imagebutton.OnClick = function(object)
    	selected.note = NOTES[3]
	end

	-- C
	local imagebutton = loveframes.Create(BUTTON_TYPE)
	imagebutton:SetImage(IMG_WHITENOTE)
	imagebutton:SetPos(width-402, IMG_YCOORDINATE)
	imagebutton:SetText("")
	imagebutton:SetClickable(true)
	imagebutton:SizeToImage()
	imagebutton.OnClick = function(object)
    	selected.note =  NOTES[1]
	end

	-- C#
	local imagebutton = loveframes.Create(BUTTON_TYPE)
	imagebutton:SetImage(IMG_BLACKNOTE)
	imagebutton:SetPos(width-389, IMG_YCOORDINATE_BN)
	imagebutton:SetText("")
	imagebutton:SetClickable(true)
	imagebutton:SizeToImage()
	imagebutton.OnClick = function(object)
    	selected.note = NOTES[2]
	end

	-- Eb
	local imagebutton = loveframes.Create(BUTTON_TYPE)
	imagebutton:SetImage(IMG_BLACKNOTE)
	imagebutton:SetPos(width-360, IMG_YCOORDINATE_BN)
	imagebutton:SetText("")
	imagebutton:SetClickable(true)
	imagebutton:SizeToImage()
	imagebutton.OnClick = function(object)
    	selected.note = NOTES[4]
	end

	-- F#
	local imagebutton = loveframes.Create(BUTTON_TYPE)
	imagebutton:SetImage(IMG_BLACKNOTE)
	imagebutton:SetPos(width-308, IMG_YCOORDINATE_BN)
	imagebutton:SetText("")
	imagebutton:SetClickable(true)
	imagebutton:SizeToImage()
	imagebutton.OnClick = function(object)
    	selected.note = NOTES[7]
	end

	-- G#
	local imagebutton = loveframes.Create(BUTTON_TYPE)
	imagebutton:SetImage(IMG_BLACKNOTE)
	imagebutton:SetPos(width-280, IMG_YCOORDINATE_BN)
	imagebutton:SetText("")
	imagebutton:SetClickable(true)
	imagebutton:SizeToImage()
	imagebutton.OnClick = function(object)
    	selected.note = NOTES[9]
	end

	-- Bb
	local imagebutton = loveframes.Create(BUTTON_TYPE)
	imagebutton:SetImage(IMG_BLACKNOTE)
	imagebutton:SetPos(width-252, IMG_YCOORDINATE_BN)
	imagebutton:SetText("")
	imagebutton:SetClickable(true)
	imagebutton:SizeToImage()
	imagebutton.OnClick = function(object)
    	selected.note = NOTES[11]
	end

	-- UNDO Button
		local imagebutton = loveframes.Create(BUTTON_TYPE)
	imagebutton:SetImage(IMG_BLACKNOTE)
	imagebutton:SetPos(width-252, IMG_YCOORDINATE_BN)
	imagebutton:SetText("")
	imagebutton:SetClickable(true)
	imagebutton:SizeToImage()
	imagebutton.OnClick = function(object)
    	
	end
end

-- Draw the UI
function UI:draw()
	loveframes.draw()
end

-- Updates the UI
function UI:update(dt)
	loveframes.update(dt)
end

-- Event if something in the UI is mousepressed
function UI:mousepressed(x,y, button)
	loveframes.mousepressed(x, y, button)
end

-- Event after something in the UI is mousepressed
function UI:mousereleased(x,y, button)
	loveframes.mousereleased(x, y, button)
end

return UI