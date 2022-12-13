def hash_each(hash, block = nil)
  idx = 0
  keys = hash.keys
  if block
    while idx < keys.size
      block.call(keys[idx], hash[keys[idx]])
      idx += 1
    end
    hash
  else
    hash.to_enum
  end
end

def array_each(array, block = nil)
  idx = 0
  if block
    while idx < array.size
      block.call(array[idx])
      idx += 1
    end
    array
  else
    array.to_enum
  end
end


def each(data_structure, &block)
  if data_structure.class == Hash
    hash_each(data_structure, block)
  else
    array_each(data_structure, block)
  end
end

arr = [1, 2, 3, 4]

p each(arr) #{ |n| puts n * 2 }

hash = {one: 1, two: 2, three: 3, four: 4}

p each(hash) #{ |k, v| puts "Keys is #{k}; Value is #{v}"}

puts 'Hello Dolly'