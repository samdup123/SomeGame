coins = {}

function spawnCoin(x, y)
  local coin = {}
  coin.x = x
  coin.y = y
  coin.collected = false

  coin.grid = anim8.newGrid(41, 42, 123, 126)
  coin.animation = anim8.newAnimation(coin.grid('1-3', 1, '1-3', 2, '1-2', 3), 0.08)

  table.insert(coins, coin)
end

function coinUpdate(deltaTime)
  for i, coin in ipairs(coins) do
    -- print(distanceBetween(coin.x, coin.y, player.body:getX(), player.body:getY()))
    if distanceBetween(coin.x, coin.y, player.body:getX(), player.body:getY()) < 50 then
      coin.collected = true
    end
  end

  for i = #coins, 1, - 1 do
    local coin = coins[i]
    if coin.collected then
      table.remove(coins, i)
    end
  end
end
