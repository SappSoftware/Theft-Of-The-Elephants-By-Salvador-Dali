Stairway = Class{
  init = function(self,x1,y1,sprite1, x2,y2,sprite2)
    self.doors = {{},{}}
    self.doors[1].pos = Vector(x1,y1)
    self.doors[1].sprite = sprite1
    self.doors[1].w = self.doors[1].sprite:getWidth()
    self.doors[1].h = self.doors[1].sprite:getHeight()
    self.doors[1].mask = HC.rectangle(x1,y1,self.doors[1].w,self.doors[1].h)
    self.doors[1].offset = Vector(self.doors[1].sprite:getWidth()/2, self.doors[1].sprite:getHeight()/2)
    self.doors[1].isHighlighted = false
    
    self.doors[2].pos = Vector(x2,y2)
    self.doors[2].sprite = sprite2
    self.doors[2].w = self.doors[2].sprite:getWidth()
    self.doors[2].h = self.doors[2].sprite:getHeight()
    self.doors[2].mask = HC.rectangle(x2,y2,self.doors[2].w,self.doors[2].h)
    self.doors[2].offset = Vector(self.doors[2].sprite:getWidth()/2, self.doors[2].sprite:getHeight()/2)
    self.doors[2].isHighlighted = false
  end;
  
  draw = function(self)
    love.graphics.setColor(CLR.WHITE)
    love.graphics.draw(self.doors[1].sprite, self.doors[1].pos.x, self.doors[1].pos.y, 0, 1, 1)
    love.graphics.draw(self.doors[2].sprite, self.doors[2].pos.x, self.doors[2].pos.y, 0, 1, 1)
    if self.doors[1].isHighlighted then
      love.graphics.setColor(CLR.RED)
      self.doors[1].mask:draw()
    end
    if self.doors[2].isHighlighted then
      love.graphics.setColor(CLR.RED)
      self.doors[2].mask:draw()
    end
  end;
  
  highlight = function(self, player)
    for i, stairway in ipairs(self.doors) do
      local test = player:collidesWith(stairway.mask)
      if test == true then
        stairway.isHighlighted = true
      else
        stairway.isHighlighted = false
      end
    end
  end;
  
  useDoor = function(self)
    if self.doors[1].isHighlighted then
      local offset = Vector(self.doors[2].offset.x, self.doors[2].h)
      return self.doors[2].pos+offset
    elseif self.doors[2].isHighlighted then
      local offset = Vector(self.doors[1].offset.x, self.doors[1].h)
      return self.doors[1].pos+offset
    else
      return nil
    end    
  end;
}