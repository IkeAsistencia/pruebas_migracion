<%@ page contentType="text/html; charset=iso-8859-1" language="java" %>
<%@ page import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<html>    
    <head>
        <title>Reactivación de Clientes</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>

    <body class="cssBody" onload="">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" />
        <script src='../../Utilerias/Util.js'></script>
        <script src='../../Utilerias/UtilDireccion.js'></script>
        <script src='../../Utilerias/UtilAjax.js'></script>

        <%
                String StrclUsrApp = "0";
                String StrclPaginaWeb = "0";
                String StrClReactivacion = "0";
                String StrFolioVTR = "";
                String StrClGpoCuenta = "0";
                String StrFechaCancelacion = "";
                String StrNomAfil = "";
                String StrClave = "";
                String StrPersonaReporta = "";
                String StrTelPersonaReporta = "";
                String StrRFC = "";
                String StrMotReactiva = "";
                String StrclMotivoCancela = "";

                if (session.getAttribute("clUsrApp") != null) {
                    StrclUsrApp = session.getAttribute("clUsrApp").toString();
                }

                if (request.getParameter("clReactivacion") != null) {
                    StrClReactivacion = request.getParameter("clReactivacion");
                }

                if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {
        %>Fuera de Horario<%
                    StrclUsrApp = null;
                    StrclPaginaWeb = null;
                    StrClReactivacion = null;
                    StrFolioVTR = null;
                    StrClGpoCuenta = null;
                    StrFechaCancelacion = null;
                    StrNomAfil = null;
                    StrClave = null;
                    StrPersonaReporta = null;
                    StrTelPersonaReporta = null;
                    StrRFC = null;
                    StrMotReactiva = null;
                    StrclMotivoCancela = null;

                    return;
                }

                StrclPaginaWeb = "6046";
                MyUtil.InicializaParametrosC(399, Integer.parseInt(StrclUsrApp));
                session.setAttribute("clPaginaWebP", StrclPaginaWeb);

                if (!StrClReactivacion.equalsIgnoreCase("0")) {
                    StringBuffer sb = new StringBuffer();

                    sb.append("st_getDetalleReactivacion ").append(StrClReactivacion);

                    ResultSet rs = UtileriasBDF.rsSQLNP(sb.toString());
                    sb.delete(0, sb.length());

                    if (rs.next()) {
                        StrFolioVTR = rs.getString("clRetencTmk");
                        StrClGpoCuenta = rs.getString("clGrupoCuenta");
                        StrFechaCancelacion = rs.getString("FechaLlamada");
                        StrNomAfil = rs.getString("NombreAfil");
                        StrClave = rs.getString("clave");
                        StrPersonaReporta = rs.getString("NombPerReporta");
                        StrTelPersonaReporta = rs.getString("TelefonoCasa");
                        StrRFC = rs.getString("Rfc");
                        StrMotReactiva = rs.getString("motReactivacion");
                        StrclMotivoCancela = rs.getString("dsMotivoCancela");
                    }
                }
        %>

        <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaReactivaCliente", "fnHabilitaLupa();", "")%>

        <script>
            document.all.btnCambio.disabled="true";
            document.all.btnElimina.disabled="true";
        </script>

        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="ReactivaCliente.jsp?"%>'>
        <INPUT id='clAfiliado' name='clAfiliado' type='hidden' value=''>
        <INPUT id='clAfilTMK' name='clAfilTMK' type='hidden' value=''>
        <INPUT id='tipoCanc' name='tipoCanc' type='hidden' value=''>
        <INPUT id='clCuenta' name='ClCuenta' type='hidden' value=''>
        <INPUT id='prefijoSISE' name='prefijoSISE' type='hidden' value=''>
        <INPUT id='prefijoTMK' name='prefijoTMK' type='hidden' value=''>
        <INPUT id='clReactivacion' name='clReactivacion' type='hidden' value='<%=StrClReactivacion%>'>
        <INPUT id='gpoCuenta' name='gpoCuenta' type='hidden' value=''>        

        <%=MyUtil.ObjInput("Folio Retención", "FolioVTR", StrFolioVTR.toString(), false, false, 30, 70, "", false, false, 25)%>
        <%=MyUtil.ObjComboC("Grupo de Cuenta", "clGpoCuenta", "", true, true, 200, 70, "", "st_getGrupoCuentasRetenciones", "fnLimpiaCampos();", "", 30, true, true)%>
        <%=MyUtil.ObjInput("Fecha de llamada", "FechaCancelacion", StrFechaCancelacion.toString(), false, false, 460, 70, "", false, false, 25)%>
        <%=MyUtil.ObjInput("Nombre del Afiliado", "nomAfil", StrNomAfil.toString(), true, true, 30, 110, "", false, false, 47)%>
        <%=MyUtil.ObjInput("Clave", "Clave", StrClave.toString(), false, false, 300, 110, "", true, true, 25, "if(this.readOnly==false){fnBuscaClave()}")%>
        <div id="lupa1" class='VTable' style='position:absolute; z-index:30; left:450px; top:119px;'>
            <IMG SRC='../../Imagenes/Lupa.gif' class='handM' onClick='fnBuscaClave();' WIDTH=20 HEIGHT=20>
        </div>
        <%=MyUtil.ObjInput("Persona quien reporta", "personaReporta", StrPersonaReporta.toString(), false, false, 30, 150, "", false, false, 47)%>
        <%=MyUtil.ObjInput("Teléfono", "TelPersonaReporta", StrTelPersonaReporta.toString(), true, true, 300, 150, "", false, false, 25)%>
        <%=MyUtil.ObjInput("Cédula", "RFC", StrRFC.toString(), true, true, 460, 150, "", false, false, 25)%>
        <%=MyUtil.ObjInput("Motivo de Reactivación", "MotReactiva", StrMotReactiva.toString(), true, false, 30, 190, "", true, false, 50)%>
        <%=MyUtil.ObjInput("Motivo de Cancelación", "clMotivoCancela", StrclMotivoCancela.toString(), false, false, 310, 190, "", false, false, 50)%>

        <%=MyUtil.DoBlock("Reactivación de Clientes", -30, 0)%>
        <%=MyUtil.GeneraScripts()%>

        <%
                StrclUsrApp = null;
                StrclPaginaWeb = null;
                StrClReactivacion = null;
                StrFolioVTR = null;
                StrFechaCancelacion = null;
                StrNomAfil = null;
                StrClave = null;
                StrPersonaReporta = null;
                StrTelPersonaReporta = null;
                StrRFC = null;
                StrMotReactiva = null;
                StrclMotivoCancela = null;
        %>

        <script>
            document.all.clGpoCuentaC.value = <%=StrClGpoCuenta%>;
            document.all.lupa1.style.visibility="hidden";
            
            function fnHabilitaLupa(){ //ok
                document.all.lupa1.style.visibility="visible";
            }

            function fnBuscaClave(){ 
                if(document.all.clGpoCuenta.value==''){
                    alert("Debe seleccionar un grupo de cuentas..."); //Me
                }else{
                    var pstrCadena = "../../Utilerias/FiltrosReactiva.jsp?strSQL=st_BuscaClaveAfilReactiva";
                    pstrCadena = pstrCadena + "&Clave=" + document.all.Clave.value + "&clGpoCuenta=" + document.all.clGpoCuenta.value + "&nomAfil=" + document.all.nomAfil.value;
                    window.open(pstrCadena,'newWin','scrollbars=yes,status=yes,width=700,height=500');
                }
            }

            function fnLimpiaCampos(){     //ok
                document.all.FolioVTR.value='';
                document.all.FechaCancelacion.value='';
                document.all.nomAfil.value='';
                document.all.Clave.value='';
                document.all.personaReporta.value='';
                document.all.TelPersonaReporta.value='';
                document.all.RFC.value='';
                document.all.clMotivoCancela.value='';
                document.all.MotReactiva.value='';
                document.all.gpoCuenta.value='0';
                
            }
            
            function fnRecuperaDatos(pfolioRet,pfechaLlamada,pclAfilaido,pclAfiltmk,pnomAfil,pClave,pgpoCuenta,pCuenta,pPrefSISE,pPrefTMK,pNomPerReporta,pTel,pRFC,pmotCanc,ptipoCanc){
                document.all.FolioVTR.value=pfolioRet;
                document.all.FechaCancelacion.value=pfechaLlamada;
                document.all.clAfiliado.value=pclAfilaido;
                document.all.clAfilTMK.value=pclAfiltmk;
                document.all.nomAfil.value=pnomAfil;
                document.all.Clave.value=pClave;
                document.all.gpoCuenta.value=pgpoCuenta;
                document.all.ClCuenta.value=pCuenta;
                document.all.prefijoSISE.value=pPrefSISE;
                document.all.prefijoTMK.value=pPrefTMK;
                document.all.personaReporta.value=pNomPerReporta;
                document.all.TelPersonaReporta.value=pTel;
                document.all.RFC.value=pRFC;
                document.all.clMotivoCancela.value=pmotCanc;
                document.all.tipoCanc.value=ptipoCanc;
            }
        </script>
    </body>
</html>
