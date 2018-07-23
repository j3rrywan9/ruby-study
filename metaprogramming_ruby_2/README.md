# Metaprogramming Ruby 2

## Chapter 1

Metaprogramming is writing code that manipulates language constructs at runtime.

Ruby is a very metaprogramming-friendly language.
It has no compile time at all, and most constructs in a Ruby program are available at runtime.

## Chapter 2

### Open Classes

In a sense, the `class` keyword in Ruby is more like a scope operator than a class declaration.
Yes, it creates classes that don't yet exist, but you might argue that it does this as a pleasant side effect.
For `class`, the core job is to move you in the context of the class, where you can define methods.

This distinction about the `class` keyword is not an academic detail.
It has an important practical consequence: you can always reopen existing classes - even standard library classes such as `String` or `Array` - and modify them on the fly.
You can call this technique *Spell: Open Class*.

### Inside the Object Model

To remove the ambiguity, you should say that `my_method` is an *instance method* (not just “a method”) of `MyClass`, meaning that it's defined in `MyClass`, and you actually need an object (or instance) of `MyClass` to call it.
It's the same method, but when you talk about the class, you call it an instance method, and when you talk about the object, you simply call it a method.

Let's wrap it all up: an object's instance variables live in the object itself, and an object's methods live in the object's class.
That's why objects of the same class share methods but don't share instance variables.

#### The truth about classes

Here is possibly the most important thing you'll ever learn about the Ruby object model: *classes themselves are nothing but objects*.

Because a class is an object, everything that applies to objects also applies to classes.
Classes, like any object, have their own class, called - you guessed it - `Class`:
```ruby
String.class  # => Class
```
By contrast, a `Class` in Ruby is quite literally the class itself, and you can manipulate it like you would manipulate any other object.

This flexibility is typical of Ruby's metaprogramming: while other languages allow you to read class-related information, Ruby allows you to *write* that information at runtime.

Like any object, classes also have methods.
The methods of an object are also instance methods of its class.
In turn, this means that the methods of a class are the instance methods of Class:
```ruby
Class.instance_method(false)  # => [:new, :allocate, :superclass]
```

#### Modules

```ruby
Class.superclass  # => Module
```
The superclass of `Class` is `Module` - which is to say, every class is also a module.
To be precise, a class is a module with three additional instance methods (`new`, `allocate`, and `superclass`) that allow you to create objects or arrange classes into hierarchies.

The main reason for having a distinction between modules and classes is clarity: by carefully picking either a class or a module, you can make your code more explicit.
Usually, you pick a module when you mean it to be included somewhere, and you pick a class when you mean it to be instantiated or inherited.

#### Constants

Any reference that begins with an uppercase letter, including the names of classes and modules, is a *constant*.

All the constants in a program are arranged in a tree similar to a file system, where modules (and classes) are *directories* and regular constants are *files*.
Like in a file system, you can have multiple files with the same name, as long as they live in different directories.
You can even refer to a constant by its *path*, as you'd do with a file.

#### The paths of constants

Constants' paths use a double colon (`::`) as a separator.

If you're sitting deep inside the tree of constants, you can provide the absolute path to an outer constant by using a leading double colon as root.

The `Module` class also provides an instance method and a class method that, confusingly, are both called `constants`.
`Module#constants` returns all constants in the current scope, like your file system's `ls` command (or `dir` command, if you're running Windows).
`Module.constants` returns all the top-level constants in the current program, including class names.

### What Happens When You Call a Method?

When you call a method, Ruby does two things:
* It finds the method.
This is a process called *method lookup*.
* It executes the method.
To do that, Ruby needs something called `self`.

#### Method lookup

When you call a method, Ruby looks into the object's class and finds the method there.
Before you look at a more complicated example, though, you need to know about two new concepts: the receiver and the ancestors chain.

The *receiver* is the object that you call a method on.

To understand the concept of an *ancestors chain*, look at any Ruby class.
Then imagine moving from the class into its superclass, then into the superclass’s superclass, and so on, until you reach `BasicObject`, the root of the Ruby class hierarchy.
The path of classes you just traversed is the ancestors chain of the class.

Now that you know what a receiver is and what an ancestors chain is, you can sum up the process of method lookup in a single sentence: to find a method, Ruby goes in the receiver's class, and from there it climbs the ancestors chain until it finds the method.

