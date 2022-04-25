<%-- 
    Document   : ConciergeFrameCobertura
    Created on : 12/10/2010, 05:26:05 PM
    Author     : rfernandez
--%>

<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>

<HTML>
    <HEAD>
        <TITLE>Concierge</TITLE>
    </HEAD>
    <%
                String strclUsr = "0";
                String StrclConcierge = "0";
                String StrclCuenta = "0";

                if (session.getAttribute("clUsrApp") != null) {
                    strclUsr = session.getAttribute("clUsrApp").toString();
                }

                if (request.getParameter("clConcierge") != null) {
                    StrclConcierge = request.getParameter("clConcierge").toString();
                } else {
                    if (session.getAttribute("clConcierge") != null) {
                        StrclConcierge = session.getAttribute("clConcierge").toString();
                    }
                }

                if (session.getAttribute("clCuenta") != null) {
                    StrclCuenta = session.getAttribute("clCuenta").toString();
                }

                StrclCuenta = StrclCuenta.trim();

                session.setAttribute("clConcierge", StrclConcierge);
                String StrclPaginaWeb = "1237";
                session.setAttribute("clPaginaWebP", StrclPaginaWeb);

                MyUtil.InicializaParametrosC(1237, Integer.parseInt(strclUsr));

                if (StrclCuenta.equalsIgnoreCase("1353") || StrclCuenta.equalsIgnoreCase("1354")) {
    %>

    <FRAMESET rows="50,50"  frameborder="SI" border="3" framespacing="2">
        <FRAME SRC="CSCobertura.jsp?clConcierge=<%=StrclConcierge%>" name="CoberturaBins">
            <FRAMESET cols="30%"  frameborder="no" border="" framespacing="0">
                <FRAME SRC="../../Operacion/VistaCobertura.jsp?clCuenta=<%=StrclCuenta%>" name="CoberturaExp">
            </FRAMESET>
    </FRAMESET>
    <%} else {%>
    <FRAMESET rows="100"  frameborder="SI" border="3" framespacing="2">
        <FRAME SRC="../../Operacion/VistaCobertura.jsp?clCuenta=<%=StrclCuenta%>" name="CoberturaExp">
    </FRAMESET>
</FRAMESET>

<%}%>
</HTML>|