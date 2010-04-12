module Relex
  class Token
    attr_reader :valor, :classificacao

    def initialize(valor, classificacao)
      @valor = valor
      @classificacao = classificacao
    end

    def to_s
      "#{@valor} #{@classificacao.to_s.gsub(/_/, ' ').capitalize}"
    end
  end
end
