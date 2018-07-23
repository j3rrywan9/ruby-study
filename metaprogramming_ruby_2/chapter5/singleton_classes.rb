#!/usr/bin/env ruby

class C
  # a method defined on C's singleton class "#C"
  class << self
    def a_class_method
      "C.a_class_method()"
    end
  end

  def a_method
    "C#a_method()"
  end
end

class D < C; end

obj = D.new

class << obj
  # a method defined on obj's singleton class "#obj"
  def a_singleton_method
    "obj#a_singleton_method()"
  end
end

puts obj.a_method  # => C#a_method()
puts obj.class  # => D
puts obj.singleton_class  # => #<Class:#<D:0x00007fd5cb0b26d0>>
puts obj.singleton_class.superclass  # => D
puts obj.singleton_class.instance_methods(false)  # => a_singleton_method

puts C.singleton_class  # => #<Class:C>
puts C.singleton_class.instance_methods(false)  # => a_class_method

puts D.singleton_class  # => #<Class:D>

puts D.singleton_class.superclass  # => #<Class:C>
puts C.singleton_class.superclass  # => #<Class:Object>

# call a class method on a subclass
puts D.a_class_method  # => C.a_class_method()
