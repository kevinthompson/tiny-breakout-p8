paddle = block:extend({
  layer = 4,
  x = 24,
  y = 52,
  speed = 0.2,

  max_width = 16,
  min_width = 16,
  width = 16,
  height = 3,

  solid = true,

  before_update = function(_ENV)
    vx *= 0.9
    if (btn(0)) vx -= speed
    if (btn(1)) vx += speed
  end,

  after_update = function(_ENV)
    x = mid(1, x, 63 - width)
    vx = mid(-1, vx, 1)
  end,

  animate_width = function(_ENV, target_width)
    async(function()
      local prev_width = width

      for i = 1, 15 do
        local new_width = lerp(prev_width, target_width, ease_in(i / 15))
        x += (width - new_width) / 2
        width = new_width
        yield()
      end
    end)
  end
})