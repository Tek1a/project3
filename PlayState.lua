PlayState = Class{__includes = BaseState}


function PlayState:init()
	self.fruit_1 = Fruit( math.random(1,VIRTUAL_WIDTH), 0, 10, 10)
	self.fruit_2 = Fruit( math.random(1,VIRTUAL_WIDTH), 0, 10, 10)
    self.fruit_3 = Fruit( math.random(1,VIRTUAL_WIDTH-10), 0, 10, 10)

	self.basket_1 = Baskets (104, 238, 32, 50 )
	self.basket_2 = Baskets (240, 238, 32, 50 )
	self.basket_3 = Baskets (376, 238, 32, 50 )

	self.spawntimer = 0
	self.score = 0
end

function PlayState:update(dt)
	
	self.timer = math.random(1,3)
	
	if self.timer == 1 then
        self.fruit_1:update(dt)
    elseif self.timer == 2 then
        self.fruit_2:update(dt)
    elseif self.timer == 3 then
        self.fruit_3:update(dt)
	end

	if fruit_1:collides(busket_1) or fruit_2:collides(busket_2) or fruit_3:collides(busket_3) then
		self.score = self.score + 1
		self.timer = math.random(1,3)
	elseif fruit_1:collides(busket_2) or fruit_1:collides(busket_3) or fruit_2:collides(busket_1) or fruit_2:collides(busket_3) or fruit_3:collides(busket_1) or fruit_3:collides(busket_2) then
		stateMachine:change('fail')
		
	end

	
end
	
function PlayState:render()

	love.graphics.setColor(255/255, 0/255, 0/255, 255/255)
	self.fruit_1:render()
	self.basket_1:render()
    love.graphics.setColor(0/255, 53/255, 255/255, 255/255)
    self.fruit_2:render()
	self.basket_2:render()
    love.graphics.setColor(0/255, 255/255, 26/255, 255/255)
	self.fruit_3:render()
	self.basket_3:render()

end