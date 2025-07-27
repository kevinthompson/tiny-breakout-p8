paddle = rectangle:extend({
  x = 24,
  y = 52,
  speed = 0.2,

  width = 16,
  height = 3,

  semi_solid = true,

  before_update = function(_ENV)
    vx *= 0.9
    if (btn(0)) vx -= speed
    if (btn(1)) vx += speed
  end,

  after_update = function(_ENV)
    x = mid(2, x, 62 - width)
    vx = mid(-1, vx, 1)
  end,
})