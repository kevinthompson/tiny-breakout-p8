win = scene:extend({
  init = function(_ENV)
    title_y = -16
    sfx(12)
    async(function()
      for i = 1, 30 do
        title_y = lerp(-16, 16, ease_out(i/30))
        yield()
      end

      global.loading = false
    end)

    async(function()
      while scene.current == win do
        local new_brick = brick({
          gravity_scale = 1,
          vy = -5,
          x = 8 + rnd(48),
          y = 64,
          primary_color = 8 + rnd(7)\1
        })

        async(function()
          wait(30 + rnd(10))
          new_brick:destroy()
        end)

        wait(15)
      end
    end)
  end,

  update = function(_ENV)
    if not loading and btnp(5) then
      transition(function()
        async:reset()
        scene:load(title)
      end)
    end
  end,

  draw = function(_ENV)
    game.draw(_ENV)
    spr(144, 8, title_y, 6, 2)
    prompt("again")
  end
})
