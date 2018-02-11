describe('KeyStatusUpdater', function()

  local mock = require 'mach'
  local KeyStatusUpdater = require '../../src/KeyStatusUpdater/KeyStatusUpdater'
  local dbMock = mock.mock_table(require('../../src/JamGameCommon/src/CentralDataBase/CentralDataBase').init({}))

  it('should update the central data base upon a key press', function()
    local ksu = KeyStatusUpdater(dbMock)
    dbMock.write:should_be_called_with(true, 'key_q'):when(function() ksu.keyPressed('q') end)
  end)

  it('should update the central data base upon a key release', function()
    local ksu = KeyStatusUpdater(dbMock)
    dbMock.write:should_be_called_with(false, 'key_q'):when(function() ksu.keyReleased('q') end)
  end)
end)
