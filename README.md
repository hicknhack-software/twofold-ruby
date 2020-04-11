# Twofold Ruby

**Generate correctly indented source code with the power of Ruby**

Welcome to the Ruby implementation of Twofold.

[![Gem Version](https://img.shields.io/gem/v/twofold.svg)](http://rubygems.org/gems/twofold)
[![Build Status](https://img.shields.io/travis/hicknhack-software/twofold-ruby.svg?branch=master)](http://travis-ci.org/hicknhack-software/twofold-ruby)

## Motivation

Most template engines like Slim or Haml are focused towards HTML.
ERB allows you to generate any text, but control structures are cumbersome.

We want to be able to read the target language and also the control language.

With the power of Ruby it's all very easy.

## Features

* indentation stacking
* control every generated line and every whitespace
* some unit tests

## Syntax

Unlike most template languages every line is Ruby unless it starts with on of:

* `|` - followed by output text, breaks the output line
* `\` - followed by output text without breaking the output line
* `=` - followed by ruby code

Output text can contain `#{interpolated}` ruby code.

Whitespaces BEFORE these symbols are ignored.
But whitespaces AFTER the symbols are used as output indentations.
These indentations stack.

Let's look at an example:

## Example

```twofold
def self.greet_method(name, greet)
                    |def greet_#{name}(name)
                    |  puts("#{greet} \#{name}")
                    |end
  return # be careful what you return.
end
                    |class Greeters
methods.each do |m|
                    =  greet_method(m[:name], m[:greet])
end
                    |end
```

If we provide the following locals:
```ruby
locals = {
  methods: [
    { name: "hello", greet: "Hello World of " },
    { name: "tag", greet: "Guten Tag " },
  ]
}
```

Twofold will produce:
```ruby
class Greeters
  def greet_world(name)
    puts("Hello World of #{name}")
  end
  def greet_tag(name)
    puts("Guten Tag #{name}")
  end
end
```

Notice how all the methods and their content are indented into the class, even though there is no indentation in the template?
This is because we call `greet_method` with the two space indentation.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'twofold'
```

## Usage

You simply create a Tilt template (`Twofold::Template`)

```ruby
require 'twofold'

Twofold::Template.new('template.twofold').render(scope)
```

## Development

After checking out the repo, run `bundle install` to install dependencies.
Then, run `rake spec` to run the tests.
You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.
To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, 
which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/hicknhack-software/twofold.temple. 
This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to 
the [code of conduct](https://github.com/hicknhack-software/twofold-ruby/blob/master/CODE_OF_CONDUCT.md).

## License

Twofold is released under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the twofold project's codebases, issue trackers, chat rooms and mailing lists 
is expected to follow the [code of conduct](https://github.com/hicknhack-software/twofold-ruby/blob/master/CODE_OF_CONDUCT.md).
