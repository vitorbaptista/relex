require 'relex/token'

module Relex
  class CLI
    def self.execute(stdout=STDOUT, stdin=STDIN, arguments=[])
      numero_da_linha = 0
      comentario = false
      parenteses = 0
      tokens = []

      stdin.read.split('\n').each do |linha|
        numero_da_linha += 1

        linha.split.each_char do |caractere|
          next if caractere =~ /:blank:/
          next if comentario

          comentario = true if token =~ /\{/
          comentario = false if token =~ /\}/
       end
      end

    puts tokens.inspect
    end
  end
end
