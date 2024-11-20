

class Plato{
   const valoracion 
   
   method precio() = valoracion * 300 + self.precioExtra()
   method precioExtra() {
      if (self.esAptoCeliaco()) {return 1200} 
      else {return 0}
   }

    method esAptoCeliaco()
    method esEspecial()
    
    
}

class Provoleta inherits Plato{
    const peso
    const empanado
    
    override method esApatoCeliaco() = empanado
    override method esEspecial() = peso > 250 and empanado
}