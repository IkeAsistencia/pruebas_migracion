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
        <script src='../Utilerias/UtilDireccion.js' ></script>
        <%  
        com.ike.util.I18N i18n = com.ike.util.I18N.getInstance("es","AR");
        
        String StrclProveedor = "0";
        String StrclCentroAtencion = "0";
        
        
        
        
        String StrSql = "";
        String StrNomOpe = "";
        String StrclUsrApp="0";
        
        if (session.getAttribute("clUsrApp")!= null)
        {
            StrclUsrApp = session.getAttribute("clUsrApp").toString();
        }
        
        if (session.getAttribute("clProveedor")!= null)
        {
            StrclProveedor = session.getAttribute("clProveedor").toString();
        }
        
        if (request.getParameter("clCentroAtencion")!= null)
        {
            StrclCentroAtencion = request.getParameter("clCentroAtencion").toString();
        }
        
        if (session.getAttribute("NombreOpe")!= null)
        {
            StrNomOpe = session.getAttribute("NombreOpe").toString();
        }
        
        if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true)
        {
        %><%="Fuera de Horario"%><%
        
        return;
        }
        
        StringBuffer StrSql1 = new StringBuffer();
        
        StrSql1.append(" select CA.NmbCentroAtecion,TC.dstipocentroatencion,CA.Contacto,CA.PuestoContacto,CA.Horario,CA.Telefono1,coalesce(CA.Telefono2,'')'Telefono2'," );
        StrSql1.append(" coalesce(CA.Observaciones,'')'Observaciones',EF.dsentfed,CA.CodEnt'CodEnt',MD.dsmundel,CA.CodMD'CodMD',CA.Colonia,CA.Callenum,CA.CP" );
        StrSql1.append(" FROM  CentroAtencion CA " );
        StrSql1.append(" inner join cTipoCentroAtencion  TC on (CA.cltipoCentroAtencion=TC.cltipoCentroAtencion)" );
        StrSql1.append(" left join cEntFed EF on (CA.CodEnt=EF.CodEnt)" );
        StrSql1.append(" left join Cmundel MD on (CA.CodEnt=MD.CodEnt and CA.CodMD=MD.CodMD)" );
        StrSql1.append(" where CA.clCentroAtencion = " ).append(StrclCentroAtencion);
        
        
        ResultSet rs = UtileriasBDF.rsSQLNP( StrSql1.toString());
        StrSql1.delete(0,StrSql1.length());
        
        String StrclPaginaWeb = "501";
        session.setAttribute("clPaginaWebP",StrclPaginaWeb);
        %>
        <SCRIPT>fnOpenLinks()</script>
        <%
        MyUtil.InicializaParametrosC(501,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
        %>
        <%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion","")%>
        <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="DetalleCentroAtencionM.jsp?'>"%>
        <%
        if (rs.next())
        {
        %>
        <INPUT id='clProveedor' name='clProveedor' type='hidden' value='<%=StrclProveedor%>'>
        <INPUT id='clCentroAtencion' name='clCentroAtencion' type='hidden' value='<%=StrclCentroAtencion %>'>
        <%=MyUtil.ObjInput("Nombre Operativo","NombreOpe",StrNomOpe,false,false,20,100,StrNomOpe,false,false,70)%>
        
        <%=MyUtil.ObjInput("Nombre Centro Atención","NmbCentroAtecion",rs.getString("NmbCentroAtecion"),true,true,20,140,"",true,true,40)%>
        <%=MyUtil.ObjComboC("Tipo Centro de Atención","clTipoCentroAtencion",rs.getString("dsTipoCentroAtencion"),true,true,310,140,"1","SELECT * FROM cTipoCentroAtencion ","","",50,true,true)%>
        <%=MyUtil.ObjInput("Contacto","Contacto",rs.getString("Contacto"),true,true,20,180,"",true,true,40)%>
        <%=MyUtil.ObjInput("Puesto Contacto","PuestoContacto",rs.getString("PuestoContacto"),true,true,310,180,"",true,true,25)%>
        <%=MyUtil.ObjInput("Horario","Horario",rs.getString("Horario"),true,true,20,220,"",true,true,50)%>
        <%=MyUtil.ObjInput("Telefono 1","Telefono1",rs.getString("Telefono1"),true,true,310,220,"",true,true,15)%>
        <%=MyUtil.ObjInput("Telefono 2","Telefono2",rs.getString("Telefono2"),true,true,415,220,"",false,false,15)%>
        <%=MyUtil.ObjTextArea("Observaciones","Observaciones",rs.getString("Observaciones"),"100","5",true,true,20,270,"",false,false)%>          
        <%=MyUtil.DoBlock("Detalle Centro de Atención Médicos",0,40)%>
        
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.entidad"),"dsEntFed",rs.getString("dsEntFed"),false,false,20,410,"",true,true,50)%>
        <INPUT id='CodEnt' name='CodEnt' type='hidden' value='<%=rs.getString("CodEnt")%>'>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.municipio"),"dsMunDel",rs.getString("dsMunDel"),false,false,310,410,"",true,true,50)%>
        <INPUT id='CodMD' name='CodMD' type='hidden' value='<%=rs.getString("CodMD")%>'>
        
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.colonia"),"Colonia",rs.getString("Colonia"),false,false,20,450,"",true,true,50)%>
        <%=MyUtil.ObjInput("Calle","CalleNum",rs.getString("CalleNum"),true,true,310,450,"",true,true,50)%>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.cp"),"CP",rs.getString("CP"),false,false,20,490,"",true,true,10)%>
        <div class='VTable' style='position:absolute; z-index:25; left:130px; top:500px;'>
        <INPUT type='button' VALUE='Buscar..' onClick='fnBuscaColonia();' class='cBtn'></div>
        <%=MyUtil.DoBlock("Ubicación del Centro de Atención",105,0)%>
        
        <%
        }
        else
        {
        %>
        <INPUT id='clProveedor' name='clProveedor' type='hidden' value='<%=StrclProveedor%>'>
        <INPUT id='clCentroAtencion' name='clCentroAtencion' type='hidden' value=''>
        <%=MyUtil.ObjInput("Nombre Operativo","NombreOpe",StrNomOpe,false,false,20,100,StrNomOpe,false,false,70)%>
        
        <%=MyUtil.ObjInput("Nombre Centro Atención","NmbCentroAtecion","",true,true,20,140,"",true,true,40)%>
        <%=MyUtil.ObjComboC("Tipo Centro de Atención","clTipoCentroAtencion","",true,true,310,140,"1","SELECT * FROM cTipoCentroAtencion ","","",50,true,true)%>
        <%=MyUtil.ObjInput("Contacto","Contacto","",true,true,20,180,"",true,true,40)%>
        <%=MyUtil.ObjInput("Puesto Contacto","PuestoContacto","",true,true,310,180,"",true,true,25)%>
        <%=MyUtil.ObjInput("Horario","Horario","",true,true,20,220,"",true,true,50)%>
        <%=MyUtil.ObjInput("Telefono 1","Telefono1","",true,true,310,220,"",true,true,15)%>
        <%=MyUtil.ObjInput("Telefono 2","Telefono2","",true,true,415,220,"",false,false,15)%>
        <%=MyUtil.ObjTextArea("Observaciones","Observaciones","","100","5",true,true,20,270,"",false,false)%>          
        <%=MyUtil.DoBlock("Detalle Centro de Atención Médicos",0,40)%>
        
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.entidad"),"dsEntFed","",false,false,20,410,"",true,true,50)%>
        <INPUT id='CodEnt' name='CodEnt' type='hidden' value=''>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.municipio"),"dsMunDel","",false,false,310,410,"",true,true,50)%>
        <INPUT id='CodMD' name='CodMD' type='hidden' value=''>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.colonia"),"Colonia","",false,false,20,450,"",true,true,50)%>
        <%=MyUtil.ObjInput("Calle","CalleNum","",true,true,310,450,"",true,true,50)%>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.cp"),"CP","",false,false,20,490,"",true,true,10)%>
        <div class='VTable' style='position:absolute; z-index:25; left:130px; top:500px;'>
        <INPUT type='button' VALUE='Buscar..' onClick='fnBuscaColonia();' class='cBtn'></div>
        <%=MyUtil.DoBlock("Ubicación del Centro de Atención",105,0)%>
        
        <%    
        } 
        %>
        
        <%=MyUtil.GeneraScripts()%>
        <%
        rs.close();
        rs=null;
        
        StrSql1=null;
        StrclProveedor=null;
        StrclCentroAtencion=null;
        StrNomOpe=null;
        StrclPaginaWeb=null;
        %>
    </body>
</html>
