/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ar.com.ike.util.rest;

import com.google.gson.Gson;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.io.BufferedReader;
import java.io.Reader;
import java.net.URL;
import java.net.URLConnection;
import java.security.SecureRandom;
import java.security.Security;
import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;
import java.util.LinkedHashMap;
import java.util.Map;
import javax.net.ssl.HostnameVerifier;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSession;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;
import javax.servlet.http.HttpServletRequest;

/**
 *
 * @author ddiez
 */
public class SimpleRESTCall {
    
  // trusting all certificate 
 public void doTrustToCertificates() throws Exception {
        Security.addProvider(new com.sun.net.ssl.internal.ssl.Provider());
        TrustManager[] trustAllCerts = new TrustManager[]{
                new X509TrustManager() {
                    public X509Certificate[] getAcceptedIssuers() {
                        return null;
                    }
                    public void checkServerTrusted(X509Certificate[] certs, String authType) throws CertificateException {
                        return;
                    }
                    public void checkClientTrusted(X509Certificate[] certs, String authType) throws CertificateException {
                        return;
                    }
                }
        };
        SSLContext sc = SSLContext.getInstance("SSL");
        sc.init(null, trustAllCerts, new SecureRandom());
        HttpsURLConnection.setDefaultSSLSocketFactory(sc.getSocketFactory());
        HostnameVerifier hv = new HostnameVerifier() {
            public boolean verify(String urlHostName, SSLSession session) {
                if (!urlHostName.equalsIgnoreCase(session.getPeerHost())) {
                    System.out.println("Warning: URL host '" + urlHostName + "' is different to SSLSession host '" + session.getPeerHost() + "'.");
                }
                return true;
            }
        };
        HttpsURLConnection.setDefaultHostnameVerifier(hv);
    }
        
    private int iConnectionTimeout = 10; //En segundos.
    private LinkedHashMap<String,String> colHeaders = null;
    
    public SimpleRESTCall() {
        addHeader("Content-Type", "application/json; utf-8");
        addHeader("Accept", "application/json");
    }
    
    public void setConnectionTimeout(int iTimeOut ){
        this.iConnectionTimeout = iTimeOut;
    }
    
    public void addHeader(String name, String value) {
        if (colHeaders == null ) {
            this.colHeaders = new LinkedHashMap();
        }
        this.colHeaders.put(name, value);
    }
    
    public static void main(String[] args) throws IOException, Exception {
        testHttps();
        /*String url = "http://gps.ikeasistencia.com.ar:8000/prestadores/buscar";
        SimpleRESTCall cli = new SimpleRESTCall();
        String tmpStr = "{\n" +
            "    \"id_origen\": \"-34.63593, -58.36593\",\n" +
            "    \"id_destino\": \"\",\n" +
            "    \"id_caso\": \"123129\",\n" +
            "    \"id_servicio\": \"Asistencia Vial\",\n" +
            "    \"id_subservicio\": \"UML\"\n" +
            "}";
        System.out.println( cli.fetchJsonStringContent(url, "POST", tmpStr ) );
        */
    }    
    
