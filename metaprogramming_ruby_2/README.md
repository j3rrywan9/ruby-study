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

Let's wrap it all up: an object’s instance variables live in the object itself, and an object's methods live in the object's class.
That's why objects of the same class share methods but don't share instance variables.
