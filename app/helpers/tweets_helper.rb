module TweetsHelper
    def hashtag(content) #Metodo para el hashtag
        format_content = content.split(" ")#Aqui todo el texto del contenido es separado
        tag = [] #Se crea variable para guardar un arreglo
        format_content.each do |t| #Iterando el array del contenido
            if t.start_with?("#") #Buscar en el contenido si existe el simbolo #
               t = link_to t, controller: 'tweets', q: t #Aqui se configura que el hashtag sea linkeable y permita buscar
            end
            tag.push(t) #Aqui guardo lo iterado en el variable declarada anteriormente
        end
        raw tag.join(" ") #Aqui vuelve a unir el texto del contenido
    end
end
