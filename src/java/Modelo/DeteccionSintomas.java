
package Modelo;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import jess.Fact;
import jess.JessException;

public class DeteccionSintomas {
    private String tipo; /*pregunta, respuesta*/
    private String sentencia; /*valor de la respuesta o pregunta*/
    private List<Fact> hechos;
    private Iterator it;
    private Fact hecho;
    
    public DeteccionSintomas() {
    }
    
    /*actualiza los datos del ultimo hecho asertado*/
    public void leerValoresHecho() {     
        try {
            tipo = (hecho.getName().contains("pregunta")?"pregunta":"solucion"); /*simbolo texto*/
            sentencia = String.valueOf(hecho.get(0)); /*string valor*/
            
        } catch (JessException ex) {
            System.err.println("Error al actualizar hecho nuevo");
        }
    }
    
    /*respuesta: si / no*/
    public void ingresarRespuestaSintoma(String respuesta) {
        try {
            BaseConocimiento.gestorClips.assertString("(respuesta " + respuesta + ")");
            BaseConocimiento.gestorClips.run();
            obtenerHechoActual();
        } catch (JessException ex) {
            System.err.println("Error al crear el hecho.");
        }
    }
    
    public void obtenerHechoActual() {
        int contador = -1;
        
        it = BaseConocimiento.gestorClips.listFacts();
        while(it.hasNext()) {
            hecho = (Fact) it.next();
            try {
                System.out.println(hecho.getName() + " "+ hecho.get(0));
            } catch (JessException ex) {
                
            }
            contador++;
        }
        System.out.println("contador " + contador);
        leerValoresHecho();
      }
    
    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public String getSentencia() {
        return sentencia;
    }

    public void setSentencia(String sentencia) {
        this.sentencia = sentencia;
    }

    
}
