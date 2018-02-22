local resources = require('src/databaseResources')

function love.load()
  myWorld = love.physics.newWorld(0, 500, false)
  local sprites = {}
  sprites.player = love.graphics.newImage('sprites/player.png')

  tiler = require('lib/tiledWorker/sti')
  gameMap = tiler('maps/mainMap.lua')

  for _, obj in gameMap.layers['objects'].objects do
    print(obj.width)
  end
end

function love.update(deltaTime)

end

function love.draw()

end

function createPlatform(x, y, width, height)
  local platform = {}
  platform.body = love.physics.newBody(myWorld, x, y, "static")
  platform.shape = love.physics.newRectangleShape(width / 2, height / 2, width, height)
  platform.fixture = love.physics.newFixture(platform.body, platform.shape)
  platform.width = width
  platform.height = height

  return platform
end
