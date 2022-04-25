<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
<%
   	String StrclExpediente = "0";
    	String strclUsr = "0";
    
   	if (request.getParameter("clUsrApp")!= null)
      	{
       		strclUsr = request.getParameter("clUsrApp").toString(); 
        }
                     
      	if (request.getParameter("clExpediente")!= null)
      	{
       		StrclExpediente = request.getParameter("clExpediente").toString(); 
        }  
%><HTML>
<HEAD>
<TITLE>Venta de Acumuladores Duracell</TITLE>
</HEAD>
<FRAMESET rows="410,*" frameborder="NO" border="0" framespacing="0">
<FRAME SRC="VentaAcumulador.jsp?clExpediente=<%=StrclExpediente%>&clUsrApp=<%=strclUsr%>" name="InfoVenta">
<FRAME SRC="CarritoAcumulador.jsp?clExpediente=<%=StrclExpediente%>" name="ListaVenta">
</FRAMESET>
</HTML>

