Lobby = Class{
  init = function(self, lobbyIndex, lobbyName, lobbyCreator)
    self.lobbyIndex = lobbyIndex
    self.lobbyName = lobbyName
    self.lobbyCreator = lobbyCreator
    self.players = {}
    self.currentPlayer = nil
    self.state = "lobby"
    self.isConnected = false
    self.activeMap = nil
  end;
  
  update = function(self, dt)
    if self.state == "lobby" then
      self:update_lobby(dt)
    elseif self.state == "game" then
      self:update_game(dt)
    else
      
    end
  end;
  
  update_lobby = function(self, dt)
    
  end;
  
  update_game = function(self, dt)
  
  draw = function(self)
    if self.state == "lobby" then
      self:draw_lobby()
    elseif self.state == "game" then
      self:draw_game()
    else
      
    end
  end;
  
  draw_lobby = function(self)
    
  end;
  
  draw_game = function(self)
    
  end;
}
