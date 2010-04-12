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
    Then I should see
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
    := Comando de atribuicao 6
    10 Numero inteiro 6
    ; Delimitador 6
    end Palavra reservada 7
    . Delimitador 7
    """

  Scenario: Analyze Clauirton's test program
    Given I run local executable "relex" with arguments
    """
    program teste1;  {exemplo de programa correto
    var
      xxx,yyyy,z_z : integer;
      a1,b2b,cc33_ : real;
      v1,v_2: boolean; @
    begin
      if (xxx <= 5) or (a1 <> 7) or v1 then
        a1 := yyyy * yyyy / cc33_
      else
        z_z := xxx;
   
      while( (a1+879.=55476.0)and(a1>=55476.0)) do
        b2b:=(98+100.0)/33;    
    end.
    """
    Then I should see
    """
    program Palavra reservada 1
    teste1 Identificador 1
    ; Delimitador 1
    var Palavra reservada 2
    xxx Identificador 3
    , Delimitador 3
    yyyy Identificador 3
    , Delimitador 3
    z_z Identificador 3
    : Delimitador 3
    integer Palavra reservada 3
    ; Delimitador 3
    a1 Identificador 4
    , Delimitador 4
    b2b Identificador 4
    , Delimitador 4
    cc33_ Identificador 4
    : Delimitador 4
    real Palavra reservada 4
    ; Delimitador 4
    v1 Identificador 5
    , Delimitador 5
    v_2 Identificador 5
    : Delimitador 5
    boolean Palavra reservada 5
    ; Delimitador 5
    begin Palavra reservada 6
    if Palavra reservada 7
    ( Delimitador 7
    xxx Identificador 7
    <= Operador relacional 7
    5 Numero inteiro 7
    ) Delimitador 7
    or Operador aditivo 7
    ( Delimitador 7
    a1 Identificador 7
    <> Operador relacional 7
    7 Numero inteiro 7
    ) Delimitador 7
    or Operador aditivo 7
    v1 Identificador 7
    then Palavra reservada 7
    a1 Identificador 8
    := Comando de atribuicao 8
    yyyy Identificador 8
    * Operador multiplicativo 8
    yyyy Identificador 8
    / Operador multiplicativo 8
    cc33_ Identificador 8
    else Palavra reservada 9
    z_z Identificador 10
    := Comando de atribuicao 10
    xxx Identificador 10
    ; Delimitador 10
    while Palavra reservada 12
    ( Delimitador 12
    ( Delimitador 12
    a1 Identificador 12
    + Operador aditivo 12
    879. Numero real 12
    = Operador relacional 12
    55476.0 Numero real 12
    ) Delimitador 12
    and Operador multiplicativo 12
    ( Delimitador 12
    a1 Identificador 12
    >= Operador relacional 12
    55476.0 Numero real 12
    ) Delimitador 12
    ) Delimitador 12
    do Palavra reservada 12
    b2b Identificador 13
    := Comando de atribuicao 13
    ( Delimitador 13
    98 Numero inteiro 13
    + Operador aditivo 13
    100.0 Numero real 13
    ) Delimitador 13
    / Operador multiplicativo 13
    33 Numero inteiro 13
    ; Delimitador 13
    end Palavra reservada 14
    . Delimitador 14
    """
