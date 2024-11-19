class Cocinero {
    var especialidad 
 //var cocinar

    method califarPlato (plato) = especialidad.catar(plato)

//3
    method cambiarEspecialidad(nuevaEspecialidad) { especialidad = nuevaEspecialidad}

//5
    method cocinar() = especialidad.cocinar(self)
    // method cocinar() = cocinar
}



class Chef {
    var caloriasMax
    

         method catar(plato){
        if((plato.bonito()) and (plato.cantidadCalorias() < caloriasMax)){
            return 10
        } else {
            return self.noCumplioExpectativas()
        }
    }

    method noCumplioExpectativas() = 0 

    method cocinar(elCocinero) = new Principal (cocinero = elCocinero, bonito=true, cantAzucar=caloriasMax)
             
}

class SousChef inherits Chef {
   override method noCumplioExpectativas() = 6
   override method cocinar(elCocinero) = new Entrada(cocinero = elCocinero)

}

class Pastelero  {
  var dulzorDeseado 

method catar(plato) = 10.min((5 * plato.cantAzucar()) / dulzorDeseado)

method cocinar(elCocinero) = new Postre(cocinero = elCocinero , cantColores = dulzorDeseado/50 )
}

class Plato {
    var cocinero 

    method cantAzucar() 
    method cocinero() = cocinero
    

//1
    const caloriasBase = 100
    method cantidadCalorias() = 3* self.cantAzucar() + caloriasBase
    
    
    

}

class Entrada inherits Plato {
    override method cantAzucar() = 0
     method bonito()= true
}

class Principal inherits Plato {
    var bonito
    var cantAzucar

    override method cantAzucar() = cantAzucar
         method bonito() = bonito

}

class Postre inherits Plato {
    var cantColores
    override method cantAzucar() = 120
     method bonito() = cantColores > 3
}


object torneo {
  var catadores = []
  var platosParticipantes = []
  
  method participar(cocinero) = platosParticipantes.add(cocinero.cocinar())

  /* method calificarPlatos() {
    platosParticipantes.each { plato -> 
      catadores.each { catador -> 
        catador.califarPlato(plato)
      }
    }
  } */

    method calificacionesTorneo(plato) = platosParticipantes.sum {platoPrin =>  self.cataciones(plato) }

    method ganador() = platosParticipantes.max({ plato => self.calificacionesTorneo(plato)}).cocinero()

    method cataciones(plato)= catadores.foreach({catador => catador.califarPlato(plato)})
} 




// ------------------------------