<%-- 
    Document   : CSDetalleCrucero
    Created on : 3/01/2011, 06:28:41 PM
    Author     : rfernandez
--%>


<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="Seguridad.SeguridadC,Combos.cbEntidad,com.ike.concierge.DAOAltaCrucero,com.ike.concierge.to.CSAltaCrucero" errorPage="" %>
<html>
    <head>
        <title>Alta de Crucero</title>
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
                String StrclCrucero = "0";

                DAOAltaCrucero ac = null;
                CSAltaCrucero AltaCrucero = null;

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

                if (request.getParameter("clCrucero") != null) {
                    StrclCrucero = request.getParameter("clCrucero").toString();
                }

                String StrclPaginaWeb = "1301";
                session.setAttribute("clPaginaWebC", StrclPaginaWeb);

                MyUtil.InicializaParametrosC(1301, Integer.parseInt(strclUsr));
                if (strclUsr != null) {
                    ac = new DAOAltaCrucero();
                    AltaCrucero = ac.getCSAltaCrucero(StrclCrucero);
                }
%>

    <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionOperacionConcierge", "", "")%>

    <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="CSDetalleCrucero.jsp?'>"%>

    <INPUT id='clConcierge' name='clAsistencia' type='hidden' value='<%=StrclAsistencia%>'>
    <INPUT id='clUsrApp' name='clUsrApp' type='hidden' value='<%=strclUsr%>'>
    <INPUT id='clCrucero' name='clCrucero' type='hidden' value='<%=StrclCrucero%>'> 

    <%=MyUtil.ObjInput("Dia", "Dia", AltaCrucero != null ? AltaCrucero.getDia(): "", true, true, 30, 80, "", true, false, 5)%>
    <%=MyUtil.ObjInput("Puerto", "Puerto", AltaCrucero != null ? AltaCrucero.getPuerto() : "", true, true, 80, 80, "", false, false, 35)%>
    <%=MyUtil.ObjInput("Arribo", "Arribo", AltaCrucero != null ? AltaCrucero.getArribo() : "", true, true, 280, 80, "", false, false, 35)%>
    <%=MyUtil.ObjInput("Salida", "Salida", AltaCrucero != null ? AltaCrucero.getSalida(): "", true, true, 480, 80, "", false, false, 35)%>
    <%=MyUtil.ObjInput("Descripcion", "Descripcion", AltaCrucero != null ? AltaCrucero.getDescripcion(): "", true, true, 680, 80, "", false, false, 50)%>
    <%=MyUtil.DoBlock("Alta de Pasajero", 110, 0)%>

    <%=MyUtil.GeneraScripts()%>
    <%
        strclUsr = null;
        ac = null;
        AltaCrucero = null;
    %>

    <script>
   function fnAccionAlta(){

            top.frames[1].location.reload();
            parent.ListaCrucero.location.href="CSListaCrucero.jsp?clAsistencia=0";
        }

    </script>
</body>
</html>
