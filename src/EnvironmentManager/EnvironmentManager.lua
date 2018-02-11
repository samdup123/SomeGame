return function(uneditedEnvironmentEntities)
  local environmentEntities = {}
  for tag, entity in pairs(uneditedEnvironmentEntities) do
    local newEntity = entity
    newEntity.width = entity.image.getWidth()
    newEntity.height = entity.image.getHeight()
    environmentEntities[tag] = newEntity
  end
  return {
    allEntities = function() return environmentEntities end
    -- requestMovement = function(entityToMove)
    --   for _, entity in pairs(environmentEntities) do
    --   end
  }
end
