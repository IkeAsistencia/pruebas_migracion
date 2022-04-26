<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<html>
<head><b><center><table><tr><td><font color='#423A9E'><b>Importando Paquete de Servicios...</b></font></td></tr></table></center></b> 
<title></title>
</head>
<body class="cssBody">
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
<br><br>

<%  
    String StrclUsrApp="0";
    String StrclCobertura="0";
    String StrclPaquete="0";
    
    if (session.getAttribute("clUsrApp")!= null)
     {
       StrclUsrApp = session.getAttribute("clUsrApp").toString(); 
     }  
    
    

    if (SeguridadC.verificaHorarioC((Integer.parseInt(StrclUsrApp))) != true) 
     {
       %>Fuera de Horario<%
       
         return; 
     } 
    
    if (request.getParameter("clCobertura")!= null) 
     {
       StrclCobertura = request.getParameter("clCobertura").toString(); 
     }  

    if (Integer.parseInt(StrclCobertura) == 0)
     { %>
      <script>alert('Debe ingresar primero los Datos Generales de la Cobertura');</script>
      <script>location.href='<%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="../Utilerias/Lista.jsp?P=44&Apartado=S';"%></script><%
     } 
    
    if (request.getParameter("clPaquete")!= null)
     {
       StrclPaquete = request.getParameter("clPaquete").toString(); 
     }      

    String StrclPaginaWeb = "50"; 

    session.setAttribute("clPaginaWebP",StrclPaginaWeb);

       
    MyUtil.InicializaParametrosC(50,Integer.parseInt(StrclUsrApp));    // se checan permisos de consulta de esta pagina para el "USUARIO"
    if (MyUtil.blnAccess[3] == false) { 
       %>No tiene permisos para consultar la página o su sesión ya caducó<%
       return; 
    }
    StringBuffer StrSql = new StringBuffer();
    StrSql.append("sp_ImportaPaquete ").append(StrclPaquete).append(",").append(StrclCobertura);  
    UtileriasBDF.ejecutaSQLNP(StrSql.toString()); 
    StrSql.delete(0,StrSql.length());
    
//       out.println("<script>location.href='" + request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1) + "../Utilerias/Lista.jsp?P=45&Apartado=S';</script>");   %>
       <script>location.href='<%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="../Utilerias/Lista.jsp?P=45&Apartado=S';"%></script><%
%>

</body>
</html>
 