<%@page contentType="application/json; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.ResultSet,Utilerias.UtileriasBDF" %><%
    String sPais = (request.getParameter("parent_osm_id")!=null?request.getParameter("parent_osm_id"):null);
    String sProvincia = (request.getParameter("text")!=null?request.getParameter("text"):null);
    StringBuilder sRet = new StringBuilder("[");
    try {
        if ( sPais != null && sProvincia != null) {
            String StrSql = "st_GEOgetEntFedLike " + sPais + "," + sProvincia ;
            ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
            boolean bFirst = true;
            while (rs.next() ) {
                if (bFirst) {
                    bFirst = false;
                }
                else {
                    sRet.append(",\n");
                }
                sRet.append("{");
                sRet.append("\"name\":").append("\"" + rs.getString("dsEntFed") + "\",");
                sRet.append("\"codEnt\":").append("\"" + rs.getString("codEnt") + "\",");
                sRet.append("\"osm_id\":").append("\"" + rs.getString("IdGeoLoc") + "\"");
                sRet.append("}");
            }
        }
    }
    catch (Exception e) {
        System.out.println("Geolocalizacion/getProvincias.jsp.error:" + e.toString());
    }
    sRet.append("]");
    System.out.println( "getProvincias:" + sRet.toString());
    out.print(sRet.toString());%>