/*
 * SessionListener.java
 *
 * Created on 18 de marzo de 2009, 01:33 AM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */
package Seguridad;

/*
 *
 * @author sotelom
 */
import javax.servlet.http.HttpSessionAttributeListener;
import javax.servlet.http.HttpSessionBindingEvent;
import Utilerias.UtileriasBDF;

public class SessionListener implements HttpSessionAttributeListener {

    public void attributeAdded(HttpSessionBindingEvent se) {
        // TODO Auto-generated method stub
        //System.out.println("Inicia Session Atribute" );
    }

    public void attributeRemoved(HttpSessionBindingEvent se) {
        // TODO Auto-generated method stub
        //clusrApp
        if (se.getName().toString() == "clUsrApp") {
            String strclUsrApp = "";
            if (se.getValue() == null) {
                strclUsrApp = "";
            } else {
                strclUsrApp = se.getValue().toString();
                UtileriasBDF.ejecutaSQLNP("st_Salir '" + strclUsrApp + "','','',''");
            }
            System.out.println("attributeRemoved clusrapp: " + strclUsrApp.toString());
            strclUsrApp = null;

        }
        //clBitacora
        if (se.getName().toString() == "AccesoId") {
            String strAccID = "";
            if (se.getValue() == null) {
                strAccID = "";
            } else {
                strAccID = se.getValue().toString();
                UtileriasBDF.ejecutaSQLNP("st_Salir '','','" + strAccID + "','Termina Sesion'");
            }
            System.out.println("attributeRemoved clbitacora: " + strAccID.toString());
            strAccID = null;

        }

        //ext
        if (se.getName().toString() == "ExtAgente") {
            String strExtension = "";
            if (se.getValue() == null) {
                strExtension = "";
            } else {
                strExtension = se.getValue().toString();
                UtileriasBDF.ejecutaSQLNP("st_Salir '','" + strExtension + "','',''");
            }
            System.out.println("attributeRemoved Extension: " + strExtension.toString());
            strExtension = null;

        }

    }

    public void attributeReplaced(HttpSessionBindingEvent se) {
        // TODO Auto-generated method stub
        //System.out.println("Remplaza Session Atribute" );
    }
}
