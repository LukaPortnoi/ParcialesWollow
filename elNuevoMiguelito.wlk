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
    var property habito

    method darseGusto() {
        self.comprarPlato(parrillaMichael.mejorPlatoPara1(self) )
    }
    method comprarPlato(plato) {
        dinero -= plato.precio()
        parrillaMichael.venderPlato(plato, self)
    }

    // method mejorPlato() = filter parrillaMichael.platoMayorValoracion() 
    

    method puedePermitirselo (plato) = plato.precio() <= dinero

    method agregarDinero(cantidad) {dinero += cantidad}


    method cambiarHabito(nuevoHabito) {habito = nuevoHabito}
    method problemasGastricos() {self.cambiarHabito(celiaco)}
    method decisionEconomica() {
        if(habito.esFino()) {
            self.cambiarHabito(todoTerreno)
        }
    }

}

object celiaco{
    method leAgrada(plato) = plato.esAptoCeliaco()
    method esFino() = false
}

object paladarFino{
    method leAgrada(plato) = plato.esEspecial() || plato.valoracion() > 100
    method esFino() = true
}

object todoTerreno{
    method leAgrada(plato) = true
    method esFino() = false
}

object parrillaMichael{
    var platos = []
    var dinero = 0
    var comensales =[]

    method venderPlato(plato,comensal) {
        dinero += plato.precio()
        comensales.add(comensal)
    }

    method agregarPlatoMenu(plato)  {platos.add(plato)}

    method platosQueLeGustanA(comensal) = platos.filter({plato => comensal.habito().leAgrada(plato)})
    
    method puedeComprarPlatos(comensal) {
    if(!self.platosQuePuedeComprar(comensal).isEmpty())  {
        return self.platosQuePuedeComprar(comensal)
    }
    else{
        throw new Exception(message = "No hay plato que pueda comprar")
        }
    } 

    method platosQuePuedeComprar (comensal) = platos.filter({plato => plato.precio() <= comensal.dinero()}) 

    
    method platoMayorValoracion(platosTotales) = platosTotales.max({plato => plato.valoracion()})
    
    // method mejorPlatoPara(comensal)=platoMayorValoracion(platosQueLeGustanA(platosQuePuedeComprar(comensal)))   NO ANDA PELOTUDO

    method mejorPlatoPara1(comensal) {        
        var posiblesPlatos = platos
        posiblesPlatos = self.puedeComprarPlatos(comensal)
        posiblesPlatos = self.platosQueLeGustanA(comensal)
        return self.platoMayorValoracion(posiblesPlatos)
    }

        
    method mejorPlatoPara2(comensal)= self.platoMayorValoracion(self.platosQueLeGustanA(comensal).puedeComprarPlatos(comensal))

    method hacerPromocion(cantidadDinero) {comensales.forEach({comensal => comensal.agregarDinero(cantidadDinero)})}
}