title = scene:extend({
  init = function(_ENV)
    entity:each("destroy")
    logo_y = 6

    for i = 1, 14 do
      local x = 8 + ((i - 1) % 7) * 7
      local y = 25 + ((i - 1) \ 7) * 4
      brick({ x = x, y = y, primary_color = 8 + rnd(3)\1 })
    end

    global.player = paddle({ x = 24, y = 56 })

    async(function()
      wait(15)
      sfx(11)
    end)
  end,

  update = function(_ENV)
    -- load game if any button pressed
    if not loading and btn(5) then
      global.loading = true
      brick:detonate()

      async(function()
        for i = 1, 30 do
          logo_y = lerp(6, -25, ease_in(i/30))
          yield()
        end

        scene:load(game)
      end)
    end
  end,

  draw = function(_ENV)
    cls(5)

    -- draw logo
    spr(64, 6, logo_y, 7, 2)
    line(6, logo_y + 16, 57, logo_y + 16, 0)

    -- draw entities
    entity:each("draw")

    -- draw prompt
    if not loading then
      prompt("start")
    end

    line(0, 63, 128, 63, 1)
  end
})