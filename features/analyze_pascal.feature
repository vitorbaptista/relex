Feature: Lexical analysis of a subset of Pascal
  As a semantical analyzer
  I want a table of which symbol represents what
  So that I can treat them

  Scenario: Analyze test program
    Given I run local executable "relex" with arguments
    """
    program teste; {programa exemplo}
    var
      valor1: integer;
      valor2: real;
    begin
      valor1 := 10;
    end.
    """
    Then I should see exactly
    """
    Program\tPalavra reservada\t1
    teste\tIdentificador\t1
    ;\tDelimitador\t1
    var\tPalavra reservada\t2
    valor1\tIdentificador\t3
    :\tDelimitador\t3
    integer\tPalavra reservada\t3
    ;\tDelimitador\t3
    valor2\tIdentificador\t4
    :\tDelimitador\t4
    real\tPalavra reservada\t4
    ;\tDelimitador\t4
    begin\tPalavra reservada\t5
    valor1\tIdentificador\t6
    :=\tDelimitador\t6
    10\tNúmero inteiro\t6
    ;\tDelimitador\t6
    end\tPalavra reservada\t7
    .\tDelimitador\t7
    """
