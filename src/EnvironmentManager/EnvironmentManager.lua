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
    requestMovement = function(tagOfEntityToBeMoved, movement)

      local entityToMove = environmentEntities[tagOfEntityToBeMoved]
      local newLocation = {}
      newLocation.x = entityToMove.location.x + movement.deltaX
      newLocation.y = entityToMove.location.y + movement.deltaY

      local xMinForEntityToBeMoved = entityToMove.location.x - entityToMove.width / 2
      local xMaxForEntityToBeMoved = entityToMove.location.x + entityToMove.width / 2
      local yMinForEntityToBeMoved = entityToMove.location.y - entityToMove.height / 2
      local yMaxForEntityToBeMoved = entityToMove.location.y + entityToMove.height / 2

      for tag, entity in pairs(environmentEntities) do
        if tag ~= tagOfEntityToBeMoved then
          local xMinForOtherEntity = entity.location.x - entity.width / 2
          local xMaxForOtherEntity = entity.location.x + entity.width / 2
          local yMinForOtherEntity = entity.location.y - entity.height / 2
          local yMaxForOtherEntity = entity.location.y + entity.height / 2
        end
      end

      entityToMove.location.x = newLocation.x
      entityToMove.location.y = newLocation.y

      return true
    end
  }
end
