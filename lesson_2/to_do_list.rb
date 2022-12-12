# create a TodoList containing ToDo objects
# use array to back te collection of Todo objects

class Todo
  DONE_MARKER = 'X'
  UNDONE_MARKER = ' '

  attr_accessor :title, :description, :done

  def initialize(title, description='')
    @title = title
    @description = description
    @done = false
  end

  def done!
    self.done = true
  end

  def done?
    done
  end

  def undone!
    self.done = false
  end

  def to_s
    "[#{done? ? DONE_MARKER : UNDONE_MARKER}] #{title}"
  end

  def ==(otherTodo)
    title == otherTodo.title &&
      description == otherTodo.description &&
      done == otherTodo.done
  end
end

class TodoList
  attr_accessor :title

  def initialize(title)
    @title = title
    @todos = []
  end


  def add(todo)
    raise TypeError.new("can only add Todo objects") unless todo.is_a? Todo
    todos << todo
  end
  alias_method :<< , :add

  def delete_item(todo_title)
    todo = todos.find {|todo| todo.title.downcase == todo_title.downcase}
    todos.delete(todo)
  end

  def size
    todos.size
  end

  def first
    todos.first
  end

  def last
    todos.last
  end

  def to_a
    todos.dup
  end

  def done?
    todos.all?(&:done?)
  end

  def item_at(idx)
    todos.fetch(idx)
  end

  def mark_done_at(idx)
    item_at(idx).done!
  end

  def mark_undone_at(idx)
    item_at(idx).undone!
  end

  def done!
    todos.each(&:done!)
  end

  def shift
    return "List Empty" if todos.empty?
    todos.shift
  end

  def pop
    return "List Empty" if todos.empty?
    todos.pop
  end

  def remove_at(idx)
    todos.delete(item_at(idx))
  end

  def each
    idx = 0
    until idx >= todos.size
      yield(item_at(idx)) if block_given?
      idx += 1
    end
    self
  end

  def each_with_object(obj)
    each { |todo| yield(todo, obj) }
    obj
  end

  def select(temp_name = 'Temp Todo')
    each_with_object(self.class.new(temp_name)) do |todo, obj|
      obj.add(todo) if yield(todo)
    end
  end
  
  def all_done
    select('Done') {|todo| todo.done? }
  end

  def all_not_done
    select('Not Done') {|todo| !todo.done? }
  end

  def find_by_title(name)
    todos.find {|todo| todo.title.downcase == name.downcase}
  end

  def mark_done(*names)
    names.each do |name|
      find_by_title(name) && find_by_title(name).done!
    end
  end

  def mark_all_done
    each { |todo| todo.done! }
  end

  def mark_all_undone
    each { |todo| todo.undone! }
  end

  def to_s
    text = "------ #{title} ------\n"
    text << todos.map(&:to_s).join("\n")
    text
  end

  private

  attr_reader :todos
end


