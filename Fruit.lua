Fruit = Class{}

local SPEED = 50
local GRAVITY = 20

function Fruit:init( x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    
    self.dy = 0
    self.dx = 0

end

function Fruit:reset()

    self.x = math.random(1, VIRTUAL_WIDTH - self.width)
    self.y = 0
    self.dy = 0
    self.dx = 0
end    

function Fruit:collides(baskets)
    if self.x > baskets.x + baskets.width or baskets.x > self.x + self.width then 
        return false 
    end
    if self.y > baskets.y + baskets.height or baskets.y > self.y + self.height then
        return false
    end
    return true
end

function Fruit:update(dt)
    self.dy = self.dy + GRAVITY * dt

    if self.dx > 0 then
		self.x = math.min(VIRTUAL_WIDTH - self.width, self.x + self.dx * dt)
	else
		self.x = math.max(0, self.x + self.dx * dt)
	end
	if love.keyboard.wasPressed('right') then
		self.dx = SPEED
    elseif love.keyboard.wasPressed('left') then
        self.dx = -SPEED
    else
        self.dx = 0
	end
end



function Fruit:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end

    