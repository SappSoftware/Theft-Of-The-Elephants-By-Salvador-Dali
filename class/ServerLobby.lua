Lobby = Class{
  init = function(self, lobbyIndex, lobbyName, lobbyCreator)
    self.lobbyIndex = lobbyIndex
    self.lobbyName = lobbyName
    self.lobbyCreator = lobbyCreator
    self.peers = {}
    self.players = {}
    self.currentPlayer = nil
    self.isConnected = false
  end;
  
  addPlayer = function(self, player_data)
    
  end;
  
  removePlayer = function(self, player_index)
    
  end;
  
  connectToLobby = function(self, peer)
    
  end;
  
  disconnectFromLobby = function(self, peer)
    
  end;
}