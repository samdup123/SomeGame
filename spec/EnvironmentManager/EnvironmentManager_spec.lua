describe('EnvironmentManager', function()
  local mock = require 'mach'

  local imageMock1 = mock.mock_table({getHeight = function() end, getWidth = function() end}, 'image1')

  local EnvironmentManager = require '../../src/EnvironmentManager/EnvironmentManager'

  local entity1 = {image = imageMock1, location = {x = 100, y = 100}}

  it('should be able to initialize with some ennvironment entities and display them', function()
    local em
    imageMock1.getWidth:should_be_called_with(imageMock1):and_also(imageMock1.getHeight:should_be_called_with(imageMock1))
    :when(function() em = EnvironmentManager({['entity1'] = entity1}) end)
    assert.are.same(em.allEntities(), {['entity1'] = entity1})
  end)

  -- it('should be able to request a movement', function()
  --   local em = EnvironmentManager({['entity1'] = entity1})
  --
  --   em.requestMovement('entity1', {deltaX = 100, deltaY = 100})
  --
  --   assert.are.same(em.allEntities(), {['entity1'] = {image = entity1.image, location = {x = entity1.location.x + 100, y = entity1.location.y + 100}}})
  -- end)
end)
