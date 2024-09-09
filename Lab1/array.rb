def min_elem(array)
  if array.length > 0
    min = array[0]
  else min = -1
  end
  for elem in array
    min = elem if elem < min
  end
  min
end

def first_pos(array)
  result = -1
  for elem in array 
    if elem >= 0
      result = elem
      break
    end
  end
  result
end