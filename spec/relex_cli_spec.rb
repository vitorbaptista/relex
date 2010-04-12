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

  def batch_test(input_tests, formatted_expected_output)
    input_tests.each { |input|
      expected_output = formatted_expected_output.gsub('#value#', input)
      stdout = run(input)
      stdout.should =~ Regexp.new(expected_output)
    }
  end

  it "should ignore commentaries" do
    input_tests = ['{commentarie}']
    batch_test(input_tests, "")
  end

  it "should print an error message and exit when a char not in the language's alphabet is found" do
    input_tests = ['á', 'é', 'ç', '\"', '@', '#', '@']
    batch_test(input_tests, "^#value# simbolo_nao_reconhecido \\d+$")
  end

  it "should detect positive integers" do
    input_tests = ['0', '20', '341', '4123', '59583', '758493', '8098376']
    batch_test(input_tests, "^#value# numero_inteiro \\d+$")
  end

  it "should detect non-signed real numbers" do
    input_tests = ['0.3', '20.42', '341.253', '4123.4125', '59583.74585',
                   '758493.254896', '8098376.1245389']
    batch_test(input_tests, "^#value# numero_real \\d+$")
  end

  it "should detect reserved words" do
    input_tests = ['program', 'var', 'integer', 'real', 'boolean', 'procedure',
                   'begin', 'end', 'if', 'then', 'else', 'while', 'do']
    batch_test(input_tests, "^#value# palavra_reservada \\d+$")
  end

    input_tests.each { |input|
      stdout = run(input)
      stdout.should =~ /^#{input} palavra_reservada \d+$/
    }
  end
end
