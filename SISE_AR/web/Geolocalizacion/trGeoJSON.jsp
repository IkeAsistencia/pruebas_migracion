<%@page language="java" contentType="application/json;charset=UTF-8"  import="java.io.InputStreamReader,java.net.URL,java.io.BufferedReader" %>

{ "type": "FeatureCollection",    
    "features": 
        [      { "type": "Feature",         
                       "geometry": 
<% 
    String urlString = "http:" + ar.com.ike.geo.Geolocalizacion.GEO_HOST + ar.com.ike.geo.Geolocalizacion.GEO_PORT + "/get_gjson?parent_osm_id=" + request.getParameter("osmid");
    System.out.println("urlString:" + urlString);
    //String urlString = "http://186.122.147.182:8080/get_gjson?parent_osm_id=" + request.getParameter("osmid");
    BufferedReader reader = null;
    try {
        URL url = new URL(urlString);
        reader = new BufferedReader(new InputStreamReader(url.openStream()));
        StringBuffer buffer = new StringBuffer();
        int read;
        char[] chars = new char[4096];
        while ((read = reader.read(chars)) != -1) {
            buffer.append(chars, 0, read); 
        }
        //System.out.println(buffer.toString());
        out.print( buffer.toString() );
    } 
    catch (Exception e ) {
        out.print( e.toString());
    }
    finally {
        if (reader != null) {
            reader.close();
        }
    }
%>
                }    
        ]
}   