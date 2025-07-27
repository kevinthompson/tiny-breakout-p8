brick = rectangle:extend({
  solid = true,
  width = 6,
  height = 3,
  health = 1,

  before_destroy = function(_ENV)
    local px = x + width / 2
    local py = y + height / 2

    for i = 0, 2 do
      particle({
        layer = 2,
        x = px,
        y = py,
        frames = 25 + rnd(10),
        vx = -0.5 + i * (0.5 + rnd(0.5)) ,
        vy = -0.5 - rnd(),
        gravity_scale = 1,
        radius = { 1, 0},
        color = { primary_color, secondary_color, 1 }
      })
    end
  end
})