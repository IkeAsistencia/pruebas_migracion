<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="com.ike.concierge.DAOConcierge,com.ike.concierge.CSContactoxRef,Combos.cbTipoContacto,java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
<head><title>Detalle Contacto xReferencia</title>
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
</head>
<body class="cssBody">
<%-- <jsp:useBean id="beanInstanceName" scope="session" class="beanPackage.BeanClassName" /> --%>
<%-- <jsp:getProperty name="beanInstanceName"  property="propertyName" /> --%>
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
<script src='../Utilerias/Util.js' ></script>
<%  
    String StrclContactoxRef = "0";
    String StrclReferencia = "0";
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

    if (session.getAttribute("clReferencia") != null)
    {
      StrclReferencia= session.getAttribute("clReferencia").toString();
    }else{
       %>Para consultar el contacto, debe ingresar por el detalle de referencias <%
       return;
    }

    if (request.getParameter("clContactoxRef") != null)
    {
      StrclContactoxRef= request.getParameter("clContactoxRef");
    }    

       ResultSet rs = null;
       StringBuffer StrSql = new StringBuffer();
       
       DAOConcierge daoc = new DAOConcierge();
       CSContactoxRef  ContactoxRefI = null;
       
       if (StrclContactoxRef.compareToIgnoreCase("0")!=0){
            ContactoxRefI = daoc.getContactoxRef(StrclContactoxRef);
       }
       
       String StrclPaginaWeb = "645";
       session.setAttribute("clPaginaWebP",StrclPaginaWeb); %>
        <SCRIPT>fnOpenLinks()</script> <%
       MyUtil.InicializaParametrosC(645,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina 

       %>
       <%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion","")%>
            <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="DetContxRef.jsp?'>"%>

            <INPUT id='clContactoxRef' name='clContactoxRef' type='hidden' value='<%=StrclContactoxRef%>'><br>
            <INPUT id='clReferencia' name='clReferencia' type='hidden' value='<%=StrclReferencia%>'><br>
            <%=MyUtil.ObjComboMem("clTipoContacto","clTipoContacto",ContactoxRefI != null ? ContactoxRefI.getDsTipoContacto() : "",ContactoxRefI != null ? String.valueOf(ContactoxRefI.getClTipoContacto()) : "",cbTipoContacto.GeneraHTML(50,ContactoxRefI != null ? String.valueOf(ContactoxRefI.getDsTipoContacto()) : ""),true,true,30,120,"0","","",50,true,true)%>
            <%=MyUtil.ObjInput("Contacto","Contacto",ContactoxRefI != null ? ContactoxRefI.getContacto() : "",true,true,30,160,"",true,true,100,"")%>            
            <%=MyUtil.DoBlock("Detalle de Contacto",350,0)%>
            <%
               if (ContactoxRefI == null){
            %>
                  <script>document.all.btnElimina.disabled=true;document.all.btnCambio.disabled=true</script>
            <%
               }
            %>
          <%=MyUtil.GeneraScripts()%> 

</body>
</html>