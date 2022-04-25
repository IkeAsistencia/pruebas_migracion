package com.ike.ws.nrm;

import Utilerias.ConexionGeocoding;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class WSGeocodingNrm {

    private ConexionGeocoding conexionGeocoding;

    public String geocoding(String latitud, String longitud) {
        conexionGeocoding = new ConexionGeocoding();
        System.out.println("Entro a WSGeocoding");
        System.out.println("Latitud: " + latitud);
        System.out.println("Longitud: " + longitud);
        JSONObject jSONObject = new JSONObject();
        jSONObject.put("latitude", latitud);
        jSONObject.put("longitude", longitud);
        jSONObject.put("character", true);
        JSONObject responseGeo = conexionGeocoding.conectaGeocoding(jSONObject);
        JSONArray results = (JSONArray) responseGeo.get("results");
        System.out.println("First : " + ((JSONObject) results.get(0)).get("formattedAddress"));
        System.out.println("Second : " + ((JSONObject) results.get(1)).get("formattedAddress"));
        String ubicacion = null;
        if (((JSONObject) results.get(0)).get("formattedAddress").toString() != null
                && !"".equals(((JSONObject) results.get(0)).get("formattedAddress").toString())
                && ((JSONObject) results.get(0)).get("formatted_address") != "Unnamed Road") {

            ubicacion = ((JSONObject) results.get(0)).get("formattedAddress").toString();
            ubicacion = reemplaza(ubicacion);
            System.out.println("Ubicacion con replace: " + ubicacion);
        }
        
        return ubicacion;
    }
    
     private String reemplaza(String mensaje) {
        String salida = mensaje
                .replaceAll("�", "i")
                .replaceAll("�", "e")
                .replaceAll("�", "a")
                .replaceAll("�", "o")
                .replaceAll("�", "u")
                .replaceAll("�", "n")
                .replaceAll("�", "N")
                .replaceAll("�", "")
                .replaceAll("�", "")
                .replaceAll("�", "")
                .replaceAll("�", "")
                .replaceAll("�", "")
                .replaceAll("�", "")
                .replaceAll("�", "S")
                .replaceAll("�", "")
                .replaceAll("�", "C")
                .replaceAll("�", "")
                .replaceAll("�", "")
                .replaceAll("�", "")
                .replaceAll("�", "")
                .replaceAll("�", "")
                .replaceAll("�", "")
                .replaceAll("�", "")
                .replaceAll("�", "")
                .replaceAll("�", "")
                .replaceAll("�", "")
                .replaceAll("�", "")
                .replaceAll("�", "")
                .replaceAll("�", "")
                .replaceAll("�", "")
                .replaceAll("�", "")
                .replaceAll("�", "")
                .replaceAll("�", "")
                .replaceAll("�", "")
                .replaceAll("�", "")
                .replaceAll("�", "")
                .replaceAll("�", "")
                .replaceAll("�", "A")
                .replaceAll("�", "A")
                .replaceAll("�", "A")
                .replaceAll("�", "A")
                .replaceAll("�", "A")
                .replaceAll("�", "A")
                .replaceAll("�", "")
                .replaceAll("�", "C")
                .replaceAll("�", "E")
                .replaceAll("�", "E")
                .replaceAll("�", "E")
                .replaceAll("�", "E")
                .replaceAll("�", "I")
                .replaceAll("�", "I")
                .replaceAll("�", "I")
                .replaceAll("�", "I")
                .replaceAll("�", "D")
                .replaceAll("�", "O")
                .replaceAll("�", "O")
                .replaceAll("�", "O")
                .replaceAll("�", "O")
                .replaceAll("�", "O")
                .replaceAll("�", "X")
                .replaceAll("�", "O")
                .replaceAll("�", "U")
                .replaceAll("�", "U")
                .replaceAll("�", "U")
                .replaceAll("�", "U")
                .replaceAll("�", "Y")
                .replaceAll("�", "")
                .replaceAll("�", "")
                .replaceAll("�", "")
                .replaceAll("�", "")
                .replaceAll("�", "")
                .replaceAll("�", "")
                .replaceAll("��", "");
        return salida;
    }
}
