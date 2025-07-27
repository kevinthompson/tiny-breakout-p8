life = entity:extend({
  width = 2,
  height = 2,
  y = 60,
  sy = 3,
  delay = 0,

  after_init = function(_ENV)
    async(function()
      wait(delay)

      for i = 1,15 do
        sy = lerp(3, 0, (i/15)^2)
        yield()
      end
    end)
  end,

  draw = function(_ENV)
    rectfill(x + sx, y + sy, x + sx + width - 1, y + sy + height - 1, 1)
  end
})