    public static void testGetHttps() throws IOException, Exception {
        String url = "https://qa.miservicio.ikeasistencia.com.ar/sise/api/v2/citas/44/";
        SimpleRESTCall cli = new SimpleRESTCall();
        cli.addHeader("Authorization", "Api-Key GhleghaE.2ZzCv8RnVA9VYlkkok6KzsExk3WThIhc");
        ar.com.ike.geo.hogar.ConsultaHogarResponse chr = (ar.com.ike.geo.hogar.ConsultaHogarResponse)cli.fetchGsonHttpsUrl(url,"GET", ar.com.ike.geo.hogar.ConsultaHogarResponse.class);
        System.out.println(chr.estado);
    }
    
    
    public static void testHttps ( ) throws IOException, Exception {
        String url = "https://qa.miservicio.ikeasistencia.com.ar/sise/api/v2/citas/";
        SimpleRESTCall cli = new SimpleRESTCall();
        cli.addHeader("Authorization", "Api-Key GhleghaE.2ZzCv8RnVA9VYlkkok6KzsExk3WThIhc");
        ar.com.ike.geo.hogar.DireccionGeo dirGeo = new ar.com.ike.geo.hogar.DireccionGeo();
        dirGeo.latitude =-34.633530;
        dirGeo.longitude = -58.399186;
        
        ar.com.ike.geo.hogar.ServicioHogarTO servHogar = new ar.com.ike.geo.hogar.ServicioHogarTO();
        servHogar.id_sise = 12357;
        servHogar.nombre_cliente = "Alfredo Sarasa";
        servHogar.clave_sise_cliente = "000000124";
        servHogar.email_cliente = "addlfredo.perez@gmail.com";
        servHogar.telefono_cliente = "541163757200";
        servHogar.localidad = "00141";
        servHogar.dia = "2020-01-15";
        servHogar.hora_desde = "09:00";
        servHogar.hora_hasta = "12:00";
        servHogar.servicio = "hogar";
        servHogar.subservicio = "plomeria";
        servHogar.descripcion_servicio = "Pierde agua por el sifon de la pileta";
        servHogar.direccion = "Avenida Alvarez Thomas 3021";
        servHogar.direccion_geo = dirGeo;
        servHogar.zona = "Villa Urquiza";
        servHogar.expediente = "454325";
        servHogar.urgente = false;
        servHogar.clservicio = 3;
        servHogar.clsubservicio = 218;
        servHogar.codigo_proveedor = "14";
        //ar.com.ike.geo.hogar.ServicioHogarResponse servHogarRes = new ar.com.ike.geo.hogar.ServicioHogarResponse();
        ar.com.ike.geo.hogar.ServicioHogarResponse servHogarRes = (ar.com.ike.geo.hogar.ServicioHogarResponse)cli.fetchGsonHttpsContent(url, "POST", servHogar, ar.com.ike.geo.hogar.ServicioHogarResponse.class);
        System.out.println(servHogarRes.toString());
    }
    
    
    private HttpsURLConnection prepareHttpsConnection(String uri, String method) throws IOException, Exception  {
        System.out.println("Establishing HTTPS connection");
        java.lang.System.setProperty("https.protocols", "TLSv1,TLSv1.1,TLSv1.2");
        URL url = new URL(uri);
        doTrustToCertificates();//  
        HttpsURLConnection connection = (HttpsURLConnection) url.openConnection();
        connection.setConnectTimeout(this.iConnectionTimeout * 1000); //10 segundos
        connection.setRequestMethod(method.toUpperCase());
        for (Map.Entry<String,String> entry : colHeaders.entrySet() ) {
            connection.setRequestProperty( entry.getKey(), entry.getValue() );
        }
        connection.setDoOutput(true);
        return connection;
    }
    
    private HttpURLConnection prepareConnection(String uri, String method) throws IOException  {
        URL url = new URL(uri);
        System.out.println("Establishing HTTP connection");
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();       
        connection.setConnectTimeout(this.iConnectionTimeout * 1000); //10 segundos
        connection.setRequestMethod(method.toUpperCase());
        for (Map.Entry<String,String> entry : colHeaders.entrySet() ) {
            connection.setRequestProperty( entry.getKey(), entry.getValue() );
        }
        connection.setDoOutput(true);
        return connection;
    }
    
    public Object fetchGsonContent(String uri, String method, Object postObject, Class responseType) throws IOException, Exception   {
        HttpURLConnection connection = prepareConnection(uri, method);    
        Gson gson = new Gson();
        String postString = gson.toJson(postObject);
        OutputStream os;
        try {
            os = connection.getOutputStream();
            byte[] input = postString.getBytes("utf-8");
            os.write(input, 0, input.length);           
        }
        catch(Exception e){
            System.out.println("fetchGsonContent.Error:" + e.toString() );
        }
	int responseCode = connection.getResponseCode();
        System.out.println("SimpleRESTCall.fetchGsonContent:" + uri + "  response:" + String.valueOf(responseCode));
	if( responseCode == 200 || responseCode == 201 ){
                Object obj = gson.fromJson(new InputStreamReader(connection.getInputStream()), responseType);
		return obj;
	}
	return null;
    }     

    public Resultado getGsonHttpsUrl(String uri, String method, Class responseType) throws IOException, Exception {
        HttpsURLConnection connection = prepareHttpsConnection(uri, method);
        Gson gson = new Gson();
	int responseCode = connection.getResponseCode();
        System.out.println("SimpleRESTCall.fetchGsonContent:" + uri + "  response:" + String.valueOf(responseCode));
	if( responseCode == 200 || responseCode == 201 ){
            Object obj = gson.fromJson(new InputStreamReader(connection.getInputStream()), responseType);
            return new Resultado(new Integer(responseCode) , obj);
	}
	return new Resultado(new Integer(responseCode), null);
    }
    
    public Object fetchGsonHttpsUrl(String uri, String method, Class responseType) throws IOException, Exception   {
        HttpsURLConnection connection = prepareHttpsConnection(uri, method);
        Gson gson = new Gson();
	int responseCode = connection.getResponseCode();
        System.out.println("SimpleRESTCall.fetchGsonContent:" + uri + "  response:" + String.valueOf(responseCode));
	if( responseCode == 200 || responseCode == 201 ){
                Object obj = gson.fromJson(new InputStreamReader(connection.getInputStream()), responseType);
		return obj;
	}
	return null;
    }     

