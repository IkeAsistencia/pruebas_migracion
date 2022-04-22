<%@page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Seguridad.SeguridadC,Utilerias.UtileriasBDF,com.ike.Supervision.DAOSCSQueja,com.ike.Supervision.to.SCSQueja" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>

<html>
    <head>
        <title>
            Consulta Quejas x Asistencia
        </title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" />
        <script src='../Utilerias/Util.js' ></script>
        <%
        String StrclUsrApp="0";
        String StrclPaginaWeb = "1192";
        String strclSupervision = "0";
        String StrclQuejaxSupervision = "0";
        String StrclAsistencia = "0";

        DAOSCSQueja daoQueja = null;
        SCSQueja Queja = null;

        if (session.getAttribute("clUsrApp")!= null){
            StrclUsrApp = session.getAttribute("clUsrApp").toString();
        }

        if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true){
        %>Fuera de Horario<%
        return;
        }

        if (session.getAttribute("clSupervision")!= null){
            strclSupervision = session.getAttribute("clSupervision").toString();
        }

        if (request.getParameter("clQuejaxSupervision")!= null){
            StrclQuejaxSupervision= request.getParameter("clQuejaxSupervision").toString();
            session.setAttribute("clQuejaxSupervision", StrclQuejaxSupervision);
        }

        if (request.getParameter("clAsistencia")!= null){
            StrclAsistencia= request.getParameter("clAsistencia").toString();
        }else{
            if (session.getAttribute("clAsistencia")!= null){
                StrclAsistencia= session.getAttribute("clAsistencia").toString();
            }
        }

        System.out.println("StrclAsistencia     "+StrclAsistencia);

        daoQueja = new DAOSCSQueja();
        Queja = daoQueja.getclQuejaxAsist(StrclQuejaxSupervision);

        System.out.println("StrclQuejaxSupervision      "+StrclQuejaxSupervision);

        session.setAttribute("clAsistencia", StrclAsistencia);

        StringBuffer StrSql = new StringBuffer();

        ResultSet rs = null;
        rs = UtileriasBDF.rsSQLNP( "st_SCSBuscaQueja "+StrclQuejaxSupervision);

        StrSql.delete(0,StrSql.length());
        %>
        <script>
            fnOpenLinks()
        </script>
        <%
        MyUtil.InicializaParametrosC(1192,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina

        session.setAttribute("clPaginaWebP",StrclPaginaWeb);%>
        <% if (rs.next()) { %>
            <INPUT id='clQuejaxSupervision' name='clQuejaxSupervision' type='hidden' value='<%=StrclQuejaxSupervision%>'>
            <%=MyUtil.ObjComboC("Queja","clQuejaVTR", Queja != null ? Queja.getDsQueja() : "",false,false,30,70,"","Select clQueja, dsQueja from cQueja","","",50,false,false)%>
            <%=MyUtil.ObjComboC("Estatus  de la Queja","clEstatusQuejaVTR", Queja != null ? Queja.getDsEstatusQueja() : "",false,false,300,70,"1","Select clEstatusQueja,dsEstatusQueja from cEstatusQueja","","", 45,false,false)%>
            <%=MyUtil.ObjChkBox("Queja o Inconformidad","EsQuejaVTR", Queja != null ? Queja.getEsQueja() : "", false,false,550,65,"0","Queja","Inconformidad","")%>
            <%=MyUtil.ObjTextArea("Observaciones de Supervisor","ObservacionesSupVTR", Queja != null ? Queja.getObservacionesSup() : "","80","3",false,false,30,120,"",false,false)%>
            <%=MyUtil.ObjTextArea("Observaciones de Área","ObservacionesAreaVTR", Queja != null ? Queja.getObservacionesArea() : "","80","3",false,false,30,190,"",false,false)%>
            <%=MyUtil.ObjTextArea("SOLUCIÓN","SolucionVTR", Queja != null ? Queja.getSolucion() : "","80","3",false,false,30,260,"",false,false)%>
            <%=MyUtil.ObjInput("Fecha de Ingreso<BR>AAAA/MM/DD HH:MM","FechaIngresoVTR", Queja != null ? Queja.getFechaIngreso() : "",false,false,30,330,"",false,false,22)%>
            <%=MyUtil.ObjInput("Fecha de Solución<BR>AAAA/MM/DD HH:MM","FechaSolucionVTR", Queja != null ? Queja.getFechaSolucion() : "",false,false,300,330,"",false,false,22,"")%>
            <%=MyUtil.DoBlock("Módulo de Quejas",50,25)%>

            <%=MyUtil.ObjChkBox("Comercial","NSComercial", Queja != null ? Queja.getNSComercial() : "", false,false,30,450,"0","SI","NO","")%>
            <%=MyUtil.ObjChkBox("Cliente  ","NSCliente", Queja != null ? Queja.getNSCliente() : "", false,false,120,450,"0","SI","NO","")%>
            <%=MyUtil.ObjChkBox("Usuario  ","NSUsuario", Queja != null ? Queja.getNSUsuario() : "", false,false,200,450,"0","SI","NO","")%>
            <%=MyUtil.ObjChkBox("Jefe     ","NSJefe", Queja != null ? Queja.getNSJefe() : "", false,false,280,450,"0","SI","NO","")%>
            <%=MyUtil.ObjChkBox("GCP      ","NSGCP", Queja != null ? Queja.getNSGCP() : "", false,false,360,450,"0","SI","NO","")%>
            <%=MyUtil.ObjChkBox("Proveedor","NSProveedor", Queja != null ? Queja.getNSProveedor() : "", false,false,440,450,"0","SI","NO","")%>
            <%=MyUtil.DoBlock("Notificación de Solución")%>

            <% if (rs.getString("clQueja").equalsIgnoreCase("1")){ %>
                <%=MyUtil.ObjComboC("Tipo de Daño","clDano", Queja != null ? Queja.getDsDano() : "",false,false,30,550,"0","Select clDano , dsDano  from cDanos","fn_LLenaSubDano();","",50,false,false)%>
                <%=MyUtil.ObjComboC("SubTipo de Daño","clSubDano", Queja != null ? Queja.getDsSubDano() : "",false,false,200,550,"0","sp_TraeSubDano '"+rs.getString("clDano")+"'","","",50,false,false)%>
                <%=MyUtil.ObjChkBox("ACEPTACIÓN","clAceptacionDano", Queja != null ? Queja.getClAceptacionDano() : "", false,false,370,550,"0","SI","NO","")%>
                <%=MyUtil.ObjInput("Fecha Aceptación<BR>(AAAA-MM-DD)","FechaAceptacionDano", Queja != null ? Queja.getFechaAceptacionDano() : "",false,false,470,540,"",false,false,12,"fnValMask(this,document.all.FechaMask.value,this.name);")%>
                <%=MyUtil.ObjComboC("Responsabilidad","clResponsabilidadDano",Queja != null ? Queja.getDsResponsabilidadDano() : "",false,false,30,600,"0","Select clResponsabilidadDano , dsResponsabilidadDano  from cResponsabilidadDano ","","",50,false,false)%>
                <%=MyUtil.ObjComboC("Modo Reparación","clModoReparacionDano", Queja != null ? Queja.getDsModoReparacionDano() : "",false,false,250,600,"0","Select clModoReparacionDano , dsModoReparacionDano  from cModoReparacionDano ","","",50,false,false)%>
                <%=MyUtil.ObjComboC("Tipo de Pago","clTipoPagoDano", Queja != null ? Queja.getDsTipoPagoDano() : "",false,false,30,654,"0","Select clTipoPagoDano , dsTipoPagoDano  from cTipoPagoDano ","fn_HayPago(this.value);","",50,false,false)%>
                <%=MyUtil.ObjInput("Fecha Registro Tipo de Pago (AAAA-MM-DD)","FechaRegistroTipoPago", Queja != null ? Queja.getFechaRegistroTipoPago() : "",false,false,250,640,"",false,false,12,"fnValMask(this,document.all.FechaMask.value,this.name);")%>
                <%=MyUtil.ObjInput("Fecha Pago/Ingreso a Taller (AAAA-MM-DD)","FechaPagoIngreso", Queja != null ? Queja.getFechaPagoIngreso() : "",false,false,30,700,"",false,false,12,"fnValMask(this,document.all.FechaMask.value,this.name);")%>
                <%=MyUtil.ObjComboC("Comprobante de Reparación","clComprobanteRepDano", Queja != null ? Queja.getDsComprobanteRepDano() : "",false,false,250,713,"0","select clComprobanteRepDano,dsComprobanteRepDano from cComprobanteRepDano","","",50,false,false)%>
                <%=MyUtil.ObjInput("Fecha Comprobante REPARACIÓN (AAAA-MM-DD)","FechaRegistroComprob", Queja != null ? Queja.getFechaRegistroComprob() : "",false,false,470,700,"",false,false,12,"fnValMask(this,document.all.FechaMask.value,this.name);")%>
                <%=MyUtil.DoBlock("Detalle de Daños")%>
            <% }
        }else{ %>
            No Existe la Queja
        <% } %>
        <%=MyUtil.GeneraScripts()%>
        <%
        //Limpieza de  Variables
        StrclUsrApp = null;
        StrclPaginaWeb = null;
        strclSupervision = null;
        StrclQuejaxSupervision = null;
        StrclAsistencia = null;
        %>
    </body>
</html>
