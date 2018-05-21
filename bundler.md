# Bundler

Bundler is a tool that was developed to help you manage the dependencies of a project (essentially, the libraries upon which your project depends) in a more structured way.
It comes by default on some Ruby installs, but you can always ensure it's installed with `gem install bundler`.

Bundler lets you create a file (called `Gemfile`) within a project's directory that specifies what libraries the project depends on.

If you run `bundle install` from the directory where a Gemfile is present, Bundler ensures that the right gems are installed or upgraded to the right versions.

One other thing to be aware of is that when you install or upgrade gems, another file is created or updated called `Gemfile.lock`.
This is not a file you are meant to change yourself, but it simply reflects what the precise set of dependencies are, along with their version numbers, so that if you distribute the project anywhere else, the very same set of libraries and versions will be installed properly.
The Gemfile.lock's job, therefore, is to explicitly communicate which versions of which libraries are working with the project right now.
