Lobby = Class{
  init = function(self, lobbyID, lobbyName, lobbyHost)
    self.lobbyID = lobbyID
    self.lobbyName = lobbyName
    self.lobbyHost = lobbyHost
    self.peers = {}
    self.players = {}
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