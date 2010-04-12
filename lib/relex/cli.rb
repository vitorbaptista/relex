require 'relex/token'

module Relex
  class CLI
    ALFABETO = /[a-z]|[A-Z]|[0-9]|_|:|;|\)|\(|\.|<|>|=|\+|-|\*|\\|\{|\}/

    def self.execute(stdout=STDOUT, stdin=STDIN, arguments=[])
      comentario = false
      parenteses = 0
      tokens = []

      stdin.read.split('\n').each do |linha|
        tokens_desta_linha = []
        comentario = false
        tmp = ''

        linha.each_char do |caractere|
          comentario = true if caractere =~ /\{/
          comentario = false if caractere =~ /\}/

          if !tmp.empty? && (caractere =~ /\s/ || comentario)
            tokens_desta_linha << classifica_token(tmp)
            tmp = ''
            next
          end

          next if comentario
          next if !(caractere =~ ALFABETO)

          tmp += caractere
        end

        if !tmp.empty? && !comentario
          token = classifica_token(tmp)
          tokens_desta_linha << token if token
          tmp = ''
        end

        tokens << tokens_desta_linha if tokens_desta_linha
      end
 
      tokens.each_with_index { |tokens_da_linha, linha|
        tokens_da_linha.each { |token|
          stdout.puts "#{token} #{linha + 1}"
        }
      }
    end

    def self.classifica_token(token)
      case token
        when /(program|var|begin|end|integer|if|then|else)/ then 
          Relex::Token.new(token, :palavra_reservada)
        when /\+|\*/
          Relex::Token.new(token, :operador_aritmeticos)
        when /[a-z]+[a-z0-9_]*/
          Relex::Token.new(token, :identificador)
        when /[0-9]+\.[0-9]+/
          Relex::Token.new(token, :numero_real)
        when /[0-9]+/
          Relex::Token.new(token, :numero_inteiro)
        when /\:=/
          Relex::Token.new(token, :comando_de_atribuicao)
        when /=/
          Relex::Token.new(token, :operador_relacional)
      end
    end
  end
end
