title_scene = scene:extend({
  update = function(_ENV)
    -- load game if any button pressed
    if any_button() then
      scene:load(game_scene)
    end
  end,

  draw = function(_ENV)
    cls(5)
    printc("tiny breakout", 16, 7)
    printc("❎ to start", 46, 7)
  end
})
