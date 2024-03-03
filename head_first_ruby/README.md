# Head First Ruby

## Chapter 2. Methods and Classes: Getting Organized

### Defining methods

If you want calls to your method to include arguments, you'll need to add **parameters** to the method definition.
Parameters appear after the method name, within parentheses.
(You should leave off the parentheses if there are no parameters.)
Each argument on the method call gets stored in one of the parameters within the method.

The method body consists of one or more Ruby statements that are executed when the method is called.

### Calling methods you've defined

Methods that are defined outside of any class (like these examples) are included in the top-level execution environment.
Like we saw back in Chapter 1, you can call them anywhere in your code, *without* using the dot operator to specify a receiver.

### Method names

The method name can be one or more lowercase words, separated by underscores.
(This is just like the convention for variable names.)
Numbers are legal, but rarely used.

### Parameters

If you need to pass data into your method, you can include one or more parameters after the method name, separated by commas.
In your method body, parameters can be accessed just like any variable.

### Optional parameters

There's an easy solution, though: *make the parameter optional*.
You can provide a default value in the method declaration.

Here's an example of a method that uses default values for some of its parameters:
```ruby
def order_soda(flavor, size = "medium", quantity = 1)
  if quantity == 1
    plural = "soda"
  else
    plural = "sodas"
  end
  puts "#{quantity} #{size} #{flavor} #{plural}, coming right up!"
end
```
Now, if you want to override the default, just provide an argument with the value you want.
And if you’re happy with the default, you can skip the argument altogether.
```ruby
order_soda("orange")
order_soda("lemon-lime", "small", 2)
order_soda("grape", "large")
```
There is one requirement to be aware of with optional parameters: they need to appear *after* any other parameters you intend to use.
If you make a required parameter following an optional parameter, you won’t be able to leave the optional parameter off:

### Return values

As in most languages, Ruby methods have a **return value**, a value that they send back to the code that called them.
A Ruby method can return a value to its caller using the `return` keyword.

#### Implicit return values

You don't actually need the return keyword in the above method.
The value of the last expression evaluated within a method automatically becomes that method's return value.

### Returning from a method early

### Some messy method

### Too many arguments

### Too many "if" statements

### Designing a class

The benefit of using objects is that they keep a set of data, and the methods that operate on that data, in one place.

To start creating your own objects, though, you're going to need classes.
A **class** is a blueprint for making objects.
When you use a class to make an object, the class describes what that object *knows* about itself, as well as what that object *does*.

An **instance** of a class is an object that was made using that class.
You only have to write *one* class, but you can make *many* instances of that class.

**Instance variables** are variables that belong to one object.
They comprise everything the object **knows** about itself.
They represent the object's state (its data), and they can have different values for each instance of the class.

**Instance methods** are methods that you can call directly on that object.
They comprise what the object **does**.
They have access to the object's instance variables, and can use them to change their behavior based on the values in those variables.

### What's the difference between a class and an object?

A class is a blueprint for an object.
The class tells Ruby how to make an object of that particular type.
Objects have instance variables and instance methods, but those variables and methods are *designed* as part of the class.

Each instance of a class can have its own values for the instance variables used within that class's methods.

### Your first class

We use the `class` keyword to start a new class definition, followed by the name of our new class.
```ruby
class Dog

  def talk
    puts "Bark!"
  end

  def move(destination)
    puts "Running to the #{destination}."
    end

end
```
Within the class definition, we can include method definitions.
Any method we define here will be available as an instance method on instances of the class.

We mark the end of the class definition with the `end` keyword.

### Creating new instances (objects)

If we call the `new` method on a class, it will return a new instance of that class.
We can then assign that instance to a variable, or do whatever else we need to do with it.
```ruby
fido = Dog.new
rex = Dog.new
```
Once we have one or more instances of the class, we can call their instance methods.
We do it in the same way we've called all other methods on objects so far: we use the dot operator to specify which instance is the method's receiver.
```ruby
fido.talk
rex.move("food bowl")
```

### Breaking up our giant methods into classes

### Creating instances of our new animal classes

