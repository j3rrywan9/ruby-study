#!/usr/bin/env ruby

module M1
  def my_method
    'M1#my_method()'
  end
end

class C
  include M1
end

class D < C

end

puts D.ancestors
