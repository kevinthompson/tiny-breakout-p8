game = scene:extend({
  init = function(_ENV)
    difficulty = 0

    -- life entities (for animation)
    for i = 0, 2 do
      local l = life({
        x = 1 + i * 3,
        y = 60,
        delay = i * 5
      })
    end

    -- load level
    _ENV:load_next_level()

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
    if (loading) return

    -- all bricks cleared
    if #brick.objects == 0 then
      global.loading = true

      async(function()
        -- fade ball out
        for c in all(split("6,12,13,1,5")) do
          current_ball.color = c
          yield()
        end

        -- reset ball attributes
        current_ball:reset()

        -- load next level
        if difficulty < 3 then
          _ENV:load_next_level()
        else
          -- todo win scene
        end
      end)
    elseif current_ball then
      -- launch ball
      if not current_ball.active
      and btnp(5) then
        current_ball:launch()
      end

      -- destroy ball off screen
      if not aabb(current_ball, screen) then
        current_ball:destroy()
        current_ball = nil

        screen:shake(2, 3)
        sfx(4)

        if #life.objects > 0 then
          -- load next ball
          _ENV:load_ball()
        else
          -- load game over scene
          scene:load(game_over)
        end
      end
    end
  end,

  draw = function(_ENV)
    cls(5)
    line(0, 63, 128, 63, 1)

    entity:each("draw")

    -- draw prompt
    if not loading
    and current_ball
    and not current_ball.active
    and show_flashing then
      spr(71, 20, 40)
      print("play", 29, 41, 1)
    end
  end,

  load_ball = function(_ENV)
    global.loading = true
    local frames = 15

    if (current_ball) current_ball:reset()

    async(function()
      if not current_ball then
        local current_life = life.objects[#life.objects]
        current_ball = ball()

        for i = 1, frames do
          current_life.sy = lerp(0, 3, (i / frames)^2)
          yield()
        end

        current_life:destroy()
      end

      for i = 1, frames do
        current_ball.sy = lerp(3, 0,  1 - ((i/frames) - 1)^2)
        yield()
      end

      global.loading = false
    end)
  end,

  load_next_level = function(_ENV)
    difficulty += 1
    _ENV:load_level(rnd(levels[difficulty]))
  end,

  load_level = function(_ENV, id)
    -- create bricks from sprite
    local sx = (id % 16) * 8
    local sy = (id \ 16) * 8

    for y = sy, sy + 7 do
      for x = sx, sx + 7 do
        local pixel_color = sget(x, y)

        if pixel_color != 0 then
          brick({
            x = 33 - (brick.width + 1) * 4 + (x - sx) * (brick.width + 1),
            y = 5 + (y - sy) * (brick.height + 1),
            oy = -128,
            delay = #brick.objects/2,
            primary_color = pixel_color
          })
        end
      end
    end

    -- delay on loading based on brick count
    async(function()
      wait(15 + #brick.objects / 2)
      _ENV:load_ball()
    end)

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