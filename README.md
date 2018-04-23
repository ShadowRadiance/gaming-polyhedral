# Polyhedral

Roll some dice. In D&D stylings.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'polyhedral'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install polyhedral

## Usage

`3.d6+4` to roll a six-sided die three times and add 4 to the total

`4.d6.drop_lowest` to roll four six-sided dice and add together the best three.

`1.d20.with_advantage` to roll two d20 and keep the best one

`Polyhedral::Die.d20.with_advantage` will manage the same thing

`1.d20.with_disadvantage` to roll two d20 and keep the crappy one

`Polyhedral::Die.d20.with_disadvantage` will manage the same thing

`%w{str dex con int wis cha}.map {|attr| [attr, 4.d6.drop_lowest]}.to_h` will give you your starting character ability scores

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/shadowradiance/polyhedral. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Polyhedral project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/shadowradiance/polyhedral/blob/master/CODE_OF_CONDUCT.md).
