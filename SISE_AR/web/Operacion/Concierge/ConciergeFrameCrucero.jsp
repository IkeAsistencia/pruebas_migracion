<%-- 
    Document   : ConciergeFrameCrucero
    Created on : 4/01/2011, 11:18:48 AM
    Author     : rfernandez
--%>

<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>


<%
   	String strclUsr = "0";
    	String StrclConcierge = "0";
        String StrclAsistencia = "0";

       if (session.getAttribute("clUsrApp")!= null) {
            strclUsr = session.getAttribute("clUsrApp").toString();
        }

        if (request.getParameter("clConcierge")!= null) {
            StrclConcierge= request.getParameter("clConcierge").toString();
        } else{
            if (session.getAttribute("clConcierge")!= null) {
                StrclConcierge= session.getAttribute("clConcierge").toString();
            }
        }

        if (request.getParameter("clAsistencia")!= null) {
            StrclAsistencia= request.getParameter("clAsistencia").toString();
        } else{
            if (session.getAttribute("clAsistencia")!= null) {
                StrclAsistencia= session.getAttribute("clAsistencia").toString();
            }
        }

        session.setAttribute("clAsistencia",StrclAsistencia);
        String StrclPaginaWeb = "1302";
        session.setAttribute("clPaginaWebP",StrclPaginaWeb);

        MyUtil.InicializaParametrosC(1302,Integer.parseInt(strclUsr));
        %>


 <HTML>
    <HEAD>
    <TITLE>Alta de Pasajeros</TITLE>
    </HEAD>
    <FRAMESET rows="25,50"  frameborder="SI" border="3" framespacing="2">
            <FRAME SRC="CSDetalleCrucero.jsp?clAsistencia=<%=StrclAsistencia%>" name="AltaCrucero" id="AltaCrucero">
                <FRAMESET cols="50%"  frameborder="no" border="" framespacing="0">
                    <FRAME SRC="CSListaCrucero.jsp?clAsistencia=<%=StrclAsistencia%>" name="ListaCrucero" id="ListaCrucero">
            </FRAMESET>
        </FRAMESET>
</HTML>

