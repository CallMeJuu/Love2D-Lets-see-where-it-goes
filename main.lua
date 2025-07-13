
local camera = require('lib.hump.camera')
local class = require('lib.hump.class')
local gamestate = require('lib.hump.gamestate')
local timer = require('lib.hump.timer')
local vector = require('lib.hump.vector')
local anim8 = require('lib.anim8')
local sti = require('lib.sti')
local screen = require("lib.sunscreen")

local player = require('src.player')

function love.load()
    -- initiating a retro screen 
    screen:init({
        gameWidth = 480,
        gameHeight = 270,
        mode = "fit", -- Letterbox, pixel-perfect
        debug = false
    })
    -- Filter for Pixel Art
    love.graphics.setDefaultFilter("nearest", "nearest")

    player:init(200, 150)
    player:load()

end

function love.update(dt)
    player:update(dt)
end

function love.draw()
    -- Applying the Initiated Screen
    screen:apply()
    player:draw()
end

-- Love.rezise mousepressed and mousemoved still need to look into 
function love.resize(w, h)
    screen:onResize(w, h)
end

function love.mousepressed(x, y, button, istouch, presses)
    local gameX, gameY = screen:screenToGame(x, y)
    -- Use gameX, gameY for your game logic
end

function love.mousemoved(x, y, dx, dy, istouch)
    local gameX, gameY = screen:screenToGame(x, y)
    local gameDX, gameDY = screen:screenToGame(dx, dy)
    -- Use gameX, gameY, gameDX, gameDY as needed
end