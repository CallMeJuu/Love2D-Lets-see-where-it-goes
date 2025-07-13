
local Class = require('lib.hump.class')
local anim8 = require('lib.anim8')
local Vector = require('lib.hump.vector')

local player = Class{}

function player:init(x , y)
    self.x = x or 0
    self.y = y or 0
    self.speed = 150
    self.dir = 'Down'
    self.state = 'Idle'
    self.move = Vector()
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

    self.anim = self.animation[self.state..'_'..self.dir]
end

function player:update(dt)
    player:movement(dt)
    player:updateAnimation()
    self.anim:update(dt)
end

function player:draw()
    self.anim:draw(self.spriteSheet, self.x, self.y)
end

function player:movement(dt)
    -- Reset movement vector each frame
    self.move = Vector()
    
    -- Check input and set movement direction
    if love.keyboard.isDown('w') or love.keyboard.isDown('up') then
        self.move.y = self.move.y - 1
        self.dir = 'Up'
    end

    if love.keyboard.isDown('s') or love.keyboard.isDown('down') then
        self.move.y = self.move.y + 1
        self.dir = 'Down'
    end

    if love.keyboard.isDown('a') or love.keyboard.isDown('left') then
        self.move.x = self.move.x - 1
        self.dir = 'Left'
    end

    if love.keyboard.isDown('d') or love.keyboard.isDown('right') then
        self.move.x = self.move.x + 1
        self.dir = 'Right'
    end
    
    -- Normalize the movement vector to ensure consistent speed in all directions
    if self.move:len() > 0 then
        self.move = self.move:normalized()
        -- Apply speed and delta time
        self.move = self.move * self.speed * dt
        -- Update player position
        self.x = self.x + self.move.x
        self.y = self.y + self.move.y
    end
end

function player:updateAnimation()
    -- Determine if player is moving
    local isMoving = self.move:len() > 0
    
    -- Update state
    if isMoving then
        self.state = 'Walk'
    else
        self.state = 'Idle'
    end
    
    -- Update animation
    self.anim = self.animation[self.state..'_'..self.dir]
end

return player