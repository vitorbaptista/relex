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
      expected_output = formatted_expected_output.gsub('#value#', Regexp.escape(input))
      stdout = run(input)
      stdout.should =~ Regexp.new("^#{expected_output}$")
    }
  end

  it "should ignore commentaries" do
    input_tests = ['{comment}']
    batch_test(input_tests, "")
  end

  it "should print an error message and exit when a char not in the language's alphabet is found" do
    input_tests = ['á', 'é', 'ç', '\"', '@', '#', '@']
    batch_test(input_tests, "#value# simbolo_nao_reconhecido \\d+")
  end

  it "should detect positive integers" do
    input_tests = ['0', '20', '341', '4123', '59583', '758493', '8098376']
    batch_test(input_tests, "#value# numero_inteiro \\d+")
  end

  it "should detect non-signed real numbers" do
    input_tests = ['0.3', '20.42', '341.253', '4123.4125', '59583.74585',
                   '758493.254896', '8098376.1245389']
    batch_test(input_tests, "#value# numero_real \\d+")
  end

  it "should detect reserved words" do
    input_tests = ['program', 'var', 'integer', 'real', 'boolean', 'procedure',
                   'begin', 'end', 'if', 'then', 'else', 'while', 'do']
    batch_test(input_tests, "#value# palavra_reservada \\d+")
  end

  it "should detect identifiers" do
    input_tests = ['numero', 'a', 'foo5', 'bar32_', 'vida_universo_e_tudo_mais_42']
    batch_test(input_tests, "#value# identificador \\d+")
  end

  it "should detect delimiters" do
    input_tests = [';', '.', ':', '(', ')']
    batch_test(input_tests, "#value# delimitador \\d+")
  end

  it "should detect assignment commands" do
    input_tests = [':=']
    batch_test(input_tests, "#value# comando_de_atribuicao \\d+")
  end

  it "should detect relational operators" do
    input_tests = ['=', '<', '>', '<=', '>=', '<>']
    batch_test(input_tests, "#value# operador_relacional \\d+")
  end

  it "should detect additive operators" do
    input_tests = ['+', '-', 'or']
    batch_test(input_tests, "#value# operador_aditivo \\d+")
  end

  it "should detect multiplicative operators" do
    input_tests = ['*', '/', 'and']
    batch_test(input_tests, "#value# operador_multiplicativo \\d+")
  end
end
