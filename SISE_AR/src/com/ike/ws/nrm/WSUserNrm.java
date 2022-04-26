package com.ike.ws.nrm;

import Utilerias.ConexionApiNRM;
import Utilerias.ResultList;
import com.ike.ws.nrm.to.User;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

public class WSUserNrm {

    private ConexionApiNRM conexionApiNRM;
    private JSONObject result;
    private StringBuffer strSql;
    private ResultList rs;
    private String status = "";
    private User user;
    private static final String PATH = "SubscriptionEvent/user-info/";

    public JSONObject request(String json, String clVinTspPseudo) {
        conexionApiNRM = new ConexionApiNRM();
        try {
            JSONParser jSONParser = new JSONParser();
            JSONObject jSONObject = (JSONObject) jSONParser.parse(json);
            result = conexionApiNRM.conectaAPI(PATH + "/request", jSONObject);
            System.out.println("Result Request: " + result);

            if (Integer.parseInt(result.get("status").toString()) == 200) {
                for (int minutos = 0; minutos < 1; minutos++) {
                    for (int segundos = 0; segundos < 60; segundos++) {
                        System.out.println("Tiempo transcurrido: {} " + minutos + ":" + segundos);
                        strSql = new StringBuffer();
                        strSql.append("[st_nrm_ConsultaStatusVinTspPseudo] ").append(clVinTspPseudo);
                        rs = new ResultList();
                        rs.rsSQL(strSql.toString());
                        strSql.delete(0, strSql.length());
                        if (rs.next()) {
                            status = rs.getString("status");
                        }
                        if (status.equals("USER RESPONSE")) {
                            user = new User();
                            strSql = new StringBuffer();
                            strSql.append("[st_nrm_ConsultaUserResponse] ").append(clVinTspPseudo);
                            System.out.println("Consulta: " + strSql);
                            rs = new ResultList();
                            rs.rsSQL(strSql.toString());
                            strSql.delete(0, strSql.length());

                            if (rs.next()) {
                                    user.setExitoso(1);
                                    user.setName(rs.getString("name"));
                                    user.setPhoneNumber(rs.getString("phoneNumber"));
                                    user.setModelName(rs.getString("modelName"));
                                    user.setVechicleBrand(rs.getString("vechicleBrand"));
                                    user.setVehicleColor(rs.getString("vehicleColor"));
                                    user.setVehiclePlateNumber(rs.getString("vehiclePlateNumber"));
                                    user.setMessage("SE HA ACTUALIZADO LA INFORMACION DEL USUARIO");
                                    break;
                            }

                        }
                        System.out.println("Sensando base. Status: " + status);
                        delaySegundos();
                    }
                }
                
                if(user == null){
                    user = new User();
                    user.setExitoso(0);
                    user.setMessage("NO SE PUEDE REALIZAR LA PETICION, INTENTELO NUEVAMENTE");
                }
            } else {
                System.out.println(result.get("message").toString());
                user = new User();
                user.setExitoso(0);
                user.setMessage("NO SE PUEDE REALIZAR LA PETICION, INTENTELO NUEVAMENTE");
            }
        } catch (Exception ex) {
             user = new User();
             user.setExitoso(0);
             user.setMessage("OCURRIO UN ERROR REALIZAR LA PETICION, INTENTELO NUEVAMENTE");
            Logger.getLogger(WSUserNrm.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        JSONObject jsonUser = new JSONObject();
        jsonUser.put("exitoso", user.getExitoso());
        jsonUser.put("message", user.getMessage());
        jsonUser.put("name", user.getName());
        jsonUser.put("phoneNumber", user.getPhoneNumber());
        jsonUser.put("modelName", user.getModelName());
        jsonUser.put("vechicleBrand", user.getVechicleBrand());
        jsonUser.put("vehicleColor", user.getVehicleColor());
        jsonUser.put("vehiclePlateNumber", user.getVehiclePlateNumber());
        return jsonUser;
    }

    public JSONObject forward(String json) {
        conexionApiNRM = new ConexionApiNRM();
        try {
            JSONParser jSONParser = new JSONParser();
            JSONObject jSONObject = (JSONObject) jSONParser.parse(json);
            result = conexionApiNRM.conectaAPI(PATH + "/forward-user-settings", jSONObject);
            System.out.println("Result Forward: " + result);
        } catch (Exception ex) {
            Logger.getLogger(WSUserNrm.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
    }

    private static void delaySegundos() {
        try {
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
}
