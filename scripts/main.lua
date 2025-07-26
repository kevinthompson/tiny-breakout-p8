poke(0x5f2e, 1)   -- enable alternate palette
poke(0x5f5c, 255) -- disable key repeat
poke(0x5f2c, 3)   -- set resolution to 64x64

-- define cart id for saving data
cartdata("tiny_breakout")

-- setup global references
global = _ENV
global.level = 1
_noop = function()end
_after_draw = _noop

-- configure fade transition
custom_transition_table = [[
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
  1,1,129,129,129,129,129,129,129,129,0,0,0,0,0
  2,2,2,130,130,130,130,130,128,128,128,128,128,0,0
  139,139,3,3,3,3,3,131,129,129,129,129,0,0,0
  4,4,132,132,132,132,132,132,130,128,128,128,128,0,0
  129,129,129,129,129,129,129,0,0,0,0,0,0,0,0
  6,6,134,13,13,13,141,5,5,5,133,130,128,128,0
  7,6,6,6,134,134,134,134,5,5,5,133,130,128,0
  136,136,136,2,2,132,132,130,130,130,128,128,128,0,0
  9,9,9,4,4,4,4,132,132,132,128,128,128,128,0
  135,135,135,134,134,134,134,5,5,5,133,133,128,128,0
  138,138,138,138,5,5,5,5,133,133,128,128,128,128,0
  12,12,12,140,140,140,140,131,131,131,1,129,129,129,0
  140,140,140,140,131,131,1,1,1,129,129,129,129,0,0
  14,14,14,134,134,141,141,2,2,133,130,130,128,128,0
  15,143,143,134,134,134,134,5,5,5,133,133,128,128,0
]]

-- initialize cartridge
function _init()
	scene:load(splash_scene)
end

-- update current scene
function _update60()
  async:update()
  scene.current:update()
  screen:update()
end

-- draw current scene
function _draw()
  scene.current:draw()
  _after_draw()
end