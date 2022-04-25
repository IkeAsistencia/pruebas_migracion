package com.ike.ws.nrm;

import Utilerias.ConexionApiNRM;
import Utilerias.ConexionGeocoding;
import Utilerias.ResultList;
import com.ike.ws.nrm.to.Tracking;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class WSTrackingNrm {

    private ResultList rs;
    private Tracking tracking;
    private JSONObject result;
    private String status = "";
    private StringBuffer strSql;
    private ConexionApiNRM conexionApiNRM;
    private ConexionGeocoding conexionGeocoding;
    private static final String PATH = "TrackingEvent/tracking/";

    public JSONObject tracking(String command, String vinTspPseudo, Integer clVinTspPseudo) {
        conexionApiNRM = new ConexionApiNRM();
        conexionGeocoding = new ConexionGeocoding();
        JSONObject attributes = new JSONObject();
        attributes.put("command", command);
        attributes.put("vinTspPseudo", vinTspPseudo);

        JSONObject data = new JSONObject();
        data.put("type", "SVT_TRACKING_REQUEST");
        data.put("attributes", attributes);

        JSONObject jSONObject = new JSONObject();
        jSONObject.put("systemId", "ike");
        jSONObject.put("instanceId", "INSTANCE1");
        jSONObject.put("eventType", "SVT_TRACKING_REQUEST");
        jSONObject.put("data", data);
        try {
            result = conexionApiNRM.conectaAPI(PATH + "request", jSONObject);
            if (Integer.parseInt(result.get("status").toString()) == 200) {

//                for (int minutos = 0; minutos < 1; minutos++) {
                    for (int segundos = 0; segundos < 30; segundos++) {
                        System.out.println("Tiempo transcurrido: {} " + segundos);
                        strSql = new StringBuffer();
                        strSql.append("[st_nrm_ConsultaStatusVinTspPseudo] ").append(clVinTspPseudo);
                        rs = new ResultList();
                        rs.rsSQL(strSql.toString());
                        strSql.delete(0, strSql.length());

                        if (rs.next()) {
                            status = rs.getString("status");
                        }

                        if ("TRACKING".equals(status) || "UNTRACKING".equals(status) || "TRACK STATUS VNEXT CORRECT".equals(status) || "UNTRACK STATUS VNEXT CORRECT".equals(status)) {
                            System.out.println("Encontro el estatus VNEX CORRECT");
                            tracking = new Tracking();

                            strSql = new StringBuffer();
                            Integer pointDes = 0;
                            Integer able = 1;
                            if (command.equals("track")) {
                                pointDes = 1;
                            } else if (command.equals("untrack")) {
                                pointDes = 5;
                            }
                            strSql.append("[st_nrm_ConsultaTrackingEvent] ").append(clVinTspPseudo).append(",").append(pointDes).append(",").append(able);
                            System.out.println("Consulta: " + strSql);
                            rs = new ResultList();
                            rs.rsSQL(strSql.toString());
                            strSql.delete(0, strSql.length());

                            if (rs.next()) {
                                if (rs.getString("createdIke") != null) {
                                    System.out.println("SE ENCONTRO EL EVENTO DE TRACKING/UNTRACKING");
                                    tracking.setLatitud(rs.getString("latitude"));
                                    tracking.setLongitud(rs.getString("longitude"));
                                    tracking.setFechaHoraRegistro(rs.getString("createdIke"));
                                    tracking.setEstatusServicio(rs.getString("serviceState"));
                                    tracking.setVelocidad(rs.getString("speed"));
                                    tracking.setEstatusArranque(rs.getString("vehicleState"));
                                    tracking.setNivelBateria(rs.getString("socBattery"));
                                    tracking.setKilometraje(rs.getString("distanceTotalizer"));
                                    tracking.setExitoso(1);
                                    tracking.setMessage(result.get("message").toString());

                                    jSONObject = new JSONObject();
                                    jSONObject.put("latitude", tracking.getLatitud());
                                    jSONObject.put("longitude", tracking.getLongitud());
                                    jSONObject.put("character", true);
                                    JSONObject responseGeo = conexionGeocoding.conectaGeocoding(jSONObject);
                                    JSONArray results = (JSONArray) responseGeo.get("results");
                                    System.out.println("First : " + ((JSONObject) results.get(0)).get("formattedAddress"));
                                    System.out.println("Second : " + ((JSONObject) results.get(1)).get("formattedAddress"));
                                    String ubicacion;
                                    if (((JSONObject) results.get(0)).get("formattedAddress").toString() != null
                                            && !"".equals(((JSONObject) results.get(0)).get("formattedAddress").toString())
                                            && ((JSONObject) results.get(0)).get("formattedAddress") != "UNNAMED ROAD") {

                                        ubicacion = ((JSONObject) results.get(0)).get("formattedAddress").toString();
                                        ubicacion = reemplaza(ubicacion);
                                        System.out.println("Ubicacion con replace: " + ubicacion);
                                        tracking.setUbicacionVehiculo(ubicacion);
                                    } else if (((JSONObject) results.get(1)).get("formattedAddress").toString() != null
                                            && !"".equals(((JSONObject) results.get(1)).get("formattedAddress").toString())
                                            && ((JSONObject) results.get(1)).get("formattedAddress") != "UNNAMED ROAD") {
                                        ubicacion = ((JSONObject) results.get(1)).get("formattedAddress").toString();
                                        ubicacion = reemplaza(ubicacion);
                                        System.out.println("Ubicacion con replace: " + ubicacion);
                                        tracking.setUbicacionVehiculo(ubicacion);
                                    }else{
                                        tracking.setUbicacionVehiculo("NO SE ENCONTRO UBICACION.");
                                    }
                                    status = "TRACKING";
                                    System.out.println("Tracking :" + tracking.toString());
                                    break;
                                }
                            }

                        } else if ("TRACK STATUS VNEXT FAILE".equals(status) || "UNTRACK STATUS VNEXT FAILE".equals(status)) {
                            tracking = new Tracking();
                            tracking.setExitoso(0);
                            tracking.setMessage("LA PETICION NO HA SIDO EXITOSA, INTENTELO NUEVAMENTE");
                            break;
                        }

                        System.out.println("Sensando base. Status: " + status);
                        delaySegundos();
                    }
//                }

                System.out.println("Status: " + status);

                if ("".equals(status) || "TRACK STATUS VNEXT CORRECT".equals(status) || "TRACK STATUS KAM CORRECT".equals(status) || "TRACKING REQUEST".equals(status) || "TRACKING RESPONSE".equals(status)) {
                    System.out.println("TIMEOUT");
                    tracking = new Tracking();
                    tracking.setExitoso(0);
                    tracking.setMessage("LA PETICION ESTA SIENDO MONITOREADA, PUEDE CONTINUAR");
                } else if ("".equals(status) || "UNTRACK STATUS VNEXT CORRECT".equals(status) || "UNTRACK STATUS KAM CORRECT".equals(status) || "UNTRACKING REQUEST".equals(status) || "UNTRACKING RESPONSE".equals(status)) {
                    System.out.println("TIMEOUT");
                    tracking = new Tracking();
                    tracking.setExitoso(0);
                    tracking.setMessage("LA PETICION ESTA SIENDO MONITOREADA, PUEDE CONTINUAR");
                }
            } else {
                System.out.println(result.get("message").toString());
                tracking = new Tracking();
                tracking.setExitoso(0);
                tracking.setMessage("LA PETICION NO HA SIDO EXITOSA, INTENTELO NUEVAMENTE");
            }
        } catch (Exception e) {
            e.printStackTrace();
            tracking = new Tracking();
            tracking.setExitoso(0);
            tracking.setMessage("NO SE PUEDE REALIZAR LA PETICION, INTENTELO NUEVAMENTE");
        }

        JSONObject jsonTracking = new JSONObject();
        jsonTracking.put("ubicacionVehiculo", tracking.getUbicacionVehiculo());
        jsonTracking.put("fechaHoraRegistro", tracking.getFechaHoraRegistro());
        jsonTracking.put("estatusServicio", tracking.getEstatusServicio());
        jsonTracking.put("velocidad", tracking.getVelocidad());
        jsonTracking.put("estatusArranque", tracking.getEstatusArranque());
        jsonTracking.put("nivelBateria", tracking.getNivelBateria());
        jsonTracking.put("kilometraje", tracking.getKilometraje());
        jsonTracking.put("exitoso", tracking.getExitoso());
        jsonTracking.put("message", tracking.getMessage());

        return jsonTracking;
    }

    private static void delaySegundos() {
        try {
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
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
