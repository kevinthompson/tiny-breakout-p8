game_scene = scene:extend({
  init = function(_ENV)
    entity:destroy_all()
    _ENV:load_level(rnd(levels))
    lives = 3

    -- reset ball speed
    ball.speed = ball.min_speed

    -- change ball speed after brick destroy
    local max_bricks = #brick.objects
    brick.after_destroy = function(_ENV)
      local percent = (max_bricks - #brick.objects) / max_bricks
      ball.speed = ball.min_speed + (ball.max_speed - ball.min_speed) * percent
    end
  end,

  update = function(_ENV)
    entity:update_all()

    -- launch ball
    if #ball.objects == 0 and btnp(5) then
      ball({
        x = player.x + player.width \ 2,
        y = player.y - 2,
      })
    end

    for b in all(ball.objects) do
      -- destroy ball off screen
      if not aabb(b, screen) then
        b:destroy()
        lives -= 1
        screen:shake(2, 3)
        sfx(4)
      end
    end

    -- load level when lives run out
    if lives <= 0 or #brick.objects == 0 then
      _ENV:init()
    end
  end,

  draw = function(_ENV)
    cls(5)

    for e in all(entity.objects) do
      e:draw()
    end

    if #ball.objects == 0 then
      printc("❎ to start", 46, 7)
    end

    ? "♥X" .. lives, 1, 57, 1
  end,

  load_level = function(_ENV, id)
    -- create bricks from sprite
    local sx = (id % 16) * 8
    local sy = (id \ 16) * 8

    for x = sx, sx + 7 do
      for y = sy, sy + 7 do
        local pixel_color = sget(x, y)

        if pixel_color != 0 then
          brick({
            x = 33 - (brick.width + 1) * 4 + (x - sx) * (brick.width + 1),
            y = 4 + (y - sy) * (brick.height + 1),
            primary_color = pixel_color
          })
        end
      end
    end

    -- create player
    player = paddle()

    -- create walls
    wall({ x = -1, y = 0, width = 1, height = 64 })
    wall({ x = 64, y = 0, width = 1, height = 64 })

    -- create ceiling
    wall({
      x = 0,
      y = -1,
      width = 64,
      height = 1,
      on_hit = function()
        -- reduce paddle size when hitting ceiling
        local paddle_size = max(player.width - 2, 8)

        if paddle_size < player.width then
          player.width = paddle_size
          player.x += 1
          sfx(3)
        end
      end
    })
  end
})