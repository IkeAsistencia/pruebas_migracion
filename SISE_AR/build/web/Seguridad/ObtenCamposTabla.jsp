<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<html>
<head>
<title>Construye Reporte</title>
</head>
<body class="cssBody" topMargin="70">
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>

<%  
    String StrclUsrApp = "0";
    
    

    if (session.getAttribute("clUsrApp")!= null){
        StrclUsrApp= session.getAttribute("clUsrApp").toString(); 
    }

    if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true){
        %>
        Fuera de Horario
        <%
        
        return;
    }

    String strclTabla = "0";
    if (request.getParameter("strclTabla")!=null){
      strclTabla=request.getParameter("strclTabla");
    }
    String strObject = "";
    if (request.getParameter("strObject")!=null){
      strObject=request.getParameter("strObject");
    }

    StringBuffer StrHTML = new StringBuffer();
    
    ResultSet rs=null;
    rs=UtileriasBDF.rsSQLNP("Select clCampoTabla, dsCampoTabla, Alias from cCampoTabla where clTabla = " + strclTabla);
    
    if(rs.next()){
      rs.first();
      StrHTML.append("<table>");
      do {  
          StrHTML.append("<tr><td><input value='").append(rs.getString("dsCampoTabla")).append("'></td></tr>");
      } while(rs.next());
      StrHTML.append("</table>");
    }
    try{
      rs.close();
      
    }
    catch(Exception e){
    }
    %>
<script>
  window.opener.fnAddFields("<%=strObject%>","<%=StrHTML.toString()%>");
  <%
    StrHTML.delete(0,StrHTML.length());
  %>
  window.close();
</script>
</body>
</html>