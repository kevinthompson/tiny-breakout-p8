level_text = entity:extend({
  height = 0,
  x = 64,
  layer = 5,

  after_init = function(_ENV)
    async(function()
      for i = 1, 15 do
        height = lerp(0, 1, ease_out(i / 15))
        yield()
      end

      for i = 1, 15 do
        x = lerp(64, 16, ease_out(i / 15))
        yield()
      end

      wait(15)
      callback()
      wait(15)

      for i = 1, 15 do
        x = lerp(18, -32, ease_in(i / 15))
        yield()
      end

      for i = 1, 15 do
        height = lerp(1, 0, ease_in(i / 15))
        yield()
      end

      _ENV:destroy()
    end)
  end,

  draw = function(_ENV)
    local y = 18
    line(0, y - 5 * height, 127, y - 5 * height, 1)
    rectfill(0, y - 4 * height, 127, y + 4 * height, 5)
    sspr(64, 56, 22, 5, x, y - 2)
    sspr(88 + (level - 1) * 8, 56, 4, 5, x + 27, y - 2)
    line(0, y + 5 * height, 127, y + 5 * height, 1)
    line(0, y + 6 * height, 127, y + 6 * height, 0)
  end
})