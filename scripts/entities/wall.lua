wall = entity:extend({
  solid = true,

  draw = function(_ENV)
    rectfill(x, y, x + width - 1, y + height - 1, 8)
  end
})