# Notify

This library implements a client, which sends signals to the configured server. It uses Queue to store messages. It monitors the queue and sends the messages to the url at specified intervals.

## Requirements
* Ruby >= 3.1.x

## Installation

```bash
cd notify
```

And then execute:

    $ bundle install

## Usage

To read the messages from the interactive console:
* `` bundle exec bin/notify start --url http://localhost:8000/notify -i 10 ``. 

By pressing Enter, the message will be queued for sending.

We can also read the input from a file. Each line will be a new message:
* `` bundle exec bin/notify start --url http://localhost:8000/notify < filename.txt ``

## OPTIONS
    -h, --help                           Print this help text and exit
    -u, --url                            Runs the server on a specific url
    -i                                   Notification interval

## Running tests
```bash
bundle exec rspec
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Notify project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/notify/blob/master/CODE_OF_CONDUCT.md).
