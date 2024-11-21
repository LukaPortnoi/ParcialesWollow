class Equipo{
    var empleados

    method puedeCumplir (mision) = empleados.any({empleado => empleado.puedeCumplir(mision)})

    method realizarMision(mision){
        if (self.puedeCumplir(mision)) {
            empleados.foreach({empleado => empleado.recibirDanio(mision.peligrosidad())})}
        else{
           throw new Exception(message = "El equipo no puede cumplir la mision")
        }
    }
}



class Empleado{
    var salud
    var saludCritica
    var habilidades
    

    var property oficio

    method salud()=salud
      
    
    method saludCritica() = saludCritica
    method habilidades() = habilidades

    method estaIncapacitado() = salud < saludCritica

    method puedeUsar(habilidad) = habilidades.contains(habilidad)
    
    method puedeCumplir(mision) = mision.habilidadesRequeridas().all({habilidad => self.puedeUsar(habilidad)})


    method recibirDanio(danio){
        salud=salud-danio
    }

    method realizarMision(mision){
        if (self.puedeCumplir(mision)) {
            self.recibirDanio(mision.peligrosidad())
        }
        else{
            throw new Exception(message = "No puede cumplir la mision")
        }
    }

    method sobrevivioAMision() = salud > 0

    method finalizarMision(mision){
        if (self.sobrevivioAMision()) {
            oficio.obtenerRecompensas(mision,self)
        }
        else{
            throw new Exception(message = "No sobrevivio")
        }
    }
}

class Mision{
    const habilidadesRequeridas
    const peligrosidad

    method peligrosidad() = peligrosidad
}

object espia{
    method saludCritica() = 15

    method obtenerRecompensas(mision,empleado) { self.aprenderHabilidades(mision,empleado)}

method aprenderHabilidades(mision, empleado) {
        empleado.habilidades().addAll(self.habilidadesDesconocidas(mision, empleado))
    }

    method habilidadesDesconocidas(mision, empleado) {
    const habilidadesNoConocidas = mision.habilidadesRequeridas().filter({habilidad => not empleado.puedeUsar(habilidad)})
    return habilidadesNoConocidas
}
}
class Oficinista{
    var cantEstrellas

    method saludCritica() = 40-5* cantEstrellas

    method obtenerRecompensas(mision,empleado){
        cantEstrellas+=1
        if(cantEstrellas==3){
            empleado.oficio(espia)
        }
    }
}

class Jefe inherits Empleado{
    var empleados

    override method puedeUsar(habilidad) = super(habilidad) or empleados.any({empleado => empleado.puedeUsar(habilidad)})
}




















