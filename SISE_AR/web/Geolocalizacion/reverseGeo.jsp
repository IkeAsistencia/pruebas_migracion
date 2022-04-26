<%@page language="java" contentType="application/json;charset=UTF-8"  import="java.io.InputStreamReader,java.net.URL,java.io.BufferedReader" %>

<%  String sLat = (request.getParameter("lat")!=null?request.getParameter("lat"):"-34.64431");
    String sLon = (request.getParameter("lon")!=null?request.getParameter("lon"):"-58.80445");
    String sFormat = (request.getParameter("format")!=null?request.getParameter("format"):"json");
    String urlString = "http:" + ar.com.ike.geo.Geolocalizacion.GEO_HOST + ar.com.ike.geo.Geolocalizacion.GEO_PORT + "/reverse?format=" + sFormat + "&lat=" + sLat + "&lon="+ sLon;

    //System.out.println("urlString:" + urlString);
    BufferedReader reader = null;
    try {
        URL url = new URL(urlString);
        reader = new BufferedReader(new InputStreamReader(url.openStream()));
        StringBuffer buffer = new StringBuffer();
        int read;
        char[] chars = new char[1024];
        while ((read = reader.read(chars)) != -1) {
            buffer.append(chars, 0, read); 
        }
        //System.out.println(buffer.toString());
        out.print( buffer.toString() );
    } 
    catch (Exception e ) {
        System.out.println("reverseGeo.Error:" + e.toString() );
        out.print( e.toString());
    }
    finally {
        if (reader != null) {
            reader.close();
        }
    }
%>