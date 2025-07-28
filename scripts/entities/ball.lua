ball = entity:extend({
  layer = 3,
  width = 2,
  height = 2,
  speed = 0.25,
  min_speed = 0.3,
  max_speed = 0.9,
  active = false,
  sy = 3,

  collides_with = {
    paddle,
    brick,
    wall,
  },

  after_init = function(_ENV)
    _ENV:reset()
  end,

  before_update = function(_ENV)
    if vx == 0 and vy == 0 then
      x = player.x + player.width / 2 - 1
    else
      local a = atan2(vx, vy)
      vx = cos(a) * speed
      vy = sin(a) * speed
    end
  end,

  on_collide = function(_ENV, other, axis)
    other:hit()

    -- reflect angle
    if (axis == "y") vy *= -1
    if (axis == "x") vx *= -1

    -- use angle to paddle
    if other:is(paddle) then
      y = other.y - height

      local px = other.x + other.width / 2
      local py = other.y + other.height / 2
      local bx = x + width / 2
      local by = y + height / 2
      local a = atan2(bx - px, by - py)

      -- restrict angle
      a = mid(.125, a, .375)
      vx = cos(a) * speed
      vy = sin(a) * speed

      sfx(2)
    elseif other:is(brick) then
      sfx(1)
    else
      sfx(0)
    end
  end,

  launch = function(_ENV)
    sfx(8)
    vy = -speed
    vx = (player.x + player.width / 2 >= 32 and speed or -speed)
    active = true
  end,

  reset = function(_ENV)
    _ENV.color = 7
    vx = 0
    vy = 0
    x = player.x + player.width \ 2 - 1
    y = player.y - 3
    sy = 3
    active = false
  end
})