### Updating our class diagram with instance methods

### Instance variables live as long as the instance does

An object can store data in **instance variables**: variables that are tied to a particular object instance.
Data written to an object’s instance variables stays with that object, getting removed from memory only when the object is removed.

An instance variable looks just like a regular variable, and follows all the same naming conventions.
The only difference in syntax is that its name begins with an “at” symbol (`@`).

Here's that Dog class again.
It's identical to the previous one, except that we added two little `@` symbols to convert the *two* local variables to *one* instance variable.
```ruby
class Dog

  def make_up_name
    @name = "Sandy"
  end

  def talk
    puts "#{@name} says Bark!"
  end

end
```

### Encapsulation

Ruby never allows us to access instance variables directly from outside our class.

To help avoid exposing an object's data to malicious (or clumsy) users, most object-oriented languages encourage the concept of **encapsulation**: preventing other parts of the program from directly accessing or changing an object's instance variables.

### Attribute accessor methods

To encourage encapsulation and protect your instances from invalid data, Ruby doesn't allow you to access or change instance variables from outside the class.
Instead, you can create **accessor methods**, which will write values to the instance variables and read them back out again for you.
Once you're accessing your data through accessor methods, it's easy to extend those methods to *validate* your data - to reject any bad values that get passed in.

Ruby has two kinds of accessor methods: *attribute writers* and *attribute readers*.
(An *attribute* is another name for a piece of data regarding an object.)
Attribute *writer* methods *set* an instance variable, and attribute *reader* methods *get* the value of an instance variable back.

Here's a simple class with writer and reader methods for an attribute named my_attribute:
```ruby
class MyClass

  def my_attribute=(new_value)
    @my_attribute = new_value
  end

  def my_attribute
    @my_attribute
  end

end
```

Accessor methods are just ordinary instance methods; we only refer to them as "accessor methods" because their primary purpose is to access an instance variable.

### Using accessor methods

Writing a reader and writer method by hand for each attribute can get tedious, though.
Next, we'll look at an easier way...

### Attribute writers and readers

Creating this pair of accessor methods for an attribute is so common that Ruby offers us shortcuts - methods named `attr_writer`, `attr_reader`, and `attr_accessor`.
Calling these three methods within your class definition will automatically define new accessor methods for you:

| Write this within your class definition... | ...and Ruby will automatically define these methods: |
| --- | --- |
| attr_writer :name | |
| attr_reader :name | |
| attr_accessor :name | |

All three of these methods can take multiple arguments, specifying multiple attributes that you want to define accessors for.
```ruby
attr_accessor :name, :age
```

#### Symbols

In case you're wondering, those `:name` and `:age` things are symbols.
A Ruby **symbol** is a series of characters, like a string.
Unlike a string, though, a symbol's value can't be changed later.
That makes symbols perfect for use inside Ruby programs, to refer to anything whose name doesn't (usually) change, like a method.

A symbol reference in Ruby code always begins with a colon (`:`).
A symbol should be in all lowercase, with words separated by underscores, just like a variable name.

### Attribute writers and readers in action

### Ensuring data is valid with accessors

## Chapter 3. Inheritance: Relying on Your Parents

### Copy, paste... Such a waste...

### Inheritance to the rescue!

Fortunately, like most object-oriented languages, Ruby includes the concept of **inheritance**, which allows classes to inherit methods from one another.
If one class has some functionality, classes that inherit from it can get that functionality *automatically*.

Instead of repeating method definitions across many similar classes, inheritance lets you move the common methods to a single class.
You can then specify that other classes inherit from this class.
The class with the common methods is referred to as the **superclass**, and the classes that inherit those methods are known as **subclasses**.

If a superclass has instance methods, then its subclasses automatically inherit those methods.
You can get access to all the methods you need from the superclass, without having to duplicate the methods' code in each subclass.

Note that in Ruby, subclasses technically do not inherit instance variables; they inherit the *attribute accessor methods* that create those variables.

### Defining a superclass (requires nothing special)

### Defining a subclass (is really easy)

A subclass definition looks just like an ordinary class definition, except that you specify the superclass it will inherit from.

