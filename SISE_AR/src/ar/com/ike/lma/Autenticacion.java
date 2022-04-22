/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ar.com.ike.client.lma;

import ar.com.ike.util.rest.SimpleRESTCall;
import com.sun.xml.messaging.saaj.util.Base64;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 *
 * @author ddiez
 */
public class Autenticacion {
    //QA:
    private static final String URL = "https://servicios.qamercantilandina.com.ar:444/TarjetaRC/api/v1/credenciales";
    //PROD:
    //private static final String URL = "https://servicios.mercantilandina.com.ar/TarjetaRC/api/v1/credenciales";
    
    private static String token = null;
    private static String expires = null;
    //QA: 
    private static String usrpwd = "IKEASISTENCIA:IKEASISTENCIA";
    //PROD: 
    //private String usrpwd = "IKEASISTENCIA:Ugarte1674";
  
    //private static String usrpwd = "SUtFQVNJU1RFTkNJQTpVZ2FydGUxNjc0";
    
    private static Autenticacion single_instance =null;

    public static Autenticacion Autenticacion() {
        if  (single_instance==null) {
            single_instance = new Autenticacion();
        }
        return single_instance;
    }
    
    private Autenticacion() {
        getToken();
    }
    
    public static void main(String[] args ) throws Exception {
        Autenticacion auth = Autenticacion.Autenticacion();
        System.out.println(auth.getAuthToken() );
        System.out.println(auth.getAuthToken() );
    }
    
    public static String getAuthToken() {
        try {
            if ( token == null || expires == null || !isDateExpired(expires) ) {
                System.out.println("token, o expira null o expiro el token");
                if ( getToken() ) {
                    System.out.println("Se pudo obtener token");
                    return Autenticacion.token;
                }
                else {
                    System.out.println("No se pudo obtener token");
                    return "";
                }
            }
            else {
                System.out.println("Token reutilizado");
                return  Autenticacion.token;
            }
        }
        catch (Exception e ){
            System.out.println("ar.com.ike.client.lma.Autenticacion:ERROR AL PARSEAR FECHA" + e.toString());
            return "ERROR";
        }
    }
            
    private static synchronized boolean getToken() { 
        SimpleRESTCall src = new SimpleRESTCall();
        src.addHeader("Authorization", "Basic " + encodeBase64(usrpwd) );
        try {
            SimpleRESTCall.Resultado res = src.getGsonHttpsUrl(URL, "POST", ServTokenResponse.class);
            if ( res.getCodigo() == 200 || res.getCodigo() == 201) {
                ServTokenResponse str = (ServTokenResponse) res.getContenido();
                Autenticacion.token = str.token;
                Autenticacion.expires = str.expira;
                return true;
            }
            else {
                if ( res.getCodigo() == 403 ) {
                    System.out.println("ar.com.ike.client.lma.Autenticacion.ERROR: USUARIO/PASSWORD INCORRECTOS");
                }
                else {
                    System.out.println("ar.com.ike.client.lma.Autenticacion.ERROR: " + String.valueOf(res.getCodigo()));
                }
            }
        }
        catch (Exception e ){
            System.out.println("ar.com.ike.client.lma.Autenticacion.getToken().ERROR");
        }
        return false;
    }

    
    private static String encodeBase64(String str) {
        byte[] ptr = Base64.encode( str.getBytes() );
        String encodedAuth = new String(ptr);
        System.out.println("ENCODED BASE64:" + encodedAuth);
        return encodedAuth;
    }
    
    private static boolean isDateExpired( String expires ) throws Exception  {
       //genero date desde json
        if ( expires != null) {
            String pattern = "yyyy-MM-dd'T'HH.ss.SSS";
            SimpleDateFormat sdf = new SimpleDateFormat(pattern);
            try {
                 Date expired = sdf.parse(expires);
                 Date now = new Date();
                 System.out.println( "Esta dentro de validez: " + now.before(expired) );
                 return now.before(expired);
            }
            catch (ParseException pe) {
                 System.out.println("ar.com.ike.client.lma.Autenticacion:ERROR AL PARSEAR FECHA" + pe.toString()) ;
                 throw new Exception ("ERROR en ar.com.ike.client.lma.Autenticacion");
            }
        }
        else {
           return false;
        }
    }
}
