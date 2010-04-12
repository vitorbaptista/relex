require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'relex/cli'

describe Relex::CLI, "execute" do
  def run(input)
    stdout_io = StringIO.new
    stdin_io = StringIO.new(input)
    Relex::CLI.execute(stdout_io, stdin_io, [])
    stdout_io.rewind
    stdout_io.read
  end
 
  it "should ignore commentaries" do
    input = "{commentarie}"
    stdout = run(input)
    stdout.should =~ /^$/
  end

  it "should detect positive integers" do
    input_tests = ['0', '20', '341', '4123', '59583', '758493', '8098376']

    input_tests.each { |input|
      stdout = run(input)
      stdout.should =~ /^#{input} numero_inteiro \d+$/
    }
  end

  it "should detect non-signed real numbers" do
    input_tests = ['0.3', '20.42', '341.253', '4123.4125', '59583.74585', '758493.254896', '8098376.1245389']

    input_tests.each { |input|
      stdout = run(input)
      stdout.should =~ /^#{input} numero_real \d+$/
    }
  end
end
