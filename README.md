# Frankly

`frankly` is a small Thor-based Sinatra scaffold generator.

It creates a PostgreSQL + ActiveRecord app with a minimal RSpec setup.

## Requirements

- Ruby 3.1+
- PostgreSQL
- Bundler

## Installation

```sh
gem install frankly
```

## Usage

```sh
frankly my_app
```

Common options:

```sh
frankly my_app --bundle
frankly my_app --skip-git
```

- `--bundle`: runs `bundle install` in the generated app
- `--skip-git`: skips `git init`

## What It Generates

```text
my_app/
  app.rb
  config.ru
  Gemfile
  Rakefile
  config/
    environment.rb
    database.rb
  app/views/
    layout.erb
    index.erb
  spec/
    spec_helper.rb
    requests/app_spec.rb
```

## Name and DB Naming Behavior

- The generated folder keeps your requested name (downcased), including hyphens.
- Default database names are PostgreSQL-friendly and use underscores.
- Example: `frankly my-app` creates `my-app/`, with default DB names like `my_app_development`.

## Generated App Quickstart

```sh
cd my_app
bundle install
bundle exec rackup
```

Open [http://localhost:9292](http://localhost:9292).

## Troubleshooting

- PostgreSQL not running:
  - Start Postgres and set `DATABASE_URL`, then run `bundle exec rake db:create db:migrate`.
- Port already in use (`9292`):
  - Run on another port, e.g. `bundle exec rackup -p 9393`.

## Development (this gem)

```sh
bin/setup
bundle exec rspec
```

## License

MIT. See [LICENSE.txt](LICENSE.txt).
