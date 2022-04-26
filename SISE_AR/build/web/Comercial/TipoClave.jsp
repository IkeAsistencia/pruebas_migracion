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

    String StrclTipoClave = "0";
    String StrclUsrApp="0";
    
    

    if (session.getAttribute("clUsrApp")!= null)
     {
       StrclUsrApp = session.getAttribute("clUsrApp").toString(); 
     }  

    if (SeguridadC.verificaHorarioC((Integer.parseInt(StrclUsrApp))) != true) 
     {
       %><%="Fuera de Horario"%><%;  return; 
     }    
     
    if (request.getParameter("clTipoClave") != null)
    {
      StrclTipoClave = request.getParameter("clTipoClave");
    }    
    
        StringBuffer StrSql = new StringBuffer();
        StrSql.append("select clTipoClave, dsTipoClave ");
        StrSql.append(" From cTipoClave ");
        StrSql.append(" Where clTipoClave=").append(StrclTipoClave);
        
       ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
       StrSql.delete(0,StrSql.length());

       String StrclPaginaWeb = "40"; 
       session.setAttribute("clPaginaWebP",StrclPaginaWeb);

       MyUtil.InicializaParametrosC( 40,Integer.parseInt(StrclUsrApp));    
       %><%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion","")%>
       
        <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="TipoClave.jsp?'>"%><%
      if (rs.next()) {

             %><INPUT id='clTipoClave' name='clTipoClave' type='hidden' value='<%=StrclTipoClave%>'><br><br><br><br>
            
             <%=MyUtil.ObjInput("Tipo de Clave","dsTipoClave",rs.getString("dsTipoClave"),true,true,20,100,"",true,true,85)%><%
        }
       else {
            
             %><%=MyUtil.ObjInput("Tipo de Clave","dsTipoClave","",true,true,20,100,"",true,true,85) %><%
        }           
            
           %><%=MyUtil.DoBlock("Tipo de Clave",360,0)%>                          
             <%=MyUtil.GeneraScripts() %><%
             
           rs.close();
           rs=null;
           
           StrSql=null;
           StrclTipoClave = null;
           StrclUsrApp=null;
          
%>

</body>
</html>
