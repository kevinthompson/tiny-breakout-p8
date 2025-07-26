transition = class:extend({
  __call = function(_ENV, callback)
    callback = callback or _noop
    transition:hide(function()
      callback()
      transition:reveal()
    end)
  end,

  hide = function(_ENV, callback)
    _ENV:wipe(0, 128, 0, 0, callback)
  end,

  reveal = function(_ENV, callback)
    _ENV:wipe(0, 0, 0, -128, callback)
  end,

  wipe = function(_ENV, x1, y1, x2, y2, callback)
    async(function()
      for i = 1, 15 do
        local x = x1 + (x2 - x1) * i/15
        local y = y1 + (y2 - y1) * i/15

        global._after_draw = function()
          rectfill(x, y, x + 127, y + 127, 0)
        end

        yield()
      end

      if (callback) callback()
    end)
  end
})
