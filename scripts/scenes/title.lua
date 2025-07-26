title_scene = scene:extend({
  init = function(_ENV)
    pal(split("1,2,139,4,129,6,7,136,9,135,138,12,140,14,15,0"), 1)
  end,

  update = function(_ENV)
    -- load game if any button pressed
    if any_button() then
      scene:load(game_scene)
    end
  end,

  draw = function(_ENV)
    cls(5)
    printc("breakout", 16)
  end
})
