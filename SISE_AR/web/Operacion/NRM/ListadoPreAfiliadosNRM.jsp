<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<html>
    <head>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <link href="../../StyleClasses/Bootstrap/bootstrap.min.css" rel="stylesheet"  type="text/css">
        <link href="../../StyleClasses/AlertaNRM.css" rel="stylesheet" type="text/css">
        <title>Listado de PreAfilidados NRM</title>
    </head>
    <body class='cssBody' topmargin='10' style="width: 90%; margin: auto;">
        
        <%
        String StrclUsrApp="0";
        if(session.getAttribute("clUsrApp") != null){
            StrclUsrApp = session.getAttribute("clUsrApp").toString();
        }
        if(SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp, 10)) != true) {
            %>Fuera de Horario<%
            StrclUsrApp = null;
            return;
        }
        %>
        <p class="cssTitDet" style="width: 30%; margin: auto; margin-top: 20px;">Listado de PreAfiliados NRM</p>
        <% 
        StringBuffer strSql = new StringBuffer();
        StringBuffer strSalida = new StringBuffer();
        UtileriasBDF.rsTableNP(strSql.append("[st_nrm_ListaUsuarios]").toString(), strSalida);
        %><%=strSalida.toString()%><%
        strSql.delete(0,strSql.length());
        strSalida.delete(0,strSalida.length());
        strSalida = null;
        strSql = null;
        StrclUsrApp = null;
        %>
        
        <!-- Alerta User Request -->
        <div id="alertUserRequest" class="alerta">
            <!-- Modal content -->
            <div class="alerta-content" style="text-align: center;border: 16px solid #062f67;">
                <span id="alertCloseRequestLista" class="alerta-close">&times;</span>
                <h3 style="text-align:center;color: red;">Notificacion</h3>
                <p style="text-align:center;background-color: #afc3e0;color: #062f67;">Informacion</p>
                <div style="overflow-x:auto;">
                    <h5 id="messageRequest">
                    </h5>
                </div>  
                <br>
            </div>
        </div>
        
        <div id="process" class="alerta" style="z-index: 300;">
            <!-- Modal content -->
            <div style="text-align: center; margin: auto;">
                <!--<span id="alerta-close-tracking" class="alerta-close">&times;</span>-->
                <!--<progress max="100">Procesando...</progress>-->
                <img src="../../Imagenes/Loading.gif" style="position: static;">
                <p style="color: white; font-size: x-large;">Su peticion se esta procesando...</p>
            </div>
        </div>

       <script src='../../Utilerias/Util.js'></script>
       <script src='js/InfoUsuarioNRM.js'></script>
       <script src='../../Utilerias/v1/Ajax.js'></script>
    </body>
</html>