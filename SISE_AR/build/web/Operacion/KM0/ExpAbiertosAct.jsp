<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head><title>JSP Page</title> 
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <%-- <jsp:useBean id="beanInstanceName" scope="session" class="beanPackage.BeanClassName" /> --%>
        <%-- <jsp:getProperty name="beanInstanceName"  property="propertyName" /> --%>
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
        <script src='../../Utilerias/Util.js' ></script>
        <%  
        com.ike.util.I18N i18n = com.ike.util.I18N.getInstance("es","AR");
        
        String StrclUsrApp="0";
        String StrclExpediente="0";
        String StrclPaginaWeb="0";
        String StrclProveedor="0";
        
        
        
        if (session.getAttribute("clUsrApp")!= null)
        {
            StrclUsrApp = session.getAttribute("clUsrApp").toString();
        }
        
        if (request.getParameter("Expediente") != null)
        {
            StrclExpediente = request.getParameter("Expediente");
        }
        
        if (request.getParameter("Proveedor") != null)
        {
            StrclProveedor = request.getParameter("Proveedor");
        }
        
        if ( request.getParameter("StrSP")!= null && request.getParameter("StrSP")!= "")
        {
            if (request.getParameter("StrSP").length() > 1)
            {   //actualiza expediente solo si oprimieron botón de Actualiza
                
                ResultSet rs2 = UtileriasBDF.rsSQLNP( request.getParameter("StrSP"));
                if (rs2.next())
                {
                    if (rs2.getString(2).length() > 1)
                    { %>
        <script> alert('<%=rs2.getString(2)%>');</script><%
                    }
                }
                rs2.close();
                rs2=null;
            }
        }
        
        StrclPaginaWeb = "218";
        MyUtil.InicializaParametrosC(218,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
        session.setAttribute("clPaginaWebP",StrclPaginaWeb);
        StringBuffer StrSql1 = new StringBuffer();
        StrSql1.append("sp_WebExpedientexProv ").append(StrclUsrApp).append(",").append(StrclExpediente).append(",").append(StrclProveedor);
        ResultSet rs = UtileriasBDF.rsSQLNP( StrSql1.toString());
        StrSql1.delete(0,StrSql1.length());
        
        if (rs.next())
        {
        %>
        <form id='Forma' name ='Forma'  action='ExpAbiertosAct.jsp?' method='get'>
            <INPUT id='Expediente' name='Expediente' type='hidden' value='<%= StrclExpediente%>'>
            <INPUT id='Proveedor' name='Proveedor' type='hidden' value='<%=StrclProveedor%>'>
            <INPUT id='StrSP' name='StrSP' type='hidden' value=''>
            
            <table class='TTable'>
                <tr><th colspan=7>DETALLE DEL EXPEDIENTE</th></tr><tr></tr><tr></tr>
                
                <tr><td width='190'>Subservicio</td><td width='120'>Expediente</td><td width='120'>Descripción de lo Ocurrido</td><td width='120'>Marca del Vehículo</td><td width='120'>Tipo</td><td width='120'>Modelo</td><td width='120'>Color</td></tr>
                <td class='R1Table' width='190'><%=rs.getString("Subservicio")%></td>
                <td class='R1Table' width='260'><%=rs.getString("Expediente")%></td>
                <td class='R1Table' width='260'><%=rs.getString("DescripcionOcurrido")%></td>
                <td class='R1Table' width='260'><%=rs.getString("dsMarcaAuto")%></td>
                <td class='R1Table' width='260'><%=rs.getString("dsTipoAuto")%></td>
                <td class='R1Table' width='260'><%=rs.getString("Modelo")%></td>
                <td class='R1Table' width='260'><%=rs.getString("Color")%></td>
                </tr>
                
                <tr><td width='190'>Calle Ubicación</td><td width='120'>Referencias Visuales</td><td width='120'><%=com.ike.util.I18N.getInstance().getMessage("message.title.colonia")%></td><td width='120'>Delegación/Muncipio</td><td width='120<%="Entidad Federativa"%></td><td width='120'>Destino</td></tr>
                
                <td class='R1Table' width='190'><%=rs.getString("CalleNum")%></td>
                <td class='R1Table' width='260'><%=rs.getString("Referencias Visuales")%></td>
                <td class='R1Table' width='260'><%=rs.getString("Colonia")%></td>
                <td class='R1Table' width='260'><%=rs.getString("dsMunDel")%></td>
                <td class='R1Table' width='260'><%=rs.getString("dsEntFed")%></td>
                <td class='R1Table' width='260' colspan=2><%=rs.getString("destino")%></td>
            </tr></table><br>
            
            <table class='TTable'>
                <tr><td width='120'></td><td width='120'>Fecha Apertura Expediente:</td><td class='R1Table' width='150'><%= rs.getString("FecAperExp")%></td></tr>
                <tr></tr><tr><td width='120'></td><td width='120'>Estatus Expediente:</td><td class='R1Table' width='150'><%=rs.getString("EstatusExp")%></td></tr>
                <tr></tr><tr><td width='120'></td><td width='120'>Fecha Término Expediente:</td><td class='R1Table' width='150'><%=rs.getString("FecTerExp")%></td></tr>
                <tr></tr><tr><td width='120'></td><td width='120'>Estatus Proveedor:</td><td class='R1Table' width='150'><%=rs.getString("EstatusProv")%></td></tr>
                <tr></tr><tr><td width='120'></td><td width='120'>Fecha Asignación a Proveedor:</td><td class='R1Table' width='150'><%=rs.getString("FecAsignacion")%></td><td width='120' align='center'>Placas</td><td width='120' align='center'>Apellido Materno de Nuestro Usuario</td></tr>
                <tr></tr><tr><td width='120'><%=rs.getString("ACTFECLLEG")%></td><td width='120'>Fecha Llegada:</td><td class='R1Table' width='150'><%=rs.getString("FecLlegada")%></td><td><input id='Placas' name='Placas'></input></td><td><input id='ApeMat' name='ApeMat'></input></td></tr>
                <tr></tr><tr><td width='120'><%=rs.getString("ACTFECCONT")%></td><td width='120'>Fecha Contacto:</td><td class='R1Table' width='150'><%=rs.getString("FecContacto")%></td></tr>
                <tr></tr><tr><td width='120'><%=rs.getString("ACTFECTERMPROV")%></td><td width='120'>Fecha Término Proveedor:</td><td class='R1Table' width='150'><%=rs.getString("FecTermProv")%></td></tr>
            <tr><td><input type='button' value='IMPRIMIR' onClick='fnImprimir();' class='cBtn'></input></td></tr></table> 
            
        </form>
        <%
        }
        rs.close();
        rs=null;
        StrSql1=null;
        StrclUsrApp=null;
        StrclExpediente=null;
        StrclPaginaWeb=null;
        StrclProveedor=null;    
        
        %>
        
        <script>
function fnActualizaExpediente(Usr,Exp,Prov,TipoFec)
{ 
      document.all.StrSP.value="sp_WebExpActualizaProv " + Usr + "," + Prov + ",'" + document.all.Placas.value + "'," + TipoFec + "," + Exp + ",'" + document.all.ApeMat.value + "'";
      document.all.Forma.submit();
}
function fnImprimir()
{ 
   strPagina ='../KM0/ImpresionProveeExp.jsp?Expediente=' + document.all.Expediente.value + '&Proveedor=' + document.all.Proveedor.value;
//   alert(strPagina);
   window.open(strPagina,'newWin','scrollbars=yes,status=yes,width=800,height=560');
}
        </script>
        
    </body>
</html>
