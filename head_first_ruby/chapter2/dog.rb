#!/usr/bin/env ruby

class Dog
  attr_reader :name, :age

  # Customized attribute writer
  def name=(value)
    if value == ""
      raise "Name can't be blank!"
    end
    @name = value
  end

  # Customized attribute writer
  def age=(value)
    if value < 0
      raise "An age of #{value} isn't valid!"
    end
    @age = value
  end

  def report_age
    puts "#{@name} is #{@age} years old."
  end

  def talk
    puts "Bark!"
  end

  def move(destination)
    puts "#{@name} runs to the #{destination}."
  end
end

dog = Dog.new
dog.name = "Daisy"
dog.age = 3
dog.report_age
dog.talk
dog.move("bed")
