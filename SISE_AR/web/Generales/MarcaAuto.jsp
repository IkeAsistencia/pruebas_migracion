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
    	String StrclMarcaAuto = "0";
    	String strclUsr = "";
    
    

      	if (session.getAttribute("clUsrApp")!= null)
      	{
       		strclUsr = session.getAttribute("clUsrApp").toString(); 
        }  
        
      	if (request.getParameter("clMarcaAuto")!= null)
      	{
            StrclMarcaAuto= request.getParameter("clMarcaAuto").toString(); 
       	}  
        
        StringBuffer StrSql = new StringBuffer();
        StrSql.append("select clMarcaAuto, CodigoMarca, dsMarcaAuto  from CMARCAAUTO ");
        StrSql.append(" Where clMarcaAuto= ").append(StrclMarcaAuto).append(" Order by dsMarcaAuto");
       	
        
       	String StrclPaginaWeb = "73";
	session.setAttribute("clPaginaWebP",StrclPaginaWeb);
	
        %><SCRIPT>fnCloseLinks()</script><%
       	MyUtil.InicializaParametrosC(73,Integer.parseInt(strclUsr)); 
        MyUtil.blnAccess[0]=false;
        MyUtil.blnAccess[1]=false;
        MyUtil.blnAccess[2]=false;
	%><%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion","")%><%
        ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());        
        StrSql.delete(0,StrSql.length());
        
        %><%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="MarcaAuto.jsp?'>"%><%                
                
        if (rs.next()) {
		%><INPUT id='clMarcaAuto' name='clMarcaAuto' type='hidden' value='<%=rs.getString("clMarcaAuto")%>'>
		<%=MyUtil.ObjInput("Descripción","dsMarcaAuto",rs.getString("dsMarcaAuto"),true,true,25,80,"",true,true,30)%><%
        }
	else{
		%><INPUT id='clMarcaAuto' name='clMarcaAuto' type='hidden' value='0'>
		<%=MyUtil.ObjInput("Descripción","dsMarcaAuto","",true,true,25,80,"",true,true,30)%><%
	}			 
        %><%=MyUtil.DoBlock("Detalle de Marca de Auto",25,0)%>
	<%=MyUtil.GeneraScripts()%><%  		
        
        rs.close();
        rs=null;
        
        StrSql=null;
        StrclMarcaAuto = null;
    	strclUsr = null;
        StrclPaginaWeb=null;
%>

</body>
</html>
