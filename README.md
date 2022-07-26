# Notify

Notify uses Queue to store messages. The notifier module monitors the queue and sends the messages to the url at specified intervals. The notifier is run in a separate thread. The program also creates threads for entering data and executing http requests so as not to disturb the main routine of the program.

## Requirements
* Ruby >= 3.1.x

## Installation

```bash
cd notify
```

And then execute:

    $ bundle install

## Usage

```bash
bundle exec bin/notify start --url http://localhost:8080/notify -i 5 < messages.txt
```

## Running tests
```bash
bundle exec rspec
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Notify project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/notify/blob/master/CODE_OF_CONDUCT.md).
