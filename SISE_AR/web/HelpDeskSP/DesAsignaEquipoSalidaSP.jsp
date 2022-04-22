<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Seguridad.SeguridadC,Utilerias.UtileriasBDF" errorPage="" %>
<html>
    <head>
        <title></title>
    </head>
    <body class="cssBody">
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        
        <%  
        
        String StrclUsrApp="0";
        String StrclUsrAppSP="0";
        String StPerifericosElegidos="";
        
        if (session.getAttribute("clUsrApp")!= null) {
            StrclUsrApp = session.getAttribute("clUsrApp").toString();
        }
        
     if (session.getAttribute("clUsrAppSP")!= null) {
            StrclUsrAppSP = session.getAttribute("clUsrAppSP").toString();
        }
        
        if (request.getParameter("Resultados")!= null) {
            StPerifericosElegidos = request.getParameter("Resultados").toString();
        }
        
        if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {%>
        Fuera de Horario
        <%return; 
        }     
        try{
        
        StringBuffer StrSql = new StringBuffer();
        //StrSql.append("delete from SCSAsignacionAsistxUsr where clAsistencia in (").append(StPerifericosElegidos).append(")");
        //UtileriasBDF.ejecutaSQLNP(StrSql.toString());
        StrSql.append("sp_DesAsignaEquipoHojaSalida '").append(StrclUsrApp).append("', '").append(StPerifericosElegidos).append("'");
        UtileriasBDF.ejecutaSQLNP(StrSql.toString());
        System.out.println("a desasignar:  "+  StrSql.toString() );
        StrSql=null;
        %>
        <script> window.opener.fnValidaResponse(1,'ListaDesAsignaEquipoSalidaSP.jsp?');window.close();</script>
        <%}catch(Exception e){
        e.printStackTrace();
        }
        
        //Limpia Variables
        
        StrclUsrApp = null;
        StrclUsrAppSP=null;
        StPerifericosElegidos=null;
        
        %>
    </body>
</html>