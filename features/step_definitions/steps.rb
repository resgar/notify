Then('the output should contain messages [{string}, {string}]') do |m1, m2|
  expect(last_command_started.stdout).to include(m1)
  expect(last_command_started.stdout).to include(m2)
end