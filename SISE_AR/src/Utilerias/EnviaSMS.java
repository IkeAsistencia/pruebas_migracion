package Utilerias;

import com.google.gson.JsonObject;
import java.sql.SQLException;
import java.net.MalformedURLException;
//import jdk.nashorn.internal.ir.debug.JSONWriter;
import org.json.simple.JSONObject;

public class EnviaSMS {

    private static boolean isStarted = false;

    public static boolean getEstatus() {
        return isStarted;
    }

    public static synchronized void EnviaSMS() throws SQLException, MalformedURLException, Exception {
        int IntTopMensajes = 0;
        int IntContador = 0;
        String StrURL = "";
        String StrAccion = "";
        String StrUsuario = "";
        String StrPassword = "";
        String StrclMensaje = "0";
        String StrTelCel = "";
        String StrMensaje = "";
        String StrParametros = "";

        try {
            ResultList rs = new ResultList();
            rs.rsSQL("st_GetDataSMSWavy");
            if (rs.next()) {
                StrURL = rs.getString("URL");
                StrUsuario = rs.getString("Usuario");
                StrPassword = rs.getString("Password");
                StrAccion = rs.getString("Accion");
                IntTopMensajes = rs.getInt("NumMensajes");
            }
            rs.close();
            rs = null;
            rs = new ResultList();
            rs.rsSQL("st_GetMensajeSMSWavy '" + IntTopMensajes + "'");

            while (rs.next()) {
                IntContador = IntContador++;
                StrclMensaje = rs.getString("clMensaje");
                StrTelCel = rs.getString("Celular");
                StrMensaje = rs.getString("Mensaje");
                //StrMensaje = StrMensaje.replaceAll(",", "%2C");
                JSONObject js = new JSONObject();
                js.put("destination", StrTelCel);
                js.put("messageText", StrMensaje);
                //StrParametros = "longMessage=true" + "&action=" + StrAccion + "&usuario=" + StrUsuario + "&clave=" + StrPassword + "&cel=" + StrTelCel + "&men=" + StrMensaje;
                StrParametros = "usuario=" + StrUsuario + "&clave=" + StrPassword + "&celulares=" + StrTelCel + "&mensaje=" + StrMensaje;
                
                System.out.println("Param: " + StrParametros);
                
                if (!StrclMensaje.equalsIgnoreCase("0")) {
                    ConexionURLSMS.EnviaSMSxURL(StrURL, js, StrclMensaje, StrUsuario, StrPassword);
                }
            }

            rs.close();
            rs = null;

            if (IntContador >= IntTopMensajes) {
            } else {
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {

            StrURL = null;
            StrAccion = null;
            StrUsuario = null;
            StrPassword = null;
            StrclMensaje = null;
            StrTelCel = null;
            StrMensaje = null;
            StrParametros = null;
        }
    }

    public static void StartSMS() {
        chStatusSMS(true);
        TimerProcesaSMS.StartSMS();
    }

    public static void StopSMS() {
        chStatusSMS(false);
    }

    private static void chStatusSMS(boolean pEstatus) {
        isStarted = pEstatus;
    }

    public static void main (String con[]) throws Exception{
        EnviaSMS();
    }
}