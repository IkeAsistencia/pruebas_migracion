<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="Combos.cbTipoBenef,Combos.cbTipoContactante,Combos.cbPais,Combos.cbEntidad,Combos.cbEstatus,java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<html>
    <head>
        <title></title>
    </head>
    <body class="cssBody" OnLoad="fnGNPInfo();fnVaciarFechaCita()">
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj"/>
        
        <script src='../Utilerias/Util.js'></script>
        <script src='../Utilerias/UtilDireccion.js'></script>
        <script src='../Utilerias/UtilMask.js'></script>
        <script>
            top.document.all.rightPO.rows="70,*";
        </script>
        <%
            com.ike.util.I18N i18n = com.ike.util.I18N.getInstance("es", "AR");

            String StrclExpediente = "0";
            String strclUsr = "";
            String strclTipoVal = "0";
            String strclTipoValida = "0";
            String StrPrefijo = "";
            String StrBrindados = "0";
            String strclUsr2 = "0";
            String strclEstatus = "0";

            if (session.getAttribute("clUsrApp") != null) {
                strclUsr = session.getAttribute("clUsrApp").toString();
            }

            if (request.getParameter("clExpediente") != null) {
                StrclExpediente = request.getParameter("clExpediente").toString();
            } else {
                if (session.getAttribute("clExpediente") != null) {
                    StrclExpediente = session.getAttribute("clExpediente").toString();
                }
            }
            session.setAttribute("clExpediente", StrclExpediente);
            String StrclPaginaWeb = "155";
            session.setAttribute("clPaginaWebP", StrclPaginaWeb);
        %>
        <script>fnOpenLinks()</script>
        
        <%
            MyUtil.InicializaParametrosC(155, Integer.parseInt(strclUsr));

            /*        ResultSet rs = UtileriasBDF.rsSQLNP( "Select convert(varchar(16),getdate(),120) Fecha");
            String StrFecha ="";
            if (rs.next()){
            StrFecha = rs.getString("Fecha");
            }
            rs.close();
            rs=null;
             */
            StringBuffer StrSql = new StringBuffer();


            StrSql.append("sp_DetalleExpediente ").append(StrclExpediente);
            ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
            StrSql.delete(0, StrSql.length());

        %>
        
        <%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion", "fnAccionesAlta();", "fnValidaPaisEF();fnGNPInfoObli();fnGNPEstatusObli();validaCorreoAntesGuardar();")%>  		        
        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%>DetalleExpediente.jsp?'>
        <INPUT id='clPaginaWeb' name='clPaginaWeb' type='hidden' value='155'>
        <%
            if (rs.next()) {%>
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=rs.getString("clExpediente")%>'>
        <INPUT id='clUsrApp' name='clUsrApp' type='hidden' value='<%=rs.getString("clUsrApp")%>'>
        <%
            String clCuenta = "";
            clCuenta = rs.getString("clCuenta");
            session.setAttribute("clCuenta", clCuenta);

            String Clave = "";
            Clave = rs.getString("Clave");
            session.setAttribute("Clave", Clave);

            String StrDescrip = "";
            StrDescrip = rs.getString("DescripcionOcurrido");
            // PARA DESPLEGAR EL NUMERO DE SERVICIOS RECIBIDOS EN EL PERIODO
            // buscamos tipo de validacion y prefijo de la cuenta 
            StrSql.append(" Select clTipoValidacion, coalesce(Prefijo,'') Prefijo from cCuenta where clCuenta=").append(clCuenta);
            ResultSet rs2 = UtileriasBDF.rsSQLNP(StrSql.toString());
            StrSql.delete(0, StrSql.length());
            if (rs2.next()) {
                strclTipoValida = rs2.getString("clTipoValidacion");
                StrPrefijo = rs2.getString("Prefijo");
            }
            rs2.close();
            rs2 = null;

            if (strclTipoValida.equals("1") || strclTipoValida.equals("3")) //validacion con base de datos y prefijo
            {
                StrSql.append(" Select count(*) Maximo ");
                StrSql.append(" From Expediente ");
                // unir Prefijo a la tabla
                StrSql.append(" INNER JOIN cAfiliado").append(StrPrefijo).append(" cAfiliadoPersona ");
                StrSql.append(" ON cAfiliadoPersona.clCuenta = Expediente.clCuenta ");
                StrSql.append(" AND cAfiliadoPersona.Clave = replace(Expediente.Clave,'-','') ");
                StrSql.append(" INNER JOIN ContratoxCuenta ON ContratoxCuenta.clCuenta = Expediente.clCuenta ");
                StrSql.append(" WHERE Expediente.clCuenta = ").append(clCuenta);
                StrSql.append(" AND Expediente.Clave = '").append(Clave).append("'");
                StrSql.append(" AND ContratoxCuenta.FechaIni <= CAST(getdate() as smalldatetime ) ");
                StrSql.append(" AND ContratoxCuenta.FechaFin >= CAST(getdate() as smalldatetime ) ");
                StrSql.append(" AND cAfiliadoPersona.FechaIni <= CAST(getdate() as smalldatetime ) ");
                StrSql.append(" AND cAfiliadoPersona.FechaFin >= CAST(getdate() as smalldatetime ) ");
                StrSql.append(" AND cAfiliadoPersona.clContrato = ContratoxCuenta.clContrato ");
                StrSql.append(" AND Expediente.clEstatus in(10,14,33,35,36,37) ");
                StrSql.append(" AND Expediente.clTipoServicio in(1,6) ");
            } else {
                StrSql.append(" Select count(*) Maximo ");
                StrSql.append(" From Expediente ");
                StrSql.append(" INNER JOIN ContratoxCuenta ON  ContratoxCuenta.clCuenta = Expediente.clCuenta ");
                StrSql.append(" WHERE Expediente.clCuenta =").append(clCuenta);
                StrSql.append("   AND Expediente.Clave = '").append(Clave).append("'");
                StrSql.append("   AND ContratoxCuenta.FechaIni <= CAST(getdate() as smalldatetime ) ");
                StrSql.append("   AND ContratoxCuenta.FechaFin >= CAST(getdate() as smalldatetime ) ");
                StrSql.append(" AND Expediente.clEstatus in(10,14,33,35,36,37) ");
                StrSql.append(" AND Expediente.clTipoServicio in(1,6) ");
            }
            //out.println(StrSql);
            ResultSet rs3 = UtileriasBDF.rsSQLNP(StrSql.toString());
            StrSql.delete(0, StrSql.length());
            if (rs3.next()) {
                StrBrindados = rs3.getString("Maximo");
            }
            rs3.close();
            rs3 = null;

        %>
        <%=MyUtil.ObjInput("Expediente", "ExpedienteVTR", rs.getString("clExpediente"), false, false, 25, 92, "", false, false, 12)%>
        <%=MyUtil.ObjInput("Fecha Apertura", "FechaApertura", rs.getString("FechaApertura"), false, false, 105, 92, "", true, true, 22)%>
        <%=MyUtil.ObjInput("Fecha Registro", "FechaRegistroVTR", rs.getString("FechaRegistro"), false, false, 235, 92, "", false, true, 22)%>
        <%=MyUtil.ObjInput("Fecha Siniestro<BR>AAAA/MM/DD HH:MM", "FechaSiniestro", rs.getString("FechaSiniestro"), true, false, 365, 80, "", true, true, 22, "if(this.readOnly==false){fnValMask(this,document.all.FechaSiniestroMsk.value,this.name)}")%>
        <% String strEstatus = rs.getString("dsEstatus");%>
        <%=MyUtil.ObjComboMem("Estatus", "clEstatus", strEstatus, rs.getString("clEstatus"), cbEstatus.GeneraHTML(50, strEstatus), false, false, 500, 92, "0", "", "", 50, false, false)%>
        <%=MyUtil.ObjComboC("Estatus Poliza GNP", "clEstatusPolizaGNP", rs.getString("dsEstatusPolizaGNP"), true, true, 850, 220, "", "Select clEstatusPolizaGNP,dsEstatusPolizaGNP from cEstatusPolizaGNP ", "", "", 30, false, false)%>
        <%=MyUtil.ObjInput("Quien Reporta", "Contacto", rs.getString("Contacto"), true, true, 25, 140, "", true, true, 40, "fnGNPInfo()")%>
        <div style='position:absolute; z-index:25; left:250px; top:158px;' name='DAstContacto' id='DAstContacto'><img alt="Campo Obligatorio para GNP" src="../Imagenes/AsteriscoGNP.gif" width="10" height="10" ></div> 
        <% String strdsTipoContactante = rs.getString("dsTipoContactante");
            String strclTipoContactante = rs.getString("clTipoContactante");
        %>
        <%=MyUtil.ObjComboMem("Tipo Quien Reporta", "clTipoContactante", strdsTipoContactante, strclTipoContactante, cbTipoContactante.GeneraHTML(50, strdsTipoContactante), true, true, 365, 140, "0", "", "", 50, false, false)%>
        <div style='position:absolute; z-index:25; left:520px; top:158px;' name='DAstclTipoContactante' id='DAstclTipoContactante'><img alt="Campo Obligatorio para GNP" src="../Imagenes/AsteriscoGNP.gif" width="10" height="10" ></div>     
        <%=MyUtil.ObjComboC("Tipo Servicio", "clTipoServicio", rs.getString("dsTipoServicio"), true, true, 630, 140, "", "sp_GetTipoServicio " + strclUsr, "", "", 50, true, true)%>
        
        <%=MyUtil.ObjInput("Código", "Lada1", rs.getString("Lada1"), true, true, 25, 180, "", false, false, 8)%>
        <div style='position:absolute; z-index:25; left:85px; top:198px;' name='DAstLada' id='DAstLada'><img alt="Campo Obligatorio para GNP" src="../Imagenes/AsteriscoGNP.gif" width="10" height="10" ></div> 
        <%=MyUtil.ObjInputKP("Telefono", "Telefono1", rs.getString("Telefono1"), true, true, 100, 180, "", false, false, 25, "VerificaNumerico(document.all.Telefono1);", "return acceptNum(event)")%>
        <div style='position:absolute; z-index:25; left:250px; top:198px;' name='DAstTelefono1' id='DAstTelefono1'><img alt="Campo Obligatorio para GNP" src="../Imagenes/AsteriscoGNP.gif" width="10" height="10" ></div>     
        <%=MyUtil.ObjInput("Código", "Lada2", rs.getString("Lada2"), true, true, 365, 180, "", false, false, 8)%>
        <%=MyUtil.ObjInput("Telefono Alterno", "Telefono2", rs.getString("Telefono2"), true, true, 430, 180, "", false, false, 25)%>
        <%=MyUtil.ObjInputKP("Email", "Email", rs.getString("Email"), true, true, 630, 180, "", false, false, 50, "validaCorreo();", "return acceptMail(event)")%>
        
        <%

            ResultSet rsPermisos = UtileriasBDF.rsSQLNP(" select sum(cast(DuplicarExpediente as int)) DuplicarExpediente, sum(cast(PermiteCobertura as int)) PermiteCobertura, " +
                    " sum(cast(PermiteCotizar as int)) PermiteCotizar, sum(cast(PermiteMarcarCita as int)) PermiteMarcarCita, sum(cast(PermiteSMS as int)) PermiteSMS " +
                    " from PermisoPartxGpoPag PP inner join UsrxGpo UxG on (PP.clGpoUsr = UxG.clGpoUsr) " +
                    " Where PP.clPaginaWeb = 155 and UxG.clUsrApp = " + strclUsr);
            if (rsPermisos.next()) {
                if (rsPermisos.getInt("DuplicarExpediente") > 0) {
        %>
        <input class='cBtn' type='button' value='Duplicar' onClick='location.href="../Operacion/DuplicaExp.jsp?clExpediente=<%=rs.getString("clExpediente")%>"'></input>
        <%
                        }
                        if (rsPermisos.getInt("PermiteCobertura") > 0) {
        %>
        <input class='cBtn' type='button' value='Cobertura' onClick="window.open('VistaCobertura.jsp?&clCuenta=<%=rs.getString("clCuenta")%>','','resizable=no,menubar=0,status=0,toolbar=0,height=450,width=1005,screenX=-50,screenY=0,scrollbars=yes')"></input>
        <%
                        }
                        if (rsPermisos.getInt("PermiteCotizar") > 0) {
        %>
        <input class='cBtn' type='button' value='Cotizar' onClick="window.open('MarcarCotizado.jsp?&clExpediente=<%=rs.getString("clExpediente")%>','','resizable=no,menubar=0,status=0,toolbar=0,height=450,width=800,screenX=-50,screenY=0')"></input>                    
        <%
                        }
                        if (rsPermisos.getInt("PermiteMarcarCita") > 0) {
        %>
        <input class='cBtn' type='button' value='Marcar Cita' onClick="window.open('MarcarCita.jsp?&clExpediente=<%=rs.getString("clExpediente")%>','','resizable=no,menubar=0,status=0,toolbar=0,height=450,width=800,screenX=-50,screenY=0')"></input>
        <%
                        }
                        if (rsPermisos.getInt("PermiteSMS") > 0) {
        %>
        <input class='cBtn' name="SMS" type='button' value='Enviar mensaje SMS' onclick="window.open('../SMS/SMSAsignacion.jsp','SMS','scrollbars=no,status=no,width=670,height=170');"></input>
        <script>document.all.SMS.disabled=true;</script>
        <%                }
            }
            rsPermisos.close();
            rsPermisos = null;

            if (clCuenta.equalsIgnoreCase("257") || clCuenta.equalsIgnoreCase("268") || clCuenta.equalsIgnoreCase("269") || clCuenta.equalsIgnoreCase("945")) {
                //session.setAttribute("StrDescrip",StrDescrip);
%>
        <input class='cBtn' type='button' value='Información ADT' onClick="window.open('InfoAdicional.jsp?Clave=<%=Clave%>','','resizable=no,menubar=0,status=0,toolbar=0,height=450,width=1005,screenX=-50,screenY=0')"></input>
        <%
            }
        %>
        
        <%=MyUtil.ObjTextArea("Descripción de lo Ocurrido", "DescripcionOcurrido", StrDescrip, "120", "4", true, true, 25, 225, "", false, false)%>
        <%=MyUtil.ObjInput("Cuenta", "Nombre", rs.getString("Nombre"), true, false, 25, 300, "", true, true, 40, "if(this.readOnly==false){fnBuscaCuenta();}")%>
        <INPUT id='clCuenta' name='clCuenta' type='hidden' value="<%=rs.getString("clCuenta")%>"></INPUT>
        <INPUT id='clDerechoHab' name='clDerechoHab' type='hidden' value="<%=rs.getString("clDerechoHab")%>"> 
        <%
            if (MyUtil.blnAccess[4] == true) {
        %><div class='VTable' style='position:absolute; z-index:25; left:250px; top:315px;'>
        <IMG SRC='../Imagenes/Lupa.gif' onClick='fnBuscaCuenta();' WIDTH=20 HEIGHT=20></div>
        <%            }
        %><%=MyUtil.ObjInput("Nuestro Usuario", "NuestroUsuario", rs.getString("NuestroUsuario"), true, true, 365, 300, "", true, true, 40, "if(this.readOnly==false){fnBuscaClienteVIP()}")%>
        <%
            if (MyUtil.blnAccess[4] == true) {
        %><div class='VTable' style='position:absolute; z-index:25; left:585px; top:315px;'>
        <IMG SRC='../Imagenes/Lupa.gif' onClick='fnBuscaAfiliado();' WIDTH=20 HEIGHT=20></div>
        <%            }

        %><%=MyUtil.ObjInput("Clave", "Clave", rs.getString("Clave"), true, false, 630, 300, "", true, true, 30, "if(this.readOnly==false){if (fnValMask(this,document.all.ClaveMsk.value,this.name)){fnBuscaClave();}}")%>
        <div style='position:absolute; z-index:25; left:800px; top:318px;' name='DAstClave' id='DAstClave'><img alt="Campo Obligatorio para GNP" src="../Imagenes/AsteriscoGNP.gif" width="10" height="10" ></div>     
        <%=MyUtil.ObjInput("Agente", "Agente", rs.getString("Agente"), true, false, 800, 300, "", false, false, 10, "if(this.readOnly==false){fnValMask(this,document.all.AgenteMsk.value,this.name)}")%>
        <%
            if (rs.getString("Agente").compareToIgnoreCase("") == 0) {
        %><script>document.all.D21.style.visibility='hidden'</script>
        <%            }
        %><%=MyUtil.ObjComboC("Tipo de Beneficiario", "clTipoBeneficiario", rs.getString("dsTipoBeneficiario"), true, true, 660, 220, "0", "Select clTipoBeneficiario, dsTipoBeneficiario from cTipoBeneficiario", "", "", 50, true, true)%>
        <%=MyUtil.ObjInput("Servicios Brindados", "ServBrinVTR", StrBrindados, false, false, 660, 260, "", false, false, 10)%>
        <%

            if (rs.getString("PermiteEnvioACobro").equalsIgnoreCase("1")) {
                if (!strclEstatus.equalsIgnoreCase("10")) {
        %><%=MyUtil.ObjChkBox("Se Manda Cobro", "SeMandaCobro", rs.getString("SeMandaCobro"), false, true, 800, 92, "0", "ENVIAR", "NO ENVIAR", "")%>
        <%
                        } else {
        %><%=MyUtil.ObjChkBox("Se Manda Cobro", "SeMandaCobro", rs.getString("SeMandaCobro"), false, false, 800, 92, "0", "ENVIAR", "NO ENVIAR", "")%>
        <%
                }
            }
        %><%=MyUtil.DoBlock("Datos Generales", -40, -5)%>
        <%
            String CodEnt = "";
            CodEnt = rs.getString("CodEnt");
            session.setAttribute("CodEnt", CodEnt);

            String dsEntFed = "";
            dsEntFed = rs.getString("dsEntFed");
            session.setAttribute("dsEntFed", dsEntFed);

            String dsMunDel = "";
            dsMunDel = rs.getString("dsMunDel");
            session.setAttribute("dsMunDel", dsMunDel);

        %>
        <% String strdsPais = rs.getString("dsPais");
            String strclPais = rs.getString("clPais");
        %>
        <%=MyUtil.ObjComboMem("Pais", "clPais", strdsPais, strclPais, cbPais.GeneraHTML(20, strdsPais), true, true, 25, 385, "0", "", "", 20, false, false)%>
        <%=MyUtil.ObjInput("Ciudad", "CiudadExt", rs.getString("CiudadExt"), true, true, 250, 385, "", false, false, 50)%>
        
        <% // MyUtil.ObjComboC("Entidad Federativa","CodEnt",rs.getString("dsEntFed"),true,true,25,425,"","Select CodEnt,dsEntFed from cEntFed order by dsEntFed","fnLlenaMunicipiosExp()","",20,false,false)%>
        
        <%
            String StrCodMD = rs.getString("CodMD");
            session.setAttribute("CodMD", StrCodMD);
        %>
        <%=MyUtil.ObjComboMem(i18n.getMessage("message.title.entidad"), "CodEnt", dsEntFed, CodEnt, cbEntidad.GeneraHTML(20, dsEntFed), true, true, 25, 425, "", "fnLlenaMunicipiosExp()", "", 20, false, false)%>                
        <div style='position:absolute; z-index:25; left:200px; top:443px;' name='DAstCodEnt' id='DAstCodEnt'><img alt="Campo Obligatorio para GNP" src="../Imagenes/AsteriscoGNP.gif" width="10" height="10" ></div>     
        <%=MyUtil.ObjComboMem(i18n.getMessage("message.title.municipio"), "CodMD", dsMunDel, StrCodMD, cbEntidad.GeneraHTMLMD(30, CodEnt, dsMunDel), true, true, 250, 425, "", "", "", 20, false, false)%>
        <div style='position:absolute; z-index:25; left:520px; top:443px;' name='DAstCodMD' id='DAstCodMD'><img alt="Campo Obligatorio para GNP" src="../Imagenes/AsteriscoGNP.gif" width="10" height="10" ></div>     
        <%=MyUtil.DoBlock("Ubicación", 100, 0)%>
        
        <%=MyUtil.ObjChkBox("Cita", "CitaVTR", rs.getString("Cita"), false, false, 580, 385, "0", "")%>
        <%=MyUtil.ObjInput("Fecha Cita<br>aaaa/mm/dd hh:mm", "FechaCitaVTR", rs.getString("FechaCita"), false, false, 680, 385, "", false, false, 25)%>
        <%=MyUtil.DoBlock("Programación de Cita", 0, 20)%>
        
        <%=MyUtil.ObjChkBox("Cotizacion", "CotizacionVTR", rs.getString("Cotizacion"), false, false, 650, 515, "0", "")%>
        <%=MyUtil.DoBlock("Cotización", 0, 0)%>
        
        <%=MyUtil.ObjInput("Usuario que Registró el Servicio ", "UsrReg", rs.getString("UsrReg"), false, false, 25, 515, "", false, false, 60)%>
        <%=MyUtil.ObjInput("Usuario que Autorizó el Servicio ", "UsrAut", rs.getString("UsrAut"), false, false, 25, 555, "", false, false, 60)%>
        <%=MyUtil.ObjInput("Fecha de Autorización", "FecAut", rs.getString("FechaAut"), false, false, 370, 555, "", false, false, 30)%>
        <%=MyUtil.ObjTextArea("Motivo de Autorización", "Mot", rs.getString("MotivoAut"), "80", "3", false, false, 25, 595, "", false, false)%>
        <%=MyUtil.DoBlock("Seguridad", 50, 30)%>
        <%

            clCuenta = null;
            Clave = null;
            StrDescrip = null;
            strclTipoContactante = null;
            strdsTipoContactante = null;
            CodEnt = null;
            dsEntFed = null;
            dsMunDel = null;
            strdsPais = null;
            strclPais = null;
            StrCodMD = null;

        } else {
            //out.println("Else");
%><INPUT id='clExpediente' name='clExpediente' type='hidden' value=''>
        <INPUT id='clUsrApp' name='clUsrApp' type='hidden' value='<%=session.getAttribute("clUsrApp")%>'>
        
        <%=MyUtil.ObjInput("Expediente", "ExpedienteVTR", "", false, false, 25, 92, "", false, false, 12)%>
        <%=MyUtil.ObjInput("Fecha Apertura", "FechaApertura", "", false, false, 105, 92, "", true, true, 22)%>
        <%=MyUtil.ObjInput("Fecha Registro", "FechaRegistroVTR", "", false, false, 235, 92, "", false, true, 22)%>
        <%=MyUtil.ObjInput("Fecha Siniestro<BR>AAAA/MM/DD HH:MM", "FechaSiniestro", "", true, false, 365, 80, "", true, true, 22, "if(this.readOnly==false){fnValMask(this,document.all.FechaSiniestroMsk.value,this.name)}")%>
        <%=MyUtil.ObjComboMem("Estatus", "clEstatus", "", "", cbEstatus.GeneraHTML(50, ""), false, false, 500, 92, "0", "", "", 50, false, false)%>
        <%=MyUtil.ObjComboC("Estatus Poliza GNP", "clEstatusPolizaGNP", "", true, true, 850, 220, "", "Select clEstatusPolizaGNP,dsEstatusPolizaGNP from cEstatusPolizaGNP", "", "", 30, false, false)%>
        
        <%=MyUtil.ObjInput("Quien Reporta", "Contacto", "", true, true, 25, 140, "", true, true, 40, "if(this.readOnly==false){fnActualizaNU();fnBuscaClienteVIP()};")%>
        <div style='position:absolute; z-index:25; left:250px; top:158px;' name='DAstContacto' id='DAstContacto'><img alt="Campo Obligatorio para GNP" src="../Imagenes/AsteriscoGNP.gif" width="10" height="10" ></div> 
        <%=MyUtil.ObjComboMem("Tipo Quien Reporta", "clTipoContactante", "", "", cbTipoContactante.GeneraHTML(50, ""), true, true, 365, 140, "0", "", "", 50, false, false)%>
        <div style='position:absolute; z-index:25; left:520px; top:158px;' name='DAstclTipoContactante' id='DAstclTipoContactante'><img alt="Campo Obligatorio para GNP" src="../Imagenes/AsteriscoGNP.gif" width="10" height="10" ></div>     
        <%=MyUtil.ObjComboC("Tipo Servicio", "clTipoServicio", "", true, true, 630, 140, "", "sp_GetTipoServicio " + strclUsr, "", "", 50, true, true)%>
        
        <%=MyUtil.ObjInput("Código", "Lada1", "", true, true, 25, 180, "", false, false, 8)%>
        <div style='position:absolute; z-index:25; left:85px; top:198px;' name='DAstLada' id='DAstLada'><img alt="Campo Obligatorio para GNP" src="../Imagenes/AsteriscoGNP.gif" width="10" height="10" ></div> 
        
        <%=MyUtil.ObjInputKP("Telefono", "Telefono1", "", true, true, 100, 180, "", false, false, 25, "VerificaNumerico(document.all.Telefono1);", "return acceptNum(event)")%>
        <div style='position:absolute; z-index:25; left:250px; top:198px;' name='DAstTelefono1' id='DAstTelefono1'><img alt="Campo Obligatorio para GNP" src="../Imagenes/AsteriscoGNP.gif" width="10" height="10" ></div>     
        <%=MyUtil.ObjInput("Código ", "Lada2", "", true, true, 365, 180, "", false, false, 8)%>
        <%=MyUtil.ObjInput("Telefono Alterno", "Telefono2", "", true, true, 430, 180, "", false, false, 25)%>
        <%=MyUtil.ObjInputKP("Email", "Email", "", true, true, 630, 180, "", false, false, 50, "validaCorreo();", "return acceptMail(event)")%>
        <%=MyUtil.ObjTextArea("Descripción de lo Ocurrido", "DescripcionOcurrido", "", "120", "4", true, true, 25, 225, "", false, false)%>
        
        <%=MyUtil.ObjInput("Cuenta", "Nombre", "", true, false, 25, 300, "", true, true, 40, "if(this.readOnly==false){fnBuscaCuenta();}")%>
        <INPUT id='clCuenta' name='clCuenta' type='hidden' value=''></INPUT>
        <INPUT id='clDerechoHab' name='clDerechoHab' type='hidden' value=''>
        <%
            if (MyUtil.blnAccess[4] == true) {
        %><div class='VTable' style='position:absolute; z-index:25; left:250px; top:315px;'>
        <IMG SRC='../Imagenes/Lupa.gif' onClick='fnBuscaCuenta();' WIDTH=20 HEIGHT=20></div>
        <%            }
        %><%=MyUtil.ObjInput("Nuestro Usuario", "NuestroUsuario", "", true, true, 365, 300, "", true, true, 40, "if(this.readOnly==false){fnBuscaClienteVIP()}")%>
        <% if (MyUtil.blnAccess[4] == true) {%>
        <div class='VTable' style='position:absolute; z-index:25; left:585px; top:315px;'>
        <IMG SRC='../Imagenes/Lupa.gif' onClick='fnBuscaAfiliado();' WIDTH=20 HEIGHT=20></div>
        <% }%>
        
        <%=MyUtil.ObjInput("Clave", "Clave", "", true, false, 630, 300, "", true, true, 30, "if(this.readOnly==false){if (fnValMask(this,document.all.ClaveMsk.value,this.name)){fnBuscaClave();}}")%>
        <div style='position:absolute; z-index:25; left:800px; top:318px;' name='DAstClave' id='DAstClave'><img alt="Campo Obligatorio para GNP" src="../Imagenes/AsteriscoGNP.gif" width="10" height="10" ></div>     
        <%=MyUtil.ObjInput("Agente", "Agente", "", true, false, 800, 300, "", false, false, 10, "if(this.readOnly==false){fnValMask(this,document.all.AgenteMsk.value,this.name)}")%>
        <%=MyUtil.ObjComboC("Tipo de Beneficiario", "clTipoBeneficiario", "", true, true, 660, 220, "", "Select clTipoBeneficiario, dsTipoBeneficiario from cTipoBeneficiario", "", "", 50, true, true)%>
        <%=MyUtil.DoBlock("Datos Generales", -60, -5)%>
        
        <%=MyUtil.ObjComboMem("Pais", "clPais", "", "", cbPais.GeneraHTML(20, ""), true, true, 25, 385, "0", "", "", 20, false, false)%>
        <%=MyUtil.ObjInput("Ciudad", "CiudadExt", "", true, true, 250, 385, "", false, false, 50)%>
        <%=MyUtil.ObjComboMem(i18n.getMessage("message.title.entidad"), "CodEnt", "", "", cbEntidad.GeneraHTML(20, ""), true, true, 25, 425, "", "fnLlenaMunicipiosExp()", "", 20, false, false)%>
        <div style='position:absolute; z-index:25; left:200px; top:443px;' name='DAstCodEnt' id='DAstCodEnt'><img alt="Campo Obligatorio para GNP" src="../Imagenes/AsteriscoGNP.gif" width="10" height="10" ></div>     
        <%=MyUtil.ObjComboMem(i18n.getMessage("message.title.municipio"), "CodMD", "", "", cbEntidad.GeneraHTMLMD(30, "", ""), true, true, 250, 425, "", "", "", 20, false, false)%>
        <div style='position:absolute; z-index:25; left:520px; top:443px;' name='DAstCodMD' id='DAstCodMD'><img alt="Campo Obligatorio para GNP" src="../Imagenes/AsteriscoGNP.gif" width="10" height="10" ></div>
        <%=MyUtil.DoBlock("Ubicación", 100, 30)%>
        
        <%=MyUtil.ObjChkBox("Cita", "CitaVTR", "", false, false, 580, 385, "0", "")%>
        <%=MyUtil.ObjInput("Fecha Cita<br>aaaa/mm/dd hh:mm", "FechaCitaVTR", "", false, false, 680, 385, "", false, false, 25)%>
        <%=MyUtil.DoBlock("Programación de Cita", 50, 0)%>
        
        <%
            }
        %>
        <%
            ResultSet rsSMS1 = UtileriasBDF.rsSQLNP("st_SMSValidaEnvioAsigancion " + StrclExpediente);
            if (rsSMS1.next()) {
                if (rsSMS1.getString("Enviar").equalsIgnoreCase("1")) {
        %>
        <script>document.all.SMS.disabled=false;</script>
        <%}
            }
            rsSMS1.close();
            rsSMS1 = null;

            rs.close();
            rs = null;
            StrSql = null;
            StrclExpediente = null;
            strclUsr = null;
            strclTipoVal = null;
            strclTipoValida = null;
            StrPrefijo = null;
            StrBrindados = null;
            strclUsr2 = null;
            strclEstatus = null;

        %><%=MyUtil.GeneraScripts()%> 
        
        <div class='FTable' style='position:absolute; z-index:30; left:410px; top:120px;'>
        <p class='FTable' readonly name='ClaveMskUsr' id='ClaveMskUsr'></p></div>
        <input id='clUsrAppAut' type='hidden' name='clUsrAppAut'></input>
        <input id='MotivoAut' type='hidden' name='MotivoAut'></input>
        
        <input name='ClaveMsk' id='ClaveMsk' type='hidden' value=''>
        <input name='FechaSiniestroMsk' id='FechaSiniestroMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
        <input name='AgenteMsk' id='AgenteMsk' type='hidden' value='VN09VN09VN09VN09'>
        
        <script>
            top.document.all.DatosExpediente.contentWindow.location.reload();
            top.document.all.rightPO.rows="70,*";
            document.all.Email.maxLength=100;

            function actualizar()
            {
                location.reload();
            }

            /*function fnLlenaServicio(){  
                var strConsulta = "sp_GetServicio '" + document.all.clUsrApp2.value + "'";
                var pstrCadena = "../servlet/Utilerias.LlenaCombos?strSQL=" + strConsulta;
                document.all.clTipoServicio.value = '';
                pstrCadena = pstrCadena + "&strName=clTipoServicioC";		
                fnOptionxDefault('clTipoServicioC',pstrCadena);
        }*/

            function fnActualizaNU(){
                if (document.all.NuestroUsuario.value==''){
                    document.all.NuestroUsuario.value = document.all.Contacto.value;
                }
            }
        
            function fnBuscaClienteVIP(){
                if (document.all.NuestroUsuario.value!=''){
                    var pstrCadena = "BuscaClienteVIP.jsp?strSQL=sp_BuscaClienteVIP";
                    pstrCadena = pstrCadena + "&Nombre=" + document.all.NuestroUsuario.value;
                    window.open(pstrCadena,'newVIP','scrollbars=yes,status=yes,width=640,height=300');
                }
            }

            function fnValidaPaisEF(){
                if (document.all.clPais.value=='' && document.all.CodEnt.value==''){
                    msgVal="Debe informar país o Entidad Federativa";
                    document.all.btnGuarda.disabled=false;
                    document.all.btnCancela.disabled=false;
                }
                if (document.all.CodEnt.value!='' && document.all.CodMD.value==''){
                    msgVal="Si informa Entidad Federativa bebe informar Municipio / Delegación";
                    document.all.btnGuarda.disabled=false;
                    document.all.btnCancela.disabled=false;
                }
            }
            function fnSubmitOK(pclUsr, pMotivo){
                document.all.clUsrAppAut.value=pclUsr;
                document.all.MotivoAut.value=pMotivo;
                document.all.forma.action = "../servlet/Utilerias.EjecutaAccion";
                document.all.forma.submit();
            }

            function fnAccionesAlta(){
                document.all.clUsrApp.value=<%=session.getAttribute("clUsrApp")%>;
                top.document.all.rightPO.rows="0,*";
                document.all.forma.action = "../servlet/Utilerias.ValidaCondNU";
                if (document.all.Action.value==1){
                    document.all.CodMD.value = "";
                    document.all.CodEnt.value = "";
                    document.all.clCuenta.value="";
       
                    var pstrCadena = "../Utilerias/RegresaFechaActual.jsp";
                    window.open(pstrCadena,'newWin','width=10,height=10,left=1500,top=2000');
       
                }
            }

            function fnActualizaFechaActual(pFecha){
                document.all.FechaApertura.value = pFecha;			
                document.all.FechaSiniestro.value = pFecha;			
            }


            function fnBuscaCuenta(){
                if (document.all.Nombre.value!=''){
                    if (document.all.Action.value==1){
                        var pstrCadena = "../Utilerias/FiltrosCuenta.jsp?strSQL=sp_WebBuscaCuenta ";
                        pstrCadena = pstrCadena + "&Cuenta= " + document.all.Nombre.value;
                        document.all.clCuenta.value='';
                        window.open(pstrCadena,'newWin','scrollbars=yes,status=yes,width=700,height=500');
                    } 
                }
            }

            function fnBuscaClave(){
                //        if (document.all.NuestroUsuario.value==''){
                var pstrCadena;
                if (document.all.Nombre.value!=''){
                    if (document.all.Action.value==1){
                        pstrCadena = "../Utilerias/FiltrosClave.jsp?strSQL=sp_WebBuscaClaveGpo ";
                        pstrCadena = pstrCadena + "&Clave= " + document.all.Clave.value + "&clCuenta= " + document.all.clCuenta.value;

                        //pstrCadena = pstrCadena + "&clCuenta= " + document.all.clCuenta.value;
                        //document.all.Nombre.value='';
                        window.open(pstrCadena,'newWin','scrollbars=yes,status=yes,width=500,height=500');
                    }
                } else {
                    if (document.all.Action.value==1){
                        pstrCadena = "../Utilerias/FiltrosClave.jsp?strSQL=sp_WebBuscaClave ";
                        pstrCadena = pstrCadena + "&Clave= " + document.all.Clave.value;
                        //document.all.Nombre.value='';
                        window.open(pstrCadena,'newWin2','scrollbars=yes,status=yes,width=500,height=500');
                    }
                }
                //        } //Fin del if NuestroUsuario
            }

            function fnActualizaDatosClave(clCuenta,Nombre,Prefijo){
                document.all.Nombre .value = Nombre;			
                document.all.clCuenta.value = clCuenta;
                document.all.Clave.value = Prefijo;
                fnGNPEstatus();//Estatus Poliza GNP
        
            }

            function fnActualizaDatosCuenta(dsCuenta,clCuenta,clTipoVal, Msk, MskUsr, Agentes){
                document.all.Nombre .value = dsCuenta;			
                document.all.clCuenta.value = clCuenta;
                document.all.ClaveMsk.value = Msk;
                document.all.ClaveMskUsr.innerHTML = MskUsr;
                strclTipoVal=clTipoVal;
                if (Agentes>0){
                    document.all.D21.style.visibility='visible';
                }else{
                    document.all.D21.style.visibility='hidden';
                }
                fnGNPEstatus();//Estatus Poliza GNP
                fnGNPInfo();//Campos Obligatorios para GNP
            }


            function fnActualizaDatosNuestroUsr(dsNU,Clave, pclCuenta, pNomCuenta, Msk, MskUsr, DatosNUsr, ClaveBeneficiario){
                document.all.NuestroUsuario.value = dsNU;			
                document.all.Clave.value = Clave;
                document.all.clCuenta.value = pclCuenta;
                document.all.Nombre.value = pNomCuenta;
                document.all.ClaveMsk.value = Msk;
                document.all.ClaveMskUsr.innerHTML = MskUsr;
                document.all.DescripcionOcurrido.value= document.all.DescripcionOcurrido.value + DatosNUsr;
                document.all.clDerechoHab.value=ClaveBeneficiario;
                fnGNPEstatus();//Estatus Poliza GNP
  
            }

            TimeFillMD=5;

            function fnActualizaDatosNuestroUsrADT(dsNU,Clave, pclCuenta, pNomCuenta, Msk, MskUsr, pTel1, pDes, pEnt){
                document.all.NuestroUsuario.value = dsNU;                           
                document.all.Clave.value = Clave;
                document.all.clCuenta.value = pclCuenta;
                document.all.Nombre.value = pNomCuenta;
                document.all.ClaveMsk.value = Msk;
                document.all.ClaveMskUsr.innerHTML = MskUsr;
                document.all.Telefono1.value= pTel1;
                document.all.DescripcionOcurrido.value = pDes;
                document.all.CodEntC.value = pEnt;
                document.all.CodEnt.value=pEnt;
                fnLlenaMunicipiosExp(); // ver referencia en UtilDireccion?
                fnGNPEstatus();//Estatus Poliza GNP
            }

            function fnValidaClave(clave){
                if (document.all.Action.value==1){
                    var pstrCadena = "../Operacion/ValidaClave.jsp?strSQL=sp_ValidaClave ";
                    pstrCadena = pstrCadena + "&Clave= " + document.all.Clave.value;
                    window.open(pstrCadena,'newWin','scrollbars=yes,status=yes,width=700,height=500');
                } 
            }

            function fnBuscaAfiliado(){
                if (document.all.Action.value==1){
                    //if(document.all.clCuenta.value!=""){
                    var pstrCadena = "../Utilerias/FiltrosNuestroUsr.jsp?strSQL=sp_WebBuscaNuestroUsr ";
                    pstrCadena = pstrCadena + "&Clave= " + document.all.Clave.value + "&clCuenta= " + document.all.clCuenta.value;
                    alert(pstrCadena);
                    window.open(pstrCadena,'newWinBA','scrollbars=yes,status=yes,width=1200,height=500,top=200,left=50');
                    /*	 }else{
           alert('Debe informar primero la cuenta');
         }*/
                } 
            }

            function fnGNPInfo(){
                if (document.all.clCuenta.value == "1213" || document.all.clCuenta.value == "1215" || document.all.clCuenta.value == "1217" || document.all.clCuenta.value == "1218" ){
                    document.all.D8.style.visibility="visible";
                }else{
                    document.all.D8.style.visibility="hidden";
                }
        
                if  (document.all.clCuenta.value=="113") {
                    fnDivshow("DAstContacto");
                    fnDivshow("DAstclTipoContactante");
                    fnDivshow("DAstLada");
                    fnDivshow("DAstTelefono1");
                    fnDivshow("DAstClave");
                    fnDivshow("DAstCodEnt");
                    fnDivshow("DAstCodMD");
                    if (document.all.Action.value=="1"){
                        document.all.clTipoServicioC.value="1";
                        document.all.clTipoServicio.value="1";
                        document.all.clTipoBeneficiarioC.value="1";
                        document.all.clTipoBeneficiario.value="1";}            
                }    
                else {
                    fnDivhide("DAstContacto");
                    fnDivhide("DAstclTipoContactante");
                    fnDivhide("DAstLada");
                    fnDivhide("DAstTelefono1");
                    fnDivhide("DAstClave");
                    fnDivhide("DAstCodEnt");
                    fnDivhide("DAstCodMD");
                }
            }
    
            function fnGNPInfoObli(){

                if  (document.all.clCuenta.value=="113"){
                    if (document.all.Contacto.value=="")  msgVal=msgVal + ". Quién Reporta. "
                    if (document.all.clTipoContactanteC.value=="") msgVal=msgVal + ". Tipo Quién Reporta. "
                    if (document.all.Lada1.value=="") msgVal=msgVal + ". Lada. "
                    if (document.all.Telefono1.value=="") msgVal=msgVal + ". Teléfono SMS. "
                    if (document.all.Clave.value=="") msgVal=msgVal + ". Clave. "
                    if (document.all.CodEntC.value=="") msgVal=msgVal + ". Entidad Federativa. "
                    if (document.all.CodMDC.value=="") msgVal=msgVal + ". Municipio/Delegación. "
                    document.all.btnGuarda.disabled=false;
                    document.all.btnCancela.disabled=false;
                }    
            }
    
            function fnDivhide(i) {
                if (document.all) {
                    var ourhelp = eval ("document.all."+ i)
                    ourhelp.style.visibility="hidden";
                }
            }

            function fnDivshow(i)
            {
                if (document.all) {
                    var ourhelp = eval ("document.all."+ i)
                    ourhelp.style.visibility="visible";
                }
            }
    
            function fnGNPEstatus(){
                if (document.all.clCuenta.value == "1213" || document.all.clCuenta.value == "1215" || document.all.clCuenta.value == "1217" || document.all.clCuenta.value == "1218" ){
                    document.all.D8.style.visibility="visible";
                }else{
                    document.all.D8.style.visibility="hidden";
                    //document.all.clEstatusPolizaGNP.value="";
                    document.all.clEstatusPolizaGNPC.value="";
                }
            }
    
            function fnGNPEstatusObli(){
                if (document.all.clCuenta.value == "1213" || document.all.clCuenta.value == "1215" || document.all.clCuenta.value == "1217" || document.all.clCuenta.value == "1218" ){
                    if (document.all.clEstatusPolizaGNPC.value=="")  msgVal = msgVal + " Estatus Poliza GNP. "
                    document.all.btnGuarda.disabled=false;
                    document.all.btnCancela.disabled=false;
                }
            }   
    
            function fnVaciarFechaCita() {
                if (document.all.FechaCitaVTR.value=="1900-01-01 00:00:00") {document.all.FechaCitaVTR.value=""}
            }    
     
            var nav4 = window.Event ? true : false;
            function acceptNum(evt)
            { 
                // NOTE: Backspace = 8, Enter = 13, '0' = 48, '9' = 57   
                var key = nav4 ? evt.which : evt.keyCode; 
                return (key <= 13 || (key >= 48 && key <= 57));
            }

            var Mail = window.Event ? true : false;
            function acceptMail(evt)
            { 
                // NOTE: Backspace = 8, Enter = 13, '0' = 48, '9' = 57   
                var key = Mail ? evt.which : evt.keyCode; 
                return (key <= 13 || key == 64 || key == 45 || key == 46 || key == 95 || (key >= 48 && key <= 57) || (key >= 65 && key <= 90)  || (key >= 97 && key <= 122));
            }
   
            function validaCorreoAntesGuardar()
            {
                var Cadena
                var PosArroba
                var usuario
                var dominio
                if (document.all.Email.value!='')
                {
                    if(document.all.Email.value.indexOf('@', 0) == -1)
                    {
                        msgVal = msgVal + " La dirección de correo no es valida."
                    }
                    else
                    {
                        PosArroba = document.all.Email.value.lastIndexOf('@')
                        usuario=document.all.Email.value.substring(0,PosArroba)
                        dominio=document.all.Email.value.substring(PosArroba+1,Cadena)
      
                        if (usuario == '' || dominio=='')
                        {
                            msgVal = msgVal + " La dirección de correo no es valida."
                        }

                        //Valida el nombre de usuario y verifica que no existan dos @       
                        if(usuario.indexOf('@', 0) != -1)
                        {
                            msgVal = msgVal + " La dirección de correo no es valida."
                        }

                        //valida el dominio
                        if(dominio.indexOf('.', 0) == -1 || dominio.indexOf('@', 0) != -1)
                        {
                            msgVal = msgVal + " La dirección de correo no es valida."
                        }
                        document.all.btnGuarda.disabled = false;
                        document.all.btnCancela.disabled = false;
 
                        //alert(usuario + "," + dominio)
                    }
                }
            }
    
            function validaCorreo()
            {
                var Cadena
                var PosArroba
                var usuario
                var dominio
                if (document.all.Email.value!='')
                {
                    if(document.all.Email.value.indexOf('@', 0) == -1)
                    {
                        alert("La dirección de correo no es valida.");
                    }
                    else
                    {
                        PosArroba = document.all.Email.value.lastIndexOf('@')
                        usuario=document.all.Email.value.substring(0,PosArroba)
                        dominio=document.all.Email.value.substring(PosArroba+1,Cadena)
      
                        if (usuario == '' || dominio=='')
                        {
                            alert("La dirección de correo no es valida.");
                        }

                        //Valida el nombre de usuario y verifica que no existan dos @       
                        if(usuario.indexOf('@', 0) != -1)
                        {
                            alert("La dirección de correo no es valida.");
                        }

                        //valida el dominio
                        if(dominio.indexOf('.', 0) == -1 || dominio.indexOf('@', 0) != -1)
                        {
                            alert("La dirección de correo no es valida.");
                        }
        
                        //alert(usuario + "," + dominio)
                    }
                }
            }

            function VerificaNumerico(Campo){ 
                if (isNaN(Campo.value)==true)
                {
                    alert(Campo.name + ' Debe ser numérico');
                    Campo.focus();
                } 
            } 
    
        </script>
    </body>
</html>