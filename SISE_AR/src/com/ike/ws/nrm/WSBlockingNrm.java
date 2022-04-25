package com.ike.ws.nrm;

import Utilerias.ConexionApiNRM;
import Utilerias.ConexionGeocoding;
import Utilerias.ResultList;
import com.ike.ws.nrm.to.Blocking;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class WSBlockingNrm {

    private ResultList rs;
    private Blocking blocking;
    private JSONObject result;
    private String status = "";
    private StringBuffer strSql;
    private ConexionApiNRM conexionApiNRM;
    private ConexionGeocoding conexionGeocoding;
    private static final String PATH = "BlockingEvent/blocking/";

    public JSONObject blocking(String command, String vinTspPseudo, Integer clVinTspPseudo) {
        conexionApiNRM = new ConexionApiNRM();
        conexionGeocoding = new ConexionGeocoding();
        JSONObject attributes = new JSONObject();
        attributes.put("command", command);
        attributes.put("vinTspPseudo", vinTspPseudo);

        JSONObject data = new JSONObject();
        data.put("type", "SVT_BLOCKING_REQUEST");
        data.put("attributes", attributes);

        JSONObject jSONObject = new JSONObject();
        jSONObject.put("systemId", "ike");
        jSONObject.put("instanceId", "INSTANCE1");
        jSONObject.put("eventType", "SVT_BLOCKING_REQUEST");
        jSONObject.put("data", data);

        try {
            result = conexionApiNRM.conectaAPI(PATH + "request", jSONObject);
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

                        if ("BLOCKING".equals(status) || "UNBLOCKING".equals(status) || "BLOCK STATUS VNEXT CORRECT".equals(status) || "UNBLOCK STATUS VNEXT CORRECT".equals(status)) {

                            System.out.println("Encontro el estatus " + status);
                            blocking = new Blocking();

                            strSql = new StringBuffer();
                            Integer pointDesBlock = 0;
                            Integer pointDesTrack = 0;
                            if (command.equals("block")) {
                                pointDesBlock = 1;
                                pointDesTrack = 3;
                            } else if (command.equals("unblock")) {
                                pointDesBlock = 3;
                                pointDesTrack = 4;
                            }
                            strSql.append("[st_nrm_ConsultaBlockingEvent] ").append(clVinTspPseudo).append(",").append(pointDesBlock).append(",").append(pointDesTrack);
                            System.out.println("Consulta: " + strSql);
                            rs = new ResultList();
                            rs.rsSQL(strSql.toString());
                            strSql.delete(0, strSql.length());

                            if (rs.next()) {
                                if (rs.getString("createdIke") != null) {
                                    System.out.println("SE ENCONTRO EL EVENTO DE BLOCKING/UNBLOCKING");
                                    blocking.setLatitud(rs.getString("latitude"));
                                    blocking.setLongitud(rs.getString("longitude"));
                                    blocking.setFechaHoraRegistro(rs.getString("createdIke"));
                                    blocking.setEstatusServicio(rs.getString("serviceState"));
                                    blocking.setVelocidad(rs.getString("speed"));
                                    blocking.setEstatusArranque(rs.getString("vehicleState"));
                                    blocking.setNivelBateria(rs.getString("socBattery"));
                                    blocking.setKilometraje(rs.getString("distanceTotalizer"));
                                    blocking.setExitoso(1);
                                    blocking.setMessage(result.get("message").toString());

                                    jSONObject = new JSONObject();
                                    jSONObject.put("latitude", blocking.getLatitud());
                                    jSONObject.put("longitude", blocking.getLongitud());
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
                                        blocking.setUbicacionVehiculo(ubicacion);
                                    } else if (((JSONObject) results.get(1)).get("formattedAddress").toString() != null
                                            && !"".equals(((JSONObject) results.get(1)).get("formattedAddress").toString())
                                            && ((JSONObject) results.get(1)).get("formattedAddress") != "UNNAMED ROAD") {
                                        ubicacion = ((JSONObject) results.get(1)).get("formattedAddress").toString();
                                        ubicacion = reemplaza(ubicacion);
                                        System.out.println("Ubicacion con replace: " + ubicacion);
                                        blocking.setUbicacionVehiculo(ubicacion);
                                    }else{
                                        blocking.setUbicacionVehiculo("NO SE ENCONTRO UBICACION.");
                                    }
                                    status = "BLOCKING";
                                    System.out.println("Blocking :" + blocking.toString());
                                    break;
                                }
                            }
                        }

                        if ("BLOCK STATUS VNEXT FAILE".equals(status) || "UNBLOCK STATUS VNEXT FAILE".equals(status)) {
                            blocking = new Blocking();
                            blocking.setExitoso(0);
                            blocking.setMessage("LA PETICION NO HA SIDO EXITOSA, INTENTELO NUEVAMENTE");
                            break;
                        }

                        System.out.println("Sensando base. Status: " + status);
                        delaySegundos();
                    }
                }

                System.out.println("Status: " + status);
                
                if ("".equals(status) || "BLOCK STATUS VNEXT CORRECT".equals(status) || "BLOCK STATUS KAM CORRECT".equals(status) || "BLOCKING REQUEST".equals(status) || "BLOCKING RESPONSE".equals(status)) {
                    blocking = new Blocking();
                    blocking.setExitoso(0);
                    blocking.setMessage("LA PETICION ESTA SIENDO MONITOREADA, PUEDE CONTINUAR");
                } else if ("".equals(status) || "UNBLOCK STATUS VNEXT CORRECT".equals(status) || "UNBLOCK STATUS KAM CORRECT".equals(status) || "UNBLOCKING REQUEST".equals(status) || "UNBLOCKING RESPONSE".equals(status)) {
                    blocking = new Blocking();
                    blocking.setExitoso(0);
                    blocking.setMessage("LA PETICION ESTA SIENDO MONITOREADA, PUEDE CONTINUAR");
                }
                
            } else {
                System.out.println(result.get("message").toString());
                blocking = new Blocking();
                blocking.setExitoso(0);
                blocking.setMessage("LA PETICION NO HA SIDO EXITOSA, INTENTELO NUEVAMENTE");
            }
        } catch (Exception e) {
            e.printStackTrace();
            blocking = new Blocking();
            blocking.setExitoso(0);
            blocking.setMessage("NO SE PUEDE REALIZAR LA PETICION, INTENTELO NUEVAMENTE");
        }

        JSONObject jsonBlocking = new JSONObject();
        jsonBlocking.put("ubicacionVehiculo", blocking.getUbicacionVehiculo());
        jsonBlocking.put("fechaHoraRegistro", blocking.getFechaHoraRegistro());
        jsonBlocking.put("estatusServicio", blocking.getEstatusServicio());
        jsonBlocking.put("velocidad", blocking.getVelocidad());
        jsonBlocking.put("estatusArranque", blocking.getEstatusArranque());
        jsonBlocking.put("nivelBateria", blocking.getNivelBateria());
        jsonBlocking.put("kilometraje", blocking.getKilometraje());
        jsonBlocking.put("exitoso", blocking.getExitoso());
        jsonBlocking.put("message", blocking.getMessage());

        return jsonBlocking;
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
