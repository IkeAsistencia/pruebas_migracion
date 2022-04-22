package Utilerias;

import java.net.URLConnection;
import java.net.MalformedURLException;
import java.io.IOException;
import javax.net.ssl.HostnameVerifier;
//import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLSession;
import java.net.URL;
import java.net.HttpURLConnection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

public class ConexionURLSMS {

    //--------------------------------------------------------------------------
    public ConexionURLSMS() {
    }

    //--------------------------------------------------------------------------
    public static void EnviaSMSxURL(String StrURL, JSONObject StrParametros, String StrclMensaje, String user, String token) throws Exception, SQLException {
        URL url;
        URLConnection urlc;
        String StrEncabezado;
        String StrID = "";
        String StrRespuesta = "";
        String StrError = "0";
        String StrLine = "";
        String StrResponse = "";
        OutputStreamWriter out = null;
        BufferedReader rd = null;
        String RespStatusCode = "";
        String RespStatusMessage = "";
        String RespMessageID = "";
        String RespRecipient = "";
        String RespMessageType = "";
        String RespMessageData = "";
        try {
            CertificadoSSL(StrURL);
            /*HttpsURLConnection.setFollowRedirects(false);
            HttpsURLConnection con = (HttpsURLConnection) new URL(StrURL + StrParametros).openConnection();*/
            HttpURLConnection.setFollowRedirects(false);
            //URLEncoder encoder URLE = StrURL + StrParametros;
            HttpURLConnection con = (HttpURLConnection) new URL(StrURL).openConnection();
            //HttpURLConnection con = (HttpURLConnection) new URL(StrURL + URLEncoder.encode(StrParametros, StrParametros)).openConnection();
            con.setRequestMethod("POST");//POST
            con.setRequestProperty("authenticationtoken", token);//POST
            con.setRequestProperty("username", user);//POST
            con.setRequestProperty("Content-Type", "application/json; charset=utf-8");//POST
            con.setDoOutput(true);
            con.setReadTimeout(15000);
            con.setConnectTimeout(15000);
            con.connect();
            //---------------------------------------
          OutputStream send=con.getOutputStream();
            send.write(StrParametros.toString().getBytes("UTF-8"));
            
            send.flush();
            rd = new BufferedReader(new InputStreamReader(con.getInputStream()));
            String respuestaURL = rd.readLine();
            /*
            while ((StrLine = rd.readLine()) != null) {
                StrResponse += StrLine;
            }*/
            try {
                JSONParser jp = new JSONParser();
                JSONObject o = (JSONObject) jp.parse(respuestaURL);
                String r = o.get("id").toString();
                System.out.println("respuesta: "+r);
            } catch (Exception e) {
            }
            
            //---------------------------------------
            StrResponse = StrResponse.replaceAll("'", "");
            StrResponse = StrResponse.replaceAll("\"", "");
            con = null;
            System.out.println(StrURL + StrParametros);
            System.out.println(StrURL + StrParametros);
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("ERROR EN ENVIO SMS - SISE AR:   clMensaje " + StrclMensaje + " - URL+Parametros=" + StrURL + StrParametros);
        } finally {
            if (!StrResponse.equalsIgnoreCase("")) {
                RespStatusCode = getValueofTag(StrResponse, "statuscode");
                RespStatusMessage = getValueofTag(StrResponse, "statusmessage");
                RespMessageID = getValueofTag(StrResponse, "messageid");
                RespRecipient = getValueofTag(StrResponse, "recipient");
                RespMessageType = getValueofTag(StrResponse, "messagetype");
                RespMessageData = getValueofTag(StrResponse, "messagedata");
            }
            StrError = ActualizaEstatusSMS(StrclMensaje, StrResponse, RespStatusCode, RespStatusMessage, RespMessageID, RespRecipient, RespMessageType, RespMessageData);
            StrError = null;
        }
        url = null;
        urlc = null;
        StrEncabezado = null;
        StrID = null;
        StrRespuesta = null;
        StrError = null;
        StrLine = null;
        StrResponse = null;
        out = null;
        rd = null;
        RespStatusCode = null;
        RespStatusMessage = null;
        RespMessageID = null;
        RespRecipient = null;
        RespMessageType = null;
        RespMessageData = null;
    }

    //--------------------------------------------------------------------------
    public static void CertificadoSSL(String StrURL) throws Exception {
        try {
            HostnameVerifier hv = new HostnameVerifier() {
                public boolean verify(String StrNombreHostURL, SSLSession Sesion) {
                    StrNombreHostURL = null;
                    Sesion = null;
                    return true;
                }
            };
            ConfianzaTodoCertificadoHTTPS();
            //HttpsURLConnection.setDefaultHostnameVerifier(hv);
            //HttpURLConnection.setDefaultHostnameVerifier(hv);
            hv = null;
        } catch (MalformedURLException mue) {
            mue.printStackTrace();
        } catch (IOException ioe) {
            ioe.printStackTrace();
        }
        StrURL = null;
    }

