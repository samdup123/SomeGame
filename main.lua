function love.load()
  love.window.setMode(900, 700)

  myWorld = love.physics.newWorld(0, 550, false)
  myWorld:setCallbacks(beginContact, endContact, preSolve, postSolve)
  sprites = {}
  sprites.coin_sheet = love.graphics.newImage('sprites/coin_sheet.png')
  sprites.player_jump = love.graphics.newImage('sprites/player_jump.png')
  sprites.player_stand = love.graphics.newImage('sprites/player_stand.png')

  require('player')
  require('coin')
  anim8 = require('lib/anim8/anim8')
  tiledWorker = require('lib/tiledWorker/sti')
  Camera = require('lib/hump/camera')
  cam = Camera()

  platforms = {}

  spawnCoin(100, 500)
  spawnCoin(200, 500)

  gameMap = tiledWorker("maps/levelOne.lua")

  for i, obj in pairs(gameMap.layers["platforms"].objects) do
    spawnPlatform(obj.x, obj.y, obj.width, obj.height)
  end

  for i, obj in pairs(gameMap.layers["coins"].objects) do
    spawnCoin(obj.x, obj.y)
  end
end

function love.update(deltaTime)
  myWorld:update(deltaTime)
  playerUpdate(deltaTime)
  gameMap:update(deltaTime)
  coinUpdate(deltaTime)

  cam:lookAt(player.body:getX(), love.graphics.getHeight() / 2)

  for i, coin in ipairs(coins) do
    coin.animation:update(deltaTime)
  end
end

function love.draw()
  cam:attach()

  love.graphics.draw(player.sprite, player.body:getX(), player.body:getY(), nil, player.direction, 1, sprites.player_stand:getWidth() / 2, sprites.player_stand:getHeight() / 2)
  gameMap:drawLayer(gameMap.layers["Tile Layer 1"])

  for i, coin in ipairs(coins) do
    coin.animation:draw(sprites.coin_sheet, coin.x, coin.y, nil, nil, nil, 20.5, 21)
  end

  cam:detach()
end

function love.keypressed(key, scancode, isrepeat)
  if key == 'up' and player.grounded == true then
    player.body:applyLinearImpulse(0, - 2700)
  end
end

function spawnPlatform(x, y, width, height)
  local platform = {}

  platform.body = love.physics.newBody(myWorld, x, y, 'static')
  platform.shape = love.physics.newRectangleShape(width / 2, height / 2, width, height)
  platform.fixture = love.physics.newFixture(platform.body, platform.shape)
  platform.width = width
  platform.height = height

  table.insert(platforms, platform)
end

function beginContact(a, b, coll)
  player.grounded = true
end

function endContact(a, b, coll)
  player.grounded = false
end

function distanceBetween(x1, y1, x2, y2)
  return math.sqrt((y2 - y1)^2 + (x2 - x1)^2)
end
