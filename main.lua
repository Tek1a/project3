push = require 'push'
Class = require 'class'

require 'Fruit'
require 'Baskets'

require 'StateMachine'
require 'BaseState'
require 'StartState'
require 'PlayState'
require 'FailState'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288


SPEED = 50
function love.load()
  
  io.stdout:setvbuf("no")
  print('debug')
  math.randomseed(os.time())
	
	love.graphics.setDefaultFilter('nearest', 'nearest')
	love.window.setTitle('game')
	
	
	mediumFont = love.graphics.newFont('font.ttf', 16)
	scoreFont = love.graphics.newFont('font.ttf', 28)
	
	
	push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
		vsync = true,
		fullscreen = false,
		resizable = true
	
	})
    
    stateMachine = StateMachine {
		['start'] = function() return StartState() end,
		['play'] = function() return PlayState() end,
		['fail'] = function() return FailState() end
	}
	
	stateMachine:change('start')

	love.keyboard.keysPressed = {}
	
end

function love.update(dt)
  
	stateMachine:update(dt)
	
	love.keyboard.keysPressed = {}
end


function love.keypressed(key)
	love.keyboard.keysPressed[key] = true
	
	if key == 'escape' then
		love.event.quit()
	end
end

function love.keyboard.wasPressed(key)
	if love.keyboard.keysPressed[key] then
		return true
	else
		return false
	end
end

    
function love.resize(w, h)
	push:resize(w, h)
end

function love.draw()
	push:start()
	love.graphics.clear(62/255, 229/255, 43/255, 255/255)

	stateMachine:render()
	
	
	
	push:finish()
end
    
