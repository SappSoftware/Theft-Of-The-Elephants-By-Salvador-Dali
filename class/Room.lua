Room = Class{
  init = function(self,x,y,w,h, room_id)
    self.room_id = room_id
    self.x = x
    self.y = y
    self.w = w
    self.h = h
    self.mask = HC.rectangle(self.x, self.y, self.w, self.h)
    self.background_quad = love.graphics.newQuad(0,0,self.w,self.h, 64,64)
    self.background_image = sprites.museum_background
  end;
  
  draw = function(self)
    love.graphics.draw(self.background_image, self.background_quad, self.x, self.y, 0, 1, 1)
  end;
}