##### Modules and lookup

You learned that the ancestors chain goes from class to superclass.
Actually, the ancestors chain also includes modules.
When you `include` a module in a class (or even in another module), Ruby inserts the module in the ancestors chain, right above the including class itself.

##### The `Kernel`

The trick here is that class `Object` includes `Kernel`, so `Kernel` gets into every object's ancestors chain.
Every line of Ruby is always executed inside an object, so you can call the instance methods in `Kernel` from anywhere.
This gives you the illusion that print is a language keyword, when it's actually a method.

#### Method execution

##### The `self` keyword

##### Class definitions and `self`

In a class or module definition (and outside of any method), the role of `self` is taken by the class or module itself.

## Chapter 5

### Class Definitions Demystified

#### Inside class definition

You probably think of a class definition as the place where you define methods.
In fact, you can put any code you want in a class definition:
```ruby
class MyClass
  puts "Hello"
end
```

### Singleton Methods

#### Introducing singleton methods

As it turns out, Ruby allows you to add a method to a single object.

A method like this one, which is specific to a single object, is called a *Spell: Singleton Method*.
You can define a Singleton Method with either the syntax above or the `Object#define_singleton_method` method.

#### The truth about class methods

That's really what class methods are: they're *Singleton Methods of a class*.
In fact, if you compare the definition of a Singleton Method and the definition of a class method, you'll see that they’re the same:

#### Class macros

As an alternative, you can generate accessors by using one of the methods in the `Module#attr_*` family.
`Module#attr_reader` generates the reader, `Module#attr_writer` generates the writer, and `Module#attr_accessor` generates both:
```ruby
class MyClass
  attr_accessor :my_attribute
end
```
All the `attr_*` methods are defined on class `Module`, so you can use them whenever `self` is a module or a class.
A method such as `attr_accessor` is called a *Spell: Class Macro*.
Class Macros look like keywords, but they're just regular class methods that are meant to be used in a class definition.

### Singleton Classes

#### Singleton classes revealed

When you ask an object for its class, Ruby doesn't always tell you the whole truth.
Instead of the class that you see, an object can have its own special, hidden class.
That's called the singleton class of the object.
(You can also hear it called the *metaclass* or the *eigenclass*.
However, "singleton class" is the official name.)

Methods like `Object#class` keep the singleton class carefully hidden, but you can work around them.
Ruby has a special syntax, based on the `class` keyword, that places you in the scope of the singleton class:
```ruby
class << an_object
  # your code here
end
```
If you want to get a reference to the singleton class, you can return `self` out of the scope:
```ruby
obj = Object.new

singleton_class = class << obj
  self
end

singleton_class.class  # => Class
```
For starters, it's invisible until you resort to either `Object#singleton_class`, or the exotic `class <<` syntax.
Also, singleton classes have only a single instance (that's where their name comes from), and they can't be inherited.
More important, *a singleton class is where an object's Singleton Methods live*:
```ruby
def obj.my_singleton_method; end
obj.singleton_class.instance_methods.grep(/my_/)
```

#### Method lookup revisited

##### Method lookup review

##### Singleton classes and method lookup

As you explore singleton classes, you may notice that their names are not meant to be uttered by humans.

By this convention, `#obj` is the singleton class of `obj`, `#C` is the singleton class of `C`, and so on.

You can see how Singleton Methods fit into the normal process of method lookup.
If an object has a singleton class, Ruby starts looking for methods in the singleton class rather than the conventional class, and that's why you can call Singleton Methods such as `obj#a_singleton_method`.          If Ruby can’t find the method in the singleton class, then it goes up the ancestors chain, ending in the superclass of the singleton class—which is the object’s class.
From there, everything is business as usual.

#### Class Methods Syntaxes

Because class methods are just Singleton Methods that live in the class's singleton class, now you have three different ways to define a class method.
```ruby
def MyClass.a_class_method; end

class MyClass
  def self.another_class_method; end
end

class MyClass
  class << self
    def yet_another_class_method; end
  end
end
```
The first syntax is usually frowned upon by expert Rubyists because it duplicates the class name, making it more difficult to refactor.
The second syntax takes advantage of the fact that self in the class definition is the class itself.
The third syntax is the trickiest one: the code opens the singleton class and defines the method in there.
