<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="com.ike.concierge.DAOConcierge,com.ike.concierge.CSReferencia,com.ike.concierge.CSZonaxRef,Combos.cbCiudad,java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
<head><title>Detalle Zona x Referencia</title>
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
</head>
<body class="cssBody">
<%-- <jsp:useBean id="beanInstanceName" scope="session" class="beanPackage.BeanClassName" /> --%>
<%-- <jsp:getProperty name="beanInstanceName"  property="propertyName" /> --%>
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
<script src='../Utilerias/Util.js' ></script>
<script src='../Utilerias/UtilConcierge.js' ></script>
<%  
    String StrclZonaxRef = "0";
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

    if (request.getParameter("clZonaxRef") != null)
    {
      StrclZonaxRef= request.getParameter("clZonaxRef");
    }    
    


       ResultSet rs = null;
       StringBuffer StrSql = new StringBuffer();
       
       DAOConcierge daoc = new DAOConcierge();
       CSZonaxRef  ZonaxRefI = null;
       
       if (StrclZonaxRef.compareToIgnoreCase("0")!=0){
            ZonaxRefI = daoc.getZonaxRef(StrclZonaxRef);
       }
       
       String StrclPaginaWeb = "650";
       session.setAttribute("clPaginaWebP",StrclPaginaWeb); %>
        <SCRIPT>fnOpenLinks()</script> <%
       MyUtil.InicializaParametrosC(650,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina 

       %>

       <%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion","fnLlenaZonasCS()")%>
            <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="DetZonaxRef.jsp?'>"%>

            <INPUT id='clZonaxRef' name='clZonaxRef' type='hidden' value='<%=StrclZonaxRef%>'><br>
            <INPUT id='clReferencia' name='clReferencia' type='hidden' value='<%=StrclReferencia%>'><br>
            <INPUT id='clCiudad' name='clCiudad' type='hidden' value='<%=ZonaxRefI != null? ZonaxRefI.getClCiudadRef() : "0"%>'><br>
            <%
            String clCiudad="";
            clCiudad=ZonaxRefI != null? ZonaxRefI.getClCiudad() : "";

            String dsCiudad="";
            dsCiudad=ZonaxRefI != null? ZonaxRefI.getDsCiudad() : "";

            String dsZona="";
            dsZona=ZonaxRefI != null? ZonaxRefI.getDsZona() : "";

            String StrClZona="";
            StrClZona=ZonaxRefI != null? String.valueOf(ZonaxRefI.getClZona()) : "";

            %>
            <%=MyUtil.ObjComboMem("Zona","clZona",dsZona, StrClZona, cbCiudad.GeneraHTMLZ(30,clCiudad, dsZona), true,true,25,120,"","","",20,true,true)%>

            
            <%=MyUtil.DoBlock("Detalle de Zona Cubierta",350,0)%>
            <%
               if (ZonaxRefI == null){
            %>
                  <script>document.all.btnElimina.disabled=true;document.all.btnCambio.disabled=true</script>
            <%
               }
            %>
          <%=MyUtil.GeneraScripts()%> 

</body>
</html>