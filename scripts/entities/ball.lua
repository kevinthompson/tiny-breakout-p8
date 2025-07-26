ball = rectangle:extend({
  width = 2,
  height = 2,
  speed = 0.25,
  min_speed = 0.25,
  max_speed = 1,

  collides_with = {
    paddle,
    brick,
    wall,
  },

  after_init = function(_ENV)
    vy = -speed
    vx = speed
  end,

  before_update = function(_ENV)
    vx = sgn(vx) * speed
    vy = sgn(vy) * speed
  end,

  after_update = function(_ENV)
    if not aabb(_ENV, screen) then
      _ENV:destroy()
    end
  end,

  draw = function(_ENV)
    rectfill(x, y, x + width - 1, y + height - 1, 7)
  end,

  on_collide = function(_ENV, other, axis)
    if other:is(brick) then
      other:hit()
    end

    if other:is(paddle) then
      -- use angle to paddle
      local px = other.x + paddle.width / 2
      local py = other.y + paddle.height / 2
      local bx = x + width / 2
      local by = y + height / 2
      local a = atan2(bx - px, by - py)
      vx = cos(a) * speed
      vy = sin(a) * speed
    else
      -- reflect angle
      if (axis == "y") vy *= -1
      if (axis == "x") vx *= -1
    end
  end
})