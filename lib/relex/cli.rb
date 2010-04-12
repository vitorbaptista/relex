require 'relex/token'

module Relex
  class CLI
    ALFABETO = /[a-z]|[A-Z]|[0-9]|_|:|;|,|\)|\(|\.|<|>|=|\+|-|\*|\/|\{|\}/

    def self.execute(stdout=STDOUT, stdin=STDIN, arguments=[])
      comentario = false
      parenteses = 0
      tokens = []

      stdin.read.split("\n").each do |linha|
        tokens_desta_linha = []
        comentario = false
        tmp = ''
        linha = "#{linha}\n"

        linha.each_char do |caractere|
          comentario = true if caractere =~ /\{/
          comentario = false if caractere =~ /\}/

          if caractere =~ /\s/ || comentario
            tmp += caractere if !(tmp =~ /,/) && (caractere =~ /,/)

            if !tmp.empty?
              token = classifica_token(tmp)
              if token
                tokens_desta_linha << token
                tmp = ''
              else
                token = classifica_token(tmp[0..-2])
                if token
                  tokens_desta_linha << token
                  tmp = tmp[-1..-1]
                  redo
                end
              end
            end

            next
          end

          if !(caractere =~ ALFABETO)
            token = Relex::Token.new(caractere, :simbolo_nao_reconhecido)
            tokens_desta_linha << token
            break
          end

          tmp += caractere if !comentario
        end

        tokens << tokens_desta_linha if tokens_desta_linha
      end

      tokens.each_with_index { |tokens_da_linha, linha|
        tokens_da_linha.each { |token|
          stdout.puts "#{token} #{linha + 1}"
        }
      }

      stdout.puts "Comentário não fechado" if comentario
    end

    def self.classifica_token(token)
      case token
        when /^(program|var|begin|end|integer|real|boolean|procedure|if|then|else|while|do)$/ then 
          Relex::Token.new(token, :palavra_reservada)
        when /^(\+|-|(or))$/
          Relex::Token.new(token, :operador_aditivo)
        when /^(\*|\/|(and))$/
          Relex::Token.new(token, :operador_multiplicativo)
        when /^[a-z]+[a-z0-9_]*$/
          Relex::Token.new(token, :identificador)
        when /^[0-9]+\.[0-9]+$/
          Relex::Token.new(token, :numero_real)
        when /^[0-9]+$/
          Relex::Token.new(token, :numero_inteiro)
        when /^(=|<|>|<=|>=|<>)$/
          Relex::Token.new(token, :operador_relacional)
        when /^:=$/
          Relex::Token.new(token, :comando_de_atribuicao)
        when /^(;|,|\.|:|\(|\))$/
          Relex::Token.new(token, :delimitador)
      end
    end
  end
end