Ruby uses a less-than (`<`) symbol because the subclass is a *subset* of the superclass.

### Adding methods to subclasses

### Subclasses keep inherited methods alongside new ones

A subclass that defines its own methods doesn't lose the ones it inherits from its superclass, though.

### Overriding methods

If the superclass’s behavior isn't what you need in the subclass, inheritance gives you another mechanism to help: method *overriding*.
When you **override** one or more methods in a subclass, you replace the inherited methods from the superclass with methods specific to the subclass.

If Ruby sees that the requested method is defined on a subclass, it will call that method and stop there.

But if the method’s not found, Ruby will look for it on the superclass, then the superclass's superclass, and so on, up the chain.

### The "super" keyword

When you use the `super` keyword within a method, it makes a call to a method of the same name on the superclass.

If we make a call to the *overriding* method on the *subclass*, we'll see that the `super` keyword makes a call to the *overridden* method on the *superclass*.

The `super` keyword works like an ordinary method call in almost every respect.

Another way in which using the super keyword is like a regular method call: you can pass it arguments, and those arguments will be passed to the superclass's method.
```ruby
class Person

  def greet_by_name(name)
    "Hello, #{name}!"
  end

end

class Friend < Person
  
  def greet_by_name(name)
    basic_greeting = super(name)
    "#{basic_greeting} Glad to see you!"
  end

end
```

But here's a way that `super` *differs* from a regular method call: if you leave the arguments *off*, the superclass method will automatically be called with the same arguments that were passed to the subclass method.

### A super-powered subclass

### The `Object` class

When you define a new class, Ruby implicitly sets a class called `Object` as its superclass (unless you specify a superclass yourself).

Even if you *do* specify a superclass for your class, that superclass probably inherits from `Object`.
That means almost every Ruby object, directly or indirectly, has `Object` as a superclass!

### Why everything inherits from the `Object` class

## Chapter 4. Initializing Instances: Off to a Great Start

### "nil" stands for nothing

### "/" is a method

### The "initialize" method

Ruby provides a mechanism to help with this situation: the `initialize` method.
The `initialize` method is your chance to step in and make the object safe to use, before anyone else attempts to call methods on it.
```ruby
class MyClass
  def initialize
    puts "Setting up new instance!"
  end
end
```

Ruby calls the `initialize` method on new objects after they're created.

### Employee safety with "initialize"

### Arguments to "initialize"

It's for situations like this that any arguments to the `new` method are passed on to `initialize`.
```ruby
class MyClass
  def initialize(my_param)
    puts "Got a parameter from 'new': #{my_param}"
  end
end

MyClass.new("hello")
```

### Using optional parameters with "initialize"

Since `initialize` is an ordinary method, it can utilize all the features of ordinary methods.
And that includes optional parameters.

All Ruby classes inherit an `initialize` method from the `Object` superclass.

### "initialize" does an end-run around our validation

### "initialize" and validation

### Call other methods on the same instance with "self"

Ruby has an answer: the `self` keyword.
Within instance methods, `self` always refers to the current object.

### When "self" is optional

If you don't specify a receiver using the dot operator, the receiver defaults to the current object, `self`.

### Restoring "initialize" methods

### Inheritance and "initialize"

### "super" and "initialize"

### Class methods

It's for situations like this that Ruby supports **class methods**: methods that you can invoke directly on a class, without the need for any instance of that class.

A class method definition is very similar to any other method definition in Ruby.
The difference: you specify that you're defining it *on the class itself*.
```ruby
class MyClass

  def MyClass.my_class_method(p1, p2)
    puts "Hello from MyClass!"
    puts "My parameters: #{p1}, #{p2}"
  end

end
```
Within a class definition (but outside any instance method definitions), Ruby sets `self` to refer to the class that's being defined.
So many Rubyists prefer to replace the class name with `self`:
```ruby
class MyClass

  def self.my_class_method(p1, p2)
    puts "Hello from MyClass!"
    puts "My parameters: #{p1}, #{p2}"
  end

end
```

## Chapter 5. Arrays and Blocks: Better Than Loops

