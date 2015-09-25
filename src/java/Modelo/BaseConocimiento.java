
package Modelo;

import java.util.Iterator;
import jess.JessException;
import jess.Rete;

/**
 *
 * @author christian
 */
public class BaseConocimiento {
    public static Rete gestorClips;
    
    public BaseConocimiento () {
        gestorClips = new Rete();
    }
    
    /*carga el programa y los hechos iniciales*/
    public void iniciar(String ruta) {
        Iterator it;
        String nuevaRuta;
        
        try {
            nuevaRuta = ruta.substring(0, ruta.length() - 6) + "facts.dat";
            nuevaRuta = nuevaRuta.replace('\\', '/');
            
            gestorClips.eval("(clear)");
            gestorClips.batch(ruta);
            gestorClips.run();
            //gestorClips.eval("(load-facts \"" + nuevaRuta + "\")");
            gestorClips.assertString("(inicio \"" + nuevaRuta + "\")");
            gestorClips.run();
            
            System.out.println("nr: " + nuevaRuta);
            
            System.out.println("Reglas cargadas correctamente.");
        }
        catch(JessException je) {
            System.out.println("Error al leer programa.");
        }
    }
}
