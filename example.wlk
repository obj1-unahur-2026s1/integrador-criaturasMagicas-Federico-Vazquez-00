
class Ataque{
  var valorDaño = 100
}

class Wollomon{ //ABSTRACTA - YA NO PUEDO INICIARLIZARLA! 
    var nivelExperiencia
    var salud = 200
    const ataques = [] 

    method salud() = salud

    method puedeAtacar() = salud > 10

    method aprenderAtaque(unAtaque){
        ataques.add(unAtaque)
    }

    method dañoQueEfectua() // METODO ABSTRACTA

    method atacar(wollomonAtacado){
        if (self.puedeAtacar()){
            wollomonAtacado.recibirAtaqueDe(self)
            self.sufrirEfectosDeAtacar()
        }
    }

    method recibirAtaqueDe(wollomonAtacador){
        salud = 0.max(salud - wollomonAtacador.dañoQueEfectua())
    }

    method sufrirEfectosDeAtacar() // ABSTRACTO
}

class Bicho inherits Wollomon{
    override method dañoQueEfectua() = ataques.sum({w => w.valorDaño()})   
}


class Dragon inherits Wollomon{
//Atributo propio
    const property fuegoInterior

    override method puedeAtacar() = super() && fuegoInterior > 20 //CONSULTA

    override method dañoQueEfectua() = fuegoInterior + self.elDañoDelMejorAtaque()

    method elDañoDelMejorAtaque(){
      return ataques.max({w => w.valorDaño()}).valorDaño()
    }

}

object clima {
    var property humedad = 0
}


class Electrico inherits Wollomon{
    method estaCargado(){
        return clima.humedad() > 97
    }
    override method puedeAtacar() {
        return super() and self.estaCargado()
    }


    override method dañoQueEfectua(){
        if (self.estaCargado()){
            return ataques.first().daño()
        }
        else{
            return 0
        }
    }

    override method recibirAtaqueDe(unWollokmon){
            super(unWollokmon)
            nivelExperiencia -= 1
        }

}


class Legendario inherits Dragon{
    const insignia 

    override method dañoQueEfectua() = super() + insignia.potenciadorPara(self)
}

object insigniaRoja{
    method potenciadorPara(unDragon) = if (unDragon.fuegoInterior()>20) 10 else 0
}
object insigniaAzul{
    method potenciadorPara(unDragon) = 8
}
object insigniaVerde{
    method potenciadorPara(unDragon) = 0
}

// PRUEBA