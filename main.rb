# metodo para cargar las preguntas en el sistema:
def cargar_preguntas(file)
  return [] unless File.file?(file)
  preguntas = []
  File.foreach(file) do |line|
    pregunta, respuesta = line.chomp.split(';')
    preguntas.push({ pregunta: pregunta.strip,
                     respuesta: respuesta.strip }
                  )
  end
  preguntas
end
# cargar configuracion inicial:
archivo   = "preguntas.csv"
preguntas = cargar_preguntas(archivo)
if preguntas.any?
  # inicia el juego:
  puts "Bienvenido a reto 5, Para jugar, solo ingresa el termino correcto para"
  puts "cada una de las definiciones, Listo? Vamos!"
  puts '*tip: puede presiona "salir" en cualquier momento del juego para terminar'
  intentos = 0
  correctas = 0
  preguntas.shuffle!
  preguntas.each_with_index do |p, i|
    continuaAdivinando = true
    puts
    puts  "Definición:"
    puts  "#{i + 1}). #{p[:pregunta]}?"
    while continuaAdivinando
      intentos += 1
      puts
      print "Adivinar: "
      respuesta = gets.chomp.to_s
      if respuesta.downcase == p[:respuesta].downcase
        correctas += 1
        puts "Correcto!"
        continuaAdivinando = false
      else
        if respuesta.downcase == "salir"
          break
        else
          puts "Incorrecto!, Trata de nuevo"
        end
      end
    end
    break if respuesta.downcase == "salir"
  end
  puts
  puts "-" * 80
  if correctas == preguntas.length
    puts "Felicidades has terminado el juego por completo!"
    puts "total de preguntas: #{correctas}"
    puts "total de intentos:  #{intentos}"
    puts
  end
  puts "Gracias por jugar, hasta luego!"
else
  puts "Problemas cargando las preguntas al sistema"
  puts "se encuentra el archivo: #{archivo} en la misma ruta del programa?"
end
