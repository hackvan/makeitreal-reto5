class Question
  attr_reader :question, :answer

  def initialize(question, answer)
    @question = question
    @answer   = answer.downcase.strip
  end

  def is_valid?(answer)
    self.answer == answer.downcase.strip
  end
end

class PollQuestion
  attr_reader   :questions
  attr_accessor :file
  def initialize(file="questions.csv")
    @file      = file
    @questions = load_questions(@file)
  end

  def play
    if @questions.any?
      puts "Bienvenido a reto 5, Para jugar, solo ingresa el termino correcto para"
      puts "cada una de las definiciones, Listo? Vamos!"
      puts '*tip: puede presiona "salir" en cualquier momento del juego para terminar'
      attempts       = 0
      correctAnswers = 0
      @questions.each_with_index do |q, i|
        keepGuessing = true
        puts
        puts "Definición:"
        puts "#{i + 1}). #{q.question}?"
        while keepGuessing
          attempts += 1
          puts
          print "Adivinar: "
          userAnswer = gets.chomp.to_s.downcase
          if q.is_valid?(userAnswer)
            correctAnswers += 1
            puts "Correcto!"
            keepGuessing = false
          else
            if userAnswer == "salir"
              break
            else
              puts "Incorrecto!, Trata de nuevo"
            end
          end
        end
        break if userAnswer == "salir"
      end
      puts
      puts "-" * 80
      if correctAnswers == @questions.length
        puts "Felicidades has terminado el juego por completo!"
        puts "total de preguntas: #{correctAnswers}"
        puts "total de intentos:  #{attempts}"
      end
      puts "Gracias por jugar, hasta luego!"
    else
      puts "Problemas cargando las preguntas al sistema"
      puts "se encuentra el archivo: \"#{@file}\" en la misma ruta del programa?"
    end
  end

  private
  def load_questions(file)
    return [] unless File.file?(file)
    questions = []
    File.foreach(file) do |line|
      question, answer = line.chomp.split(';')
      question = Question.new(question.strip, answer.strip)
      questions.push(question)
    end
    questions.shuffle!
  end
end

game = PollQuestion.new
game.play
