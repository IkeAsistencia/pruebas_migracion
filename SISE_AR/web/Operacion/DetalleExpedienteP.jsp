<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<html>
<head>
<title></title>
</head>
<body class="cssBody">
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
<script src='../Utilerias/Util.js'></script>
<%  
        
    	String StrclExpediente = "0";
    	String strclUsr = "";
    
    
    
      	if (session.getAttribute("clUsrApp")!= null)
      	{
       		strclUsr = session.getAttribute("clUsrApp").toString(); 
        }  
        
      	if (request.getParameter("clExpediente")!= null)
      	{
            StrclExpediente= request.getParameter("clExpediente").toString(); 
       	}  
        session.setAttribute("clExpediente",StrclExpediente);
        
       	String StrSql = "select * from Expediente ";
       	StrSql = StrSql + " Where clExpediente= " + StrclExpediente;
       
       	String StrclPaginaWeb = "156";
	session.setAttribute("clPaginaWebP",StrclPaginaWeb);

	out.println("<script>fnCloseFilters() </script>");		
        out.println("<SCRIPT>fnOpenLinks()</script>");
        
       	MyUtil.InicializaParametrosC(155,Integer.parseInt(strclUsr)); 
        ResultSet rs = UtileriasBDF.rsSQLNP( StrSql);
	out.println(MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion",""));  		        
        out.println("<INPUT id='URLBACK' name='URLBACK' type='hidden' value='" + request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1) + "DetalleExpediente.jsp?'>");                
        if (rs.next()) {
		out.println("<INPUT id='clExpediente' name='clExpediente' type='hidden' value='"+ rs.getString("clExpediente") +"'>");
		out.println(MyUtil.ObjInput("Afiliado","Afiliado",rs.getString("Afiliado"),true,true,25,80,"",true,true,30));
		out.println(MyUtil.ObjInput("Contacto","Contacto",rs.getString("Contacto"),true,true,25,120,"",true,true,3));                
        }
	else{
		out.println("<INPUT id='clExpediente' name='clExpediente' type='hidden' value='0'>");            
		out.println(MyUtil.ObjInput("Afiliado","Afiliado","",true,true,25,80,"",true,true,30));
		out.println(MyUtil.ObjInput("Contacto","Contacto","",true,true,25,120,"",true,true,3));                
	}			 
        out.println(MyUtil.DoBlock("Detalle de Expediente",25,0));
	out.println(MyUtil.GeneraScripts());  		
        
%>

</body>
</html>