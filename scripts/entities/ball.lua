ball = entity:extend({
  width = 2,
  height = 2,
  speed = 0.25,

  collides_with = {
    paddle,
    brick,
    wall,
  },

  after_init = function(_ENV)
    vy = -speed
    vx = speed
  end,

  draw = function(_ENV)
    rectfill(x, y, x + width - 1, y + height - 1, 7)
  end,

  on_collide = function(_ENV, other, axis)
    if other:is(brick) then
      other:hit()
    end

    if (axis == "y") vy *= -1
    if (axis == "x") vx *= -1
  end
})