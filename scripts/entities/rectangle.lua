rectangle = entity:extend({
  width = 8,
  height = 4,

  primary_color = 7,

  color_map = {
    [7] = 6
  },

  after_init = function(_ENV)
    secondary_color = color_map[primary_color]
  end,

  draw = function(_ENV)
    local x2 = x + width - 1
    local y2 = y + height - 1
    rectfill(x, y, x2, y2 - 1, primary_color)
    line(x, y2, x2, y2, secondary_color)
  end
})