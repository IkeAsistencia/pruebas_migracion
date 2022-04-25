 /*
 * Cliente.java
 *
 * Created on 9 de diciembre de 2004, 04:05 PM
 */

package Seguridad;

import java.io.IOException;
import java.io.InputStream;
import java.io.DataInputStream;
import java.io.PrintWriter;
import java.net.Socket;
import java.awt.*;

/*
 * Clase Cliente: Esta clase la llama el Servlet Login y verfiica en un socket que el
 *                usuario tenga acceso al sisteme mediante una IP que es verificada 
 *                en un rango de IP's por medio del Socket que apunta a un servidor
 *
 * @author : Guillermo Lopez Espinosa
 * @version: 09/12/2004
 * @throws : Si no encuentra el Cocket por que esta apagado o por que el puerto no corresponde
 *           manda un Error
 *
 */


public class Cliente {
    
    public String Cliente() {
        int c;
        Socket s;
        InputStream sIn;
        String Host = "sonic0";
        int Puerto = 4321;
        String cadena;
        
        // Abrimos una conexión con el Servidor en el puerto 4321
        try {
            s = new Socket(Host, Puerto);
            // Obtenemos un controlador de fichero de entrada del socket y
            // leemos esa entrada
            InputStream aux = s.getInputStream();
            DataInputStream flujo = new DataInputStream(aux);
            cadena = flujo.readUTF();
            s.close();
            System.out.println(cadena);
            return cadena;
        }catch(IOException e){
             e.printStackTrace(); 
        }
        return null;
    }
}
