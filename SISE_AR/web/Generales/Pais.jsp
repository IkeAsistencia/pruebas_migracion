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
    	String StrclPais = "0";
    	String strclUsr = "";
    
    

      	if (session.getAttribute("clUsrApp")!= null)
      	{
       		strclUsr = session.getAttribute("clUsrApp").toString(); 
        }  
        
      	if (request.getParameter("clPais")!= null)
      	{
            StrclPais= request.getParameter("clPais").toString(); 
       	}  
        
        StringBuffer StrSql = new StringBuffer();
        StrSql.append("select * from cPais ");
        StrSql.append(" Where clPais= ").append(StrclPais).append(" Order by dsPais");
       
       	String StrclPaginaWeb = "79";
	session.setAttribute("clPaginaWebP",StrclPaginaWeb);
          
	%>
        <SCRIPT>fnCloseLinks()</script>
        
       	<%MyUtil.InicializaParametrosC(79,Integer.parseInt(strclUsr)); 
	%><%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion","")%><%  		        
        
        ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());   
        StrSql.delete(0,StrSql.length());
        
        %><%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="Pais.jsp?'>"%><%             
                
        if (rs.next()) {
		%><INPUT id='clPais' name='clPais' type='hidden' value='<%=rs.getString("clPais")%>'>
		<%=MyUtil.ObjInput("Descripción","dsPais",rs.getString("dsPais"),true,true,25,80,"",true,true,30)%><%
        }
	else{
		%><INPUT id='clPais' name='clPais' type='hidden' value='0'>
		<%=MyUtil.ObjInput("Descripción","dsPais","",true,true,25,80,"",true,true,30)%><%
	}			 
        %><%=MyUtil.DoBlock("Detalle de Pais",25,0)%>
	<%=MyUtil.GeneraScripts()%><%  		
        rs.close();
        rs=null;
        
        StrSql = null;
        StrclPais = null;
    	strclUsr = null;
        StrclPaginaWeb=null;
        
%>
</body>
</html>
