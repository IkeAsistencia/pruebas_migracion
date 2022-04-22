<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasObj,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<html>
<head><title></title></head>
<link href="StyleClasses/Global.css" rel="stylesheet" type="text/css">
<body topmargin="5" leftmargin="5" background="Imagenes/bgMenu.jpg" bgproperties="fixed">
<%

    String clPaginaWeb ="0";
    String strclUsr = "0";

    if (session.getAttribute("clUsrApp")!= null){
	        strclUsr = session.getAttribute("clUsrApp").toString(); 
    }  
    
    if (SeguridadC.verificaHorarioC(Integer.parseInt(strclUsr)) != true) 
     {
       %>Fuera de Horario<%
        clPaginaWeb =null;
        strclUsr = null;
        return; 
     } 
    
    if (session.getAttribute("clPaginaWebP")==null){
        clPaginaWeb=null;
        strclUsr=null;
	      return;
    }
    else{
        clPaginaWeb = session.getAttribute("clPaginaWebP").toString();
    }
    
  	    StringBuffer StrSql = new StringBuffer();
        StrSql.append("sp_WebGetLinksTxt ").append(strclUsr).append(",").append(clPaginaWeb);
        //StrSql.append("select Links from LinkxUsrxPag where clUsrApp = ").append(strclUsr).append(" and clPaginaWeb = ").append(clPaginaWeb);
        ResultSet rs = null;
	try{
	    rs = UtileriasBDF.rsSQLNP(StrSql.toString());
	    if(rs.next()) {	
        %><%=rs.getString("Links")%><%
      }
  }catch(Exception e){
      e.printStackTrace();
  }	
  finally{
      if (rs!=null){
        rs.close();
        rs=null;
      }
      StrSql.delete(0,StrSql.length());
  }
  %>
</center>
</body>
</html>

