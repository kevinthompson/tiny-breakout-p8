game_scene = scene:extend({
  init = function(_ENV)
    player = paddle()

    for i = 1, 30 do
      brick({
        x = 6 + ((i - 1) % 6) * 9,
        y = 4 + ((i - 1) \ 6) * 5
      })
    end

    ball({
      x = player.x + player.width \ 2,
      y = player.y - 2,
    })

    wall({ x = -1, y = 0, width = 1, height = 64 })
    wall({ x = 64, y = 0, width = 1, height = 64 })
    wall({ x = 0, y = -1, width = 64, height = 1 })
  end,

  update = function(_ENV)
    entity:update_all()
  end,

  draw = function(_ENV)
    cls(12)

    for e in all(entity.objects) do
      e:draw()
    end
  end,
})