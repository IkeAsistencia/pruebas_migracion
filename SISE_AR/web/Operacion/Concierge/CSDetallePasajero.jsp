<%-- 
    Document   : CSDetallePasajero
    Created on : 20/12/2010, 12:37:44 PM
    Author     : rfernandez
--%>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="Seguridad.SeguridadC,Combos.cbEntidad,com.ike.concierge.DAOCSPasajero,com.ike.concierge.to.CSPasajero" errorPage="" %>
<html>
    <head>
        <title>Alta de Pasajero</title>
    </head>
    <body class="cssBody" onload="fnAccionAlta();">
    <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
    <script src='../../Utilerias/Util.js'></script>
    <script src='../../Utilerias/UtilMask.js'></script>
    <script src='../../Utilerias/UtilDireccion.js'></script>

    <%
                String strclUsr = "0";
                String StrclAsistencia = "0";
                String StrclPasajero = "0";


                DAOCSPasajero daos = null;
                CSPasajero conciergepasajero = null;

                if (session.getAttribute("clUsrApp") != null) {
                    strclUsr = session.getAttribute("clUsrApp").toString();
                } else {
                    strclUsr = request.getParameter("clUsrApp").toString();
                }

                if (session.getAttribute("clAsistencia") != null) {
                    StrclAsistencia = session.getAttribute("clAsistencia").toString();
                } else {
                    StrclAsistencia = request.getParameter("clAsistencia").toString();
                }

                if (request.getParameter("clPasajero") != null) {
                    StrclPasajero = request.getParameter("clPasajero").toString();
                }
                         
                String StrclPaginaWeb = "1294";
                session.setAttribute("clPaginaWebC", StrclPaginaWeb);

                MyUtil.InicializaParametrosC(1294, Integer.parseInt(strclUsr));
                if (strclUsr != null) {
                    daos = new DAOCSPasajero();
                    conciergepasajero = daos.getCSPasajero(StrclPasajero);
                }
%>

    <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionOperacionConcierge", "", "")%>

    <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="CSDetallePasajero.jsp?'>"%>

    <INPUT id='clConcierge' name='clAsistencia' type='hidden' value='<%=StrclAsistencia%>'>
    <INPUT id='clUsrApp' name='clUsrApp' type='hidden' value='<%=strclUsr%>'>
    <INPUT id='clPasajero' name='clPasajero' type='hidden' value='<%=StrclPasajero%>'>

    <%=MyUtil.ObjInput("Nombre", "Nombre", conciergepasajero != null ? conciergepasajero.getNombre() : "", true, true, 30, 80, "", true, false, 40)%>
    <%=MyUtil.ObjInput("Edad", "Edad", conciergepasajero != null ? conciergepasajero.getEdad() : "", true, true, 260, 80, "", false, false, 15)%>
    <%=MyUtil.ObjInput("Tipo de Boleto", "TipoBoleto", conciergepasajero != null ? conciergepasajero.getTipoBoleto() : "", true, true, 370, 80, "", false, false, 25)%>
    <%=MyUtil.ObjInput("Clave Conf", "ClaveConf", conciergepasajero != null ? conciergepasajero.getClaveConf() : "", true, true, 530, 80, "", false, false, 25)%>
    <%=MyUtil.ObjInput("Costo", "Costo", conciergepasajero != null ? conciergepasajero.getCosto() : "", true, true, 690, 80, "", false, false, 7)%>
    <%=MyUtil.DoBlock("Alta de Pasajero", -110, 0)%>

    <%=MyUtil.GeneraScripts()%>
    <%
        strclUsr = null;
        daos = null;
        conciergepasajero = null;
    %>

    <script>
   function fnAccionAlta(){

            top.frames[1].location.reload();
            parent.ListaPasajero.location.href="CSListaPasajeros.jsp?clAsistencia=0";
        }
        
    </script>
</body>
</html>
