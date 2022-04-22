package Utilerias;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

public class ConexionApiNRM {
    
        public JSONObject conectaAPI(String StrURL, JSONObject jsonObject){
        OutputStreamWriter out = null;
        BufferedReader rd = null;
        InputStream inputStream=null;
        JSONObject jSONObject = new JSONObject();
        try {
//            String mainUrl = "http://172.21.28.52:8080/";
//            HttpURLConnection con = (HttpsURLConnection) new URL(StrURL + StrParametros).openConnection();
//            HttpURLConnection.setFollowRedirects(false);

            String mainUrl = "https://esbike.ikeasistencia.com/";
            SSLContext sc = SSLContext.getInstance("TLSv1.2");
            sc.init(null, null, new java.security.SecureRandom());
            HttpsURLConnection con = (HttpsURLConnection) new URL(mainUrl + StrURL).openConnection();
            HttpsURLConnection.setFollowRedirects(false);
            con.setRequestProperty("Accept","application/json;charset=UTF-8");
            con.setRequestProperty("Content-Type","application/json;charset=UTF-8");
            con.setRequestMethod("POST");
            con.setDoOutput(true);
            
            
            con.setRequestProperty("User-Agent", "Mozilla/5.0");
            con.setRequestProperty("Content-type", "application/json; charset=utf-8");
            con.setRequestProperty("ACCEPT-LANGUAGE", "es-ES,es;q=0.8,en;");
                
                
            con.setReadTimeout(15000);
            con.setConnectTimeout(15000);
            con.setSSLSocketFactory(sc.getSocketFactory());
            con.connect();
            
            
            
            
            out = new OutputStreamWriter(con.getOutputStream());
            out.write(jsonObject.toString());
            out.flush();
            
            int status = con.getResponseCode();
            if (status != java.net.HttpURLConnection.HTTP_OK){
                inputStream = con.getErrorStream();
                System.out.println("Error");
            }else{
                inputStream = con.getInputStream();
                System.out.println("Sin Error");
            }
            
            rd = new BufferedReader(new InputStreamReader( inputStream));
            StringBuilder builder = new StringBuilder(rd.readLine());
            System.out.println("Builder Api: " + builder);
            JSONParser jSONParser = new JSONParser();
            jSONObject = (JSONObject) jSONParser.parse(builder.toString());
            
       
           try{
                if(out!=null){out.close();}
                if(rd!=null){rd.close();}
                if(inputStream!=null){inputStream.close();}
                if (con != null) {  con.disconnect();  }
            }catch(Exception er){
                er.printStackTrace();
                System.out.println("error close BufferedReader");
            }
           
        } catch (Exception e) {
            e.printStackTrace();
        } 
        return jSONObject;
    }
}
