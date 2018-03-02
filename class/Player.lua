Player = Class{
  init = function(self, player_id, parentZone, x, y, dir)
    self.player_id = player_id
    self.pos = Vector(x or 0, y or 0)
    self.dx = 0
    self.dy = 0
    self.width = 40
    self.height = 70
    self.speed = 400
    self.accelC = 50
    self.acceleration = Vector(0,0)
    self.velocity = Vector(0,0)
    self.label = Label(self.player_id, self.pos.x, self.pos.y, "center", CLR.BLACK)
    self.mask = HC.rectangle(self.pos.x, self.pos.y, self.radius)
    self.parentZone = parentZone or false
  end;
  
  draw = function(self)
    love.graphics.setColor(CLR.GREY)
    self.mask:draw("fill")
    love.graphics.setColor(CLR.RED)
    self.mask:draw("line")
    self.label:draw()
  end;
  
  update = function(self, dt, mousePos)
    self.dx = 0
    if love.keyboard.isDown("a") then
      self.dx = self.dx - 1
    end
    if love.keyboard.isDown("d") then
      self.dx = self.dx + 1
    end
    if self.dx == 0 then
      self.acceleration = -self.velocity*self.accelC*dt*.3
    else
      self.acceleration.x = self.dx
      self.acceleration:normalizeInplace()
      self.acceleration = self.acceleration*self.accelC*dt
    end
    
    self.velocity = roundTo(self.velocity + self.acceleration, 2)
    
    self.velocity:trimInplace(self.speed*dt)
    local nextpos = Vector(0,0)
    --if self.velocity:len2() ~= 0 then
      nextpos = self.pos + self.velocity
      
      self.mask:moveTo(nextpos:unpack())
      
      if self.parentZone ~= false then
        local diff = Vector(0,0)
        local collides = {}
        local collisionResolved = true
        for i, object in ipairs(self.parentZone.masks) do
          local test, dx, dy = self.mask:collidesWith(object.mask)
          --attempt saving all collisions, resolve as a whole rather than in order
          if test == true then
            collisionResolved = false
            
            local shunt = Vector(dx,dy)
            local length = shunt:len2()
            table.insert(collides, {shunt = shunt, length = length, object = object})
          end
        end
        
        ------------------------METHOD FOUR----------------------------------
        local testCases = {}
        for i, collision in ipairs(collides) do
          local index = 1
          for j, comparison in ipairs(collides) do
            if collision.length < comparison.length then
              index = index + 1
            end
          end
          testCases[index] = collision
        end
        
        for i = 1, 2 do
          for i, collision in ipairs(testCases) do
            local test, dx, dy = self.mask:collidesWith(collision.object.mask)
            if test == true then
              local shunt = Vector(dx,dy)
              nextpos = nextpos + shunt
            end
            self.mask:moveTo(nextpos:unpack())
          end
        end
        ------------------------METHOD FOUR----------------------------------
      end
      
      self.pos = roundTo(nextpos,1)
      self.mask:moveTo(self.pos:unpack())
    self.label:setposition(self.pos.x, self.pos.y)
  end;
  
  updateExt = function(self, x, y, dir)
    self.pos.x = x
    self.pos.y = y
    self.label:setposition(self.pos.x, self.pos.y)
    self.mask:moveTo(self.pos:unpack())
  end;
  
  getUpdate = function(self)
    return self.pos.x, self.pos.y, self.player_id
  end;
}