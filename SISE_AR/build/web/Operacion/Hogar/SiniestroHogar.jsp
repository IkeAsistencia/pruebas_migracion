<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Seguridad.SeguridadC,Utilerias.UtileriasBDF" errorPage="" %>
<html>
    <head>
        <title></title>
    </head>
    <body class="cssBody">
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
        <script src='../../Utilerias/Util.js'></script>
        <script src='../../Utilerias/UtilMask.js'></script>
        <%
            com.ike.util.I18N i18n = com.ike.util.I18N.getInstance("es", "AR");

            String StrclExpediente = "0";
            String strclUsr = "";
            String strclCuenta = "";
            String strClave = "";



            if (session.getAttribute("clUsrApp") != null) {
                strclUsr = session.getAttribute("clUsrApp").toString();
            }

            if (session.getAttribute("clExpediente") != null) {
                StrclExpediente = session.getAttribute("clExpediente").toString();
            }

            if (session.getAttribute("clCuenta") != null) {
                strclCuenta = session.getAttribute("clCuenta").toString();
            }

            if (session.getAttribute("Clave") != null) {
                strClave = session.getAttribute("Clave").toString();
            }

            StringBuffer StrSql = new StringBuffer();

        // checar si ya existe asistencia para el expediente, si existe, ya no procede la alta
            StrSql.append("Select exped.TieneAsistencia ");
            StrSql.append(" From Expediente EXPED");
            StrSql.append(" Where clExpediente=").append(StrclExpediente);

            //ResultSet rs2 = UtileriasBDF.rsSQL(StrSql);     
            ResultSet rs2 = UtileriasBDF.rsSQLNP(StrSql.toString());
            StrSql.delete(0, StrSql.length());

            if (rs2.next()) {
                StrSql.append("Select SH.clExpediente as clExpediente, ");
                StrSql.append(" coalesce(GC.dsGpoCob,'') as dsGpoCob,");
                StrSql.append(" coalesce(convert(varchar(10),SH.FechaSiniestro,120),'') as FechaSiniestro,");
                StrSql.append(" coalesce(SH.Observaciones,'') as Observaciones,");
                StrSql.append(" coalesce(SH.ImporteEstimado,0) as ImporteEstimado,");
                StrSql.append(" coalesce(TME.dsTipoMoneda,'') as dsTipoMonedaEst,");
                StrSql.append(" coalesce(TA.dsTipoAjustador,'') as dsTipoAjustador,");
                StrSql.append(" coalesce(A.Nombre,'') as Nombre,");
                StrSql.append(" coalesce(convert(varchar(16),SH.FechaAsigAjustador,120),'') as FechaAsigAjustador,");
                StrSql.append(" coalesce(convert(varchar(16),SH.FechaCitaAsegurado,120),'') as FechaCitaAsegurado,");
                StrSql.append(" coalesce(convert(varchar(16),SH.FechaEntInforme,120),'') as FechaEntInforme,");
                StrSql.append(" coalesce(convert(varchar(16),SH.FechaContactoAfil,120),'') as FechaContactoAfil,");
                StrSql.append(" coalesce(SH.ObservAjustador,'') as ObservAjustador,");
                StrSql.append(" coalesce(SH.ImporteReservado,0) as ImporteReservado,");
                StrSql.append(" coalesce(TMR.dsTipoMoneda,'') as dsTipoMonedaRes,");
                StrSql.append(" coalesce(SH.Colonia,'') as Colonia,");
                StrSql.append(" coalesce(SH.Calle,'') as Calle,");
                StrSql.append(" coalesce(SH.ReqPeritaje,0) as ReqPeritaje,");
                StrSql.append(" coalesce(BX.dsRespInfoDictHS,'') as dsRespInfoDictHSBX,");
                StrSql.append(" coalesce(SH.NomAutoriza,'') as NomAutoriza,");
                StrSql.append(" coalesce(ED.dsEmpresaDic,'') as dsEmpresaDic,");
                StrSql.append(" coalesce(DP.dsRespInfoDictHS,'') as dsRespInfoDictHSDP,");
                StrSql.append(" coalesce(FC.dsRespInfoDictHS,'') as dsRespInfoDictHSFC,");
                StrSql.append(" coalesce(SCE.dsRespInfoDictHS,'') as dsRespInfoDictHSCE");
                StrSql.append(" From AsistenciaSiniestro SH");
                StrSql.append(" Inner join cTipoAjustador TA on (TA.clTipoAjustador=SH.clTipoAjustador)");
                StrSql.append(" Inner join cAjustador A on (A.clAjustador=SH.clAjustador)");
                StrSql.append(" Inner join cTipoMoneda TME on (SH.MonedaEstimado=TME.clTipoMoneda)");
                StrSql.append(" Inner join cTipoMoneda TMR on (SH.MonedaReserva=TMR.clTipoMoneda)");
                StrSql.append(" left join CobxExpediente CE on (SH.clExpediente=CE.clExpediente)");
                StrSql.append(" left join cGpoCobertura GC on (CE.clGpoCob=GC.clGpoCob)");
                StrSql.append(" left join cRespInfoDictHS BX on (BX.clRespInfoDictHS=SH.AutDanioBanamex)");
                StrSql.append(" left join cEmpresaDictamen ED on (SH.QuienDictamina=ED.clEmpresaDic)");
                StrSql.append(" left join cRespInfoDictHS DP on (DP.clRespInfoDictHS=SH.DeterPerdida)");
                StrSql.append(" left join cRespInfoDictHS FC on (FC.clRespInfoDictHS=SH.FirmaConform)");
                StrSql.append(" left join cRespInfoDictHS SCE on (SCE.clRespInfoDictHS=SH.ChequeExped)");
                StrSql.append(" Where SH.clExpediente= ").append(StrclExpediente);
    } else {%>
        El expediente no existe
        <%
                return;
            }

            String StrclPaginaWeb = "378";
            session.setAttribute("clPaginaWebP", StrclPaginaWeb);
        %>
        <SCRIPT>fnOpenLinks()</script>
            <%
                //ResultSet rs = UtileriasBDF.rsSQL(StrSql);
                ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
                StrSql.delete(0, StrSql.length());

                MyUtil.InicializaParametrosC(378, Integer.parseInt(strclUsr));
            %>
            <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist", "", "")%>
            <%
                if (rs2.getString("TieneAsistencia").compareToIgnoreCase("1") == 0) {
            %>
        <script>document.all.btnAlta.disabled = true;
                document.all.btnElimina.disabled = true;</script>
        <%            } else {
        %>
        <script>document.all.btnCambio.disabled = true;
                document.all.btnElimina.disabled = true;</script>
        <%                }
        %>
        <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="SiniestroHogar.jsp?'>"%>
        <input class='cBtn' type='button' value='Poliza' onClick="window.open('VistaPoliza.jsp?&Clave=<%=strClave%>', '', 'resizable=no,menubar=0,status=0,toolbar=0,height=500,width=630,screenX=-50,screenY=0')"></input>
        <%
            if (rs.next()) {
        %>

        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=rs.getString("clExpediente")%>'>
        <INPUT id='clUsrApp' name='clUsrApp' type='hidden' value='<%=strclUsr%>'>
        <%=MyUtil.ObjComboC("Causa del Siniestro", "clGpoCobVTR", rs.getString("dsGpoCob"), true, true, 30, 80, "", "Select clGpoCob,dsGpoCob from cGpoCobertura", "fnCobertura()", "", 50, false, false)%>
        <%=MyUtil.ObjInput("Fecha del Siniestro<br>(aaaa/mm/dd)", "FechaSiniestro", rs.getString("FechaSiniestro"), true, true, 510, 80, "", false, false, 16, "if(this.readOnly==false){fnValMask(this,document.all.Fecha2Msk.value,this.name)}")%>
        <%=MyUtil.ObjTextArea("Descripción u Observaciones", "Observaciones", rs.getString("Observaciones"), "50", "3", true, true, 30, 130, "", false, false)%>
        <%=MyUtil.ObjInput("Estimacion del Daño NU", "ImporteEstimado", rs.getString("ImporteEstimado"), true, true, 330, 130, "", true, true, 20, "EsNumerico(document.all.ImporteEstimado)")%>
        <%=MyUtil.ObjComboC("Moneda", "MonedaEstimado", rs.getString("dsTipoMonedaEst"), true, true, 510, 130, "", "Select clTipoMoneda,dsTipoMoneda from cTipoMoneda", "", "", 40, true, true)%>
        <%=MyUtil.DoBlock("Datos Generales del Siniestro", 50, 20)%>

        <%=MyUtil.ObjComboC("Tipo de Ajustador", "clTipoAjustador", rs.getString("dsTipoAjustador"), true, true, 30, 240, "", "Select clTipoAjustador,dsTipoAjustador from cTipoAjustador", "", "", 50, true, true)%>
        <%=MyUtil.ObjComboC("Ajustador", "clAjustador", rs.getString("Nombre"), true, true, 230, 240, "", "Select clAjustador,Nombre from cAjustador where clCuenta=" + strclCuenta + " order by Nombre", "", "", 50, true, true)%>
        <%=MyUtil.ObjInput("Fecha de Asignacion al Ajustador<br>(aaaa/mm/dd hh:mm)", "FechaAsigAjustador", rs.getString("FechaAsigAjustador"), true, true, 30, 290, "", false, false, 20, "if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("Cita con Asegurado<br>(aaaa/mm/dd hh:mm)", "FechaCitaAsegurado", rs.getString("FechaCitaAsegurado"), true, true, 270, 290, "", false, false, 20, "if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("Entrega de Informe Preeliminar<br>(aaaa/mm/dd hh:mm)", "FechaEntInforme", rs.getString("FechaEntInforme"), true, true, 430, 290, "", false, false, 20, "if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("Fecha de Contacto Afiliado<br>(aaaa/mm/dd hh:mm)", "FechaContactoAfil", rs.getString("FechaContactoAfil"), true, true, 660, 290, "", false, false, 20, "if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)}")%>
        <%=MyUtil.ObjTextArea("Observaciones Ajustador", "ObservAjustador", rs.getString("ObservAjustador"), "50", "3", true, true, 30, 350, "", false, false)%>
        <%=MyUtil.ObjInput("Importe Reservado", "ImporteReservado", rs.getString("ImporteReservado"), true, true, 430, 350, "", false, false, 20, "EsNumerico(document.all.ImporteReservado)")%>
        <%=MyUtil.ObjComboC("Moneda", "MonedaReserva", rs.getString("dsTipoMonedaRes"), true, true, 660, 350, "", "Select clTipoMoneda,dsTipoMoneda from cTipoMoneda", "", "", 40, true, true)%>
        <%=MyUtil.DoBlock("Datos Generales del Ajustador", 25, 20)%>

        <%=MyUtil.ObjInput(i18n.getMessage("message.title.colonia"), "Colonia", rs.getString("Colonia"), true, true, 30, 460, "", false, false, 50)%>
        <%=MyUtil.ObjInput("Calle", "Calle", rs.getString("Calle"), true, true, 330, 460, "", false, false, 100)%>
        <%=MyUtil.DoBlock("Ubicaciòn", 350, 0)%>

        <%=MyUtil.ObjChkBox("Requiere Peritaje", "ReqPeritaje", rs.getString("ReqPeritaje"), true, true, 30, 560, "0", "SI", "NO", "")%>
        <%=MyUtil.ObjComboC("Autorizacion Daño Banamex", "AutDanioBanamex", rs.getString("dsRespInfoDictHSBX"), true, true, 170, 560, "", "Select clRespInfoDictHS,dsRespInfoDictHS from cRespInfoDictHS", "", "", 20, false, false)%>
        <%=MyUtil.ObjInput("Nombre de quien Autoriza", "NomAutoriza", rs.getString("NomAutoriza"), true, true, 420, 560, "", false, false, 50)%>
        <%=MyUtil.DoBlock("Datos del Peritaje", 80, 0)%>

        <%=MyUtil.ObjComboC("Quien Dictamina", "QuienDictamina", rs.getString("dsEmpresaDic"), true, true, 30, 650, "", "Select clEmpresaDic,dsEmpresaDic from cEmpresaDictamen", "", "", 20, false, false)%>
        <%=MyUtil.ObjComboC("Determinacion de Perdida", "DeterPerdida", rs.getString("dsRespInfoDictHSDP"), true, true, 230, 650, "", "Select clRespInfoDictHS,dsRespInfoDictHS from cRespInfoDictHS", "", "", 20, false, false)%>
        <%=MyUtil.ObjComboC("Firma de Conf de Convenio", "FirmaConform", rs.getString("dsRespInfoDictHSFC"), true, true, 30, 700, "", "Select clRespInfoDictHS,dsRespInfoDictHS from cRespInfoDictHS", "", "", 20, false, false)%>
        <%=MyUtil.ObjComboC("Cheque Expedido", "ChequeExped", rs.getString("dsRespInfoDictHSCE"), true, true, 230, 700, "", "Select clRespInfoDictHS,dsRespInfoDictHS from cRespInfoDictHS", "", "", 20, false, false)%>
        <%=MyUtil.DoBlock("Informacion dictamen", 0, 0)%>

        <%
        } else {
        %>
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
        <INPUT id='clUsrApp' name='clUsrApp' type='hidden' value='<%=strclUsr%>'>
        <%=MyUtil.ObjComboC("Causa del Siniestro", "clGpoCobVTR", "", true, true, 30, 80, "", "Select clGpoCob,dsGpoCob from cGpoCobertura", "fnCobertura()", "", 50, true, true)%>
        <%=MyUtil.ObjInput("Fecha del Siniestro<br>(aaaa/mm/dd)", "FechaSiniestro", "", true, true, 510, 80, "", false, false, 16, "if(this.readOnly==false){fnValMask(this,document.all.Fecha2Msk.value,this.name)}")%>
        <%=MyUtil.ObjTextArea("Descripción u Observaciones", "Observaciones", "", "50", "3", true, true, 30, 130, "", false, false)%>
        <%=MyUtil.ObjInput("Estimacion del Daño NU", "ImporteEstimado", "", true, true, 330, 130, "", true, true, 20, "EsNumerico(document.all.ImporteEstimado)")%>
        <%=MyUtil.ObjComboC("Moneda", "MonedaEstimado", "", true, true, 510, 130, "", "Select clTipoMoneda,dsTipoMoneda from cTipoMoneda", "", "", 40, true, true)%>
        <%=MyUtil.DoBlock("Datos Generales del Siniestro", 50, 20)%>

        <%=MyUtil.ObjComboC("Tipo de Ajustador", "clTipoAjustador", "", true, true, 30, 240, "", "Select clTipoAjustador,dsTipoAjustador from cTipoAjustador", "", "", 50, true, true)%>
        <%=MyUtil.ObjComboC("Ajustador", "clAjustador", "", true, true, 230, 240, "", "Select clAjustador,Nombre from cAjustador where clCuenta=" + strclCuenta + " order by Nombre", "", "", 50, true, true)%>
        <%=MyUtil.ObjInput("Fecha de Asignacion al Ajustador<br>(aaaa/mm/dd hh:mm)", "FechaAsigAjustador", "", true, true, 30, 290, "", false, false, 20, "if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("Cita con Asegurado<br>(aaaa/mm/dd hh:mm)", "FechaCitaAsegurado", "", true, true, 270, 290, "", false, false, 20, "if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("Entrega de Informe Preeliminar<br>(aaaa/mm/dd hh:mm)", "FechaEntInforme", "", true, true, 430, 290, "", false, false, 20, "if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("Fecha de Contacto Afiliado<br>(aaaa/mm/dd hh:mm)", "FechaContactoAfil", "", true, true, 660, 290, "", false, false, 20, "if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)}")%>
        <%=MyUtil.ObjTextArea("Observaciones Ajustador", "ObservAjustador", "", "50", "3", true, true, 30, 350, "", false, false)%>
        <%=MyUtil.ObjInput("Importe Reservado", "ImporteReservado", "", true, true, 430, 350, "", false, false, 20, "EsNumerico(document.all.ImporteReservado)")%>
        <%=MyUtil.ObjComboC("Moneda", "MonedaReserva", "", true, true, 660, 350, "", "Select clTipoMoneda,dsTipoMoneda from cTipoMoneda", "", "", 40, true, true)%>
        <%=MyUtil.DoBlock("Datos Generales del Ajustador", 50, 20)%>

        <%=MyUtil.ObjInput(i18n.getMessage("message.title.colonia"), "Colonia", "", true, true, 30, 460, "", false, false, 50)%>
        <%=MyUtil.ObjInput("Calle", "Calle", "", true, true, 330, 460, "", false, false, 100)%>
        <%=MyUtil.DoBlock("Ubicaciòn", 350, 0)%>

        <%=MyUtil.ObjChkBox("Requiere Peritaje", "ReqPeritaje", "", true, true, 30, 560, "0", "SI", "NO", "")%>
        <%=MyUtil.ObjComboC("Autorizacion Daño Banamex", "AutDanioBanamex", "", true, true, 170, 560, "", "Select clRespInfoDictHS,dsRespInfoDictHS from cRespInfoDictHS", "", "", 20, false, false)%>
        <%=MyUtil.ObjInput("Nombre de quien Autoriza", "NomAutoriza", "", true, true, 400, 560, "", false, false, 50)%>
        <%=MyUtil.DoBlock("Datos del Peritaje", 80, 0)%>

        <%=MyUtil.ObjComboC("Quien Dictamina", "QuienDictamina", "", true, true, 30, 650, "", "Select clEmpresaDic,dsEmpresaDic from cEmpresaDictamen", "", "", 20, false, false)%>
        <%=MyUtil.ObjComboC("Determinacion de Perdida", "DeterPerdida", "", true, true, 230, 650, "", "Select clRespInfoDictHS,dsRespInfoDictHS from cRespInfoDictHS", "", "", 20, false, false)%>
        <%=MyUtil.ObjComboC("Firma de Conf de Convenio", "FirmaConform", "", true, true, 30, 700, "", "Select clRespInfoDictHS,dsRespInfoDictHS from cRespInfoDictHS", "", "", 20, false, false)%>
        <%=MyUtil.ObjComboC("Cheque Expedido", "ChequeExped", "", true, true, 230, 700, "", "Select clRespInfoDictHS,dsRespInfoDictHS from cRespInfoDictHS", "", "", 20, false, false)%>
        <%=MyUtil.DoBlock("Informacion dictamen", 0, 0)%>
        <%
            }
            rs.close();
            rs = null;
            rs2.close();
            rs2 = null;

            StrclExpediente = null;
            StrSql = null;
            strclUsr = null;
            strclCuenta = null;
        %>
        <%=MyUtil.GeneraScripts()%>

        <input name='FechaMsk' id='FechaMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
        <input name='Fecha2Msk' id='Fecha2Msk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09'>
        <script>
                        function fnCobertura() {
                            //            alert('CobxExpediente.jsp?clGpoCob=' + document.all.clGpoCobVTRC.value);
                            window.open('CobxExpediente.jsp?clGpoCob= ' + document.all.clGpoCobVTRC.value + ' ', 'newWin', 'scrollbars=yes,resizable=yes,status=yes,width=500,height=500');
                        }
        </script>
    </body>
</html>