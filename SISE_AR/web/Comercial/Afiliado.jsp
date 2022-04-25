<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<html>
<head>
<title></title>
</head>
<body class="cssBody">
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
<script src='../Utilerias/Util.js'></script>
<%  
    	String StrclAfiliado = "0";
    	String strclUsr = "";
    
      	if (session.getAttribute("clUsrApp")!= null)
      	{
       		strclUsr = session.getAttribute("clUsrApp").toString(); 
        }  
        
      	if (request.getParameter("clAfiliado")!= null)
      	{
            StrclAfiliado= request.getParameter("clAfiliado").toString(); 
       	} 
    StringBuffer StrSql1 = new StringBuffer();
    StrSql1.append("Select * from cAfiliado ");
    StrSql1.append(" Where clAfiliado= ").append(StrclAfiliado).append(" Order by Nombre") ;
       
       	String StrclPaginaWeb = "175";
        
	session.setAttribute("clPaginaWebP",StrclPaginaWeb);
%>
        <SCRIPT>fnCloseLinks()</script>
        <%
        
        

       	MyUtil.InicializaParametrosC(175,Integer.parseInt(strclUsr)); 
        %>
        <%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion","")%>
        <%
        ResultSet rs = UtileriasBDF.rsSQLNP( StrSql1.toString());
        StrSql1.delete(0,StrSql1.length());
        %>
        <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="MarcaAuto.jsp?'>"%>
        <%
        if (rs.next()) {
            %>
		<INPUT id='clAfiliado' name='clAfiliado' type='hidden' value='<%=rs.getString("clAfiliado")%>'>
		<INPUT id='clContrato' name='clContrato' type='hidden' value='<%=rs.getString("clContrato")%>'>
		<INPUT id='clCuenta' name='clCuenta' type='hidden' value='<%=rs.getString("clCuenta")%>'>
		<%=MyUtil.ObjInput("Nuestro Usuario","Nombre",rs.getString("Nombre"),true,true,25,80,"",true,true,30)%>
		<%=MyUtil.ObjInput("Fecha Inicial","FechaIni",rs.getString("FechaIni"),true,true,25,120,"",true,true,30)%>
		<%=MyUtil.ObjInput("Fecha Final","FechaFin",rs.getString("FechaFin"),true,true,25,160,"",true,true,30)%>
		<%=MyUtil.ObjInput("Clave","Clave",rs.getString("Clave"),true,true,25,200,"",true,true,30)%>
		<%=MyUtil.ObjInput("Inciso","Inciso",rs.getString("Inciso"),true,true,25,240,"",true,true,30)%>
		<%=MyUtil.ObjInput("Fecha Alta","FechaAlta",rs.getString("FechaAlta"),true,true,25,280,"",true,true,30)%>
		<%=MyUtil.ObjInput("Fecha Baja","FechaBaja",rs.getString("FechaBaja"),true,true,25,320,"",true,true,30)%>
		<%=MyUtil.ObjInput("Activo","Activo",rs.getString("Activo"),true,true,25,360,"",true,true,30)%>
        <%
          }
	else{
	}
			 %>
        <%=MyUtil.DoBlock("Detalle de Nuestro Usuario",25,0)%>
	<%=MyUtil.GeneraScripts()%>
  		<%
        rs.close();
        rs=null;
        
    	StrclAfiliado = null;
    	strclUsr =null;
        StrSql1 =null;
        StrclPaginaWeb =null;
%>

</body>
</html>
