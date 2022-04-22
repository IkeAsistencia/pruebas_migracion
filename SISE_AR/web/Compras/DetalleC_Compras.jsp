<%--
 Document   : C_Compras
 Create on  : 2010-03-17
 Author     : vsampablo
--%>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%@ page import="Utilerias.UtileriasBDF,Seguridad.SeguridadC,java.sql.ResultSet,com.ike.Compras.DAOC_Compras,com.ike.Compras.to.C_Compras;" %>

<html>
    <head><title>C_Compras</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>

    <body class="cssBody" onload="fnShowHiddenDiv()">
        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj"/>
        <script src='../Utilerias/Util.js' ></script>
        <script src='../Utilerias/UtilStore.js' ></script>
        <script src='../Utilerias/UtilCalendario.js' ></script>
        <link href='../StyleClasses/Calendario.css' rel='stylesheet' type='text/css'>

        <%
            String StrclUsr = "0";
            String StrclPaginaWeb = "0";
            String StrclCompra = "0";
            String StrPerfilUsr = "0";
            String StrCorreo = "";
            StrclPaginaWeb = "5064";

            if (session.getAttribute("clUsrApp") != null) {
                StrclUsr = session.getAttribute("clUsrApp").toString();
            }

            if (session.getAttribute("Correo") != null) {
                StrCorreo = session.getAttribute("Correo").toString();
                StrCorreo = StrCorreo.replace("@ikeasistencia.com", "");
            }

            if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsr)) != true) {
				%>Fuera de Horario <%
                StrclUsr = null;
                StrclPaginaWeb = null;
                StrclCompra = null;
                StrCorreo = null;
                return;
            }

            if (request.getParameter("clCompra") != null) {
                StrclCompra = request.getParameter("clCompra").toString();
                session.setAttribute("clCompra", StrclCompra);
            } else {
                if (session.getAttribute("clCompra") != null) {
                    StrclCompra = session.getAttribute("clCompra").toString();
                }
            }

            DAOC_Compras daoC_Compras = null;
            C_Compras CC = null;

            daoC_Compras = new DAOC_Compras();
            CC = daoC_Compras.getclCompra(StrclCompra.toString());

        %><script>fnOpenLinks()</script><%

            session.setAttribute("clPaginaWebP", StrclPaginaWeb);

            //<<<<<<<<<<<< Servlet Generico >>>>>>>>>>>
            String Store = "";
            Store = "st_GuardaC_Compras,st_ActualizaC_Compras";
            session.setAttribute("sp_Stores", Store);

            String Commit = "";
            Commit = "clCompra";
            session.setAttribute("Commit", Commit);

            ResultSet rsGpoUsr = null;
            rsGpoUsr = UtileriasBDF.rsSQLNP("sp_PerfilC_Usr " + StrclUsr);

            if (rsGpoUsr.next()) {
                StrPerfilUsr = rsGpoUsr.getString("Perfil");
            }

            rsGpoUsr.close();
            rsGpoUsr = null;
        %> 

        <%MyUtil.InicializaParametrosC(Integer.parseInt(StrclPaginaWeb), Integer.parseInt(StrclUsr));%>
        <%=MyUtil.doMenuAct("../servlet/com.ike.guarda.EjecutaSP", "fnAlta();validaCorreo();", "fnValidaInputs();fnValidaEstatus();", "fnDatosReq();fnsp_Guarda();")%>

        <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="DetalleC_Compras.jsp?'>"%> 

        <input id="clPaginaWeb" name="clPaginaWeb" type="hidden" value="<%=StrclPaginaWeb%>" > 
        <input id="Secuencia" name="Secuencia" type="hidden" value=""> 
        <input id="SecuenciaG" name="SecuenciaG" type="hidden" value="clUsrAppRegistra,clEstatus,clAreaOperativa,clPiso,Extension,CorreoU,DetalleCompra"> 
        <input id="SecuenciaA" name="SecuenciaA" type="hidden" value="clCompra,clUsrAppRegistra,clEstatus,clAreaOperativa,clPiso,Extension,CorreoU,DetalleCompra,AutFinanza,clUsrAppAutFinanza,AutTI,clUsrAppAutTI,clUsrAppCancelacion,MotivoCancelacion,clUsrApp"> 
        <input id="clUsrApp" name="clUsrApp" type="hidden" value="<%=StrclUsr%>">
        <input id="PerfilUsr" name="PerfilUsr" type="hidden" value="<%=StrPerfilUsr%>"> 

        <%  int iY = 70;%>

        <%=MyUtil.ObjInput("Folio", "clCompra", CC != null ? CC.getclCompra() : "", false, false, 30, iY + 10, "", false, false, 10)%> 
        <%=MyUtil.ObjInput("FechaRegistro", "FechaRegistro", CC != null ? CC.getFechaRegistro() : "", false, false, 200, iY + 10, "", false, false, 20)%> 
        <input id="clUsrAppRegistra" name="clUsrAppRegistra" type="hidden" value="<%=CC != null ? CC.getclUsrAppRegistra() : ""%>" > 
        <%=MyUtil.ObjInput("Usuario que registra", "UsrRegistra", CC != null ? CC.getUsrRegistra() : "", false, false, 30, iY + 50, session.getAttribute("NombreUsuario").toString(), true, true, 54)%>
        <%=MyUtil.ObjComboC("AreaOperativa", "clAreaOperativa", CC != null ? CC.getdsAreaOperativa() : "", true, true, 30, iY + 90, "", "select clAreaOperativa,dsAreaOperativa from C_cAreaOperativa where Activo = 1", "", "", 40, true, true)%> 
        <%=MyUtil.ObjComboC("Piso", "clPiso", CC != null ? CC.getdsPiso() : "", true, true, 30, iY + 130, "", "select clPiso,dsPiso from C_cPiso where Activo = 1", "", "", 20, true, true)%> 
        <%=MyUtil.ObjInput("Extension", "Extension", CC != null ? CC.getExtension() : "", true, true, 245, iY + 130, "", true, true, 12)%>     

        <input type="hidden" id="CorreoU" name="CorreoU" value="<%=CC != null ? CC.getCorreo() : ""%>">

        <%=MyUtil.ObjInput("Correo (Usuario Solicita)", "Correo", CC != null ? CC.getCorreo() : "", true, true, 350, iY + 130, StrCorreo, true, true, 30, " validaCorreo()")%> 
        <div class='VTable' id="dvcorreo"  style='position:absolute; z-index:245; left:520px; top:213px;'>
            <p align="center">
                <font color="navy" face="Arial" size="2" ><strong>@ikeasistencia.com</strong>
        </div>
        <%=MyUtil.ObjTextArea("Detalle de la Compra", "DetalleCompra", CC != null ? CC.getDetalleCompra() : "", "100", "8", true, true, 30, iY + 180, "", true, true)%> 
        <%=MyUtil.DoBlock("Solicitud de Compra", 50, 80)%>

        <%  String StrclEstatus = CC != null ? CC.getclEstatus() : "0";%>

        <input id="clUsrAppCancelacion" name="clUsrAppCancelacion" type="hidden" value="<%=CC != null ? CC.getclUsrAppCancelacion() : ""%>" > 
        <%=MyUtil.ObjComboC("Estatus", "clEstatus", CC != null ? CC.getdsEstatus() : "", false, true, 30, iY + 350, "1", "st_GetC_Estatus " + StrclEstatus + "," + StrclCompra, "fnValidaEstatus();", "", 20, false, true)%> 
        <%=MyUtil.ObjInputDiv("Usuario que cancela", "UsrAutCancela", CC != null ? CC.getUsrCancelacion() : "", true, true, 30, iY + 390, "", false, false, 40, "", "UsrCancela")%>
        <%=MyUtil.ObjTextArea("Motivo de la Cancelación", "MotivoCancelacion", CC != null ? CC.getMotivoCancelacion() : "", "56", "5", true, true, 260, iY + 350, "", false, false)%> 
        <%=MyUtil.DoBlock("Estatus de Solicitud", 140, 0)%>

        <%  iY = 70;%>
        <div id="Autorizacion">
            <%=MyUtil.ObjChkBox("Autorizacion  <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbspTI", "AutTI", CC != null ? CC.getAutTI() : "0", true, true, 30, iY + 480, "0", "SI", "NO", "fnAutorizacion(2);")%>  
            <input id="clUsrAppAutTI" name="clUsrAppAutTI" type="hidden" value="<%=CC != null ? CC.getclUsrAppAutTI() : ""%>" > 
            <%=MyUtil.ObjInput("Usuario Autotizacion TI", "UsrAutTI", CC != null ? CC.getUsrAutTI() : "", false, false, 150, iY + 490, "", false, false, 40)%>
            <%=MyUtil.ObjChkBox("Autorizacion <br>&nbsp;&nbsp;&nbsp;&nbsp;Finanzas", "AutFinanza", CC != null ? CC.getAutFinanza() : "0", true, true, 30, iY + 540, "0", "SI", "NO", "fnAutorizacion(1);")%>  
            <input id="clUsrAppAutFinanza" name="clUsrAppAutFinanza" type="hidden" value="<%=CC != null ? CC.getclUsrAppAutFinanza() : ""%>" > 
            <%=MyUtil.ObjInput("Usuario Autotizacion Finanzas", "UsrAutFinanza", CC != null ? CC.getUsrAutFinanza() : "", false, false, 150, iY + 550, "", false, false, 40)%>
            <%=MyUtil.DoBlock("Autorizacion", 50, 10)%>

        </div>

        <%=MyUtil.GeneraScripts()%> 

        <%
            if (CC != null) {
                if (CC.getclEstatus().equalsIgnoreCase("6") || CC.getclEstatus().equalsIgnoreCase("8")) {
        %><script>document.all.btnCambio.disabled = true;</script><%                                    }
            }
            //<<<<<<<<<<<<<<<< Limpiar Variables >>>>>>>>>  
            StrclUsr = null;
            StrclPaginaWeb = null;
            daoC_Compras = null;
            CC = null;
            StrCorreo = null;
        %>  

        <script>
            document.all.Autorizacion.style.visibility = 'hidden';
            document.all.UsrCancela.style.visibility = 'hidden';

            //<<<<<<<<<<<<<<<< Función para Validar el Estatus de la Solicitud >>>>>>>>>>>>>>>

            function fnShowHiddenDiv() {
                var clEstatus = document.all.clEstatus.value;
                var PerfilUsr = document.all.PerfilUsr.value;

                if (clEstatus >= 3 && PerfilUsr != 0) {
                    document.all.Autorizacion.style.visibility = 'visible';
                }

                if (clEstatus == 6) {
                    document.all.UsrCancela.style.visibility = 'visible';
                }
            }

            function fnValidaEstatus() {
                var clEstatus = document.all.clEstatus.value;
                var PerfilUsr = document.all.PerfilUsr.value;

                if (clEstatus >= 3 && PerfilUsr != 0) {
                    if (clEstatus == 6) {
                        document.all.Autorizacion.style.visibility = 'hidden';

                    }
                    else {
                        document.all.Autorizacion.style.visibility = 'visible';
                    }

                    //<<<<<<<<<<<<<<< GERENTE FI >>>>>>>>>>>>>>>>>>>
                    if (PerfilUsr == 3) {
                        document.all.AutFinanzaC.disabled = false;
                    }
                    else {
                        document.all.AutFinanzaC.disabled = true;
                    }

                    //<<<<<<<<<<<<<<< GERENTE TI - MEX  >>>>>>>>>>>>>>>>>>>
                    if (PerfilUsr == 2) {
                        document.all.AutTIC.disabled = false;
                    }
                    else {
                        document.all.AutTIC.disabled = true;
                    }
                }

                //<<<<<<<<<<<<<<< Estatus de Cancelacion >>>>>>>>>>>>>>>
                if (clEstatus == 6) {
                    document.all.MotivoCancelacion.disabled = false;
                    document.all.UsrCancela.style.visibility = 'visible';
                }
                else {
                    document.all.MotivoCancelacion.disabled = true;
                    document.all.UsrCancela.style.visibility = 'hidden';
                }
            }
            //<<<<<<<<<<<<<<<<<<<< Función para el evento de Alta >>>>>>>>>>>>>>>>>>>>>>
            function fnAlta() {
                document.all.clUsrAppRegistra.value = document.all.clUsrApp.value;
                // document.all.clUsrAppRegistra.value=document.all.clUsrApp.value;
            }
            //<<<<<<<<<<<<<<<<<<<<<< Autorizacion de la compra >>>>>>>>>>>>>>>>>
            function fnAutorizacion(TipoAut) {
                //<<<<<<< Aut Finanzas >>>>>>>
                if (TipoAut == 1) {
                    if (document.all.AutFinanzaC.checked == 1) {
                        document.all.clUsrAppAutFinanza.value = document.all.clUsrApp.value;
                    }
                    else {
                        document.all.clUsrAppAutFinanza.value = '0';
                    }
                }
                //<<<<<<< Aut TI >>>>>>>
                if (TipoAut == 2) {
                    if (document.all.AutTIC.checked == 1) {
                        document.all.clUsrAppAutTI.value = document.all.clUsrApp.value;
                    }
                    else {
                        document.all.clUsrAppAutTI.value = '0';
                    }
                }
            }

            function fnValidaInputs() {

                if (document.all.AutFinanzaC.checked == 1) {
                    document.all.AutFinanzaC.disabled = true;
                }
                if (document.all.AutTIC.checked == 1) {
                    document.all.AutTIC.disabled = true;
                }

                if (document.all.PerfilUsr.value != 1 && document.all.PerfilUsr.value != 2) {
                    document.all.clEstatusC.disabled = true;
                }
            }

            function validaCorreo() {
                if (document.all.Correo.value != '') {
                    if (document.all.Action.value == 1) {
                        if (document.all.Correo.value.indexOf('@', 0) != -1) {
                            alert("La dirección de correo no es valida.");
                            document.all.Correo.focus();
                        }else{
                            document.all.CorreoU.value = document.all.Correo.value + '@ikeasistencia.com';    
                        }
                         }else{
                            if (document.all.Action.value == 2) {
                                document.all.CorreoU.value = document.all.Correo.value;
                           }
                        }
                    }
                }

            function fnDatosReq() {

                var clEstatus = document.all.clEstatus.value;

                if (clEstatus == 6) {
                    if (document.all.MotivoCancelacion.value == '') {
                        msgVal = msgVal + " Motivo de la Cancelación. ";
                        document.all.btnGuarda.disabled = false;
                        document.all.btnCancela.disabled = false;
                    }
                    document.all.clUsrAppCancelacion.value = document.all.clUsrApp.value;
                }
            }

        </script>
        <%
            StrclUsr = null;
            StrclPaginaWeb = null;
            StrclCompra = null;
            StrPerfilUsr = null;
            StrCorreo = null;
        %>
    </body>
</html>
