/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ar.com.ike.geo.hogar.api;
import javax.ws.rs.ApplicationPath;
import javax.ws.rs.core.Application;
        
/**
 *
 * @author ddiez
 */
@ApplicationPath("/rest") //defino el path para los servicios REST
public class ApplicationConfig extends Application {
    public static String CL_USR_APP_AUTO = "3935";
    public static String CL_PVD_PENDIENTE_APP = "1897";
}
