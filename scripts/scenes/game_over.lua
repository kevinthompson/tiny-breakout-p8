game_over = scene:extend({
  init = function(_ENV)
    brick:detonate()
  end,

  update = function(_ENV)
    if btnp(5) then
      scene:load(game)
    end
  end,

  draw = function(_ENV)
    game.draw(_ENV)
    prompt("again")

    -- todo: draw game over message
  end
})
