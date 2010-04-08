module Relex
  class Token
    attr_reader :palavras_reservadas, :delimitadores, :operadores_aritmeticos, :identificadores, :strings_numericas, :comando_atribuicao, :operador_relacional

    def initialize(valor, classificacao)
      self.palavras_reservadas = /program|var|begin|end|integer|if|then|else/
      self.delimitadores = /;|:|,|\(|\)/
      self.operadores_aritmeticos = /\+|\*/
      self.identificadores = /[a..z]+[a..z0..9_]*/
      self.strings_numericas = /[0..9]+/
      self.comando_atribuicao = /\:=/
      self.operador_relacional = /=/

      @valor = valor
      @classificacao = classificacao
    end

    def to_s
      "#{@valor} #{@classificao}"
    end
  end
end
