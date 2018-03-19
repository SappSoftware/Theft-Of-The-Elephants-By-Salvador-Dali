Map = Class{
  init = function(self, map_id, players_data)
    self.players_data = players_data
    self.players = self:initializePlayers()
    self.npcs = {}
    self.map_id = map_id
    self.walls = self:initializeWalls(map_id)
    self.stairways = self:initializeStairways(map_id)
    self.rooms = self:initializeRooms(map_id)
    self.isConnected = true
  end;
  
  initializePlayers = function(self)
    local returnTable = {}
    for index, player_data in pairs(self.players_data) do
      returnTable[index] = Player(player_data.player_id, self, player_data.x, player_data.y, player_data.dir)
    end
    return returnTable
  end;
  
  initializeWalls = function(self, map_id)
    local walls = {}
    for i, data in ipairs(MAPS[map_id].walls) do
      local box = Wall(data.x, data.y, data.w, data.h, data.rot)
      table.insert(walls, box)
    end
    return walls
  end;
  
  initializeStairways = function(self, map_id)
    local stairways = {}
    for i, data in ipairs(MAPS[map_id].stairways) do
      local stairway = Stairway(data.x1, data.y1, sprites[data.sprite1], data.x2, data.y2, sprites[data.sprite2])
      table.insert(stairways, stairway)
    end
    return stairways
  end;
  
  initializeRooms = function(self, map_id)
    local rooms = {}
    for i, data in ipairs(MAPS[map_id].rooms) do
      local room = Room(data.x,data.y,data.w,data.h, i)
      table.insert(rooms, room)
    end
    return rooms
  end;
  
  draw = function(self, player_id)
    love.graphics.setColor(CLR.WHITE)
    
    for i, room in ipairs(self.rooms) do
      room:draw()
    end
    
    love.graphics.setColor(CLR.GREY)
    for i, wall in ipairs(self.walls) do
      wall:draw()
    end
    
    for i, stairway in ipairs(self.stairways) do
      stairway:draw()
    end
    
    for i, player in pairs(self.players) do
      if i ~= player_id then
        player:draw()
      end
    end
    
    if player_id ~= nil then
      self.players[player_id]:draw()
    end
    
    for i, npc in pairs(self.npcs) do
      npc:draw()
    end
  end;
  
  update = function(self, dt, player_index)
    for index, player_data in pairs(self.players_data) do
      if index ~= player_index then
        self:updatePlayer(player_data, index)
      end
    end
  end;
  
  updatePlayer = function(self, data, index)
    if self.players[index] ~= nil then
      self.players[index]:updateExt(data.x, data.y, data.dir)
    else
      self:instantiatePlayer(data, index)
    end
  end;
  
  addPlayer = function(self, player, index)
    local data = {x = player.pos.x, y = player.pos.y, dir = player.dir, player_id = player.player_id}
    player.activeMap = self
    self.players_data[index] = data
    self.players[index] = player
  end;
  
  instantiatePlayer = function(self, data, index)
    local player = Player(data.player_id, self, data.x, data.y, data.dir)
    self.players[index] = player
  end;
  
  removePlayer = function(self, index)
    if self.players[index] ~= nil then
      self.players_data[index] = nil
      self.players[index] = nil
    end
  end;
}