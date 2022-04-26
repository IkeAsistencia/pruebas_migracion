/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ar.com.ike.geo;
/**
 *
 * @author ddiez
 */
public class Geolocalizacion {
    public static final String GEO_HOST = "//186.122.147.182";
    public static final String GEO_PORT = ":8080";
    public static final String PROVINCIA_ENDPOINT = GEO_HOST + "/admin_levels";
    public static final String LOCALIDAD_ENDPOINT = GEO_HOST + "/admin_levels";
    public static final String CALLE_ENDPOINT = GEO_HOST + "/streets";
    public static final String ENTRECALLE_ENDPOINT = GEO_HOST +"/intersections";

    //IKE Argentina Api Key.
    public static final String GOOGLE_API_KEY = "AIzaSyDED_Yzn1vXmmmTOhw4IgxCAfEpyXXWTJk";

    public enum PopUpModo { Provincias, Localidad, Calle, EntreCalle, Mapa }

    public static PopUpModo getDefaultPopUpModo() {
        return  PopUpModo.Provincias;
    }

}
