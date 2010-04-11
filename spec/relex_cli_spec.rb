require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'relex/cli'

describe Relex::CLI, "execute" do
  def execute(input)
    stdout_io = StringIO.new
    Relex::CLI.execute(stdout_io, input, [])
    stdout_io.rewind
    stdout = stdout_io.read
  end
 
  it "should ignore commentaries" do
    input = "{commentarie}"
    stdout = execute(input)
    stdout.should =~ /^$/
  end
end
