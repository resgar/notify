Then('the output should contain messages [{string}, {string}]') do |m1, m2|
  expect(last_command_started.stdout).to include('Message one')
  expect(last_command_started.stdout).to include('Message two')
end