local params = {
  wall_thickness = 50,
  room_height = 800,
  room_width = 3000,
  map_left = -1000,
  map_top = -1000,
}

--level1 coords: -950 < x < 1950, y = 700
--level2 coords: -950 < x < 1950, y = -150

map1 = {
  walls = {
    {x = params.map_left, y = params.map_top+2*params.room_height+2*params.wall_thickness, w = params.room_width+2*params.wall_thickness, h = params.wall_thickness}, --level1_floor
    {x = params.map_left, y = params.map_top+params.room_height+params.wall_thickness, w = params.wall_thickness,  h = params.room_height+2*params.wall_thickness}, --level1_leftwall
    {x = params.map_left+params.room_width+params.wall_thickness, y = params.map_top+params.room_height+params.wall_thickness, w = params.wall_thickness,  h = params.room_height+2*params.wall_thickness}, --level1_rightwall
    {x = params.map_left, y = params.map_top+params.room_height+params.wall_thickness, w = params.room_width+2*params.wall_thickness,  h = params.wall_thickness}, --level1_ceiling/level2_floor
    {x = params.map_left, y = params.map_top, w = params.wall_thickness,  h = params.room_height+2*params.wall_thickness}, --level2_leftwall
    {x = params.map_left+params.room_width+params.wall_thickness, y = params.map_top, w = params.wall_thickness,  h = params.room_height+2*params.wall_thickness}, --level2_rightwall
    {x = params.map_left, y = params.map_top, w = params.room_width+2*params.wall_thickness,  h = params.wall_thickness}, --level2_ceiling
  },
  
  stairways = {
    {x1 = -700, y1 = 700, sprite1 = "door_up", x2 = -700, y2 = -150, sprite2 = "door_down"},
    {x1 = 1700, y1 = 700, sprite1 = "door_up", x2 = 1700, y2 = -150, sprite2 = "door_down"},
  },
  
  rooms = {
   {x = params.map_left+params.wall_thickness, y = params.map_top+params.room_height+2*params.wall_thickness, w = params.room_width, h = params.room_height},
   {x = params.map_left+params.wall_thickness, y = params.map_top+params.wall_thickness, w = params.room_width, h = params.room_height},
  },
}