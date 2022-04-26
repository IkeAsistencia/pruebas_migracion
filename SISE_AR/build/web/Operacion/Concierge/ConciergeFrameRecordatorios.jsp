<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
<HTML>
<HEAD>
    <TITLE>Concierge</TITLE>
</HEAD>
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
        String StrclPaginaWeb = "6128";
        session.setAttribute("clPaginaWebP",StrclPaginaWeb);
        System.out.println("clconcierge="+StrclConcierge);
        MyUtil.InicializaParametrosC(1244,Integer.parseInt(strclUsr));
        %>

    <frameset framespacing='0'  frameborder='si' border='2' name='principal'rows='*'>
        <frame frameborder='no' name='1' src="ConciergeFrameReminder.jsp?clConcierge=<%=StrclConcierge%>" > </frame>
      <%--  <frame frameborder='no' name='2' src="ConciergeFrameViajero.jsp?clConcierge=<%=StrclConcierge%>" ></frame>
        <frame frameborder='no' name='3' src="ConciergeFramePreferencia.jsp?clConcierge=<%=StrclConcierge%>" ></frame> --%>
    </frameset>

</HTML>