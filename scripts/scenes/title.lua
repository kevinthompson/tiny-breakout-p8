title_scene = scene:extend({
  init = function(_ENV)
    entity:each("destroy")
    logo_y = 6

    for i = 1, 14 do
      local x = 8 + ((i - 1) % 7) * 7
      local y = 25 + ((i - 1) \ 7) * 4
      brick({ x = x, y = y, primary_color = i > 7 and 10 or 9 })
    end

    global.lives = 3
    global.player = paddle({ x = 24, y = 56 })
  end,

  update = function(_ENV)
    -- load game if any button pressed
    if not loading and btn(5) then
      loading = true
      async(function()
        for b in all(brick.objects) do
          b:destroy()
          wait(2)
        end
      end)

      async(function()
        for i = 1, 30 do
          logo_y = lerp(6, -25, (i/30)^2)
          yield()
        end

        scene:load(game_scene)
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
      spr(71, 18, 39)
      print("start", 27, 40, 1)
    end

    draw_lives()
    line(0, 63, 128, 63, 1)
  end
})

draw_lives = function()
  for i = 1, global.lives do
    local x = 4 + (i - 1) * 3
    rectfill(x, 60, x + 1, 61 , 1)
  end
end