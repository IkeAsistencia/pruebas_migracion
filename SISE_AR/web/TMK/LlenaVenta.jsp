<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<html>
<head>
<title>Detalle de los Datos del Acumulador</title>
</head>
<body class="cssBody">
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
<script src='../Utilerias/Util.js'></script>
<script src='../Utilerias/UtilMask.js'></script>
<script src='../Utilerias/UtilDireccion.js'></script>
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
      
        StringBuffer StrSql = new StringBuffer();
        
            StrSql.append(" Select  getdate() 'FechaActual' ");
                        
            ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
            StrSql.delete(0,StrSql.length());

       	String StrclPaginaWeb = "655";
	session.setAttribute("clPaginaWebP",StrclPaginaWeb);
        %>
         <script>fnOpenLinks()</script>
        <%
       	MyUtil.InicializaParametrosC(655,Integer.parseInt(strclUsr)); %>
	<%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAcumuladorxExpediente","","")%>

     <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="LlenaVenta2.jsp?'>"%>

     <script> document.all.btnCambio.disabled=true</script>
         <%
       if(rs.next()) {
                 
                String StrFechaActual="";
             StrFechaActual = rs.getString("FechaActual");
     %>
                <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
                <INPUT id='clUsrApp' name='clUsrAppVenta' type='hidden' value='<%=strclUsr%>'>

            	<%=MyUtil.ObjInput("Fecha de Compra <BR>(AAAA-MM-DD HH:MM)","FechaCompra",StrFechaActual,false,false,30,80,StrFechaActual,false,false,30)%>
                <%=MyUtil.ObjInput("No. de Serie <BR>del Acumulador","SerieAcumulador","",true,true,200,80,"",true,false,40)%>
                <%=MyUtil.ObjComboC("Tipo de <BR>Acumulador","clAcumulador","",true,true,420,80,"","select clAcumulador, dsAcumulador from cAcumulador order by dsAcumulador","","",30,true,false)%>
                <%=MyUtil.ObjInput("No. de <BR>Póliza","Poliza","",true,true,580,80,"",true,false,40)%>
                <%=MyUtil.DoBlock("Registro de Compra",30,0)%> 
                <input type="button" class="cBtn" value="Cerrar" onclick="javascript:top.opener.location.reload();window.close();">

    <% } %>
    <%=MyUtil.GeneraScripts()%>
	<%
        rs.close();
        rs=null;
    	
        StrclExpediente = null;
    	strclUsr = null;
        StrSql =null; 
%>
<input name='FechaCompraMsk' id='FechaCompraMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'> 

<script>
</script>
</body>
</html>
