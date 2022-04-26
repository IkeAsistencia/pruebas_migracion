<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
<head><title>JSP Page</title>
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
</head>
<body class="cssBody">
<%-- <jsp:useBean id="beanInstanceName" scope="session" class="beanPackage.BeanClassName" /> --%>
<%-- <jsp:getProperty name="beanInstanceName"  property="propertyName" /> --%>
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
<script src='../Utilerias/Util.js' ></script>
<%  
    String StrclPaquete = "0";
    String StrclUsrApp="0";
    
    

    if (session.getAttribute("clUsrApp")!= null) 
     {
       StrclUsrApp = session.getAttribute("clUsrApp").toString(); 
     }  

    if (SeguridadC.verificaHorarioC((Integer.parseInt(StrclUsrApp))) != true) 
     {%>
       Fuera de Horario
       <%
       
       return; 
     } 
    
    if (request.getParameter("clPaquete") != null)
    {
      StrclPaquete = request.getParameter("clPaquete");
    }    
    if (StrclPaquete=="0"){
        if (session.getAttribute("clPaquete") != null)
        {
          StrclPaquete = session.getAttribute("clPaquete").toString();
        }    
    }
    session.setAttribute("clPaquete",StrclPaquete);    
    %>
    <script>fnOpenLinks(window.parent.frames.InfoRelacionada.height) </script>
    <%

       StringBuffer StrSql = new StringBuffer();
       
       StrSql.append("select P.clPaquete, P.dsPaquete ");
       StrSql.append(" From cPaquete P ");
       StrSql.append(" Where P.clPaquete=").append(StrclPaquete);
       
       ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
       StrSql.delete(0,StrSql.length());
       
       String StrclPaginaWeb = "20";
       session.setAttribute("clPaginaWebP",StrclPaginaWeb);
       
       MyUtil.InicializaParametrosC( 20,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
       %>
       <%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion","")%>
      <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="PaquetesServicios.jsp?'>"%>
       <%
       if (rs.next()) {
            // El siguiente campo llave no se mete con MyUtil.ObjInput
           %>
            <INPUT id='clPaquete' name='clPaquete' type='hidden' value='<%=StrclPaquete%>'><br><br><br><br>
            <%=MyUtil.ObjInput("","dsPaquete",rs.getString("dsPaquete"),true,true,10,80,"",true,true,73)%>
            <%
        }
       else
        {
            // El siguiente campo llave no se mete con MyUtil.ObjInput
            %>
            <INPUT id='clPaquete' name='clPaquete' type='hidden' value='<%=StrclPaquete%>'><br><br><br><br>
            <%=MyUtil.ObjInput("","dsPaquete","",true,true,10,80,"",true,false,73)%>
        <%
        }   
        %>
        <%=MyUtil.DoBlock("PAQUETE",300,0)%>
        <%=MyUtil.GeneraScripts()%>
        <%
        if (MyUtil.blnAccess[4]==true){
%>
<script>
     document.all.dsPaquete.maxLength=60;
</script>
<%
        }
        StrclUsrApp = null;
        StrclPaquete = null;
        StrclPaginaWeb = null;
        StrSql = null;
        rs.close();
        rs = null;
        
%>
</body>
</html>