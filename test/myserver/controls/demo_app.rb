# frozen_string_literal: true

# This set of inspec controls is a simple example of a validation test for a server.
#
# It will automatically be provided inspec inputs for the following:
#  - server:  The server being tested, as defined in your config.rb, with secrets scrubbed.
#
# To learn more about how to write inspec tests, see:
#  - https://inspec.io
#

server = input 'server', type: 'Hash', required: true # rubocop:disable Lint/UselessAssignment

include_controls 'demo-app' do
end
