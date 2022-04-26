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
        String StrclPaginaWeb = "718";
        session.setAttribute("clPaginaWebP",StrclPaginaWeb);
       
        MyUtil.InicializaParametrosC(718,Integer.parseInt(strclUsr));
        %>      

<HTML>
<HEAD>
<TITLE>Concierge</TITLE>
</HEAD>

    <FRAMESET rows=""  frameborder="SI" border="1" framespacing="1">
        <FRAME SRC="Concierge.jsp?clConcierge=<%=StrclConcierge%>" name="InfoConcierge">
        <!--FRAMESET cols="55%,55%,55%"  frameborder="no" border="" framespacing="0">
            <FRAME SRC="CSEventosWow.jsp?clConcierge=<%=StrclConcierge%>" name="ListaWows">
            <FRAME SRC="ConciergeFrameViajero.jsp?clConcierge=<%=StrclConcierge%>" name="ListaViajero">
            <FRAME SRC="ConciergeFramePreferencia.jsp?clConcierge=<%=StrclConcierge%>" name="ListaPreferencia">
        </FRAMESET-->
    </FRAMESET>
</HTML>
