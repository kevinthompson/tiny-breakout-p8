poke(0x5f2e, 1)   -- enable alternate palette
poke(0x5f5c, 255) -- disable key repeat
poke(0x5f2c, 3)   -- set resolution to 64x64

-- define cart id for saving data
cartdata("tiny_breakout")

-- setup global references
global = _ENV
_noop = function()end
_after_draw = _noop

-- initialize cartridge
function _init()
	scene:load(splash_scene)
end

-- update current scene
function _update60()
  async:update()
  scene.current:update()
end

-- draw current scene
function _draw()
  scene.current:draw()
  _after_draw()
end