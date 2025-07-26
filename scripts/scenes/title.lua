title_scene = scene:extend({
  init = function(_ENV)
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
