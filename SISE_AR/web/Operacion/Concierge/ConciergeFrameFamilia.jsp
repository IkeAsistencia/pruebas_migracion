<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>

<%
   	String strclUsr = "0";
    	String StrclConcierge = "0";
        String StrclPaginaWeb = "1245";
        
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
        
        session.setAttribute("clPaginaWebP",StrclPaginaWeb);

        MyUtil.InicializaParametrosC(1245,Integer.parseInt(strclUsr));
        %>

<html>
<head>
<title>Concierge</title>
</head>
    <frameset rows="50" frameborder="SI" border="2" framespacing="2">

  <frame src="CSEventosFamilia.jsp?clConcierge=<%=StrclConcierge%>" name="ListaFamilia"> 
       
    </frameset>
</html>