### Arrays

An **array** is used to hold a collection of objects.
The collection can be any size you need.
An array can hold objects of any type (even other arrays).
You can even mix multiple types together in the same array.

We can create an array object and initialize it with data by using an array literal: square brackets (`[]`) surrounding a comma-separated list of values.

### Accessing arrays

Items in an array are numbered from left to right, starting with 0.
This is called the array **index**.

To retrieve an item, you specify the integer index of the item you want within square brackets:
```ruby
prices[0]
prices[1]
prices[2]
```
You can assign to a given array index with `=`, much like assigning to a variable.

### Arrays are objects, too!

### Looping over the items in an array

### The repeating loop

### Blocks

A **block** is a chunk of code that you associate with a method call.
While the method runs, it can *invoke* (execute) the block one or more times.
*Methods and blocks work in tandem to process your data*.

#### Blocks are mind-bending stuff. But stick with it!

### Defining a method that takes blocks

Blocks and methods work in tandem.
In fact, you can't *have* a block without also having a method to accept it.
So, to start, let's define a method that works with blocks.

### Your first block

Are you ready? Here it comes: your first glimpse of a Ruby block.
```ruby
my_method do
  puts "We're in the block!"
end
```

### Flow of control between a method and block

### Calling the same method with different blocks

### Calling a block multiple times

A method can invoke a block as many times as it wants.

### Block parameters

In a similar vein, a method can pass one or more arguments to a block.
Block parameters are similar to method parameters; they're values that are passed in when the block is run, and that can be accessed within the block body.

### Using the "yield" keyword

So far, we've been treating blocks like an argument to our methods.
We've been declaring an extra method parameter that takes a block as an object, then using the `call` method on that object.
```ruby
def twice(&my_block)
  my_block.call
  my_block.call
end
```
We mentioned that this wasn't the easiest way to accept blocks, though.
Now, let's learn the less obvious but more concise way: the `yield` keyword.

The `yield` keyword will find and invoke the block a method was called with - there's no need to declare a parameter to accept the block.

This method is functionally equivalent to the one above:
```ruby
def twice
  yield
  yield
end
```
Just like with `call`, we can also give one or more arguments to `yield`, which will be passed to the block as parameters.
Again, these methods are functionally equivalent:
```ruby
def give(&my_block)
  my_block.call("2 turtle doves", "1 partridge")
end

def give
  yield "2 turtle doves", "1 partridge"
end
```

### Block formats

So far, we've been using the `do...end` format for blocks.
Ruby has a second block format, though: "curly brace" style.
You'll see both formats being used "in the wild," so you should learn to recognize both.

By the way, you've probably noticed that all our `do...end` blocks span multiple lines, but our curly-brace blocks all appear on a single line.
This follows another convention that much of the Ruby community has adopted.

### The "each" method

It's an instance method that appears on every `Array` object, and it's called `each`.

The `each` method uses this feature of Ruby to loop through each of the items in an array, yielding them to a block, one at a time.
```ruby
["a", "b", "c"].each { |param| puts param }
```

### DRYing up our code with "each" and blocks

### Blocks and variable scope

### The "each" method, step-by-step

### Blocks and variable scope

But, if you define a variable *before* a block, you can access it inside the block body.
You can *also* continue to access it *after* the block ends!

## Chapter 6. Block Return Values: How Should I Handle This?

But a *block* can also return data to the *method*.
This feature lets the method get *directions* from the block, allowing it to do more of the work.

### A big collection of words to search through

### Opening the file

Ruby has a built-in class named `File` that represents files on disk.
To open a file named *reviews.txt* in the current directory (folder) so you can read data from it, call the `open` method on the `File` class:
```ruby
review_file = File.open("reviews.txt")
```
The `open` method returns a new `File` object.
(It actually calls `File.new` for you, and returns the result of that.)

There are many different methods that you can call on this `File` instance, but the most useful one for our current purpose is the `readlines` method, which returns all the lines in the file as an array.
```ruby
lines = review_file.readlines
puts "Line 4: #{lines[3]}"
puts "Line 1: #{lines[0]}"
```

