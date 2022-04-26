package com.ike.ws.nrm;

import Utilerias.ConexionApiNRM;
import Utilerias.UtileriasBDF;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.json.simple.JSONObject;

public class WSClientsNrm {

    private ConexionApiNRM conexionApiNRM;
    
    public String getVinXVinTspPseudo(String vinTspPseudo){
        String vin = null;
        conexionApiNRM = new ConexionApiNRM();
        JSONObject jSONObject = new JSONObject();
        jSONObject.put("vinTspPseudo", vinTspPseudo);
        JSONObject result = conexionApiNRM.conectaAPI("AdditionalEvents/vinTspPseudo/decrypt", jSONObject);
        if (Integer.parseInt(result.get("status").toString()) == 200) {
            vin = ((JSONObject) result.get("data")).get("vin").toString();
        }
        return vin;
    }
    
    public String getVinTspPSeudoXVin(String vin){
        String vinTspPseudo = null;
        conexionApiNRM = new ConexionApiNRM();
        JSONObject jSONObject = new JSONObject();
        jSONObject.put("vin", vin);
        JSONObject result = conexionApiNRM.conectaAPI("AdditionalEvents/vin/crypt", jSONObject);
        if (Integer.parseInt(result.get("status").toString()) == 200) {
            vinTspPseudo = ((JSONObject) result.get("data")).get("vinTspPseudo").toString();
        }
        return vinTspPseudo;
    }

    public String getClientByVin(String vin) {
        String vinTspPseudo = null;
        String salida = null;
        conexionApiNRM = new ConexionApiNRM();
        JSONObject jSONObject = new JSONObject();
        jSONObject.put("vin", vin);
        try {
            JSONObject result = conexionApiNRM.conectaAPI("AdditionalEvents/vin/crypt", jSONObject);
            if (Integer.parseInt(result.get("status").toString()) == 200) {
                vinTspPseudo = ((JSONObject) result.get("data")).get("vinTspPseudo").toString();
                System.out.println("VinTspPseudo: " + vinTspPseudo);
                StringBuffer strSql = new StringBuffer();
                StringBuffer strSalida = new StringBuffer();
                UtileriasBDF.rsTableNP(strSql.append("[st_nrm_GetAfiliadosXVin] '").append(vinTspPseudo).append("'").toString(), strSalida);
                salida = strSalida.toString();
                strSql.delete(0, strSql.length());
                strSalida.delete(0, strSalida.length());
                strSalida = null;
                strSql = null;
            } else if (Integer.parseInt(result.get("status").toString()) == 404) {
                System.out.println("El usuario no esta afiliado o el vin proporcionado es incorrecto.");
                salida = "<table id=\"ObjTable\" class=\"Table\" border=\"0\" cellpadding=\"0\"><tbody><tr class=\"TTable\"><th>Mensaje</th></tr><tr class=\"R1Table\"><td>El usuario no esta afiliado o el vin proporcionado es incorrecto.</td></tr></tbody></table>";
            }
        } catch (Exception ex) {
            Logger.getLogger(WSClientsNrm.class.getName()).log(Level.SEVERE, null, ex);
        }
        if (salida == null) {
            salida = "<table id=\"ObjTable\" class=\"Table\" border=\"0\" cellpadding=\"0\"><tbody><tr class=\"TTable\"><th>Mensaje</th></tr><tr class=\"R1Table\"><td>El servicio no esta disponible por el momento.</td></tr></tbody></table>";
        }
        System.out.println("Salida: " + salida);
        return salida;
    }

    public String getClientByName(String name) {
        String salida = null;
        StringBuffer strSql = new StringBuffer();
        StringBuffer strSalida = new StringBuffer();
        UtileriasBDF.rsTableNP(strSql.append("[st_nrm_GetAfiliadoXName] '").append(name).append("'").toString(), strSalida);
        salida = strSalida.toString();
        strSql.delete(0, strSql.length());
        strSalida.delete(0, strSalida.length());
        strSalida = null;
        strSql = null;
        if (salida == null) {
            salida = "<table id=\"ObjTable\" class=\"Table\" border=\"0\" cellpadding=\"0\"><tbody><tr class=\"TTable\"><th>Mensaje</th></tr><tr class=\"R1Table\"><td>El usuario no esta afiliado o hay un eror en el nombre.</td></tr></tbody></table>";
        }
        System.out.println("Salida: " + salida);
        return salida;
    }
    
    public String getClientByEmail(String correo){
        String salida = null;
        StringBuffer strSql = new StringBuffer();
        StringBuffer strSalida = new StringBuffer();
         UtileriasBDF.rsTableNP(strSql.append("[st_nrm_GetAfiliadoXCorreo] '").append(correo).append("'").toString(), strSalida);
        salida = strSalida.toString();
        strSql.delete(0, strSql.length());
        strSalida.delete(0, strSalida.length());
        strSalida = null;
        strSql = null;
        if (salida == null) {
            salida = "<table id=\"ObjTable\" class=\"Table\" border=\"0\" cellpadding=\"0\"><tbody><tr class=\"TTable\"><th>Mensaje</th></tr><tr class=\"R1Table\"><td>El usuario no esta afiliado o hay un eror en el nombre.</td></tr></tbody></table>";
        }
        System.out.println("Salida: " + salida);
        return salida;
    }
}
