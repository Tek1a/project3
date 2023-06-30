PlayState = Class{__includes = BaseState}

function PlayState:init()
  self.fruit_1_image = love.graphics.newImage('apple.png')
  --self.width_1 = self.fruit_1_image:getWidth()
  --self.height_1 = self.fruit_1_image:getHeight()
  
  self.fruit_2_image= love.graphics.newImage('grapes.png')
  --self.width_2 = self.fruit_2_image:getWidth()
  --self.height_2 = self.fruit_2_image:getHeight()
  
  self.fruit_3_image = love.graphics.newImage('bananas.png')
  --self.width_3 = self.fruit_3_image:getWidth()
 -- self.height_3 = self.fruit_3_image:getHeight()
  

	self.fruit_1 = Fruit( math.random(1,VIRTUAL_WIDTH), 0-40, 10, 10 )--self.width_1, self.height_1)
	self.fruit_2 = Fruit( math.random(1,VIRTUAL_WIDTH), 0-40, 10, 10) --self.width_2, self.height_2)
  self.fruit_3 = Fruit( math.random(1,VIRTUAL_WIDTH), 0-40, 10, 10)-- self.width_3, self.height_3)

	self.basket_1 = Baskets (104, 238, 32, 50 )
	self.basket_2 = Baskets (240, 238, 32, 50 )
	self.basket_3 = Baskets (376, 238, 32, 50 )
  
  self.fruits = {}
	self.color = math.random(1,3)
	self.score = 0
  self.nextfruit = false
end 

function PlayState:update(dt)
	
	if self.color == 1 then
		table.insert(self.fruits, self.fruit_1)
    self.color = 0
  elseif self.color == 2 then
    table.insert(self.fruits, self.fruit_2)
    self.color = 0
  elseif self.color == 3 then
    table.insert(self.fruits, self.fruit_3)
    self.color = 0
	end
  
	for k, pair in pairs(self.fruits) do
    
    if self.fruit_1:collides(self.basket_1) or self.fruit_2:collides(self.basket_2) or self.fruit_3:collides(self.basket_3) then
    pair.remove = true
    end
      
		if pair.remove == true then
			table.remove(self.fruits, k)
       
    end
  
		if pair.scored == false and pair.remove == true then
			self.score = self.score + 1
			pair.scored = true

      
		end
    
    if self.fruit_1:collides(self.basket_2) or self.fruit_1:collides(self.basket_3) or self.fruit_2:collides(self.basket_1) or self.fruit_2:collides(self.basket_3) or self.fruit_3:collides(self.basket_1) or self.fruit_3:collides(self.basket_2) then
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
    
    
		pair:update(dt)
  end
  

	
  
	end

function PlayState:render() 
  
  love.graphics.setColor(255/255, 0/255, 0/255, 255/255)
	for k, pair in pairs(self.fruits) do
		self.fruit_1:render()
	end
	self.basket_1:render()
  
  love.graphics.setColor(0/255, 53/255, 255/255, 255/255)
	for k, pair in pairs(self.fruits) do
		self.fruit_2:render()
	end
  self.basket_2:render()
  
  love.graphics.setColor(0/255, 255/255, 26/255, 255/255)
	for k, pair in pairs(self.fruits) do
		self.fruit_3:render()
	end
	self.basket_3:render()

	love.graphics.setFont(scoreFont)
	love.graphics.print('Score: ' .. tostring(self.score), 10, 10)
end