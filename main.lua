debug = false

isServer = true

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
require "class/FillableField"
require "class/Label"
require "class/Zone"
require "class/Player"
require "class/RectMask"
require "class/Stairway"

require "state/server_menu"
require "state/client_menu"
require "state/login"
require "state/register"
require "state/game"

require "zones/zone1"
require "zones/zone2"

sprites = {}
quads = {}

SW = love.graphics.getWidth()
SH = love.graphics.getHeight()

CUR = {}

ZONES = {}

FNT = {}

mousePos = {}

TICK = 0
FPS = 1/60

ipAddress = "192.168.0.13"

function love.load(arg)
  if debug then require("mobdebug").start() end
  Gamestate.registerEvents()
  love.keyboard.setKeyRepeat(true)
  FNT.DEFAULT = love.graphics.newFont(math.floor(SH/64))
  loadImages()
  ZONES = loadZones()
  mousePos = HC.point(0,0)
  love.graphics.setFont(FNT.DEFAULT)
  love.graphics.setBackgroundColor(CLR.BLACK)
  CUR.H = love.mouse.getSystemCursor("hand")
  CUR.I = love.mouse.getSystemCursor("ibeam")
  fpsCounter = Label("FPS", .015, .03, "left", CLR.WHITE)
  if isServer then
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

function loadZones()
  local zones = {}
  zones[1] = zone1
  zones[2] = zone2
  
  return zones
end

function loadImages()
  sprites.door_up = love.graphics.newImage("images/door_up.png")
  sprites.door_down = love.graphics.newImage("images/door_down.png")
  sprites.museum_background = love.graphics.newImage("images/background_tile.png")
  sprites.museum_background:setWrap("repeat","repeat")
  quads.museum_background = love.graphics.newQuad(0,0,2000,430, 64,64)
  sprites.wall = love.graphics.newImage("images/wall.png")
  sprites.wall:setWrap("repeat","repeat")
end

function loadServerData()
  local data = {}
  love.filesystem.setIdentity("totebsd_server")
  if love.filesystem.exists("player_list.lua") then
    local import_string = love.filesystem.read("player_list.lua")
    data = Tserial.unpack(import_string)
  else
    love.filesystem.write("player_list.lua", Tserial.pack(data))
  end
  
  return data
end