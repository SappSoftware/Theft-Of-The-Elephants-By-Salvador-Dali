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
    self.dir = dir or 0
    self.dirLine = {self.pos.x, self.pos.y, self.pos.x + math.cos(self.dir)*self.width/2, self.pos.y + math.sin(self.dir)*self.width/2}
    self.acceleration = Vector(0,0)
    self.velocity = Vector(0,0)
    self.label = Label(self.player_id, self.pos.x, self.pos.y+self.height/4, "center", CLR.BLACK)
    self.mask = HC.rectangle(self.pos.x, self.pos.y, self.width, self.height)
    self.parentZone = parentZone or false
  end;
  
  draw = function(self)
    love.graphics.setColor(CLR.GREY)
    self.mask:draw("fill")
    love.graphics.setColor(CLR.RED)
    self.mask:draw("line")
    love.graphics.line(self.dirLine)
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
      for i, stairway in ipairs(self.parentZone.stairways) do
        stairway:highlight(self.mask)
      end
    end
    
    self.pos = roundTo(nextpos,1)
    self.mask:moveTo(self.pos:unpack())
    if self.dx ~= 0 then
      self.dir = math.atan2(0, self.dx)
    end
    self.dirLine = {self.pos.x, self.pos.y, self.pos.x + math.cos(self.dir)*self.width/2, self.pos.y + math.sin(self.dir)*self.width/2}
    self.label:setposition(self.pos.x, self.pos.y+self.width/4)
  end;
  
  keypressed = function(self, key)
    if key == "w" then
      for i, stairway in ipairs(self.parentZone.stairways) do
        local test = stairway:useDoor()
        if test ~= nil then
          self.pos = test - Vector(0, self.height/2)
          
        end
      end
    end
  end;
  
  flashlight = function(self)
    love.graphics.stencil(function() love.graphics.circle("fill", self.pos.x, self.pos.y, 100) end, "replace", 1)
    love.graphics.setStencilTest("greater", 0)
  end;
  
  updateExt = function(self, x, y, dir)
    self.pos.x = x
    self.pos.y = y
    self.dir = dir
    self.dirLine = {self.pos.x, self.pos.y, self.pos.x + math.cos(self.dir)*self.width/2, self.pos.y + math.sin(self.dir)*self.width/2}
    self.label:setposition(self.pos.x, self.pos.y+self.width/4)
    self.mask:moveTo(self.pos:unpack())
  end;
  
  getUpdate = function(self)
    return self.pos.x, self.pos.y, self.dir, self.player_id
  end;
}