### Safely closing the file

We've opened the file and read its contents.
Your next step should be to *close the file*.
Closing the file tells the operating system, "I'm done with this file; others can use it now."
```ruby
review_file.close
```

### Safely closing the file, with a block

Ruby offers a way to open a file, do whatever you need with it, and *automatically* close it again when you're done with it.
The secret is to call `File.open` with *a block*!
```ruby
File.open("reviews.txt") do |review_file|
  lines = review_file.readlines
end
```

### Don't forget about variable scope!

Switching to the block form of `File.open` has introduced a problem, however.
We store the array returned by `readlines` in a variable *within* the block, but we can't access it *after* the block.

The problem is that we're *creating* the `lines` variable *within* the block.
As we learned back in Chapter 5, any variable created within a block has a scope that's limited to the body of that block.
Those variables can't be "seen" from outside the block.

But, as we also learned in Chapter 5, local variables declared *before* a block can be seen *within* the block body (and are still visible after the block, of course).
So the simplest solution is to create the lines variable before declaring the block.
```ruby
lines = []

File.open("reviews.txt") do |review_file|
  lines = review_file.readlines
end

puts lines.length
```

### Finding array elements we want, with a block

### The verbose way to find array elements, using "each"

You can call the `include?` method on any instance of the String class to determine if it includes a substring (which you pass as an argument).
Remember, by convention, methods that end in `?` return a Boolean value.
The `include?` method will return `true` if the string contains the specified substring, and `false` if it doesn't.
```ruby
my_string = "I like apples, bananas, and oranges"
puts my_string.include?("bananas")
puts my_string.include?("elephants")
```

### Introducing a faster method...

But actually, Ruby offers a much quicker way to do this.
The `find_all` method uses a block to run a test against each element in an array.
It returns a new array that contains only the elements for which the test returned a true value.

We can use the `find_all` method to achieve the same result, by calling `include?` in its block:
```ruby
lines = []

File.open("reviews.txt") do |review_file|
  lines = review_file.readlines
end

relevant_lines = lines.find_all { |line| line.include?("Truncated") }
```

### Blocks have a return value

That's right, just like methods, Ruby blocks return the value of the last expression they contain!
It's returned to the method as the result of the `yield` keyword.

### Putting it all together

### A closer look at the block return values

### Breaking a string into an array of words

Strings have a `split` instance method that you can call to split them into an array of substrings.
```ruby
p "1-800-555-0199".split("-")
p "his/her".split("/")
p "apple, avocado, anvil".split(", ")
```
The argument to `split` is the *separator*: one or more characters that separate the string into sections.

### Finding the index of an array element

If you pass an argument to the `find_index` method, it will find us the first index where that element occurs in the array.

### Making one array based on another, using "map"

Ruby has just the magic array processor we're looking for: the `map` method.
The `map` method takes each element of an array, passes it to a block, and builds a new array out of the values the block returns.

## Chapter 7. Hashes: Labeling Data

### Hashes

Ruby has another way of storing collections of data: *hashes*.
A **hash** is a collection where each value is accessed via a *key*.
Keys are an easy way to get data back out of your hash.

### Hashes are objects

We've been hearing over and over that everything in Ruby is an object.
We saw that arrays are objects, and it probably won't surprise you to learn that hashes are objects, too.
```ruby
protons = {"H" => 1, "Li" => 3, "Ne" => 10}
puts protons.class
```

### Hashes return "nil" by default

So what happened?
As we saw in Chapter 5, if you try to access an array element that hasn't been assigned to yet, you'll get `nil` back.
If you try to access a *hash key* that has never been assigned to, the default value is *also* `nil`.

### `nil` (and only `nil`) is "falsy"

Ruby treats `nil` like it's false to make it easier to test whether values have been assigned or not.

### Returning something other than "nil" by default

Without any arguments, `Hash.new` works just like `{}`, giving you a hash that returns `nil` for unassigned keys.

But when you call `Hash.new` and pass an object as an argument, that argument becomes that hash's default object.
Any time you access a key in that hash that hasn't been assigned to yet, instead of `nil`, you'll get the default object you specified.

