/*
 * Servidor.java
 *
 * Created on 17 de noviembre de 2004, 11:05 AM
 */

package Seguridad;

import Utilerias.UtileriasBDF;
import java.sql.ResultSet;
import java.net.ServerSocket;
import java.net.Socket;
import java.io.OutputStream;
import java.io.DataOutputStream;
import java.io.IOException;

class Servidor {
    public static void main(String args[]) {
        ServerSocket s = (ServerSocket)null;
        Socket s1;
        String cadena = "Conectado";
        String cadena1 = "Servidor Ocupado Intente mas Tarde";
        int longCad;
        OutputStream s1out;
        ResultSet rsIP;
        String strIP;
        int Puerto=0;
        
        // Busca en la Base de datos el puerto para crear el socket
        ResultSet rsHost = UtileriasBDF.rsSQLNP("Select TOP 1 PuertoHost from AccesoxIp");
        try {
            rsHost.next();
            Puerto = rsHost.getInt("PuertoHost");
        } catch(Exception e){
            e.printStackTrace();
        }
        // Establece el servidor en el socket 4321 (espera 300 segundos)
        try {
            s = new ServerSocket(Puerto);
        } catch( IOException e ) {
            ;
        }

        // Ejecuta un bucle infinito de listen/accept
        while( true ) {
            try {
                // Espera para aceptar una conexión
                s1 = s.accept();
                // Obtiene un controlador de fichero de salida asociado con el socket
                s1out = s1.getOutputStream();
                
                //Revisa dentro de la base de datos la IP
                strIP = s1.getInetAddress().toString();
                strIP = strIP.replaceFirst("/", "");
                rsIP = UtileriasBDF.rsSQLNP("select Acceso from AccesoxIp where '" + strIP + "' between clNumRangIpIni and clNumRangIpFin");
                try {
                    rsIP.next();
                    if (rsIP.getString("Acceso").equals("0")) {
                        // Envia mensaje de ERROR
                        DataOutputStream flujo= new DataOutputStream(s1out);
                        flujo.writeUTF(cadena1);

                        System.out.println(cadena1);
                        System.out.println("Error IP " + s1.getInetAddress());

                        // Cierra la conexión, pero no el socket del servidor
                        s1.close();
                    } else {
                        // Envia mensaje de EXITO
                        DataOutputStream flujo= new DataOutputStream(s1out);
                        flujo.writeUTF(cadena);

                        System.out.println(cadena);
                        System.out.println("Exito IP" + s1.getInetAddress());

                        // Cierra la conexión, pero no el socket del servidor
                        s1.close();
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                        // Envia mensaje de ERROR
                        DataOutputStream flujo= new DataOutputStream(s1out);
                        flujo.writeUTF(cadena1);

                        System.out.println(cadena1);
                        System.out.println("Error IP " + s1.getInetAddress());

                        // Cierra la conexión, pero no el socket del servidor
                        s1.close();
                }

            } catch( IOException e ) {
                ;
            }
        }
    }
}

//
