block = entity:extend({
  width = 8,
  height = 4,

  primary_color = 7,
  color_map = split("5,1,1,1,0,1,6,2,4,9,3,13,1,8,14,0"),

  -- drawing offset
  delay = 0,

  after_init = function(_ENV)
    secondary_color = color_map[primary_color]
  end,

  draw_shape = function(_ENV)
    local x2 = x + width - 1
    local y2 = sy + y + height - 1
    rectfill(x, sy + y, x2, y2 - 1, primary_color)
    line(x, y2, x2, y2, secondary_color)
  end
})