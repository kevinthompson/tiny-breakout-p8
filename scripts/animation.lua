function ease_in(t)
	return t^2
end

function ease_out(t)
	return 1 - (t - 1)^2
end

function ease_in_out(t)
  return t < .5 and 2 * t^2 or 1 - 2 * (t - 1)^2
end