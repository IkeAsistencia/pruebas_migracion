<%@page contentType="application/json; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.ResultSet,Utilerias.UtileriasBDF" %><%
    
    System.out.println(request.getParameter("clEntFed") + "||" + request.getParameter("term") );
    //String sProvincia = (request.getParameter("parent_osm_id")!=null?request.getParameter("parent_osm_id"):"");
    //String sLocalidad = (request.getParameter("text")!=null?request.getParameter("text"):"");
    String sProvincia = (request.getParameter("clEntFed")!=null?request.getParameter("clEntFed"):"");
    String sLocalidad = (request.getParameter("term")!=null?request.getParameter("term"):"");
    StringBuilder sRet = new StringBuilder("[");
    try {
        if ( !sProvincia.isEmpty() && !sLocalidad.isEmpty()) {
            String strSql = "st_GEOgetMunDelLike '" + sProvincia + "','" + sLocalidad + "'";
            ResultSet rs = UtileriasBDF.rsSQLNP(strSql);
            boolean bFirst = true;
            while (rs.next() ) {
                if (bFirst) {
                    bFirst = false;
                }
                else {
                    sRet.append(",");
                }
                sRet.append("{");
                sRet.append("\"id\":").append("\"" + rs.getString("codmd") + "\",");
                sRet.append("\"value\":").append("\"" + rs.getString("dsMunDel") + "\",");
                sRet.append("\"osmid\":").append("\"" + rs.getString("IdGeoLoc") + "\"");
                sRet.append("}");
            }
        }
    }
    catch (Exception e) {
        System.out.println("Geolocalizacion/getLocalidades.jsp.Error:" + e.toString());
    }
    sRet.append("]");
    //System.out.println(sRet.toString());
    out.print(sRet.toString());%>