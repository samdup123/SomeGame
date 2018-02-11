
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
