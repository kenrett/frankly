# Frankly
![Build Status](https://travis-ci.org/kenrett/frankly.svg?branch=master)

An opinionated sinatra app skeleton generator with Rake tasks, rspec, postgres, pry and more!

## Installation

Type this into the command line:

```
gem install frankly
```

## Dependency

Frankly is dependent on using postgres as your database. If you don't have it installed, please check out this great blogpost for [OSX](https://launchschool.com/blog/how-to-install-postgresql-on-a-mac) or [Linux](https://launchschool.com/blog/how-to-install-postgres-for-linux) from [LaunchSchool](https://launchschool.com/) on how to get set up!

## Usage

Simple type `frankly APP_NAME` and frankly will create a sinatra scaffold, git init, and bundle your application. Currently frankly does not support special characters or numbers in an `APP_NAME` but please feel free to make a Pull Request if you would like to contribute!

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kenrett/frankly. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
