require 'colorize'
require 'open3'
require_relative 'commandline/return'
require_relative 'commandline/output'

module Commandline
  def run(command)
    stdout, stderr, status = Open3.capture3("bash -c '#{command}'")
    Return.new(stdout: stdout, stderr: stderr, exit_code: status.exitstatus)
  end

  # TODO: - think about how to bring the run and execute methods together or give more differentiating names
  def execute(command, fail_message:, pass_message:)
    result = run command
    say result.stdout
    if result.error?
      say result.stderr
      say error fail_message
    else
      say ok pass_message
    end
  end
end
