require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'relex/cli'

describe Relex::CLI, "execute" do
  def run(input)
    stdout_io = StringIO.new
    stdin_io = StringIO.new(input)
    Relex::CLI.execute(stdout_io, stdin_io, [])
    stdout_io.rewind
    stdout = stdout_io.read
  end
 
  it "should ignore commentaries" do
    input = "{commentarie}"
    stdout = run(input)
    stdout.should =~ /^$/
  end

  it "should detect positive integers" do
    input_tests = ['0', '20', '341', '958', '4123', '59583', '758493', '8098376']

    input_tests.each { |input|
      stdout = run(input)
      stdout.should =~ /^#{input} Número inteiro \d+$/
    }
  end
end
