zone1 = {
  masks = {
    {x = -250, y = 35, w = 2000, h = 50}, --level1_floor
    {x = -250, y = -155, w = 50,  h = 240}, --level1_leftwall
    {x = 1700, y = -155, w = 50,  h = 240}, --level1_rightwall
    {x = -250, y = -155, w = 2000,  h = 50}, --level1_ceiling/level2_floor
    {x = -250, y = -345, w = 50,  h = 240}, --level2_leftwall
    {x = 1700, y = -345, w = 50,  h = 240}, --level2_rightwall
    {x = -250, y = -345, w = 2000,  h = 50} --level2_ceiling
  },
  
  stairways = {
    {x1 = -100, y1 = -55, sprite1 = "door_up", x2 = -100, y2 = -245, sprite2 = "door_down"}
  }
}