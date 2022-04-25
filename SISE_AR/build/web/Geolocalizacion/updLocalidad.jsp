<%@page contentType="application/json; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.ResultSet,Utilerias.UtileriasBDF" %><%
    
    System.out.println("updLocalidad:" + request.getParameter("clEntFed") + "||" + request.getParameter("codMD") + "||" + request.getParameter("osmid")  + "||" + request.getParameter("clUsrApp") );
    StringBuilder sRet = new StringBuilder();
    String sLocalidad = (request.getParameter("codMD")!=null    ?request.getParameter("codMD")    :"");
    String osmid      = (request.getParameter("osmid")!=null    ?request.getParameter("osmid")    :"");
    String clUsrApp   = (request.getParameter("clUsrApp")!=null ? ( !request.getParameter("clUsrApp").equalsIgnoreCase("null")?request.getParameter("clUsrApp") :null  ) :null);
    if ( clUsrApp == null) {
        sRet.append("{ \"status\": \"Usuario no informado o sesion expirada\" } ");
    }
    else {
        String strSql = "st_GeoUpdMunDel  \"" + sLocalidad + "\", " + osmid + ", " + clUsrApp;
        ResultSet rs = UtileriasBDF.rsSQLNP(strSql);
        if (rs.next() ) {
            System.out.println( "OUT:" + String.valueOf(rs.getInt(1) ) );
            if ( rs.getInt(1) > 0 ) {
                sRet.append("{ \"status\": \"OK\" }");
            }
            else {
                sRet.append("{ \"status\": \"Error al actualizar. Usuario sin permisos\" }");
            }
        }
        else {
            sRet.append("{ \"status\": \"Error al actualizar.\" }");
        }
    }
    System.out.println( sRet.toString());
    out.println(sRet.toString());
%>