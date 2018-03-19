Burglar = Class{__includes = Player,
  init = function(self, player_id, parentMap, x, y, dir)
    Player.init(self, player_id, parentMap, x, y, dir)
    self.sprite = sprites.burglar
  end;
}