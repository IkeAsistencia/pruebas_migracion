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
                .replaceAll("í", "i")
                .replaceAll("é", "e")
                .replaceAll("á", "a")
                .replaceAll("ó", "o")
                .replaceAll("ú", "u")
                .replaceAll("ñ", "n")
                .replaceAll("Ñ", "N")
                .replaceAll("¡", "")
                .replaceAll("¢", "")
                .replaceAll("£", "")
                .replaceAll("¤", "")
                .replaceAll("¥", "")
                .replaceAll("¦", "")
                .replaceAll("§", "S")
                .replaceAll("¨", "")
                .replaceAll("©", "C")
                .replaceAll("ª", "")
                .replaceAll("«", "")
                .replaceAll("¬", "")
                .replaceAll("­", "")
                .replaceAll("®", "")
                .replaceAll("¯", "")
                .replaceAll("°", "")
                .replaceAll("±", "")
                .replaceAll("²", "")
                .replaceAll("³", "")
                .replaceAll("´", "")
                .replaceAll("µ", "")
                .replaceAll("¶", "")
                .replaceAll("·", "")
                .replaceAll("¹", "")
                .replaceAll("º", "")
                .replaceAll("»", "")
                .replaceAll("¼", "")
                .replaceAll("½", "")
                .replaceAll("¾", "")
                .replaceAll("¿", "")
                .replaceAll("À", "A")
                .replaceAll("Á", "A")
                .replaceAll("Â", "A")
                .replaceAll("Ã", "A")
                .replaceAll("Ä", "A")
                .replaceAll("Å", "A")
                .replaceAll("Æ", "")
                .replaceAll("Ç", "C")
                .replaceAll("È", "E")
                .replaceAll("É", "E")
                .replaceAll("Ê", "E")
                .replaceAll("Ë", "E")
                .replaceAll("Ì", "I")
                .replaceAll("Í", "I")
                .replaceAll("Î", "I")
                .replaceAll("Ï", "I")
                .replaceAll("Ð", "D")
                .replaceAll("Ò", "O")
                .replaceAll("Ó", "O")
                .replaceAll("Ô", "O")
                .replaceAll("Õ", "O")
                .replaceAll("Ö", "O")
                .replaceAll("×", "X")
                .replaceAll("Ø", "O")
                .replaceAll("Ù", "U")
                .replaceAll("Ú", "U")
                .replaceAll("Û", "U")
                .replaceAll("Ü", "U")
                .replaceAll("Ý", "Y")
                .replaceAll("Þ", "")
                .replaceAll("ß", "")
                .replaceAll("÷", "")
                .replaceAll("Ø", "")
                .replaceAll("Þ", "")
                .replaceAll("ÿ", "")
                .replaceAll("ïï", "");
        return salida;
    }
}
