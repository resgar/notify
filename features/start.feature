Feature: Start
  In order to start the notifier
  As a CLI
  I want to be as objective as possible

  Scenario: Tomato, or Tomato?
    When I run `notify start --url http://localhost:8080/notify`
    Then the output should contain messages ['Message one', 'Message two']