module Relex
  class Token
    def initialize(valor, classificacao)
      @valor = valor
      @classificacao = classificacao
    end

    def to_s
      "#{@valor} #{@classificacao}"
    end
  end
end
