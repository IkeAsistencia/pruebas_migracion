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
    	String StrclTipoServicio = "0";
    	String strclUsr = "";
    
    

      	if (session.getAttribute("clUsrApp")!= null)
      	{
       		strclUsr = session.getAttribute("clUsrApp").toString(); 
        }  
        
      	if (request.getParameter("clTipoServicio")!= null)
      	{
            StrclTipoServicio= request.getParameter("clTipoServicio").toString(); 
       	}  
        
        StringBuffer StrSql = new StringBuffer();
        StrSql.append("select * from ctiposervicio ");
        StrSql.append(" Where clTipoServicio= ").append(StrclTipoServicio).append(" Order by dsTipoServicio");
        
       	String StrclPaginaWeb = "77";
	session.setAttribute("clPaginaWebP",StrclPaginaWeb);
          
	%><script>fnCloseFilters() </script>
          <SCRIPT>fnCloseLinks()</script><%
          
       	MyUtil.InicializaParametrosC(77,Integer.parseInt(strclUsr)); 
	%><%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion","")%><%  		        
        ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString()); 
        StrSql.delete(0,StrSql.length()); 
        
        %><%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="TipoServicio.jsp?'>"%><%                
        
        if (rs.next()) {
		%><INPUT id='clTipoServicio' name='clTipoServicio' type='hidden' value='<%=rs.getString("clTipoServicio")%>'>
		<%=MyUtil.ObjInput("Descripción","dsTipoServicio",rs.getString("dsTipoServicio"),true,true,25,80,"",true,true,30)%><%
        }
	else{
		%><INPUT id='clTipoServicio' name='clTipoServicio' type='hidden' value='0'>            
		<%=MyUtil.ObjInput("Descripción","dsTipoServicio","",true,true,25,80,"",true,true,30)%><%
	}			 
        %><%=MyUtil.DoBlock("Detalle de Tipo de Servicio",25,0)%>
	  <%=MyUtil.GeneraScripts()%><%
          
          rs.close();
          rs=null;
          
          StrSql=null;
          StrclTipoServicio = null;
    	  strclUsr = null;
          StrclPaginaWeb=null;
          
%>

</body>
</html>
