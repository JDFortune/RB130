require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!

require_relative '../car'

class CarTest < Minitest::Test
  def setup
    @car = Car.new
  end

  # example `assert` test: Fails unless argument is truthy
  def test_car_exists
    assert(@car)
  end

  #example `assert_equal`: Fails unless exp == act
  def test_wheels
    assert_equal(4, @car.wheels)
  end

  #example `assert_nil`: Fails unless obj is nil
  def test_name_is_nil
    assert_nil(@car.name)
  end

  #assert_raises: Fails unless block raises one of *expected Errors
  def test_raise_initialize_with_arg
    assert_raises(ArgumentError) do
      Car.new(name:"Joey")
    end
  end

  #assert_instance_of: Fails unless obj is instance of class argument
  def test_instance_of_car
    assert_instance_of(Car, @car)
  end

  #assert_includes: Fails unless obj included in argument
  def test_includes_car
    arr = [1, 2, 3]
    arr << @car
    
    assert_includes(arr, @car)
  end
end