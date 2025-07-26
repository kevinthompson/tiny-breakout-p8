-- parent class for objects with lifecycle loop
game_object = class:extend({
  init = _noop,
  update = _noop,
  draw = _noop,
  destroy = _noop
})
