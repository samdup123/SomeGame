describe('EnvironmentManager', function()
  local mock = require 'mach'

  local imageMock1 = mock.mock_table({getHeight = function() end, getWidth = function() end}, 'image1')

  local EnvironmentManager = require '../../src/EnvironmentManager/EnvironmentManager'

  local entity1 = {image = imageMock1, location = {x = 100, y = 100}}

  function table.clone(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
      copy = {}
      for orig_key, orig_value in next, orig, nil do
        copy[table.clone(orig_key)] = table.clone(orig_value)
      end
      setmetatable(copy, table.clone(getmetatable(orig)))
    else -- number, string, boolean, etc
      copy = orig
    end
    return copy
  end


  it('should be able to initialize with some environment entities and display them', function()
    local em

    imageMock1.getWidth:should_be_called_with(imageMock1):and_also(imageMock1.getHeight:should_be_called_with(imageMock1))
    :when(function() em = EnvironmentManager({['entity1'] = {image = entity1.image, location = table.clone(entity1.location)}}) end)

    assert.are.same(em.allEntities(), {['entity1'] = entity1})
  end)

  it('should be able to request a movement', function()
    local em
    imageMock1.getWidth:should_be_called_with(imageMock1):and_also(imageMock1.getHeight:should_be_called_with(imageMock1))
    :when(function() em = EnvironmentManager({['entity1'] = {image = entity1.image, location = table.clone(entity1.location)}}) end)

    assert.is_true(em.requestMovement('entity1', {deltaX = 100, deltaY = 100}))

    assert.are.same(em.allEntities(), {['entity1'] = {image = entity1.image, location = {x = entity1.location.x + 100, y = entity1.location.y + 100}}})
  end)
end)