### Hashes and "each"

Hashes also have an `each` method, which works in about the same way.
The only difference is that on hashes, `each` expects a block with *two* parameters: one for the key, and one for the corresponding value.

### Using hashes as method parameters

The convention in Ruby is to use symbols instead of strings for hash parameter keys, because looking up symbol keys is more efficient than looking up strings.

### Leave off the braces!

### Leave off the arrows!

If a hash uses symbols as keys, hash literals let you leave the colon (`:`) off the symbol and replace the hash rocket (`=>`) with a colon.

### Keyword arguments

### Required keyword arguments

## Chapter 8. References: Crossed Signals

### The heap

### References

## Chapter 9. Mixins: Mix It Up

In this chapter, we'll learn about **modules** and **mixins**, a powerful way to *group methods together* and then share them *only with particular classes that need them*.

### Using modules as mixins

Ruby offers us **modules** as a way to group related methods.
A module starts with the keyword `module` and the module name (which must be capitalized) and ends with the keyword `end`.
In between, in the module body, you can declare one or more methods.

Looks similar to a class, right?
That's because a class is actually a kind of module.
There's a key difference, though.
You can create instances of a class, but you can't create instances of a module.

Modules that are *designed* to be mixed into classes are often referred to as **mixins**.
Just as a superclass can have more than one subclass, a mixin can be mixed into any number of classes.

Now, here's the cool part: any number of *modules* can be mixed into a single *class*.
The class will gain the functionality of *all* the modules!

### Mixins, behind the scenes

Ruby adds the module to the list of places it will look for methods, between the class you're mixing it into and its superclass.

From then on, if a method isn't found on the class, Ruby will look for it in the module.
And that's how mixins add methods to a class!

The instance variables don't belong to the module at all; they belong to the instances of the classes that mix the module in.

### Why you shouldn't add "initialize" to a mixin

The problem is that the `initialize` method from the class is *overriding* the `initialize` method from the mixin.

### Mixins and method overriding

For a given class, you can get a list of all the places that Ruby will look for methods (both mixins and superclasses) by using the `ancestors` class method.
It will return an array with all of the class's mixins and superclasses, in the order that they'll be searched.

Ruby searches for instance methods in the modules and classes shown in a class's `ancestors` array, in order.
If the method it's looking for is found in a class, it just invokes that method.
Any method by the same name in a mixin is ignored; that is, it gets *overridden* by the class’s method.

## Chapter 10. Comparable and Enumerable: Ready-Made Mixes

### Mixins built into Ruby

### Constants

By convention, constant names should be `ALL_CAPS`.
You can assign a value to a constant within a class or module body, and then access that constant from anywhere within that class or module.

### The Comparable mixin

### The Enumerable module

You just have to provide a specific method that `Enumerable` needs to call.
It's a method you've worked with before on other classes: the `each` method.
The methods in `Enumerable` will call on your `each` method to loop through the items in your class, and perform whatever operation you need on them.

## Chapter 11. Documentation: Read the Manual

### Learning how to learn more

### Ruby's core classes and modules

As we've said before, Ruby comes with a huge collection of classes and modules to handle a wide variety of common computing tasks.
Many of these are automatically loaded every time Ruby runs, without the need to load any external libraries; these are known as Ruby's **core** classes and modules.

### Documentation

### HTML documentation

### Listing available classes and modules

### The Ruby standard library

### Where Ruby docs come from: rdoc

You can use *rdoc*, a program included with Ruby, to generate documentation for your code.
You give rdoc a Ruby source file to parse, and it will output HTML files with the documentation.

### Adding your own documentation, with comments

## Chapter 12

### The ensure clause

If you have some code that you need to run *regardless* of whether there's an exception, you can put it in an `ensure` clause.
The `ensure` clause should appear in a `begin`/`end` block, after all the `rescue` clauses.
Any statements between the `ensure` and `end` keywords are guaranteed to be run before the block exits.

## Chapter 13

### MiniTest: Ruby's standard unit-testing library

## Chapter 14

### A simple sinatra app
