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
    program Palavra reservada 1
    teste Identificador 1
    ; Delimitador 1
    var Palavra reservada 2
    valor1 Identificador 3
    : Delimitador 3
    integer Palavra reservada 3
    ; Delimitador 3
    valor2 Identificador 4
    : Delimitador 4
    real Palavra reservada 4
    ; Delimitador 4
    begin Palavra reservada 5
    valor1 Identificador 6
    := Delimitador 6
    10 Número inteiro 6
    ; Delimitador 6
    end Palavra reservada 7
    . Delimitador 7
    """
