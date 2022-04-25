<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%@ page import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC,com.ike.asistencias.DAOReddeDescuentos,com.ike.asistencias.to.ReddeDescuentos" %>

<html>
    <head>
        <title>Red de Descuentos</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj"/>
        <script src='../Utilerias/Util.js'></script>
        <script src='../Utilerias/UtilDireccion.js' ></script>
        <script src='../Utilerias/UtilStore.js'></script>

        <%
        String strclUsr = "0";
        String strclReddeDescuentos = "";
        String StrCodEnt = "";
        String StrclPaginaWeb = "";
        String StrclExpediente = "0";
        String StrclServicio = "";
        String StrclSubServicio = "";
        
        if (session.getAttribute("clUsrApp") != null) {
            strclUsr = session.getAttribute("clUsrApp").toString();
        }
        if(session.getAttribute("clExpediente") != null){
            StrclExpediente = session.getAttribute("clExpediente").toString();                    
        }
        

        if (SeguridadC.verificaHorarioC(Integer.parseInt(strclUsr)) != true) {
        %>Fuera de Horario<%
            strclUsr = null;
            strclReddeDescuentos = null;
            StrCodEnt = null;
            StrclPaginaWeb = null;
            StrclExpediente = null;
            StrclServicio = null;
            StrclSubServicio = null;
            
            return;
        }

        if (request.getParameter("clReddeDescuentos") != null) {
            strclReddeDescuentos = request.getParameter("clReddeDescuentos").toString();
        } else {
            if (session.getAttribute("clReddeDescuentos") != null) {
                strclReddeDescuentos = session.getAttribute("clReddeDescuentos").toString();
            }
        }
        
        if (request.getParameter("clServicio") != null) {
            StrclServicio = request.getParameter("clServicio").toString();
        } else {
            if (session.getAttribute("clServicio") != null) {
                StrclServicio = session.getAttribute("clServicio").toString();
            }
        }

        if (request.getParameter("clSubServicio") != null) {
            StrclSubServicio = request.getParameter("clSubServicio").toString();
        } else {
            if (session.getAttribute("clSubServicio") != null) {
                StrclSubServicio = session.getAttribute("clSubServicio").toString();
            }
        }
        
        //session.setAttribute("clReddeDescuentos", strclReddeDescuentos);

        DAOReddeDescuentos daoReddeDescuentos = null;
        ReddeDescuentos Red = null;

        //SERVLET GENERICO
        String Store = "";
        String Commit = "";

        Store = "st_GuardaReddeDescuentos, st_ActualizaReddeDescuentos";
        session.setAttribute("sp_Stores", Store);

        Commit = "clReddeDescuentos";
        session.setAttribute("Commit", Commit);
        // TERMINA SERVLET GENERICO

        daoReddeDescuentos = new DAOReddeDescuentos();
        Red = daoReddeDescuentos.getReddeDescuentos(StrclExpediente.toString());

        if (Red != null) {
            StrCodEnt = Red.getCodEnt();
        }

        StrclPaginaWeb = "5022";
        session.setAttribute("clPaginaWebP", StrclPaginaWeb);
        %><script>fnOpenLinks()</script>

        <%MyUtil.InicializaParametrosC(5022, Integer.parseInt(strclUsr));%>
        <%--=MyUtil.doMenuAct("../servlet/com.ike.guarda.EjecutaSP", "", "fnsp_Guarda();")--%>
        
        <%=MyUtil.doMenuAct("../servlet/com.ike.guarda.EjecutaSP", "fnAccionesAlta();", "", "fnsp_Guarda();")%>

        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="ReddeDescuentos.jsp?"%>'>
        <INPUT id="Secuencia" name="Secuencia" type="hidden" value="">
        <INPUT id="SecuenciaG" name="SecuenciaG" type="hidden" value="FechadeCaptura,Contacto,NombreComercial,RazonSocial,clTipoDescuento,clGiroRed,CodEnt,CodMD,Beneficios,Correo,Telefono1,Telefono2,clExpediente,clServicio,clSubServicio,FechaApAsist">
        <INPUT id="SecuenciaA" name="SecuenciaA" type="hidden" value="clReddeDescuentos,Contacto,NombreComercial,RazonSocial,clTipoDescuento,clGiroRed,CodEnt,CodMD,Beneficios,Correo,Telefono1,Telefono2,clExpediente">
        <INPUT id="clReddeDescuentos" name="clReddeDescuentos" type="hidden" value="<%=strclReddeDescuentos%>">
        <INPUT id="clExpediente" name="clExpediente" type="hidden" value="<%=StrclExpediente%>">
        <INPUT id="clServicio" name="clServicio" type="hidden" value="<%=StrclServicio%>">
        <INPUT id="clSubServicio" name="clSubServicio" type="hidden" value="<%=StrclSubServicio%>">
        <INPUT id='FechaApAsist' name='FechaApAsist' type='hidden' value=''>

        <%=MyUtil.ObjInput("Fecha de Captura", "FechadeCaptura", Red != null ? Red.getFechadeCaptura() : "", false, false, 275, 90, "", false, false, 15, "")%>
        <%=MyUtil.ObjInput("Nombre del Contacto", "Contacto", Red != null ? Red.getContacto() : "", true, true, 40, 90, "", true, true, 40, "")%>
        <%=MyUtil.ObjInput("Nombre Comercial", "NombreComercial", Red != null ? Red.getNombreComercial() : "", true, true, 40, 130, "", true, true, 50, "")%>
        <%=MyUtil.ObjInput("Raz�n Social", "RazonSocial", Red != null ? Red.getRazonSocial() : "", true, true, 40, 170, "", true, true, 50, "")%>
        <%=MyUtil.ObjComboC("Tipo de Descuento", "clTipoDescuento", Red != null ? Red.getDsTipoDescuento() : "", true, true, 40, 210, "", "select clTipoDescuento, UPPER(dsTipoDescuento) 'dsTipoDescuento' from cTipoDescuento order by dsTipoDescuento", "fnLlenaGiroRed();", "", 10, false, false)%>
        <%=MyUtil.ObjComboC("Rubro", "clGiroRed", Red != null ? Red.getDsGiroRed() : "", true, true, 210, 210, "", "select clGiroRed, UPPER(dsGiroRed) 'dsGiroRed' from cGiroRed order by dsGiroRed", "", "", 10, true, true)%>
        <%=MyUtil.ObjComboC("Provincia", "CodEnt", Red != null ? Red.getDsEntFed() : "", true, true, 40, 250, "", "select CodEnt, dsentfed from centfed order by dsentfed asc", "fnLlenaMunicipios();", "", 10, true, true)%>
        <%=MyUtil.ObjComboC("Localidad", "CodMD", Red != null ? Red.getDsMunDel() : "", true, true, 40, 290, "", "select CodMD, dsMunDel from cMunDel where CodEnt='" + StrCodEnt + "' order by dsMunDel", "", "", 10, true, true)%>
        <%=MyUtil.ObjTextArea("Beneficios", "Beneficios", Red != null ? Red.getBeneficios() : "", "73", "5", true, true, 40, 330, "", true, true)%>
        <%=MyUtil.ObjInput("Correo Electr�nico", "Correo", Red != null ? Red.getCorreo() : "", true, true, 40, 420, "", false, false, 40, "")%>
        <%=MyUtil.ObjInput("Tel�fono 1", "Telefono1", Red != null ? Red.getTelefono1() : "", true, true, 40, 460, "", true, true, 25, "")%>
        <%=MyUtil.ObjInput("Tel�fono 2", "Telefono2", Red != null ? Red.getTelefono2() : "", true, true, 200, 460, "", false, false, 25, "")%>
        <%=MyUtil.DoBlock("Red de Descuentos (Principal)", -15, 0)%>

        <%=MyUtil.GeneraScripts()%>

        <%
        strclUsr = null;
        strclReddeDescuentos = null;
        StrCodEnt = null;
        StrclPaginaWeb = null;
        Store = null;
        Commit = null;

        daoReddeDescuentos = null;
        Red = null;
        %>

        <script>
            function fnLlenaGiroRed(){
                var strConsulta = "st_LlenaGiroRedDescuentos "+ document.all.clTipoDescuento.value;
                var pstrCadena = "../servlet/Utilerias.LlenaCombos?strSQL=" + strConsulta;
                pstrCadena = pstrCadena + "&strName=clGiroRedC";
                fnOptionxDefault('clGiroRedC',pstrCadena);
            }
            
            function fnAccionesAlta() {
                if (document.all.Action.value == 1) {
                    var pstrCadena = "../Utilerias/RegresaFechaActual.jsp";
                    window.open(pstrCadena, 'newWin', 'width=10,height=10,left=1500,top=2000');
                }
            }
            
            function fnActualizaFechaActual(pFecha) {    //ok
                document.all.FechaApAsist.value = pFecha;
            }
        </script>
    </body>
</html>