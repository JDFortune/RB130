require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!

require_relative '../to_do_list'

class TodoListTest < Minitest::Test

  def setup
    @todo1 = Todo.new("Buy milk")
    @todo2 = Todo.new("Clean room")
    @todo3 = Todo.new("Go to gym")
    @todos = [@todo1, @todo2, @todo3]
  
    @list = TodoList.new("Today's Todos")
    @todos.each { |todo| @list.add(todo) }
  end

  def test_to_a
    assert_equal(@todos, @list.to_a)
  end

  def test_size
    assert_equal(3, @list.size)
  end

  def test_first
    assert_equal(@todo1, @list.first)
  end

  def test_last
    assert_equal(@todo3, @list.last)
  end

  def test_shift
    removed = @list.shift
    assert_equal(@todo1, removed)
    assert_equal([@todo2, @todo3], @list.to_a)
  end

  def test_pop
    removed = @list.pop
    assert_equal(@todo3, removed)
    assert_equal([@todo1, @todo2], @list.to_a)
  end

  def test_done?
    assert_equal(false, @list.done?)
  end

  def test_type_error
    assert_raises(TypeError) {@list.add(3)}
    assert_raises(TypeError) {@list.add('hi')}
  end

  def test_shovel
    todo4 = Todo.new('Walk the Dog')
    @list << todo4
    @todos << todo4

    assert_equal(@todos, @list.to_a)
  end

  def test_add_is_shovel
    todo4 = Todo.new('Walk the Dog')
    @list.add(todo4)
    @todos << todo4

    assert_equal(@todos, @list.to_a)
  end

  def test_item_at
    assert_equal(@todo2, @list.item_at(1))
    assert_equal(@todo1, @list.item_at(0))
    assert_raises(IndexError) {@list.item_at(20)}
  end

  def test_mark_done_at
    assert_raises(IndexError) {@list.mark_done_at(30)}
    @list.mark_done_at(1)
    assert_equal(false, @todo1.done?)
    assert_equal(true, @todo2.done?)
    assert_equal(false, @todo3.done?)
  end

  def test_mark_undone_at
    assert_raises(IndexError) {@list.mark_undone_at(100)}
    @todo1.done!
    @todo2.done!
    @todo3.done!

    @list.mark_undone_at(1)


    assert_equal(true, @todo1.done?)
    assert_equal(false, @todo2.done?)
    assert_equal(true, @todo3.done?)
  end

  def test_done!
    assert_equal(false, @todo1.done?)
    assert_equal(false, @todo2.done?)
    assert_equal(false, @todo3.done?)
    @list.done!
    assert_equal(true, @todo1.done?)
    assert_equal(true, @todo2.done?)
    assert_equal(true, @todo3.done?)
    assert_equal(true, @list.done?)
  end

  def test_remove_at
    assert_raises(IndexError) {@list.remove_at(100)}
    removed = @list.remove_at(2)
    assert_equal(@todo3, removed)
    assert_equal([@todo1, @todo2], @list.to_a)
  end

  def test_to_s
    output = <<-OUTPUT.chomp.gsub /^\s+/, ''
    ------ Today's Todos ------
    [ ] Buy milk
    [ ] Clean room
    [ ] Go to gym
    OUTPUT

    assert_equal(output, @list.to_s)
  end

  def test_one_done_to_s
    output = <<-OUTPUT.chomp.gsub /^\s+/, ''
    ------ Today's Todos ------
    [ ] Buy milk
    [X] Clean room
    [ ] Go to gym
    OUTPUT

    @list.mark_done_at(1)
    assert_equal(output, @list.to_s)
  end

  def test_all_done_to_s
    output = <<~OUTPUT.chomp
    ------ Today's Todos ------
    [X] Buy milk
    [X] Clean room
    [X] Go to gym
    OUTPUT

    @list.done!
    assert_equal(output, @list.to_s)
  end

  def test_each
    result = []
    @list.each {|todo| result << todo }
    assert_equal(@list.to_a, result)
  end

  def test_each_return
    assert_equal(@list, @list.each)
  end

  def test_select
    @todo2.done!
    new_list = TodoList.new(@list.title)
    new_list.add(@todo2)

    assert_equal(new_list.title, @list.title)
    assert_equal(new_list.to_s, @list.select(@list.title){|todo| todo.done?}.to_s)
  end

  def test_delete_item
    @list.delete_item("Buy milk")
    assert_equal([@todo2, @todo3], @list.to_a)
  end

  def test_each_with_object
    @todo1.done!
    @todo2.done!
    result = @list.each_with_object([]) do |todo, arr|
               arr << todo if todo.done?
             end
    assert_equal([@todo1, @todo2], result)
  end
end