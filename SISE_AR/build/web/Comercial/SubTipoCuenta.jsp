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

    String StrclSubTipoCuenta = "0";
    String StrclUsrApp="0";
    
    

    if (session.getAttribute("clUsrApp")!= null)
     {
       StrclUsrApp = session.getAttribute("clUsrApp").toString(); 
     }  
    if (SeguridadC.verificaHorarioC((Integer.parseInt(StrclUsrApp))) != true) 
    {
       %><%="Fuera de Horario"%><%;  return; 
    }
    if (request.getParameter("clSubTipoCuenta") != null)
    {
      StrclSubTipoCuenta = request.getParameter("clSubTipoCuenta");
    }    
    
        StringBuffer StrSql = new StringBuffer();
        StrSql.append("select C.clTipoCuenta, C.dsTipoCuenta, SC.clSubTipoCuenta, SC.dsSubTipoCuenta ");
        StrSql.append(" From cSubTipoCuenta SC Inner Join cTipoCuenta C ON (SC.clTipoCuenta = C.clTipoCuenta) ");
        StrSql.append(" Where SC.clSubTipoCuenta=").append(StrclSubTipoCuenta);
       
       ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
       StrSql.delete(0,StrSql.length());

       String StrclPaginaWeb = "68";
       session.setAttribute("clPaginaWebP",StrclPaginaWeb);

       MyUtil.InicializaParametrosC( 68,Integer.parseInt(StrclUsrApp));    
       
       %><%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion","")%>
                 
       <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="SubTipoCuenta.jsp?'>"%><%
       if (rs.next()) {
            out.println("<INPUT id='clSubTipoCuenta' name='clSubTipoCuenta' type='hidden' value='"+ StrclSubTipoCuenta +"'><br><br><br><br>"); 
            out.println(MyUtil.ObjComboC("TipoCuenta","clTipoCuenta",rs.getString("dsTipoCuenta"),true,true,20,100,"","Select clTipoCuenta, dsTipoCuenta From cTipoCuenta Order by dsTipoCuenta","","",120,true,true));
            out.println(MyUtil.ObjInput("SubTipoCuenta","dsSubTipoCuenta",rs.getString("dsSubTipoCuenta"),true,true,20,150,"",true,true,110));
            
        }
       else {
            %><%=MyUtil.ObjComboC("Tipo de Cuenta","clTipoCuenta","",true,true,20,100,"","Select clTipoCuenta, dsTipoCuenta From cTipoCuenta Order by dsTipoCuenta","","",120,true,true)%>
            <%=MyUtil.ObjInput("SubTipo de Cuenta","dsSubTipoCuenta","",true,true,20,150,"",true,true,110)%><%
        }           
          %><%=MyUtil.DoBlock("Detalle del SubTipo de Cuentas",500,0)%>                          
          <%=MyUtil.GeneraScripts()%><% 
          rs.close();
          rs=null;
          
          StrSql=null;
          StrclSubTipoCuenta = null;
          StrclUsrApp=null;          
          
%>



</body>
</html>
