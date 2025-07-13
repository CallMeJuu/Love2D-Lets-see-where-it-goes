
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
    self.spriteSheet = love.graphics.newImage('graphics/player/player.png')

    self.grid = anim8.newGrid(32,32,self.spriteSheet:getWidth(), self.spriteSheet:getHeight())

    self.animation = {}

    -- Idle
    self.animation.Idle_Down = anim8.newAnimation(self.grid('1-6', 1), 0.1)
    self.animation.Idle_Right = anim8.newAnimation(self.grid('1-6', 2), 0.1)
    self.animation.Idle_Left = anim8.newAnimation(self.grid('1-6', 3), 0.1)
    self.animation.Idle_Up = anim8.newAnimation(self.grid('1-6', 4), 0.1)

    -- Walking
    self.animation.Walk_Down = anim8.newAnimation(self.grid('1-6', 5), 0.1)
    self.animation.Walk_Right = anim8.newAnimation(self.grid('1-6', 6), 0.1)
    self.animation.Walk_Left = anim8.newAnimation(self.grid('1-6', 7), 0.1)
    self.animation.Walk_Up = anim8.newAnimation(self.grid('1-6', 8), 0.1)

    self.anim = self.animation.Idle_Down
end

function player:update(dt)
    self.anim:update(dt)
end

function player:draw()
    self.anim:draw(self.spriteSheet, self.x, self.y)
end

return player