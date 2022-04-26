<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%@ page import="com.ike.model.DAOTieneAsistencia,com.ike.model.to.TieneAsistenciaExp,Utilerias.CamposExtra,com.ike.asistencias.DAOServicioDomVet"%>
<%@ page import="Combos.cbEntidad,Combos.cbAMIS,java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC,javax.servlet.http.HttpSession,com.ike.asistencias.to.ServicioDomVet" %>
<html>
    <head>
        <title>ServicioDomVet</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj"/>
        <script src='../../Utilerias/Util.js'></script>
        <script src='../../Utilerias/UtilStore.js'></script>

        <%
        String strclUsr = "0";
        String strclExpediente = "0";
        String strTieneAsistencia = "0";
        String StrEstado = "";
        String StrclServicio = "";
        String StrclSubServicio = "";
        

        if (session.getAttribute("clUsrApp") != null) {
            strclUsr = session.getAttribute("clUsrApp").toString();
        }
                
        if (SeguridadC.verificaHorarioC(Integer.parseInt(strclUsr)) != true) {
        %> Fuera de Horario <%
            strclUsr = null;
            strclExpediente = null;
            strTieneAsistencia = null;
            StrEstado = null;
            StrclServicio = null;
            StrclSubServicio = null;

            return;
        }
        if (session.getAttribute("clExpediente") != null) {
            strclExpediente = session.getAttribute("clExpediente").toString();
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

        DAOTieneAsistencia daoTieneAsistencia = null;
        TieneAsistenciaExp ExpedienteTA = null;

        DAOServicioDomVet daoServicioDomVet = null;
        ServicioDomVet SerDomV = null;

        if (strclExpediente.compareToIgnoreCase("0") != 0) {
            daoTieneAsistencia = new DAOTieneAsistencia();
            ExpedienteTA = daoTieneAsistencia.getExpediente(strclExpediente.toString());
        }

        strTieneAsistencia = ExpedienteTA != null ? ExpedienteTA.getTieneAsistencia() : "0";

        if (strTieneAsistencia.compareToIgnoreCase("0") != 0) {
            if (strclExpediente.compareToIgnoreCase("0") != 0) {
                daoServicioDomVet = new DAOServicioDomVet();
                SerDomV = daoServicioDomVet.getServicioDomVet(strclExpediente.toString());
            } else {
        %>  El expediente no existe   <%
                daoTieneAsistencia = null;
                ExpedienteTA = null;

                daoServicioDomVet = null;
                SerDomV = null;

                strclUsr = null;
                strclExpediente = null;
                strTieneAsistencia = null;
                StrEstado = null;

                return;
            }
        }
// <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<Uso del Servlet Generico
        String Stores = "";
        Stores = "st_GuardaServicioDomVet, st_ActualizaServicioDomVet";
        session.setAttribute("sp_Stores", Stores);
        String Commit = "";
        Commit = "clExpediente";
        session.setAttribute("Commit", Commit);
//---------------------------------------------------------------------

        String StrclPaginaWeb = "5017";
        session.setAttribute("clPaginaWebP", StrclPaginaWeb);

        %>  <script>fnOpenLinks()</script>
        <%MyUtil.InicializaParametrosC(5017, Integer.parseInt(strclUsr));%>
        <%--=MyUtil.doMenuAct("../../servlet/com.ike.guarda.EjecutaSP", "", "fnsp_Guarda();")--%>
        
        <%=MyUtil.doMenuAct("../../servlet/com.ike.guarda.EjecutaSP", "fnAccionesAlta();", "", "fnsp_Guarda();")%>

        <% if (strTieneAsistencia.equalsIgnoreCase("1")) {%>
        <script>document.all.btnAlta.disabled=true;</script>
        <% } else {%>
        <script>
            document.all.btnAlta.disabled=false;
            document.all.btnCambio.disabled=true;
        </script>      <%   }
        %>
        <%
        StrEstado = SerDomV != null ? SerDomV.getCodEnt() : "";
        %>
        <input id="Secuencia" name="Secuencia" value="" type="hidden">
        <input id="SecuenciaG" name="SecuenciaG" value="clExpediente,Nombre,clMascotaRef,Raza,clSexoMascota,Edad,Talla,clTipoAlimento,MarcaAlimento,clServicioDom,MedPrev,ObsServicioDom,CodEnt,CodMD,Calle,Numero,Diagnostico,Tratamiento,clServicio,clSubServicio,FechaApAsist" type="hidden">
        <input id="SecuenciaA" name="SecuenciaA" value="clExpediente,Nombre,clMascotaRef,Raza,clSexoMascota,Edad,Talla,clTipoAlimento,MarcaAlimento,clServicioDom,MedPrev,ObsServicioDom,CodEnt,CodMD,Calle,Numero,Diagnostico,Tratamiento" type="hidden">
        <input id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="ServicioDomVet.jsp?"%>'>
        <input id='clExpediente' name='clExpediente' type = "hidden" value='<%=strclExpediente%>'>
        <INPUT id="clServicio" name="clServicio" type="hidden" value="<%=StrclServicio%>">
        <INPUT id="clSubServicio" name="clSubServicio" type="hidden" value="<%=StrclSubServicio%>">
        <INPUT id='FechaApAsist' name='FechaApAsist' type='hidden' value=''>

        <%=MyUtil.ObjInput("Nombre", "Nombre", SerDomV != null ? SerDomV.getNombre() : "", true, true, 30, 80, "", true, false, 30)%>
        <%=MyUtil.ObjComboC("Especie", "clMascotaRef", SerDomV != null ? SerDomV.getDsMascotaRef() : "", true, true, 220, 80, "", "select clMascotaRef, dsMascotaRef from cRMascota", "", "", 10, true, false)%>
        <%=MyUtil.ObjInput("Raza", "Raza", SerDomV != null ? SerDomV.getRaza() : "", true, true, 410, 80, "", false, false, 40)%>
        <%=MyUtil.ObjComboC("Sexo", "clSexoMascota", SerDomV != null ? SerDomV.getDsSexoMascota() : "", true, true, 30, 120, "", "select clSexoMascota,dsSexoMascota from TLRcSexoMascota", "", "", 10, true, false)%>
        <%=MyUtil.ObjInput("Edad", "Edad", SerDomV != null ? SerDomV.getEdad() : "", true, true, 220, 120, "", false, false, 15)%>
        <%=MyUtil.ObjInput("Talla", "Talla", SerDomV != null ? SerDomV.getTalla() : "", true, true, 410, 120, "", false, false, 20)%>
        <%=MyUtil.ObjComboC("Tipo de Alimento", "clTipoAlimento", SerDomV != null ? SerDomV.getDsTipoAlimento() : "", true, true, 30, 160, "", "select clTipoAlimento,dsTipoAlimento from cTipoAlimentoMascota", "", "", 10, false, false)%>
        <%=MyUtil.ObjInput("Marca de Alimento", "MarcaAlimento", SerDomV != null ? SerDomV.getMarcaAlimento() : "", true, true, 220, 160, "", false, false, 30)%>
        <%=MyUtil.ObjComboC("Servicio a Domicilio", "clServicioDom", SerDomV != null ? SerDomV.getDsServicioDom() : "", true, true, 410, 160, "", "select clServicioDomVet,dsServicioDomVet from cServicioDomVet", "", "", 40, false, false)%>
        <%=MyUtil.ObjTextArea("Medicina Preventiva", "MedPrev", SerDomV != null ? SerDomV.getMedPrev() : "", "50", "5", true, true, 30, 200, "", false, false)%>
        <%=MyUtil.ObjTextArea("Observaciones", "ObsServicioDom", SerDomV != null ? SerDomV.getObsServicioDom() : "", "70", "5", true, true, 330, 200, "", false, false)%>
        <%=MyUtil.DoBlock("Historia Clinica", 125, 50)%>

        <%=MyUtil.ObjComboC("Provincia", "CodEnt", SerDomV != null ? SerDomV.getDsEntFed() : "", true, true, 30, 340, "", "st_TLR_CargaEstado 115", "fnCargaMunDel();", "", 10, true, false)%>
        <%=MyUtil.ObjComboC("Localidad/Barrio", "CodMD", SerDomV != null ? SerDomV.getDsMunDel() : "", true, true, 30, 380, "", "st_TLR_CargaMunDel '115','" + StrEstado + "'", "", "", 10, true, false)%>
        <%=MyUtil.ObjInput("Calle", "Calle", SerDomV != null ? SerDomV.getCalle() : "", true, true, 30, 420, "", true, false, 50)%>
        <%=MyUtil.ObjInput("Numero", "Numero", SerDomV != null ? SerDomV.getNumero() : "", true, true, 330, 420, "", true, false, 10)%>
        <%=MyUtil.DoBlock("Ubicacion de la Mascota", 60, 0)%>

        <%=MyUtil.ObjTextArea("Dx", "Diagnostico", SerDomV != null ? SerDomV.getDiagnostico() : "", "60", "6", true, true, 30, 510, "", false, false)%>
        <%=MyUtil.ObjTextArea("Tx", "Tratamiento", SerDomV != null ? SerDomV.getTratamiento() : "", "60", "6", true, true, 370, 510, "", false, false)%>
        <%=MyUtil.DoBlock("Evaluacion", 140, 50)%>
        <%=MyUtil.GeneraScripts()%>

        <%
        daoTieneAsistencia = null;
        ExpedienteTA = null;

        daoServicioDomVet = null;
        SerDomV = null;

        strclUsr = null;
        strclExpediente = null;
        strTieneAsistencia = null;
        StrEstado = null;
        StrclPaginaWeb = null;
        %>

        <script>
            function fnCargaMunDel(){
                var strConsulta = "st_TLR_CargaMunDel 115,'" + document.all.CodEnt.value + "'";
                var pstrCadena = "../../servlet/Utilerias.LlenaCombos?strSQL=" + strConsulta;
                pstrCadena = pstrCadena + "&strName=CodMDC";
                fnOptionxDefault('CodMDC',pstrCadena);
            }

            function fnCargaMunDel2(){
                var strConsulta = "st_TLR_CargaMunDel 115,'" + document.all.CodEnt.value + "'";
                var pstrCadena = "../../servlet/Utilerias.LlenaCombos?strSQL=" + strConsulta;
                pstrCadena = pstrCadena + "&strName=CodMDC";
                fnOptionxDefault('CodMDC',pstrCadena);
            }
            
            function fnAccionesAlta() {
                if (document.all.Action.value == 1) {
                    var pstrCadena = "../../Utilerias/RegresaFechaActual.jsp";
                    window.open(pstrCadena, 'newWin', 'width=10,height=10,left=1500,top=2000');
                }
            }
            
            function fnActualizaFechaActual(pFecha) {    //ok
                document.all.FechaApAsist.value = pFecha;
            }
            
        </script>
    </body>
</html>