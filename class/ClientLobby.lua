Lobby = Class{
  init = function(self, lobbyName, lobbyCreator)
    self.lobbyName = lobbyName
    self.lobbyCreator = lobbyCreator
    self.players = {}
    self.currentPlayer = nil
    self.isConnected = false
  end;
  
  addPlayer = function(self, player_data)
    
  end;
  
  removePlayer = function(self, player_index)
    
  end;
}