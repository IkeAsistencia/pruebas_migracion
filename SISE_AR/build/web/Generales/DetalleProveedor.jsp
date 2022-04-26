<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="com.ike.catalogos.to.Proveedor,com.ike.catalogos.DAOProveedor,Utilerias.UtileriasBDF,Combos.cbPais,Combos.cbEntidad" errorPage="" %>
<html>
    <head>
        <title>Detalle Proveedor Km0</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
        <script type="text/javascript" src='../Utilerias/Util.js'></script>
        <script type="text/javascript" src='../Utilerias/UtilDireccion.js'></script>
        <script type="text/javascript" src='../Utilerias/UtilMask.js'></script>
        <script type="text/javascript" src='../Utilerias/UtilAjax.js'></script>
        <%
            com.ike.util.I18N i18n = com.ike.util.I18N.getInstance("es", "AR");

            String SeparadorFechas = "|";
            String SeparadorHoras  = ":";
            String StrclUsr = "0";
            String StrclProveedor = "0";
            String StrNomOpe = "";
            String CodEnt = "";
            String dsEntFed = "";
            String dsMunDel = "";
            String StrCodMD = "";
            String StrclPaginaWeb = "89";
            
            //Horarios
            String lav = new String(""), lavD = new String(""), lavH = new String("");
            String sab = new String(""), sabD = new String(""), sabH = new String("");
            String dom = new String(""), domD = new String(""), domH = new String("");
            String fer = new String(""), ferD = new String(""), ferH = new String("");
            String cer = new String(""), cerD = new String(""), cerH = new String("");
            String hCommnets = new String("");
            int StrclPais = 10; //Pais default:  Argentina

            int xPos = 0, yPos = 0;

            if (session.getAttribute("clUsrApp") != null) {
                StrclUsr = session.getAttribute("clUsrApp").toString();
            }

            if (request.getParameter("clProveedor") != null) {
                StrclProveedor = request.getParameter("clProveedor").toString();
            }

            if (StrclProveedor.compareToIgnoreCase("0") == 0) {
                if (session.getAttribute("clProveedor") != null) {
                    StrclProveedor = session.getAttribute("clProveedor").toString();
                }
            }
            session.setAttribute("clProveedor", StrclProveedor);
            // ResultSet rs = UtileriasBDF.rsSQLNP("sp_DetalleProveedor " + StrclProveedor + "," + strclUsr);
            Proveedor prov = new Proveedor();
            DAOProveedor dao = new DAOProveedor();
            prov = dao.getProveedor(StrclProveedor, StrclUsr);
            session.setAttribute("clPaginaWebP", StrclPaginaWeb);
        %>
        <script type="text/javascript">fnOpenLinks()</script>
        <%
            MyUtil.InicializaParametrosC(89, Integer.parseInt(StrclUsr));
        %>
        <%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion", "fnPaisDefault();", "fnLimpiaExtra();")%>
        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="DetalleProveedor.jsp?"%>'>
        <%
            if (prov != null) {
                StrNomOpe = prov.getNombreOpe();
                session.setAttribute("NombreOpe", StrNomOpe);
                CodEnt = prov.getCodEnt();
                dsEntFed = prov.getDsEntFed();
                dsMunDel = prov.getDsMunDel();
                StrCodMD = prov.getCodMD();
                StrclPais = Integer.valueOf(prov.getClPais());

                //Decode Horario:
                String horario = prov.getHorario();
                out.print(" <!-- " + horario + "-->");
                if (!horario.isEmpty()) {
                    int i = horario.indexOf("LAV");
                    if ( i > -1) {
                        lav = "1";
                        lavD = horario.substring( i+3, i+5 );
                        lavH = horario.substring( i+6, i+8 );
                    }
                    else {
                        lav = "0"; lavD = "00"; lavH = "24";
                    }
                    i = horario.indexOf("SAB");
                    if ( i > -1) {
                        sab = "1";
                        sabD = horario.substring( i+3, i+5 );
                        sabH = horario.substring( i+6, i+8 );
                    }
                    else {
                        sab = "0"; sabD = "00"; sabH = "24";
                    }
                    i = horario.indexOf("DOM");
                    if ( i > -1) {
                        dom = "1";
                        domD = horario.substring( i+3, i+5 );
                        domH = horario.substring( i+6, i+8 );
                    }
                    else {
                        dom = "0"; domD = "00"; domH = "24";
                    }
                    i = horario.indexOf("FER");
                    if ( i> -1) {
                        fer = "1";
                        ferD = horario.substring( i+3, i+5 );
                        ferH = horario.substring( i+6, i+8 );
                    }
                    else {
                        fer = "0"; ferD = "00"; ferH = "24";
                    }
                    i = horario.indexOf("CER");
                    if ( i > -1) {
                        cer = "1";
                        cerD = horario.substring( i+3, i+ 13 );
                        cerH = horario.substring( i+14, i+24 );
                    }
                    else {
                        cer = "0"; cerD = ""; cerH = "";
                    }
                    i = horario.indexOf("###");
                    if ( i > -1) {
                        hCommnets = horario.substring( i+3, horario.length() );
                    }
                }
            }
            //System.out.println(dsEntFed + ',' + dsMunDel);
