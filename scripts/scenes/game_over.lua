game_over = scene:extend({
  init = function(_ENV)
    brick:detonate()
    title_y = -16
    sfx(13)
    async(function()
      for i = 1, 30 do
        title_y = lerp(-16, 16, ease_out(i/30))
        yield()
      end

      global.loading = false
    end)
  end,

  update = function(_ENV)
    if not loading and btnp(5) then
      transition(function()
        scene:load(title)
      end)
    end
  end,

  draw = function(_ENV)
    game.draw(_ENV)
    spr(112, 4, title_y, 7, 2)
    prompt("again")
  end
})
