PlayState = Class{__includes = BaseState}


function PlayState:init()
	self.fruit_1 = Fruit( math.random(1,VIRTUAL_WIDTH), 0-20, 10, 10)
	self.fruit_2 = Fruit( math.random(1,VIRTUAL_WIDTH), 0-20, 10, 10)
  self.fruit_3 = Fruit( math.random(1,VIRTUAL_WIDTH-10), 0-20, 10, 10)

	self.basket_1 = Baskets (104, 238, 32, 50 )
	self.basket_2 = Baskets (240, 238, 32, 50 )
	self.basket_3 = Baskets (376, 238, 32, 50 )

	self.color = math.random(1,3)
  self.scores = false
	self.score = 0
  
end

function PlayState:update(dt)
  
	if self.scores == true then
     self.score = self.score + 1
     self. scores = false

  end
	if self.color == 1 then
      self.fruit_1:update(dt)
  elseif self.color == 2 then
      self.fruit_2:update(dt)
  elseif self.color == 3 then
      self.fruit_3:update(dt)
	end

	if love.keyboard.wasPressed('right') then
		self.dx = SPEED
  elseif love.keyboard.wasPressed('left') then
      self.dx = -SPEED
  else
      self.dx = 0
	end

	if self.fruit_1:collides(self.basket_1) or self.fruit_2:collides(self.basket_2) or self.fruit_3:collides(self.basket_3) then
    GRAVITY = 0

	elseif self.fruit_1:collides(self.basket_2) or self.fruit_1:collides(self.basket_3) or self.fruit_2:collides(self.basket_1) or self.fruit_2:collides(self.basket_3) or self.fruit_3:collides(self.basket_1) or self.fruit_3:collides(self.basket_2) then
		stateMachine:change('fail',{
			score = self.score
		})
		
	end
	if self.fruit_1.y > VIRTUAL_HEIGHT then
		stateMachine:change('fail', {
			score = self.score
		})
  elseif self.fruit_2.y > VIRTUAL_HEIGHT then
		stateMachine:change('fail', {
			score = self.score
		})
  elseif self.fruit_3.y > VIRTUAL_HEIGHT then
		stateMachine:change('fail', {
			score = self.score
		})
	end
	
end
	
function PlayState:render()
	love.graphics.setColor(255/255, 0/255, 0/255, 255/255)
	--if self.timer == 1 then
	self.fruit_1:render()
	self.basket_1:render()
    love.graphics.setColor(0/255, 53/255, 255/255, 255/255)
   -- if self.timer == 2 then
	self.fruit_2:render()
	--end
	self.basket_2:render()
    love.graphics.setColor(0/255, 255/255, 26/255, 255/255)
	--if self.timer == 3 then 
	self.fruit_3:render()
	--end
	self.basket_3:render()

	love.graphics.setFont(scoreFont)
	love.graphics.print('Score: ' .. tostring(self.score), 10, 10)
end