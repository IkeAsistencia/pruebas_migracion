<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
<html>
<head>
    <title>Concierge</title>
</head>
<%
   	String strclUsr = "0";
    	String StrclConcierge = "0";
        String StrclPaginaWeb = "1244";

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
        System.out.println("clconcierge="+StrclConcierge);
        MyUtil.InicializaParametrosC(1244,Integer.parseInt(strclUsr));
        %>


    <frameset framespacing='1'  frameborder='si' border='2' name='principal'cols='51%,*'>    
        <frameset framespacing='2'  frameborder='si' border='2' name='principal'rows='30%,30%,*' > 
		<frame frameborder='si' name='1' border='2' scrolling="auto" src="ConciergeFrameWow.jsp?clConcierge=<%=StrclConcierge%>" > 
		<frame frameborder='si' name='2' border='2' scrolling="auto" src="ConciergeFrameReminder.jsp?clConcierge=<%=StrclConcierge%>" >
                <frame frameborder='si' name='3' border='2' scrolling="auto" src="ConciergeFrameViajero.jsp?clConcierge=<%=StrclConcierge%>" >
        </frameset>
            <frameset framespacing='1'  frameborder='si' border='2' name='principal'rows='50%,*' >      
              <frame frameborder='si' name='1' frameborder='si' border='2' src="ConciergeFramePreferencia.jsp?clConcierge=<%=StrclConcierge%>">
              <frame frameborder='si' name='2' frameborder='si' border='2' src="ConciergeFrameFamilia.jsp?clConcierge=<%=StrclConcierge%>">    
            </frameset>
    </frameset>
</html>