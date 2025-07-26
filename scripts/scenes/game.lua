game_scene = scene:extend({
  init = function(_ENV)
    pal(split("1,2,139,4,129,6,7,136,9,135,138,12,140,14,15,0"), 1)
    entity:destroy_all()

    _ENV:load_level(global.level)

    brick.after_destroy = function(_ENV)
      for obj in all(ball.objects) do
        obj.speed += (ball.max_speed - ball.speed ) / #brick.objects
      end
    end

    player = paddle()

    wall({ x = -1, y = 0, width = 1, height = 64 })
    wall({ x = 64, y = 0, width = 1, height = 64 })
    wall({ x = 0, y = -1, width = 64, height = 1 })
  end,

  update = function(_ENV)
    entity:update_all()

    if #ball.objects == 0 and btnp(5) then
      ball({
        x = player.x + player.width \ 2,
        y = player.y - 2,
      })
    end

    if btnp(4) then
      global.level += 1
      _ENV:init()
    end
  end,

  draw = function(_ENV)
    cls(5)

    for e in all(entity.objects) do
      e:draw()
    end
  end,

  load_level = function(_ENV, id)
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
  end
})