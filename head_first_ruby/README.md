# Head First Ruby

## Chapter 2

### Designing a class

A **class** is a blueprint for making objects.
When you use a class to make an object, the class describes what that object *knows* about itself, as well as what that object *does*.

### Your first class

We use the `class` keyword to start a new class definition, followed by the name of our new class.

Within the class definition, we can include method definitions.
Any method we define here will be available as an instance method on instances of the class.

We mark the end of the class definition with the `end` keyword.

### Creating new instances (objects)

If we call the `new` method on a class, it will return a new instance of that class.

### Instance variables live as long as the instance does

An object can store data in **instance variables**: variables that are tied to a particular object instance.
Data written to an object’s instance variables stays with that object, getting removed from memory only when the object is removed.

An instance variable looks just like a regular variable, and follows all the same naming conventions.
The only difference in syntax is that its name begins with an “at” symbol (`@`).

### Encapsulation

Ruby never allows us to access instance variables directly from outside our class.

### Attribute accessor methods

To encourage encapsulation and protect your instances from invalid data, Ruby doesn’t allow you to access or change instance variables from outside the class.
Instead, you can create **accessor methods**, which will write values to the instance variables and read them back out again for you.

Ruby has two kinds of accessor methods: *attribute writers* and *attribute readers*.
(An *attribute* is another name for a piece of data regarding an object.)
Attribute *writer* methods *set* an instance variable, and attribute *reader* methods *get* the value of an instance variable back.

Accessor methods are just ordinary instance methods; we only refer to them as “accessor methods” because their primary purpose is to access an instance variable.

### Using accessor methods

### Attribute writers and readers

Creating this pair of accessor methods for an attribute is so common that Ruby offers us shortcuts — methods named `attr_writer`, `attr_reader`, and `attr_accessor`.
Calling these three methods within your class definition will automatically define new accessor methods for you.

## Chapter 3

### Inheritance to the rescue!

Fortunately, like most object-oriented languages, Ruby includes the concept of **inheritance**, which allows classes to inherit methods from one another.

Note that in Ruby, subclasses technically do not inherit instance variables; they inherit the *attribute accessor methods* that create those variables.

### Defining a subclass (is really easy)

A subclass definition looks just like an ordinary class definition, except that you specify the superclass it will inherit from.

Ruby uses a less-than (`<`) symbol because the subclass is a *subset* of the superclass.

### Adding methods to subclasses

### Subclasses keep inherited methods alongside new ones

A subclass that defines its own methods doesn’t lose the ones it inherits from its superclass, though.

### Overriding methods

If the superclass’s behavior isn’t what you need in the subclass, inheritance gives you another mechanism to help: method *overriding*.
When you **override** one or more methods in a subclass, you replace the inherited methods from the superclass with methods specific to the subclass.

If Ruby sees that the requested method is defined on a subclass, it will call that method and stop there.

But if the method’s not found, Ruby will look for it on the superclass, then the superclass’s superclass, and so on, up the chain.

### The "super" keyword

When you use the `super` keyword within a method, it makes a call to a method of the same name on the superclass.

If we make a call to the *overriding* method on the *subclass*, we’ll see that the `super` keyword makes a call to the *overridden* method on the *superclass*.

The `super` keyword works like an ordinary method call in almost every respect.