%>
        <INPUT id='clProveedor' name='clProveedor' type='hidden' value='<%= StrclProveedor%>'>
        <INPUT id='clAreaOperativa' name='clAreaOperativa' type='hidden' value='1'>

        <%=MyUtil.ObjInput("Nombre", "NombreRZ", prov != null ? prov.getNombreRZ() : "", true, true, 25, 80, "", true, true, 50)%>
        <%=MyUtil.ObjInput("Nombre En Operación", "NombreOpe", prov != null ? prov.getNombreOpe() : "", true, true, 310, 80, "", true, true, 50)%>
        <%=MyUtil.ObjInput("Titular", "Titular", prov != null ? prov.getTitular() : "", true, true, 25, 120, "", true, true, 50)%>
        <%=MyUtil.ObjComboC("Rubro", "clGiro", prov != null ? prov.getDsGiro() : "", true, true, 310, 120, "", "Select clGiro, dsGiro from cGiro where clAreaOperativa = 1 order by dsGiro", "", "", 45, true, true)%>
        <%=MyUtil.ObjChkBox("", "Activo", prov != null ? prov.getActivo() : "", true, true, 370, 160, "", "ACTIVO", "INACTIVO", "")%>
        <%=MyUtil.ObjInput("CUIT", "RFC", prov != null ? prov.getRFC() : "", true, true, 25, 160, "", false, false, 20, "if(this.readOnly==false){fnValMask(this,document.all.CuitMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("Nextel", "NumNextel", prov != null ? prov.getNumNextel() : "", true, true, 175, 160, "", false, false, 20)%>
        <%=MyUtil.ObjComboC("Tipo de Proveedor", "clTipoProveedor", prov != null ? prov.getDsTipoProveedor() : "", true, true, 25, 200, "", "Select clTipoProveedor, dsTipoProveedor from cTipoProveedor where clAreaOperativa = 1 order by dsTipoProveedor", "", "", 20, true, true)%>
        <%=MyUtil.ObjInput("Prioridad", "Prioridad", prov != null ? prov.getPrioridad() : "", true, true, 200, 200, "", true, true, 5)%>
        <!--%=MyUtil.ObjInput("Alias Asignador Automatico", "alias", prov != null ? prov.getAlias():"", true, true, 310,200, "", true, true,  40 ) %-->
        <%=MyUtil.DoBlock("Detalle de Proveedor de Grúa")%>

        <!-- LAV -->
        <% yPos=290; %>
        <%=MyUtil.ObjInput("Horario", "Horario", prov!=null ? prov.getHorario(): "", false, false, 25, yPos, prov!=null?prov.getHorario():"", false, false, 120) %>
        <% yPos +=40; %>
        <%=MyUtil.ObjChkBox("Lunes A Viernes","lav",lav,true,true, 25, yPos, "0", "lavD.disabled=(this.checked==false);lavH.disabled=(this.checked==false);concat();")%>
        <%=MyUtil.ObjInput("", "lavD", lavD, true, true, 145, yPos-9, "", false, false, 1, "if(this.readOnly==false){fnValMask(this,document.all.HoraMsk.value,this.name);concat();}")%>
        <%=MyUtil.ObjInput("", "lavH", lavH, true, true, 175, yPos-9, "", false, false, 1, "if(this.readOnly==false){fnValMask(this,document.all.HoraMsk.value,this.name);concat();}")%>
        <!-- SAB -->
        <%=MyUtil.ObjChkBox("Sabados","sab",sab,true,true, 220, yPos, "0", "sabD.disabled=(this.checked==false);sabH.disabled=(this.checked==false);concat();")%>
        <%=MyUtil.ObjInput("", "sabD", sabD, true, true, 300, yPos-9, "", false, false, 1, "if(this.readOnly==false){fnValMask(this,document.all.HoraMsk.value,this.name);concat();}")%>
        <%=MyUtil.ObjInput("", "sabH", sabH, true, true, 330, yPos-9, "", false, false, 1, "if(this.readOnly==false){fnValMask(this,document.all.HoraMsk.value,this.name);concat();}")%>
        <!-- DOM -->
        <%=MyUtil.ObjChkBox("Domingos","dom",dom,true,true, 370, yPos, "0", "domD.disabled=(this.checked==false);domH.disabled=(this.checked==false);concat();")%>
        <%=MyUtil.ObjInput("", "domD", domD, true, true, 450, yPos-9, "", false, false, 1, "if(this.readOnly==false){fnValMask(this,document.all.HoraMsk.value,this.name);concat();}")%>
        <%=MyUtil.ObjInput("", "domH", domH, true, true, 480, yPos-9, "", false, false, 1, "if(this.readOnly==false){fnValMask(this,document.all.HoraMsk.value,this.name);concat();}")%>
        <!-- FERIADOS -->
        <% yPos +=30; %>
        <%=MyUtil.ObjChkBox("Feriados","fer",fer,true,true, 25, yPos, "0", "ferD.disabled=(this.checked==false);ferH.disabled=(this.checked==false);concat();")%>
        <%=MyUtil.ObjInput("", "ferD", ferD, true, true, 145, yPos-9, "", false, false, 1, "if(this.readOnly==false){fnValMask(this,document.all.HoraMsk.value,this.name);concat();}")%>
        <%=MyUtil.ObjInput("", "ferH", ferH, true, true, 175, yPos-9, "", false, false, 1, "if(this.readOnly==false){fnValMask(this,document.all.HoraMsk.value,this.name);concat();}")%>
        <!-- CERRADO  -->
        <%=MyUtil.ObjChkBox("Cerrado","cer", cer,true,true, 220, yPos, "0", "cerD.disabled=(this.checked==false);cerH.disabled=(this.checked==false);concat();")%>
        <%=MyUtil.ObjInput("", "cerD", cerD, true, true, 300, yPos-9, "", false, false, 9,"if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name);concat();}")%>
        <%=MyUtil.ObjInput("", "cerH", cerH, true, true, 370, yPos-9, "", false, false, 9,"if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name);concat();}")%>
        <!-- COMENTARIOS  -->
        <% yPos +=30; %>
        <%=MyUtil.ObjTextArea("Comentarios", "Comentarios", hCommnets, "118", "3", true, true, 30, yPos, "", false, false,"", "concat();")%>
        <%=MyUtil.DoBlock("Horarios",0,20)%>
        
        <% yPos +=110; %>
        <%=MyUtil.ObjComboMem("Pais", "clPais", prov != null ? prov.getDsPais() : "", prov != null ? prov.getClPais() : "", cbPais.GeneraHTML(20, prov != null ? prov.getDsPais() : ""), true, true, 25, yPos, "0", "fnLlenaEntidadAjaxFn(this.value);", "", 20, false, false)%>
        <%=MyUtil.ObjComboMemDiv("Provincia", "CodEnt", dsEntFed, CodEnt, cbEntidad.GeneraHTML(20, dsEntFed, StrclPais), true, true, 280, yPos, "", "fnLLenaComboMDAjax(this.value);", "", 20, true, true, "CodEntDiv")%>
        <%=MyUtil.ObjComboMemDiv("Localidad", "CodMD", dsMunDel, StrCodMD, cbEntidad.GeneraHTMLMD(30, CodEnt, dsMunDel), true, true, 660, yPos, "", "", "", 20, true, true, "LocalidadDiv")%>
        <% yPos += 30; %>
        <%=MyUtil.ObjInput("Calle", "Calle", prov != null ? prov.getCalle() : "", true, true, 25, yPos, "", false, false, 50)%>
        <%=MyUtil.ObjInput("Código Postal", "CP", prov != null ? prov.getCP() : "", true, true, 310, yPos, "", false, false, 10)%>
        <%=MyUtil.DoBlock("Ubicación del Proveedor", 90, 0)%>

        <%yPos += 90;%>
        <%=MyUtil.ObjComboC("Banco", "clBanco", prov != null ? prov.getDsBanco() : "", true, true, 25, yPos, "", "Select clBanco, Nombre from cBanco where Activo=1 order by Nombre", "", "", 50, false, false)%>
        <%=MyUtil.ObjInput("Num. Sucursal", "SucursalBan", prov != null ? prov.getSucursalBan() : "", true, true, 350, yPos, "", false, false, 15)%>
        <%=MyUtil.ObjInput("Tipo de Cuenta", "TipoCuentaBan", prov != null ? prov.getTipoCuentaBan() : "", true, true, 460, yPos, "", false, false, 20)%>
        <%=MyUtil.ObjChkBox("Cheque", "Cheque", prov != null ? prov.getCheque() : "", true, true, 600, yPos, "", "SI", "NO", "")%>
        <%yPos += 40;%>
        <!--%=MyUtil.ObjInput("Plaza", "PlazaBan", prov != null ? prov.getPlazaBan() : "", true, true, 25, yPos, "", false, false, 5)%-->
        <%=MyUtil.ObjInput("A Nombre De", "ANombreDe", prov != null ? prov.getANombreDe() : "", true, true, 25, yPos, "", false, false, 48)%>
        <%=MyUtil.ObjInput("Num. de Cuenta", "CuentaBan", prov != null ? prov.getCuentaBan() : "", true, true, 305, yPos, "", false, false, 20)%>
        <%=MyUtil.ObjInput("C.B.U.", "Clabe", prov != null ? prov.getClabe() : "", true, true, 440, yPos, "", false, false, 30, "if(this.readOnly==false){fnValMask(this,document.all.CubMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("CUIT Asociado", "CuitA", prov != null ? prov.getCuitA() : "", true, true, 620, yPos, "", false, false, 20, "if(this.readOnly==false){fnValMask(this,document.all.CuitMsk.value,this.name)}")%>
        <%yPos += 40;%>
        <%=MyUtil.ObjInput("Email 1", "Email1", prov != null ? prov.getEmail1() : "", true, true, 25, yPos, "", false, false, 40)%>
        <%=MyUtil.ObjInput("Email 2", "Email2", prov != null ? prov.getEmail2() : "", true, true, 250, yPos, "", false, false, 40)%>
        <%=MyUtil.ObjInput("Email 3", "Email3", prov != null ? prov.getEmail3() : "", true, true, 475, yPos, "", false, false, 40)%>
        <%=MyUtil.DoBlock("Banco del Proveedor", 0, 0)%>
        
        <%yPos += 90;%>
        <%=MyUtil.ObjTextArea("Observaciones", "Observaciones", prov != null ? prov.getObservaciones() : "", "103", "7", true, true, 30, yPos, "", false, false)%>
        <%=MyUtil.DoBlock("Observaciones Extras", 400, 70)%>
        
        <%yPos += 160;%>
        <%=MyUtil.ObjChkBox("Carta Oferta Original Firmado", "Convenio", prov != null ? prov.getConvenio() : "", true, true, 30, yPos, "0", "")%>
        <%yPos += 40;%>
        <%=MyUtil.ObjChkBox("Ficha de proveedor(Obligatorio) ", "Ficha", prov != null ? prov.getFicha() : "", true, true, 30, yPos, "0", "")%>
        <%yPos += 40;%>
        <%=MyUtil.ObjChkBox("Conocimientos", "Conocimientos", prov != null ? prov.getConocimientos() : "", true, true, 30, yPos, "0", "")%>
        <%yPos += 40;%>
        <%=MyUtil.ObjChkBox("Experiencia ", "Experiencia", prov != null ? prov.getExperiencia() : "", true, true, 30, yPos, "0", "")%>
        <%yPos += 40;%>
        <%=MyUtil.ObjChkBox("Infraestructura", "Infraestructura", prov != null ? prov.getInfraestructura() : "", true, true, 30, yPos, "0", "")%>
        <%yPos += 40;%>
        <%=MyUtil.ObjChkBox("Copia del " + "cuit" + " (Obligatorio) ", "CopiaRFC", prov != null ? prov.getCopiaRFC() : "", true, true, 30, yPos, "0", "")%>
        <%yPos += 40;%>
        <%=MyUtil.ObjChkBox("Copia de Identificación del responsable y técnicos(Opcional)", "CopiaIdent", prov != null ? prov.getCopiaIdent() : "", true, true, 30, yPos, "0", "")%>
        <%yPos += 40;%>
        <%=MyUtil.ObjChkBox("Estado de cuenta bancaria(Opcional)", "EdoCuenta", prov != null ? prov.getEdoCuenta() : "", true, true, 30, yPos, "0", "")%>
        <%yPos += 40;%>
        <%=MyUtil.ObjChkBox("Copia de factura del negocio u original cancelada(Opcional)", "CopiaFactura", prov != null ? prov.getCopiaFactura() : "", true, true, 30, yPos, "0", "")%>
        <%yPos += 40;%>
        <%=MyUtil.ObjChkBox("Fotografías del negocio(Opcional)", "Fotografias", prov != null ? prov.getFotografias() : "", true, true, 30, yPos, "0", "")%>
        <%=MyUtil.DoBlock("Requisitos de Aprobación", 300, 0)%>

        <input name='CuitMsk' id='CuitMsk' type='hidden' value='VN09VN09F---VN09VN09VN09VN09VN09VN09VN09VN09F/--VN09'>
        <input name='HoraMsk' id='HoraMsk' type='hidden' value='VN09VN09'>
        <input id='FechaMsk' name='FechaMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09'>
        <!--input name='CuitAMsk' id='CuitAMsk' type='hidden' value='VN09VN09F---VN09VN09VN09VN09VN09VN09VN09VN09F/--VN09'-->
        <input name='CubMsk' id='CubMsk' type='hidden' value='VN09VN09VN09VN09VN09VN09VN09VN09VN09VN09VN09VN09VN09VN09VN09VN09VN09VN09VN09VN09VN09VN09'>
        <%
            StrclUsr = null;
            StrclProveedor = null;
            StrNomOpe = null;
            StrclPaginaWeb = null;
            CodEnt = null;
            dsEntFed = null;
            dsMunDel = null;
            StrCodMD = null;
            prov = null;
            dao = null;
        %>
        <%=MyUtil.GeneraScripts()%>

        <script>
            function fnPaisDefault() {
                document.all.clPais.value = 10;
                document.all.clPaisC.value = 10;
                fnLlenaEntidadAjaxFn(10); // Carga Entidades de Argentina Por Default
            }
       
            function concat() {
                var horario="";
                var errMsg="";
                if ( document.getElementById('lavC').checked == 1 ) {
                    if ( document.getElementById('lavD').value.length > 0 && document.getElementById('lavH').value.length > 0 ) {
                        if ( parseInt(document.getElementById('lavD').value) >-1 && parseInt(document.getElementById('lavD').value) < 25 &&
                             parseInt(document.getElementById('lavH').value) >-1 && parseInt(document.getElementById('lavH').value) < 25 ) {
                            horario = 'LAV'+document.getElementById('lavD').value+"<%=SeparadorHoras%>"+document.getElementById('lavH').value;
                        }
                        else {
                          errMsg ="Error en horas desde/hasta de Lunes a Viernes\n";
                        }
                    }
                }
                if ( document.getElementById('sabC').checked == 1 ) {
                    if ( document.getElementById('sabD').value.length > 0 && document.getElementById('sabH').value.length > 0 ) {
                        if ( parseInt(document.getElementById('sabD').value) >-1 && parseInt(document.getElementById('sabD').value) < 25 &&
                             parseInt(document.getElementById('sabH').value) >-1 && parseInt(document.getElementById('sabH').value) < 25 ) {
                            horario += (horario!=""?"<%=SeparadorFechas%>":"");
                            horario += 'SAB'+document.getElementById('sabD').value+"<%=SeparadorHoras%>"+document.getElementById('sabH').value;
                        }
                        else {
                            errMsg +="Error en horas desde/hasta de Sabados\n";
                        }
                    }
                }
                if ( document.getElementById('domC').checked == 1 ) {
                    if ( document.getElementById('domD').value.length > 0 && document.getElementById('domH').value.length > 0 ) {
                        if ( parseInt(document.getElementById('domD').value) >-1 && parseInt(document.getElementById('domD').value) < 25 &&
                             parseInt(document.getElementById('domH').value) >-1 && parseInt(document.getElementById('domH').value) < 25 ) {
                            horario += (horario!=""?"<%=SeparadorFechas%>":"");
                            horario += 'DOM'+document.getElementById('domD').value+"<%=SeparadorHoras%>"+document.getElementById('domH').value;
                        }
                        else {
                            errMsg +="Error en horas desde/hasta de Domingos\n";
                        }
                    }
                }
                if ( document.getElementById('ferC').checked == 1 ) { 
                    if ( document.getElementById('ferD').value.length > 0 && document.getElementById('ferH').value.length > 0 ) {
                        if ( parseInt(document.getElementById('ferD').value) >-1 && parseInt(document.getElementById('ferD').value) < 25 &&
                             parseInt(document.getElementById('ferH').value) >-1 && parseInt(document.getElementById('ferH').value) < 25 ) {
                            horario += (horario!=""?"<%=SeparadorFechas%>":"");
                            horario += 'FER'+document.getElementById('ferD').value+"<%=SeparadorHoras%>"+document.getElementById('ferH').value;
                        }
                        else {
                            errMsg +="Error en horas desde/hasta de Feriados\n";
                        }
                    }
                }
                if ( document.getElementById('cerC').checked == 1 ) {
                     horario += (horario!=""?"<%=SeparadorFechas%>":"");
                     horario += 'CER'+document.getElementById('cerD').value+"<%=SeparadorHoras%>"+document.getElementById('cerH').value;
                }
                if ( "" != document.getElementById('Comentarios').value ) {
                    horario += (horario!=""?"<%=SeparadorFechas%>":"");
                    horario += '###'+document.getElementById('Comentarios').value
                }
                document.getElementById('Horario').value = horario;
                if ( errMsg.length > 0) {
                    alert(errMsg);
                    //alert( horario );
                }
            }
        </script>
    </body>
</html>