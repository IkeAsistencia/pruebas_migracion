<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head><title>Cambia Titular</title> 
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <script src='../../Utilerias/Util.js' ></script>
        
        <%  
        
        StringBuffer StrSql = new StringBuffer();
        String StrclUsrApp="0";
        String StrclSolicitud="0";
        String clUsrxSol="0";
        
        if (session.getAttribute("clUsrApp")!= null) {
            StrclUsrApp = session.getAttribute("clUsrApp").toString();
        }
        
        if (request.getParameter("clUsrxSol") != null){
            clUsrxSol= request.getParameter("clUsrxSol");
        }
        
        if (session.getAttribute("clSolicitud")!= null) {
            StrclSolicitud = session.getAttribute("clSolicitud").toString();
        }
        
        ResultSet rs = null;
        
        if(StrclSolicitud.equalsIgnoreCase("0")){
            out.println("No hay solicitud");
        }else{
            
            
            StrSql.append("sp_CabiaTitularHD ").append(StrclSolicitud).append(",").append(clUsrxSol);
            
             rs = UtileriasBDF.rsSQLNP( StrSql.toString());
            if(rs.next()){
                out.print(rs.getString("Mensaje"));
            }     
        %>
        <script>window.opener.fnRelocate('../servlet/Utilerias.Lista?P=568&Apartado=S');window.close();</script>
        <%
        }  
        
        
        StrSql.delete(0,StrSql.length());
        
        StrSql=null;
        
        StrclUsrApp=null; 
        StrclSolicitud=null;  
        clUsrxSol=null;       
        
        if(rs!=null){
        rs.close();
        rs=null;
        }        
        
        
        %>
    </body>
</html>

