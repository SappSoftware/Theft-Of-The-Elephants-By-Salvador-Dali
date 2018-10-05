debug = false

isServer = false

Sock = require "sock"
Bitser = require "bitser"

HC = require "hc"
Shape = require "hc.shapes"

Gamestate = require "hump.gamestate"
Class = require "hump.class"
Vector = require "hump.vector"
Camera = require "hump.camera"

require "CLR"
require "helper"

require "Tserial"

require "class/ServerObject"
require "class/ClientObject"
require "class/Button"
require "class/Field"
require "class/Label"
require "class/Map"
require "class/Player"
require "class/Wall"
require "class/Stairway"
require "class/Burglar"
require "class/Investigator"
require "class/Room"
require "class/ServerLobby"
require "class/ClientLobby"

require "state/server_menu"
require "state/client_lobby"
require "state/client_menu"
require "state/login"
require "state/register"
require "state/game"

require "maps/map1"
require "maps/map2"

sprites = {}
quads = {}

SW = love.graphics.getWidth()
SH = love.graphics.getHeight()

CUR = {}

MAPS = {}

FNT = {}

mousePos = {}

ipAddress = "10.246.1.40"

function love.load(arg)
  if debug then require("mobdebug").start() end
  Gamestate.registerEvents()
  love.keyboard.setKeyRepeat(true)
  FNT.DEFAULT = love.graphics.newFont(math.floor(SH/64))
  loadImages()
  MAPS = loadMaps()
  mousePos = HC.point(0,0)
  love.graphics.setFont(FNT.DEFAULT)
  love.graphics.setBackgroundColor(CLR.BLACK)
  CUR.H = love.mouse.getSystemCursor("hand")
  CUR.I = love.mouse.getSystemCursor("ibeam")
  fpsCounter = Label("FPS", .015, .03, "left", CLR.WHITE)
  if isServer then
    --love.window.setFullscreen(false)
    server_data = loadServerData()
    Gamestate.switch(server_menu)
  else 
    client = nil
    Gamestate.switch(login)
  end
end

function love.update(dt)
  
end

function love.draw(dt)

end

function love.keypressed(key)

end

function love.run()
 
	if love.math then
		love.math.setRandomSeed(os.time())
	end
 
	if love.load then love.load(arg) end
 
	-- We don't want the first frame's dt to include time taken by love.load.
	if love.timer then love.timer.step() end
  
	-- Main loop time.
  local frametime = 0
  local accumulator = 0
  local dt = 0.01  --specify the target update frequency here

  while true do
    love.timer.step()
    frametime = love.timer.getDelta()
    accumulator = accumulator + frametime

    while (accumulator >= dt) do
      if love.event then
        love.event.pump()
        for name, a,b,c,d,e,f in love.event.poll() do
          if name == "quit" then
            if not love.quit or not love.quit() then
              return a
            end
          end
          love.handlers[name](a,b,c,d,e,f)
        end
      end
      -- Call update and draw
      love.update(dt)
      accumulator = accumulator - dt
    end

    love.graphics.clear()
    love.graphics.origin()
    love.draw()
    love.graphics.present()
  end
end

function loadMaps()
  local maps = {}
  maps[1] = map1
  maps[2] = map2
  
  return maps
end

function loadImages()
  sprites.door_up = love.graphics.newImage("images/door_up.png")
  sprites.door_down = love.graphics.newImage("images/door_down.png")
  
  sprites.investigator = love.graphics.newImage("images/investigator.png")
  sprites.burglar = love.graphics.newImage("images/burglar.png")
  
  sprites.museum_background = love.graphics.newImage("images/background_tile.png")
  sprites.museum_background:setWrap("repeat","repeat")
  quads.museum_background = love.graphics.newQuad(0,0,2000,430, 64,64)
  sprites.wall = love.graphics.newImage("images/wall.png")
  sprites.wall:setWrap("repeat","repeat")
end

function loadServerData()
  local data = {}
  love.filesystem.setIdentity("totebsd_server")
  if love.filesystem.getInfo("player_list.lua") ~= nil then
    local import_string = love.filesystem.read("player_list.lua")
    data = Tserial.unpack(import_string)
  else
    love.filesystem.write("player_list.lua", Tserial.pack(data))
  end
  
  return data
end