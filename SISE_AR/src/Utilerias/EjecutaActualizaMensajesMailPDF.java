/*
 * EjecutaActualizaMensajesMail.java
 *
 * Created on 20 de septiembre de 2007, 04:54 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package Utilerias; 

/*
 *
 * @author escobarm
 */
public class EjecutaActualizaMensajesMailPDF {
    
    /* Creates a new instance of EjecutaActualizaMensajesMailPDF */
    public static void ActualizaEnviado(Integer clMensaje,Integer enviado) {       
        
        //System.out.println("entra act mail");
        try {
                        
            UtileriasBDF.ejecutaSQLNP(" st_ActualizaMensajesMailPDF "+clMensaje+","+ enviado);
            
        }catch (Exception ex){
            System.out.println("Error en EjecutaActualizaMensajesMailPDF");
            ex.printStackTrace();
        }
        
        //System.out.println("sale act mail");
    }
    
            
}
