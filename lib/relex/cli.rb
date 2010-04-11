require 'relex/token'

module Relex
  class CLI
    def self.execute(stdout=STDOUT, stdin=STDIN, arguments=[])
      comentario = false
      parenteses = 0
      tokens = []

      stdin.read.split('\n').each do |linha|
        tokens_desta_linha = []

        linha.each_char do |caractere|
          next if caractere =~ /:blank:/
          next if comentario

          comentario = true if caractere =~ /\{/
          comentario = false if caractere =~ /\}/
        end

        tokens << tokens_desta_linha
      end

      tokens.each_with_index { |tokens_da_linha, linha|
        tokens_da_linha.each { |token|
          puts "#{token} #{linha + 1}"
        }
      }
    end
  end
end
