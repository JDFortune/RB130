
def times(num)
  counter = 0
  while counter < num
    yield(counter)
    counter += 1
  end

  num
end


# times(5) do |n|
#   puts n
# end

class Custom
  attr_accessor :num

  def initialize(num)
    @num = num
  end

  def times
    count = 0
    while count < num
      yield(count)
      count += 1
    end
    num
  end
end

number = Custom.new(5)
number.num = 15

p "original is #{number.times {|n| puts n }}"