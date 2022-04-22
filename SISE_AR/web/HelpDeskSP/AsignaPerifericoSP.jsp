<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC,Utilerias.ConnectionURL" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head><title>Actualiza Fecha Proveedor</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj" />
        <script src='../../Utilerias/Util.js' ></script>
        <%
        String StrclUsrApp="0";
        String StrclPerifericoSP="0";
        String StrProveedor="1";
        String StrclOK="0";
        ResultSet   rs = null;
        
        if (session.getAttribute("clUsrAppSP")!= null)  {
            StrclUsrApp = session.getAttribute("clUsrAppSP").toString();         }
        if (session.getAttribute("clPeriferico")!= null){
            StrclPerifericoSP = session.getAttribute("clPeriferico").toString();        }
        if(request.getParameter("clPeriferico")!= null){
            StrclPerifericoSP = request.getParameter("clPeriferico").toString().trim();       }
             
        
        if(!StrclUsrApp.equalsIgnoreCase("0")) {
            if(!StrclPerifericoSP.equalsIgnoreCase("0")){
               
                    //<<<<<<<<<<<<<ASIGNACION>>>>>>>>>>>>>>>>>>>>
                    System.out.println("sp_AsignaPerifericoSP '"+StrclUsrApp+"','"+ StrclPerifericoSP+"'");
                  
                    rs=UtileriasBDF.rsSQLNP("sp_AsignaPerifericoSP '"+StrclUsrApp+"','"+ StrclPerifericoSP+"'");
                    if(rs.next()){
        %>
        <script>alert('EQUIPO ASIGNADO CORRECTAMENTE');</script>
        <script>location.href='<%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%>../HelpDeskSP/InventarioSP.jsp?';</script>
        <%
        
        StrclOK=rs.getString("OK"); }
                    
                   } else {
        %><script>alert('NO SE ASIGNO EL PROVEEDOR');</script><%
                }   }
        
        StrclUsrApp=null;
        StrclPerifericoSP=null;
        StrProveedor=null;
        StrclOK=null;
        rs = null;
        %>
        <script>
        top.frames['Contenido'].location.reload();
        </script>
    </body>
</html>

