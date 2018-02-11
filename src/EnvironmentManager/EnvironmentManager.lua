return function(uneditedEnvironmentEntities)
  local environmentEntities = {}
  for tag, entity in pairs(uneditedEnvironmentEntities) do
    local newEntity = entity
    newEntity.width = entity.image:getWidth()
    newEntity.height = entity.image:getHeight()
    environmentEntities[tag] = newEntity
  end
  return {
    allEntities = function()
      return environmentEntities
    end,
    requestMovement = function(tag, movement)
      local entityToMove = environmentEntities[tag]
      local newLocation = {}
      newLocation.x = entityToMove.location.x + movement.deltaX
      newLocation.y = entityToMove.location.y + movement.deltaY

      entityToMove.location.x = newLocation.x
      entityToMove.location.y = newLocation.y
      return true
    end
  }
end
