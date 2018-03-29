ClientObject = Class{
  init = function(self, ip, port, user_data, registering)
    self.sender = Sock.newClient(ip, port)
    self.sender:setSerialization(Bitser.dumps, Bitser.loads)
    self.user_data = user_data
    self.isRegistering = registering
    self.isConnected = false
    self:setCallbacks()
    self.sender:connect()
    self.lobby = {}
    self.player = {}
  end;
  
  setCallbacks = function(self)
    self.sender:setSchema("playerInfo", {
      "index",
      "username"
    })
    
    self.sender:setSchema("updatePlayer", {
      "x",
      "y",
      "dir",
      "player_id"
    })
    
    self.sender:on("connect", function(data)
      if self.isRegistering then
        self.sender:send("register", self.user_data)
      else
        self.sender:send("login", self.user_data)
      end
    end)
    
    self.sender:on("register", function(data)
      if data == true then
        Gamestate.switch(client_menu)
      else
        self.sender:disconnectNow(1)
      end
    end)
    
    self.sender:on("login", function(data)
      if data == true then
        Gamestate.switch(client_menu)
      else
        self.sender:disconnectNow(1)
      end
    end)
    
    self.sender:on("createLobby", function(data)
      
    end)
    
    self.sender:on("joinLobby", function(data)
      
    end)
    
    self.sender:on("joinMap", function(data)
      self.activeMap = Map(data.map_id, data.players_data)
      self.player = self.activeMap.players[self.user_data.username]
    end)
    
    self.sender:on("updatePlayers", function(data)
      --self.activeMap.players_data = data
    end)
    
    self.sender:on("removePlayer", function(data)
      --self.activeMap:removePlayer(data)
    end)
  end;
  
  update_menu = function(self, dt)
    self.sender:update(dt)
  end;
  
  update_game = function(self, dt, mousePos)
    self.sender:update(dt)
    
    if self.activeMap ~= {} then
      --self.player:update(dt, mousePos)
      
      --self.activeMap:update(dt, self.user_data.username)
      
      --local data = {self.player:getUpdate()}
      self.sender:send("updatePlayer", data)
    end
  end;
  
  keypressed = function(self, key)
    self.player:keypressed(key)
  end;
  
  draw = function(self)
    love.graphics.print(self.sender:getState(), 5, 5)
  end;
  
  draw_game = function(self)
    --self.player:flashlight()
    --self.activeMap:draw(self.player.player_id)
  end;
  
  createLobby = function(self)
    
  end;
  
  joinLobby = function(self)
    
  end;
  
  joinMap = function(self)
    --self.sender:send("joinMap", self.user_data.username)
  end;
  }