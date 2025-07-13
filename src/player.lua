
local Class = require('lib.hump.class')
local anim8 = require('lib.anim8')
local Vector = require('lib.hump.vector')

local player = Class{}

function player:init(x , y)
    self.x = x or 0
    self.y = y or 0
    self.speed = 150
    self.spriteSheet = nil --love.graphics.newImage('graphics/Player/Player.png')

    self.grid = nil

    self.animation = nil

    self.anim = nil
end

function player:load()
    self.spriteSheet = love.graphics.newImage('graphics/Player/Player.png')

    self.grid = anim8.newGrid(32,32,self.spriteSheet:getWidth(), self.spriteSheet:getHeight())

    self.animation = {}

    -- Idle
    self.animation.Idle_Down = anim8.newAnimation('1-6', 1)
    self.animation.Idle_Right = anim8.newAnimation('1-6', 2)
    self.animation.Idle_Left = anim8.newAnimation('1-6', 3)
    self.animation.Idle_Up = anim8.newAnimation('1-6', 4)

    -- Walking
    self.animation.Walk_Down = anim8.newAnimation('1-6', 5)
    self.animation.Walk_Right = anim8.newAnimation('1-6', 6)
    self.animation.Walk_Left = anim8.newAnimation('1-6', 7)
    self.animation.Walk_Up = anim8.newAnimation('1-6', 8)

end

return player