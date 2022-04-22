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
    	String StrclEstatus = "0";
    	String strclUsr = "";
    
    

      	if (session.getAttribute("clUsrApp")!= null)
      	{
       		strclUsr = session.getAttribute("clUsrApp").toString(); 
        }  
        
      	if (request.getParameter("clEstatus")!= null)
      	{
            StrclEstatus= request.getParameter("clEstatus").toString(); 
       	}  
        
        StringBuffer StrSql = new StringBuffer();
        StrSql.append("select * from cEstatus");
        StrSql.append(" Where clEstatus= ").append(StrclEstatus).append(" Order by dsEstatus");
       
       	String StrclPaginaWeb = "81";
	session.setAttribute("clPaginaWebP",StrclPaginaWeb);
          
	%>
         <SCRIPT>fnCloseLinks()</script><%
       	MyUtil.InicializaParametrosC(81,Integer.parseInt(strclUsr)); 
	%><%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion","")%><%  		        
        
        ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());     
        StrSql.delete(0,StrSql.length());
        
        %><%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="Estatus.jsp?'>"%><%                 
        
        if (rs.next()) {
            
		%><INPUT id='clEstatus' name='clEstatus' type='hidden' value='<%=rs.getString("clEstatus")%>'>
		<%=MyUtil.ObjInput("Descripción","dsEstatus",rs.getString("dsEstatus"),true,true,25,80,"",true,true,30)%>
		<%=MyUtil.ObjInput("Prefijo","Prefijo",rs.getString("Prefijo"),true,true,25,120,"",true,true,5)%><%

        }
	else{
		%><INPUT id='clEstatus' name='clEstatus' type='hidden' value='0'>            
		<%=MyUtil.ObjInput("Descripción","dsEstatus","",true,true,25,80,"",true,true,30)%>
		<%=MyUtil.ObjInput("Prefijo","Prefijo","",true,true,25,120,"",true,true,5)%><%
	}			 
        %><%=MyUtil.DoBlock("Detalle de Estatus",25,0)%>
	  <%=MyUtil.GeneraScripts()%><%  	
                   
        rs.close();
        rs=null;
        
        StrSql=null;
        StrclEstatus = null;
    	strclUsr =null;
        StrclPaginaWeb=null;
        
        
%>
<script>
     document.all.Prefijo.maxLength=3;
     document.all.Prefijo.maxLength=3;
 </script>

</body>
</html>
