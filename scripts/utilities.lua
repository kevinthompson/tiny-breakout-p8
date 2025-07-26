-- linear interpolation
function lerp(a,b,t)
  return a+(b-a)*t
end

-- print centered
function printc(str,y,clr,w)
  w=w or 4
  local center = peek(0x5f2c) == 3 and 32 or 64
	local x=peek2(0x5f28) + center - (#str*w)/2
	print(str,x,peek2(0x5f2a) + y,clr)
end

-- input detection helpers
function any_button()
  return btnp() > 0
end