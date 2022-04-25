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
    String StrclPrefijo = "0";
    String StrclCuenta = "0";
    String StrSqlCuenta = "";
    String StrclUsrApp="0";

    if (session.getAttribute("clUsrApp")!= null)
    {
       StrclUsrApp = session.getAttribute("clUsrApp").toString(); 
    }
    
    

    if (SeguridadC.verificaHorarioC((Integer.parseInt(StrclUsrApp))) != true) 
    {
       %>Fuera de Horario<%
         
         return; 
    }  
    
    if (request.getParameter("clPrefijo") != null)
    {
      StrclPrefijo = request.getParameter("clPrefijo");
    }    
    
    if (session.getAttribute("clCuenta")!= null)
    {
       StrclCuenta = session.getAttribute("clCuenta").toString(); 
    }
    
       StringBuffer StrSql = new StringBuffer();
       StrSql.append("Select Nombre as Cuenta From cCuenta Where clCuenta=").append(StrclCuenta);
       ResultSet rsCta = UtileriasBDF.rsSQLNP( StrSql.toString());
       StrSql.delete(0,StrSql.length());

       if (rsCta.next()){};
       
       StrSql.append("select C.Nombre as Cuenta, PxC.Prefijo ");
       StrSql.append(" From PrefijoxCuenta PxC Inner Join cCuenta C ON (PxC.clCuenta=C.clCuenta) ");
       StrSql.append(" Where PxC.clPrefijo=").append(StrclPrefijo);
       ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
       StrSql.delete(0,StrSql.length());

       String StrclPaginaWeb = "17";
       session.setAttribute("clPaginaWebP",StrclPaginaWeb);
       
       MyUtil.InicializaParametrosC( 17,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina    
       %><%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion","")%>        
       <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="PrefijosxCuenta.jsp?'>"%><% 
       
       // Los campos llave no se mete con MyUtil.ObjInput  %>
       <INPUT id='clPrefijo' name='clPrefijo' type='hidden' value='<%=StrclPrefijo%>'><br><br><br><br>
       <INPUT id='clCuenta' name='clCuenta' type='hidden' value='<%=StrclCuenta%>'><br><br><br><br><% 

       if (rs.next()) {  %>
            <%=MyUtil.ObjInput("Cuenta","Cuenta",rs.getString("Cuenta"),false,false,20,100,rs.getString("Cuenta"),true,true,55)%>
            <%=MyUtil.ObjInput("Prefijo","Prefijo",rs.getString("Prefijo"),true,true,400,100,"",true,true,12)%><%
        }
       else { %>
            <%=MyUtil.ObjInput("Cuenta","Cuenta",rsCta.getString("Cuenta"),false,false,20,100,rsCta.getString("Cuenta"),true,true,55)%>
            <%=MyUtil.ObjInput("Prefijo","Prefijo","",true,true,400,100,"",true,true,12)%><%
        }    %>      
        <%=MyUtil.DoBlock("Detalle de Prefijo Por Cuenta")%>                          
        <%=MyUtil.GeneraScripts()%>
        <%
          rs.close();
          rs =null;
          
          %>

<script>
     document.all.Prefijo.maxLength=14;
</script>

</body>
</html>
