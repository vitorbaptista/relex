require 'relex/token'

module Relex
  class CLI
    def self.execute(stdout, arguments=[])
      numero_da_linha = 0
      comentario = false
      parenteses = 0
      tokens = []

      STDIN.read.split('\n').each do |linha|
        numero_da_linha += 1

        linha.split.each do |token|
          comentario = true if (token =~ /\{/)
          comentario = false if (comentario && token =~ /\}/)
          token.gsub!(/\{[^\}]*\}?/, '')
          token.gsub!(/.*\}/, '') if comentario

          if token =~ /;|:|,|\(|\)/
            parenteses += 1 if token =~ /\(/
            parenteses -= 1 if token =~ /\)/
            token.gsub!(/;|:|,|\(|\)/, '')
            tokens << Relex::Token.new(token, :delimitadores)
          end

          tokens << case token
              when /[\{\}].*/ then
                comentario = !comentario
              when /program|var|begin|end|integer|if|then|else/ then 
                Relex::Token.new(token, :palavra_reservada)
              when /\+|\*/
                Relex::Token.new(token, :operadores_aritmeticos)
              when /[a..z]+[a..z0..9_]*/
                Relex::Token.new(token, :identificadores)
              when /[0..9]+/
                Relex::Token.new(token, :strings_numericas)
              when /\:=/
                Relex::Token.new(token, :comando_atribuicao)
              when /=/
                Relex::Token.new(token, :operador_relacional)
              else
                "ERRO!"
            end
        end
      end

    puts tokens.inspect
    end
  end
end
