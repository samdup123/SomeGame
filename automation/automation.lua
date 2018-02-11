local main = io.open("/home/samdup/aplace/game/SomeGame/automation/main.lua", "w")
main:write(
  [[

function love.load()
  farts = false
end

function love.keypressed(key)
  farts = true
end

function love.draw()
  if(farts) then
    love.graphics.print('Hello fart World!', 400, 300)
  end
end
]])
io.close(main)
os.execute('love /home/samdup/aplace/game/SomeGame/automation/')
os.execute('sleep', 1000)
love.keypressed('blah')
