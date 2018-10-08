-- Put functions in this file to use them in several other scripts.
-- To get access to the functions, you need to put:
-- require "my_directory.my_file"
-- in any script using the functions.

local colyseus_client = require "colyseus.client"
local client
local room

local Module = {}

local screen_x = 640
local screen_y = 1136

local function start (self, go)
  client = colyseus_client.new("ws://5daf6a70.ngrok.io")
	room = client:join("chat")

  -- listen for changes on a path on the state
  room:listen("players/:id/:attribute", function(change)
    -- print(change.operation)
    -- print(change.path.id)
    -- print(change.path.attribute)
    -- print(change.value)
    -- print(change.value)
    -- print(change.value)

    -- self.dir.x
    -- if client.id

    if client.id == change.path.id then
      if change.path.attribute == 'x' then
        self.myNextDir.x = change.value
      elseif change.path.attribute == 'y' then
        self.myNextDir.y = change.value
      end

      print(self.myNextDir)
    else

      if change.path.attribute == 'x' then
        self.oppNextDir.x = screen_x - change.value
      elseif change.path.attribute == 'y' then
        self.oppNextDir.y = screen_y - change.value
      end

      print(self.oppNextDir)
    end

  end)

  return client, room
end

Module.start = start

return Module
