return function(db)

  local function updateKeyInDataBase(key, isPressed)
    db.write(isPressed, 'key_' .. key)
  end

  return {
    keyPressed = function (key) updateKeyInDataBase(key, true) end,
    keyReleased = function (key) updateKeyInDataBase(key, false) end
  }
end
