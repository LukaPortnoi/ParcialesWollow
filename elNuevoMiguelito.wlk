

class Plato{

   method precio() = self.valoracion() * 300 + self.precioExtra()
   method precioExtra() {
      if (self.esAptoCeliaco()) {return 1200} 
      else {return 0}
   }

    method esAptoCeliaco()
    method esEspecial() = self.peso()>250
    method valoracion () 
    method peso ()
    
    
}

class Provoleta inherits Plato{
    const empanado
    const peso
    override method esAptoCeliaco() = empanado
    override method esEspecial() = super() and empanado
    override method valoracion() = if (self.esEspecial()) {return 120} else {return 80}
    override method peso() = peso
}

class HamburguesaDeCarne inherits Plato{
    const pan
    const pesoCarne
    method pesoCarne()=pesoCarne
    
    override method esAptoCeliaco() = pan.esAptoCeliaco()
    override method peso() = self.pesoCarne() + pan.peso()
    override method valoracion()= self.peso()/100
}



class HamburguesaDoble inherits HamburguesaDeCarne{
    override method pesoCarne() = super()*2
    override method esEspecial() = self.peso() > 500
    
}


class Pan{
    var property peso
    var property esAptoCeliaco
}

const panIndustrial = new Pan (peso = 60, esAptoCeliaco = false)
const panCasero = new Pan (peso = 100, esAptoCeliaco = false)
const panMaiz = new Pan (peso=30, esAptoCeliaco = true)

class CorteDeCarne inherits Plato{
    const aPunto
    const peso
    
    override method peso() = peso
    override method esEspecial()= super() and aPunto
    override method esAptoCeliaco() = true
    override method valoracion() = 100
}

class Parrillada inherits Plato{
    const platos 
    
    override method peso()= self.sumaDePesos()

    method sumaDePesos()= platos.sum({plato => plato.peso()})
    override method esEspecial() = super() and platos.size() >= 3
    override method esAptoCeliaco() = platos.all({plato => plato.esAptoCeliaco()})
    override method valoracion() = platos.max({plato => plato.valoracion()})
}

class Comensal{
    var dinero
    var property tipo

    method darseGusto() {
        self.comprarPlato(parrillaMichael.mejorPlatoPara1(self) )
    }
    method comprarPlato(plato) {
        dinero -= plato.precio()
        parrillaMichael.venderPlato(plato)
    }

    // method mejorPlato() = filter parrillaMichael.platoMayorValoracion() 
    

    method puedePermitirselo (plato) = plato.precio() <= dinero


}

object celiaco{
    method leAgrada(plato) = plato.esAptoCeliaco()
}

object paladarFino{
    method leAgrada(plato) = plato.esEspecial() || plato.valoracion() > 100
}

object todoTerreno{
    method leAgrada(plato) = true
}

object parrillaMichael{
    var platos = []
    var dinero

    method venderPlato(plato) {dinero += plato.precio()}

    method platosQueLeGustanA(comensal) = platos.filter({plato => comensal.tipo().leAgrada(plato)})
    method platosQuePuedeComprar(comensal) = (platos.filter({plato => plato.precio() <= comensal.dinero()})

    
    method platoMayorValoracion(platosTotales) = platosTotales.max({plato => plato.valoracion()})
    
    // method mejorPlatoPara(comensal)=platoMayorValoracion(platosQueLeGustanA(platosQuePuedeComprar(comensal)))   NO ANDA PELOTUDO

    method mejorPlatoPara1(comensal) {        
        var posiblesPlatos = platos
        posiblesPlatos = self.platosQuePuedeComprar(comensal)
        posiblesPlatos = self.platosQueLeGustanA(comensal)
        return self.platoMayorValoracion(posiblesPlatos)
    }

        
    method mejorPlatoPara2(comensal)= self.platoMayorValoracion(self.platosQueLeGustanA(comensal).platosQuePuedeComprar(comensal))
}