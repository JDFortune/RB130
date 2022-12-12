# def select(array)
#   idx = 0
#   new_array = []
#   while idx < array.size
#     new_array << array[idx] if yield(array[idx])
#     idx += 1
#   end
#   new_array
# end

def select(array)
  new_array = []
  array.each do |element|
    new_array << element  if yield(element)
  end
  new_array
end

array = [1, 2, 3, 4, 5]

p select(array) { |num| num.odd? }      # => [1, 3, 5]
p select(array) { |num| puts num }      # => [], because "puts num" returns nil and evaluates to false
p select(array) { |num| num + 1 }       # => [1, 2, 3, 4, 5], because "num + 1" evaluates to true