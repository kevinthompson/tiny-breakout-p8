game_scene = scene:extend({
  init = function(_ENV)
    difficulty = 1
    lives = 3
    _ENV:load_level(rnd(levels[difficulty]))

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
  end,

  update = function(_ENV)
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
    if lives <= 0 then
      -- todo: game over scene
      _ENV:init()
    end

    -- all bricks cleared
    if #brick.objects == 0 then
      -- todo: level cleared
      ball:each("destroy")

      if difficulty < 3 then
        difficulty += 1
        _ENV:load_level(rnd(levels[difficulty]))
      else
        -- todo win scene
      end
    end
  end,

  draw = function(_ENV)
    cls(5)

    entity:each("draw")

    -- draw prompt
    if not loading then
      spr(71, 20, 39)
      print("ball", 29, 40, 1)
    end

    draw_lives()
    line(0, 63, 128, 63, 1)
  end,

  load_level = function(_ENV, id)
    -- create bricks from sprite
    local sx = (id % 16) * 8
    local sy = (id \ 16) * 8
    local i = 0

    for y = sy, sy + 7 do
      for x = sx, sx + 7 do
        local pixel_color = sget(x, y)

        if pixel_color != 0 then
          brick({
            x = 33 - (brick.width + 1) * 4 + (x - sx) * (brick.width + 1),
            y = 5 + (y - sy) * (brick.height + 1),
            oy = -128,
            delay = i,
            primary_color = pixel_color
          })
          i += 1
        end
      end
    end

    -- reset ball speed
    ball.speed = ball.min_speed

    -- change ball speed after brick destroy
    local max_bricks = #brick.objects
    brick.after_destroy = function(_ENV)
      local percent = (max_bricks - #brick.objects) / max_bricks
      ball.speed = ball.min_speed + (ball.max_speed - ball.min_speed) * percent
    end
  end
})