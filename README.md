# Frankly

`frankly` is a Sinatra starter generator.

It creates a PostgreSQL + ActiveRecord app scaffold with a modern Sinatra setup.

## Requirements

- Ruby 3.1+
- PostgreSQL
- Bundler

## Installation

```sh
gem install frankly
```

Install and runtime banner:

```text
              .
  .---------.'---.
  '.       :    .'
    '.  .:::  .' The Chairman
      '.'::'.'    of the Board
        '||'       has arrived.
         ||
         ||
         ||
     ---====---
```

## Usage

Generate a new app:

```sh
frankly my_app
```

### Options

```sh
frankly my_app --bundle
frankly my_app --skip-git
```

- `--bundle`: runs `bundle install` in the generated app
- `--skip-git`: skips `git init`

## Generated app quickstart

```sh
cd my_app
bundle install
bundle exec rackup
```

Open http://localhost:9292.

## Development (this gem)

```sh
bin/setup
bundle exec rspec
```

## Release

```sh
bundle exec rake build
bundle exec rake install
bundle exec rake release
```

## Contributing

Issues and pull requests are welcome at:
https://github.com/kenrett/frankly

## License

MIT. See [LICENSE.txt](LICENSE.txt).
