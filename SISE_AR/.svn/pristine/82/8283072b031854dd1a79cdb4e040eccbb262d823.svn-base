<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<html>
<head>
<title></title>
</head>
<body class="cssBody">
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>

<%  

    	String strclUsr = "";
        String strclTipoCuenta = "11";
        
    
      	if (session.getAttribute("clUsrApp")!= null)
      	{
            strclUsr = session.getAttribute("clUsrApp").toString(); 
        }  
      
      

        if (SeguridadC.verificaHorarioC((Integer.parseInt(strclUsr))) != true) 
        {
            %><%="Fuera de Horario"%><%;  return; 
        } 
        
      	if (request.getParameter("clTipoCuenta")!= null)
      	{
            strclTipoCuenta= request.getParameter("clTipoCuenta").toString(); 
       	}  
    
        StringBuffer StrSql = new StringBuffer();
        StrSql.append("select clTipoCuenta, dsTipoCuenta from cTipoCuenta ");
        StrSql.append(" Where clTipoCuenta= ").append(strclTipoCuenta);
        
       
       	String StrclPaginaWeb = "34";
	session.setAttribute("clPaginaWebP",StrclPaginaWeb);
		
       	MyUtil.InicializaParametrosC( 34,Integer.parseInt(strclUsr)); 
        ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
        StrSql.delete(0,StrSql.length());
        
	%><%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion","")%>
                        
       <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="TipoCuenta.jsp?'>"%><%
        if (rs.next()) {

		%><INPUT id='clTipoCuenta' name='clTipoCuenta' type='hidden' value='<%=rs.getString("clTipoCuenta")%>'>
		<%=MyUtil.ObjInput("Descripción de Tipo de Cuenta","dsTipoCuenta",rs.getString("dsTipoCuenta"),true,true,100,80,"",true,true,30)%><%
        }
	else{
		%><INPUT id='clTipoCuenta' name='clTipoCuenta' type='hidden' value='0'>
		 <%=MyUtil.ObjInput("Descripción de Tipo de Cuenta","dsTipoCuenta","",true,true,100,80,"",true,true,30)%><%
	}			 
        %><%=MyUtil.DoBlock("Detalle del Tipo de Cuenta",20,0)%>
	<%=MyUtil.GeneraScripts()%><%
        rs.close();
        rs=null;
        
        StrSql=null;
    	strclUsr = null;
        strclTipoCuenta = null;
%>
<script src='../Utilerias/Util.js'></script>
</body>
</html>
