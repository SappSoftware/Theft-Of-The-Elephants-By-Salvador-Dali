client_lobby = {}

local buttons = {}
local fields = {}
local labels = {}

function client_lobby:init()
  fields.lobbyID = Field(.5, 4/8, 1/8, 1/24, "Lobby ID", true, true, 20, false)
  buttons.createLobby = Button(.5, 5/8, 1/8, 1/12, "Create Lobby")
  buttons.joinLobby = Button(.5, 6/8, 1/8, 1/12, "Join Lobby")
  buttons.createLobby.action = self.createLobby
  buttons.joinLobby.action = self.joinLobby
end

function client_lobby:update(dt)
  self:handleMouse(dt)
  
  client:update_lobby(dt)
  
  if client.lobby.isConnected == true then
    Gamestate.switch(game)
  end
end

function client_lobby:draw()
  drawFPS(fpsCounter)
  if client ~= nil then
    client:draw()
  end
  
  for i, button in pairs(buttons) do
    button:draw()
  end
  
  for i, field in pairs(fields) do
    field:draw()
  end
end

function client_lobby:keypressed(key)
  if key == "escape" then
    
  end
  for i, field in pairs(fields) do
    field:keypressed(key)
  end
end

function client_lobby:textinput(text)
  for i, field in pairs(fields) do
    field:textinput(text)
  end
end

function client_lobby:mousepressed(mousex,mousey,mouseButton)
  for i, button in pairs(buttons) do
    button:highlight(mousePos)
    button:mousepressed(mouseButton)
  end
  
  for i, field in pairs(fields) do
    field:highlight(mousePos)
    field:mousepressed(mouseButton)
  end
end

function client_lobby:quit()
  if client ~= nil then
    client.sender:disconnectNow(1)
  end
end

function client_lobby:handleMouse(dt)
  mousePos:moveTo(love.mouse.getX(), love.mouse.getY())
  local highlightButton = false
  local highlightField = false
  
  for key, button in pairs(buttons) do
    button:update(dt)
    if button:highlight(mousePos) then
      highlightButton = true
    end
  end
  
  for key, field in pairs(fields) do
    field:update(dt)
    if field:highlight(mousePos) then
      highlightField = true
    end
  end
  
  if highlightButton then
    love.mouse.setCursor(CUR.H)
  elseif highlightField then
    love.mouse.setCursor(CUR.I)
  else
    love.mouse.setCursor()
  end
end