    //--------------------------------------------------------------------------
    private static void ConfianzaTodoCertificadoHTTPS() throws Exception {
        javax.net.ssl.TrustManager[] ConfiaTodoCertificado = new javax.net.ssl.TrustManager[1];
        javax.net.ssl.TrustManager tm = new AdminConfianza();
        ConfiaTodoCertificado[0] = tm;
        javax.net.ssl.SSLContext sc = javax.net.ssl.SSLContext.getInstance("SSL");
        sc.init(null, ConfiaTodoCertificado, null);
        javax.net.ssl.HttpsURLConnection.setDefaultSSLSocketFactory(sc.getSocketFactory());
    }

    //--------------------------------------------------------------------------
    public static class AdminConfianza implements javax.net.ssl.TrustManager, javax.net.ssl.X509TrustManager {

        public java.security.cert.X509Certificate[] getAcceptedIssuers() {
            return null;
        }

        public boolean EsServidorConfianza(java.security.cert.X509Certificate[] certs) {
            return true;
        }

        public boolean isClientTrusted(java.security.cert.X509Certificate[] certs) {
            return true;
        }

        public void checkServerTrusted(java.security.cert.X509Certificate[] certs, String authType) throws java.security.cert.CertificateException {
            return;
        }

        public void checkClientTrusted(java.security.cert.X509Certificate[] certs, String authType) throws java.security.cert.CertificateException {
            return;
        }
    }

    //--------------------------------------------------------------------------
    public static String ActualizaEstatusSMS(String StrclMensaje, String StrResponse, String RespStatusCode, String RespStatusMessage, String RespMessageID, String RespRecipient, String RespMessageType, String RespMessageData) throws Exception, SQLException {
        String StrError = "0";
        String StrSQl = "";
        ResultSet rs = null;
        StrSQl = "st_UpdateStatusSMS '" + StrclMensaje + "','" + StrResponse + "','" + RespStatusCode + "','" + RespStatusMessage + "','" + RespMessageID + "','" + RespRecipient + "','" + RespMessageType + "','" + RespMessageData + "'";
        System.out.println(StrSQl);
        System.out.println(StrSQl);
        System.out.println(StrSQl);
        rs = UtileriasBDF.rsSQLNP(StrSQl);
        if (rs.next()) {
            StrError = rs.getString("Error");
        }
        rs.close();
        rs = null;
        StrSQl = null;
        return StrError;
    }

    //--------------------------------------------------------------------------
    //<<<<<<<<<<<<<<<<<< Función para obtener el valor del nodo en la cadena  >>>>>>>>>>>>>>>>>
    public static String getValueofTag(String RespuestaURL, String Tag) {
        //<<<<<<<<<<<<<<<< Eliminar los espacios en blanco en la cadena >>>>>>>>>>>>>>>>
        RespuestaURL = RespuestaURL.replace(" ", "%20");
        int index = 0;
        //<<<<<<<<<<<<<< Obtener el index de donde inicia el Tag  >>>>>>>>>>>>>>>
        index = RespuestaURL.indexOf(Tag, 0);
        if (index > 0) {
            try { //<<<<<<<<<<<<< Eliminar lo anterior al Tag >>>>>>>>>>>>>
                RespuestaURL = RespuestaURL.substring(index + Tag.length());
            } catch (Exception ex) {
                ex.printStackTrace();
            }
            //<<<<<<<<<<<< Agregar </ para buscar el tag del final >>>>>>>>>>>>>
            Tag = Tag.replace("<", "</");
            //<<<<<<<<<<<<<< Obtener el index de donde inicia el Tag  >>>>>>>>>>>>>>>
            index = RespuestaURL.indexOf(Tag, 0);
            try {  //<<<<<<<<<<<< Obtener el valor del Tag >>>>>>>>>>>>
                RespuestaURL = RespuestaURL.substring(0, index);
            } catch (Exception ex2) {
                ex2.printStackTrace();
            }
            RespuestaURL = RespuestaURL.substring(1, RespuestaURL.length());
            RespuestaURL = RespuestaURL.substring(0, RespuestaURL.length() - 2);
            //<<<<<<<<<<<<<< Regresa el valor del Tag >>>>>>>>>>>>>>
            RespuestaURL = RespuestaURL.replace("%20", " ");
        } else {
            RespuestaURL = "";
        }
        return RespuestaURL; 
    } 
    //--------------------------------------------------------------------------
}