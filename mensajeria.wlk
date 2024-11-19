class Mensaje{
    const emisor
    const contenido 

    method peso() = 5 + contenido.peso() * 1.3


}

class Texto{
    const texto
    method peso() = texto.size()
}

class Audio{
    const duracion
    method peso() = duracion *  1.2
}

class Imagen{
    const ancho
    const alto
    const compresion
    method peso() = compresion.peso()

    method calcularPixeles() = (ancho * alto) *2
}

class CompresionOriginal{
method peso() = Imagen.calcularPixeles()
}
class ComprensionVariable{
    const porcentage

method peso()= Imagen.calcularPixeles() * porcentage
}

class ComprensionMaxima{
method peso()= 10000.min(Imagen.calcularPixeles())
}

class Gif inherits Imagen{
    const cuadros

    override method peso() = super() * cuadros
}

class Contacto{
    const usuario

    method peso() = 3

}

class Usuario{
    const idUsuario
    const memoriaLibre
    var chats = []

    
    method agregarChat(chat){ chats.add(chat)} 

//4
    method mensajePesadosDeCadaChat() =  chats.map({chat => chat.elQueMasPesa()})

}

class Chat {
    var usuarios = []
    var mensajes = []

     method enviarMensaje(mensaje){
        if (self.puedeEnviar(mensaje)){
            mensajes.add(mensaje)
        }else{
            throw new Exception(message = "No se puede enviar el mensaje")
        }
    } 
    
    method puedeEnviar(mensaje) = (usuarios.contains(mensaje.emisor())) and (self.todosTienenEspacio(mensaje))
    
    method cantidadMensajes() = mensajes.size()
    
    method todosTienenEspacio(mensaje) = usuarios.all({usuario => usuario.memoriaLibre() > mensaje.peso()})

//1
    method pesoTotal() = mensajes.sum({mensaje => mensaje.peso()})

    method elQueMasPesa()= mensajes.max({mensaje => mensaje.peso()})

    method espacioOcupado() = mensajes.sum({mensaje => mensaje.peso()})

//3
}

class ChatPremium inherits Chat{
    const restriccion

    override method puedeEnviar(mensaje) = super(mensaje) and restriccion.puedeEnviar(mensaje)
}

class Difusion{
    const creador
    method puedeEnviar(mensaje) = creador == mensaje.emisor()
}

class Restringido{
    const maxMensajes
    const chat
    
    method puedeEnviar(mensaje)= chat.cantidadMensajes() < maxMensajes
}

class Ahorro{
    const tamMax

    method puedeEnviar(mensaje) = mensaje.peso() < tamMax
}






