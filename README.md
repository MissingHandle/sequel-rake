# sequel-rake

Provides useful rake tasks when working with the awesome Sequel gem.

The `database.yml` must be located at `./database.yml` or `./config/database.yml` in
order to be located.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sequel-rake'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sequel-rake

## Usage

```ruby
# Rakefile

require 'sequel/rake'
Sequel::Rake.load!
```

```
$ bundle exec rake ...

sequel:init             # Creates a database.yml file
sequel:generate[name]   # Generate a new migration file `sequel:generate[create_books]`
sequel:migrate[version] # Migrate the database (you can specify the version with `db:migrate[N]`)
sequel:rollback[step]   # Rollback the database N steps (you can specify the version with `db:rollback[N]`)
sequel:remigrate        # Undo all migrations and migrate again
```

## TODO

* Rollback to previous version
* Write some tests
* Seeds

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sandelius/sequel-rake. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
