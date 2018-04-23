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

`Polyhedral::Die.d4` to create a four-sided die
`Polyhedral::Die.d6` to create a six-sided die
`Polyhedral::Die.d8` to create a eight-sided die
`Polyhedral::Die.d10` to create a ten-sided die
`Polyhedral::Die.d12` to create a twelve-sided die
`Polyhedral::Die.d20` to create a twenty-sided die
`Polyhedral::Die.new(n)` to create an arbitrary n-sided die

`Polyhedral::Dice.new(array_of_dice)` to create a dice set

```
dice = Polyhedral::Dice.new(Array.new(4) {Die.d6})
dice.roll # rolls the dice - returns the set of dice
dice.roll.reroll_ones # rolls the dice, rerolls any dice showing a one
dice.roll.drop_lowest # rolls the dice, drops the lowest die (now have 3d6 left)
dice.sum # adds up the dice faces
```


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/shadowradiance/polyhedral. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Polyhedral project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/shadowradiance/polyhedral/blob/master/CODE_OF_CONDUCT.md).
