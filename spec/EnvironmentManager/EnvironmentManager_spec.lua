describe('EnvironmentManager', function()
  local mock = require 'mach'

  local imageMock1 = mock.mock_object({getHeight = function() end, getWidth = function() end}, 'image1')
  local imageMock2 = mock.mock_object({getHeight = function() end, getWidth = function() end}, 'image2')

  local EnvironmentManager = require '../../src/EnvironmentManager/EnvironmentManager'

  local entity1 = {image = imageMock1, location = {x = 100, y = 100}, gravityCollision = true, otherCollision = true}
  local noCollisionEntity = {image = imageMock2, location = {x = 100, y = 200}, gravityCollision = false, otherCollision = false}
  local collisionEntity = {image = imageMock2, location = {x = 100, y = 200}, gravityCollision = false, otherCollision = true}

  function table.clone(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
      copy = {}
      for orig_key, orig_value in next, orig, nil do
        copy[table.clone(orig_key)] = table.clone(orig_value)
      end
      setmetatable(copy, table.clone(getmetatable(orig)))
    else
      copy = orig
    end
    return copy
  end

  function cloned(entity) return {image = entity.image, location = table.clone(entity.location), gravityCollision = entity.gravityCollision, otherCollision = entity.otherCollision} end

  function theHeightAndWidthForThisImageAre(image, height, width)
    return image.getWidth:should_be_called():and_will_return(width):and_also(image.getHeight:should_be_called():and_will_return(height))
  end

  it('should be able to initialize with some environment entities', function()
    local em

    theHeightAndWidthForThisImageAre(imageMock1, 1000, 2000)
    :when(function() em = EnvironmentManager({['entity1'] = cloned(entity1)}) end)

    local entity1IncludingWidthAndHeight = cloned(entity1)
    entity1IncludingWidthAndHeight.height = 1000
    entity1IncludingWidthAndHeight.width = 2000
    assert.are.same(em.allEntities(), {['entity1'] = entity1IncludingWidthAndHeight})
  end)

  it('should be able to request a movement and have that movement occur', function()
    local em

    theHeightAndWidthForThisImageAre(imageMock1, 1, 1)
    :when(function() em = EnvironmentManager({['entity1'] = cloned(entity1)}) end)

    local movementWasCompleted = em.requestMovement('entity1', {deltaX = 100, deltaY = 100})
    assert.is_true(movementWasCompleted)

    assert.are.same(em.allEntities(), {['entity1'] = 
    {image = entity1.image, location = {x = entity1.location.x + 100, y = entity1.location.y + 100}, gravityCollision = true, otherCollision = true, width = 1, height = 1}})
  end)

  it('should make a partial movement until colliding with an object', function()
    local em
    theHeightAndWidthForThisImageAre(imageMock1):and_also(theHeightAndWidthForThisImageAre(imageMock2))
    :when(function() em = EnvironmentManager({['entity1'] = cloned(entity1), ['collisionEntity'] = cloned(collisionEntity)}) end)

    local movementWasCompleted, deltaOfMovementThatTookPlaceIfNotCompleted = em.requestMovement('entity1', {deltaX = 0, deltaY = 100})

    assert.is_false(movementWasCompleted)

    assert.are.same(em.allEntities(), {['entity1'] = {image = entity1.image, location = {x = entity1.location.x + 100, y = entity1.location.y + 100}}})
  end)
end)