    public Object fetchGsonHttpsContent(String uri, String method, Object postObject, Class responseType) throws IOException,Exception    {
        HttpsURLConnection connection = prepareHttpsConnection(uri, method);    
        Gson gson = new Gson();
        String postString = gson.toJson(postObject);
        OutputStream os;
        int responseCode = 0;
        try {
            os = connection.getOutputStream();
            byte[] input = postString.getBytes("utf-8");
            os.write(input, 0, input.length);           
            responseCode = connection.getResponseCode();
        }
        catch (IOException ioe) {
            System.out.println(ioe.toString() );
            System.out.println("SimpleRESTCall.fetchGsonHttpsContent.ERROR: " + responseCode );
            System.out.println("Content:\n" +  getStringResponse(connection.getInputStream() ) );
        }
        catch(Exception e){
            System.out.println("fetchGsonContent.Error:" + e.toString() );
        }
        System.out.println("SimpleRESTCall.fetchGsonContent:" + uri + "  response:" + String.valueOf(responseCode));
	if( responseCode == 200 || responseCode == 201 ){
            Object obj = gson.fromJson(new InputStreamReader(connection.getInputStream()), responseType);
            return obj;
	}
        else {
            System.out.println("SimpleRESTCAll.fetchGsonHttpsContent.RESPONSE: HTTPS RESPONSE NOT 200/201 STATUS:");
            System.out.println(responseCode);
            System.out.println(getStringResponse(connection.getInputStream()) );
            return null;
        }
    }     
    
    public String fetchJsonStringContent(String uri, String method, String jsonReq) throws IOException, Exception {
        URLConnection connection;
        if (uri.startsWith("https")  ) {
            connection = prepareHttpsConnection(uri, method);    
        }
        else {
            connection = prepareConnection(uri, method);        
        }
        OutputStream os;
        try {
            if (jsonReq != null ) {
                os = connection.getOutputStream();
                byte[] input = jsonReq.getBytes("utf-8");
                os.write(input, 0, input.length);
            }
        }
        catch(Exception e){
            System.out.println("fetchGsonContent.Error:" + e.toString() );
        }
	int responseCode = ((HttpURLConnection)connection).getResponseCode();
        System.out.println("SimpleRESTCall.fetchJsonContent:" + uri + "  response:" + String.valueOf(responseCode));
	if(responseCode == 200){
            StringBuilder builder = new StringBuilder();
            BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
            String current;
            while ((current = in.readLine()) != null) {
                builder.append(current);
            }
            return( builder.toString() );
	}
	return null;
    }
    
    public String fetchJsonServletContent(String uri, String method, HttpServletRequest request) throws IOException {
        //PRocesa Body de request.
        StringBuilder jb = new StringBuilder();
        String line;
        try {
            BufferedReader reader = request.getReader();
            while ((line = reader.readLine()) != null)
                jb.append(line);
        }
        catch (Exception e) { 
            System.out.println(e.toString());
        }
        System.out.println("INPUT BODY:" + jb.toString() );
        HttpURLConnection connection = prepareConnection(uri, method);

        //Arma el body del request
        OutputStream os;
        try {
            os = connection.getOutputStream();
            byte[] input = jb.toString().getBytes("utf-8");
            os.write(input, 0, input.length);           
        }
        catch(Exception e){
            System.out.println("fetchGsonContent.Error:" + e.toString() );
        }
	int responseCode = connection.getResponseCode();
        System.out.println("SimpleRESTCall.fetchJsonContent:" + uri + "  response:" + String.valueOf(responseCode));
        //Toma la rta si va correcto
	if(responseCode == 200){
                StringBuilder builder = new StringBuilder();
                BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
                String current;
                while ((current = in.readLine()) != null) {
                    builder.append(current);
                }
                System.out.println("RESPONSE BODY:" + builder.toString());
                return( builder.toString() );
	}
	return null;
    }

    
    public class Resultado<U, V> {
        private U codigoRespuesta = null;
        private V contenido = null;
        
        public Resultado(U codigoRespuesta, V contenido) {
            this.codigoRespuesta = codigoRespuesta;
            this.contenido = contenido;
        }
        
        public int getCodigo() {
            if (this.codigoRespuesta != null) {
                return ((Integer)this.codigoRespuesta).intValue();
            }
            else {
                return -1;
            }
        }
        public V getContenido(){
            return this.contenido;
        }
    }
    
    private String getStringResponse( InputStream cnxIs ) {
        char[] buf = new char[1024];
        StringBuilder s = new StringBuilder();
        try {
            Reader r=  new InputStreamReader(cnxIs);
            while( true ){
                int n = r.read(buf);
                if (n < 0 ) {
                    break ;
                }
                s.append(buf, 0,n);
            }
        }
        catch (Exception e ) {
            s.append("SimpleRESTCall.getStringResponse.Error:" + e.toString() );
        }
        return s.toString();
    }

    
    
}
