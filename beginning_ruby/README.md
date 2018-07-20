# Beginning Ruby

The [text.txt](text.txt) file is copied from [http://www.rubyinside.com/book/oliver.txt](http://www.rubyinside.com/book/oliver.txt)

## Chapter 6

### Reflection and discovering an object's methods

It’s possible to query almost any object within Ruby for the methods that are defined within it.
This is another part of reflection.
```ruby
a = "This is a test"
puts a.methods.join(' ')
```

The results reveal some other reflective methods too.
For example, `protected_methods`, `private_methods`, and `public_methods` all reveal methods encapsulated in different ways.

### Encapsulation

Encapsulation describes the way in which data and methods can be bundled together into objects that operate as a single unit.
Within Ruby, however, the term is often used to describe the ability for an object to have certain methods and attributes available for use publicly (from any section of code), but for others to be visible only within the class itself or by other objects of the same class.

### Polymorphism

Polymorphism is the concept of writing code that can work with objects of multiple types and classes at once.

Some of Ruby's built-in standard classes (such as Array, Hash, String, and so on) have polymorphic methods of their own.

### Nested classes

### Modules, Namespaces, and Mix-Ins

Modules provide a structure to collect Ruby classes, methods, and constants into a single, separately named and defined unit.

First, we'll look at how to use modules to create namespaces to avoid name-related clashes.

#### Namespaces

Modules provide a structure to collect Ruby classes, methods, and constants into a single, separately named and defined unit.

#### Mix-ins

However, in some cases it can be useful to share functionality between disparate classes.
In this sense, modules act like a sort of bundle of methods, classes, and constants that can be included into other classes, extending that class with the methods the module offers.

However, of more interest to us are the modules Ruby provides that you can include in your own classes to gain more functionality immediately.
Two such modules are `Enumerable` and `Comparable`.

#### Structs: quick and easy data classes

There's an easier way to create this sort of special data-holding class in Ruby with a single line of a class called a *struct*.

A struct is a special class whose only job is to have attributes and to hold data.
Here's a demonstration:
```ruby
Person = Struct.new(:name, :gender, :age)
fred = Person.new("Fred", "male", 50)
chris = Person.new("Chris", "male", 25)
puts fred.age + chris.age
```

## Chapter 7

### Projects and Using Code from Other Files

The most common way to separate functionality in Ruby is to put different classes in different files.
This gives you the ability to write classes that could be used in multiple projects simply by copying the file into your other project.

#### Basic file inclusion

Ruby does not include the current directory in the path of directories to search for Ruby files by default, so you can either specify the current directory specifically by using `./`, as above, or by using `require_relative`.

### Ruby Gems

RubyGems is a packaging system for Ruby programs and libraries.
It enables developers to package their Ruby libraries in a form that's easy for users to maintain and install.
RubyGems makes it easy to manage different versions of the same libraries on your machine, and gives you the ability to install them with a single line at the command prompt.

Each individually packaged Ruby library (or application) is known simply as a gem or RubyGem.
Gems have names, version numbers, and descriptions.
You can manage your computer's local installations of gems using the gem command, available from the command line.

#### Finding Gems

It's useful to get a list of the gems that are installed on your machine, as well as get a list of the gems available for download and installation.
To do this, you use gem's list command.

### Bundler

Bundler is a tool that was developed to help you manage the dependencies of a project (essentially, the libraries upon which your project depends) in a more structured way.
It comes by default on some Ruby installs, but you can always ensure it's installed with `gem install bundler`.

Bundler lets you create a file (called Gemfile) within a project's directory that specifies what libraries the project depends on.

If you run `bundle install` from the directory where a Gemfile is present, Bundler ensures that the right gems are installed or upgraded to the right versions.

One other thing to be aware of is that when you install or upgrade gems, another file is created or updated called Gemfile.lock.
This is not a file you are meant to change yourself, but it simply reflects what the precise set of dependencies are, along with their version numbers, so that if you distribute the project anywhere else, the very same set of libraries and versions will be installed properly.

The Gemfile.lock's job, therefore, is to explicitly communicate which versions of which libraries are working with the project right now.

## Chapter 8
