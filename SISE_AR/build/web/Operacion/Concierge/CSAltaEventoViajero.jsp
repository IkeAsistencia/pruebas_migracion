<%--
Document   : CSAltaEventoViajero
Created on : 17/12/2009, 03:48:13 PM
Author     : rfernandez
--%>

<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="Seguridad.SeguridadC,Combos.cbEntidad,com.ike.concierge.DAOConciergeViajero,com.ike.concierge.ConciergeViajero" errorPage="" %>
<html>
    <head>
        <title>Alta de Evento Wow</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <link href="../../StyleClasses/Calendario.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
        <script src='../../Utilerias/Util.js'></script>
        <script src='../../Utilerias/UtilMask.js'></script>
        <script src='../../Utilerias/UtilCalendarioV.js'></script>
        <%
                String strclUsr = "0";
                String StrclConcierge = "0";
                String StrclCSViajero = "0";

                DAOConciergeViajero dacv = null;
                ConciergeViajero conciergevia = null;

                if (session.getAttribute("clUsrApp") != null) {
                    strclUsr = session.getAttribute("clUsrApp").toString();
                } else {
                    strclUsr = request.getParameter("clUsrApp").toString();
                }

                if (request.getParameter("clConcierge") != null) {
                    StrclConcierge = request.getParameter("clConcierge").toString();
                } else {
                    if (session.getAttribute("clConcierge") != null) {
                        StrclConcierge = session.getAttribute("clConcierge").toString();
                    }
                }
                if (request.getParameter("clCSViajero") != null) {
                    StrclCSViajero = request.getParameter("clCSViajero").toString();
                } else {
                    if (session.getAttribute("clCSViajero") != null) {
                        StrclCSViajero = session.getAttribute("clCSViajero").toString();
                    }
                }

                String StrclPaginaWeb = "1071";
                session.setAttribute("clPaginaWebP", StrclPaginaWeb);

                MyUtil.InicializaParametrosC(1071, Integer.parseInt(strclUsr));
                if (strclUsr != null) {
                    dacv = new DAOConciergeViajero();
                    conciergevia = dacv.getConciergeViajero(StrclCSViajero);
                }
        %>
        <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccion", "", "")%>

        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="CSAltaEventoViajero2.jsp?"%>'>
        <INPUT id='clCSViajero' name='clCSViajero' type='hidden' value='<%=StrclCSViajero%>'>
        <INPUT id='clConcierge' name='clConcierge' type='hidden' value='<%=StrclConcierge%>'>
        <INPUT id='clUsrApp' name='clUsrApp' type='hidden' value='<%=strclUsr%>'>

        <%=MyUtil.ObjComboC("Programa", "clCSPrograma", conciergevia != null ? conciergevia.getdsCSPrograma() : "", true, true, 30, 80, "", "select clCSPrograma,dsCSPrograma from CScPrograma", "", "", 30, true, false)%>
        <%=MyUtil.ObjInput("Compañía", "Compania", conciergevia != null ? conciergevia.getCompania() : "", true, true, 200, 80, "", true, false, 35)%>
        <%=MyUtil.ObjInput("Membresía", "Membresia", conciergevia != null ? conciergevia.getMembresia() : "", true, true, 400, 80, "", true, false, 35)%>
        <%=MyUtil.ObjInputFA("Fecha (AAAA-MM-DD)", "FechaVigencia", conciergevia != null ? conciergevia.getFechaVigencia() : "", true, true, 600, 80, "", true, true, 20, 2, "fnReqHoraViajero();if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)};")%>

        <%=MyUtil.DoBlock("Registro de Viajero", 20, 0)%>
        <input type="button" class="cBtn" value="Cerrar" onclick="javascript:top.opener.location.reload();window.close();">

        <%=MyUtil.GeneraScripts()%>
        <%
                strclUsr = null;
                dacv = null;
                conciergevia = null;
        %>
        <input name='FechaMsk' id='FechaMsk' type='hidden' value=''>
        <script type="text/javascript" >
            function fnReqHoraViajero(){
                var StrFechaWow = document.all.FechaVigencia.value;
                document.all.FechaVigencia.value=StrFechaWow.substring(0,10);
                document.all.FechaMsk.value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09';
            }
        </script>
    </body>
</html>
