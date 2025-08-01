-- empty function
_noop = function()end

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

-- axis aligned bounding box collision
function aabb(rect1,rect2)
  return rect1.x < rect2.x + rect2.width and
    rect1.x + rect1.width > rect2.x and
    rect1.y < rect2.y + rect2.height and
    rect1.y + rect1.height > rect2.y
end

-- sort collection of tables
function sort(tbl,key,lo,hi)
  key,lo,hi=key or "y",lo or 1,hi or #tbl
  if lo<hi then
    local p,i,j=tbl[(lo+hi)\2][key],lo-1,hi+1
    while true do
      repeat i+=1 until tbl[i][key]>=p
      repeat j-=1 until tbl[j][key]<=p
      if (i>=j) break
      tbl[i],tbl[j]=tbl[j],tbl[i]
    end
    sort(tbl,key,lo,j)
    sort(tbl,key,j+1,hi)
  end
end

-- rounding
function round(i)
  return (i % 1 >= 0.5 and ceil or flr)(i)
end