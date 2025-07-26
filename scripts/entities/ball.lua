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

  draw = function(_ENV)
    rectfill(x, y, x + width - 1, y + height - 1, 7)
  end,

  on_collide = function(_ENV, other, axis)
    other:hit()

    -- reflect angle
    if (axis == "y") vy *= -1
    if (axis == "x") vx *= -1

    -- use angle to paddle
    if other:is(paddle) then
      local px = other.x + other.width / 2
      local py = other.y + other.height / 2
      local bx = x + width / 2
      local by = y + height / 2
      local a = atan2(bx - px, by - py)
      vx = cos(a) * speed
      vy = sin(a) * speed
      sfx(2)
    elseif other:is(brick) then
      sfx(1)
    else
      sfx(0)
    end
  end
})