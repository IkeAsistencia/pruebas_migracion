package Utilerias;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

public class ConexionGeocoding {
    
    public JSONObject conectaGeocoding(JSONObject coordenadas){
        OutputStreamWriter out = null;
        BufferedReader rd = null;
        InputStream inputStream=null;
        JSONObject jSONObject = new JSONObject();
        
        try {
            String mainUrl = "http://201.116.44.194/map_service/api/util/reverseGeocoding";
            HttpURLConnection.setFollowRedirects(false);
            HttpURLConnection con = (HttpURLConnection) new URL(mainUrl).openConnection();
            con.setRequestProperty("Accept","*/*");
            con.setRequestProperty("Content-Type","application/json");
            con.setRequestMethod("POST");
            con.setDoOutput(true);
            con.setReadTimeout(15000);
            con.setConnectTimeout(15000);
            con.connect();
            
            out = new OutputStreamWriter(con.getOutputStream());
            out.write(coordenadas.toString());
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
            System.out.println("Builder Geocoding: " + builder);
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
