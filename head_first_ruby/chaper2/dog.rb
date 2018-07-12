#!/usr/bin/env ruby

class Dog
  attr_accessor :name, :age

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
