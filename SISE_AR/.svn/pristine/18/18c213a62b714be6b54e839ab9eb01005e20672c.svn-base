<%-- 
    Document   : ConciergeFramePreferencia
    Created on : 17/12/2009, 05:40:20 PM
    Author     : rfernandez
--%>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>


<%
   	String strclUsr = "0";
    	String StrclConcierge = "0";

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
        session.setAttribute("clConcierge",StrclConcierge);
        String StrclPaginaWeb = "1074";
        session.setAttribute("clPaginaWebP",StrclPaginaWeb);

        MyUtil.InicializaParametrosC(1074,Integer.parseInt(strclUsr));
        %>

<HTML>
<HEAD>
<TITLE>Concierge</TITLE>
</HEAD>
    <FRAMESET rows="50" frameborder="SI" border="2" framespacing="2">
       
  <FRAME SRC="CSEventosPreferencia.jsp?clConcierge=<%=StrclConcierge%>" name="ListaPreferencia">

    </FRAMESET>
</HTML>