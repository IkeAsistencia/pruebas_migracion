<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head><title>Reporte LISOL</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj"/>
        <script src='../../Utilerias/Util.js' ></script>
        <script src='../../Utilerias/UtilMask.js'></script>
        <%

            String strclUsrApp = "0";

            if (session.getAttribute("clUsrApp") != null) {
                strclUsrApp = session.getAttribute("clUsrApp").toString();
            }

            if (SeguridadC.verificaHorarioC(Integer.parseInt(strclUsrApp)) != true) {
        %>
        <b>Fuera de Horario</b>
        <%
                strclUsrApp = null;
                return;
            }

            String StrclPaginaWeb = "6095";
            session.setAttribute("clPaginaWebP", StrclPaginaWeb);
            MyUtil.InicializaParametrosC(708, Integer.parseInt(strclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina 

        %>
        <INPUT id='clUsrApp' name='clUsrApp' type='hidden' value='<%=strclUsrApp%>'>
        <%=MyUtil.ObjInput("Fecha Inicio <br> (AAAA/MM/DD)", "FechaIni", "", false, true, 30, 40, "", false, true, 15, "if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("Fecha Final <br> (AAAA/MM/DD)", "FechaFin", "", false, true, 170, 40, "", false, true, 15, "if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)}")%>
        <div  class='VTable' style='position:absolute; z-index:4; left:120px; top:110px;'>
            <input type="button" value="Solicitar Reporte" onclick="fnSolicitaRPT()"/>    
        </div>
        <%=MyUtil.DoBlock("Filtros L-ISOL", -70, 60)%>
        <%=MyUtil.GeneraScripts()%>
        <input name='FechaMsk' id='FechaMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09'>
    </body>
    <script>
        document.all.FechaIni.readOnly = false;
        document.all.FechaFin.readOnly = false;
        
        function fnSolicitaRPT(){
            window.open('ProcesaLISOL.jsp?FechaIni='+document.all.FechaIni.value+'&FechaFin='+document.all.FechaFin.value,'','resizable=yes,menubar=0,status=1,toolbar=1,screenY=100,height=200,width=400,scrollbars=1');
        }
    </script>
</html>

