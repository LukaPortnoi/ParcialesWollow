class Personaje{
  
var property copas =0

method darCopas(cantidad) {copas + cantidad  } 
}


class Arquero inherits Personaje {
  const rango
  const agilidad

  /* method rango() = rango
  method agilidad() = agilidad */

  method tieneEstrategia() = rango > 100
   method destreza () = rango * agilidad

  //override method copas() = copas + 1

}

class Guerrera inherits Personaje {
  const fuerza
  const tieneEstrategia 

  method tieneEstrategia() = tieneEstrategia
   method destreza() = fuerza + fuerza/2
  

}

class Ballestero inherits Arquero {
  override method destreza() = super() *2
  
}




class Mision{

  var formaDePremiar = normal

  // PUNTO 1
  method superada() = self.destrezaSuficiente() || self.personajeTieneEstrategia()
	
	method destrezaSuficiente()
	
	method personajeTieneEstrategia() 
  //----------------------------------


  // PUNTO 2
  method realizar(){
    if (self.puedeRelizarce()){
      self.repartirCopas()
    }else{
         throw new Exception(message = "Misión no puede comenzar")
    }
  }


  method puedeRelizarce()

  method repartirCopas()


  method sumarOrestarCopas () = if (self.superada()) 1 else -1

  method cantCopas() = formaDePremiar.cantCopasFinal(self)

}

class MisionIndividual inherits Mision {
  
  var dificultad

  var  property personaje 



  method copasEnJuego() = dificultad * 2

  override method destrezaSuficiente() = dificultad < personaje.destreza()
  override method personajeTieneEstrategia() = personaje.tieneEstrategia()


  override method puedeRelizarce() = personaje.copas()>10

  override method repartirCopas() = personaje.darCopas(self.sumarOrestarCopas()*self.cantCopas())


  method cantParticipantes() = 1


}

class MisionPorEquipo inherits Mision {
  
  var personajes= []




  method copasEnJuego() = 50 / personajes.size()


  override method destrezaSuficiente() = personajes.all{personaje => personaje.destreza()>400}

  override method personajeTieneEstrategia() = personajes.count{personaje => personaje.tieneEstrategia()}>personajes.size()/2




  override method puedeRelizarce() = personajes.sum{personaje => personaje.copas()}>59

  override method repartirCopas() = personajes.forEach{personaje => personaje.darCopas(self.sumarOrestarCopas()*self.cantCopas())}

  method cantParticipantes() = personajes.size()

}


object normal {
	method cantCopasFinal(mision) = mision.copasEnJuego()
}

class Boost {
	var property multiplicador 

  method cantCopasFinal(mision) = mision.copasEnJuego()* multiplicador
}

object bonus {
  method cantCopasFinal(mision) = mision.cantParticipantes() + mision.copasEnJuego()
}

