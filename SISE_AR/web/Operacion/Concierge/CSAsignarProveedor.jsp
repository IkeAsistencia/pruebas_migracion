<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="Seguridad.SeguridadC,java.sql.ResultSet,Utilerias.UtileriasBDF,com.ike.concierge.DAOConciergeG,com.ike.concierge.to.ConciergeG,com.ike.concierge.DAOReferenciasxAsist,com.ike.concierge.to.ReferenciasxAsist,Combos.cbPais,Combos.cbEntidad" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head>
        <title>Asignar Proveedor</title>
        <link rel="stylesheet" id="cssRef" href="floating_window_with_tabs-skin2.css" media="screen">
        <script type="text/javascript">
            var floating_window_skin = 2;
        </script>
        <script type="text/javascript" src="floating_window_with_tabs.js"></script>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody" onLoad="fnChkArgentina();fnVerificaPais(document.all.clPais.value)">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" />
        <script type="text/javascript" src='../../Utilerias/Util.js' ></script>
        <script type="text/javascript" src='../../Utilerias/UtilAjax.js'></script>
        <script type="text/javascript" src='../../Utilerias/UtilDireccion.js' ></script>

        <%
                    String strclUsr = "0";
                    String StrclConcierge = "0";
                    String StrclAsistencia = "0";
                    String CodEnt = "";

                    String CodMD = "";
                    String dsEntFed = "";
                    String dsMunDel = "";
                    String StrclSubservicio = "0";
                    String StrDescrip = "";
                    String StrclPais = "10";

                    DAOConciergeG daosg = null;
                    ConciergeG conciergeg = null;

                    DAOReferenciasxAsist daoRef = null;
                    ReferenciasxAsist ref = null;

                    if (session.getAttribute("clUsrApp") != null) {
                        strclUsr = session.getAttribute("clUsrApp").toString();
                    }

                    if (request.getParameter("clConcierge") != null) {
                        StrclConcierge = request.getParameter("clConcierge").toString();
                    } else {
                        if (session.getAttribute("clConcierge") != null) {
                            StrclConcierge = session.getAttribute("clConcierge").toString();
                        }
                    }

                    if (request.getParameter("clAsistencia") != null) {
                        StrclAsistencia = request.getParameter("clAsistencia").toString();
                    } else {
                        if (session.getAttribute("clAsistencia") != null) {
                            StrclAsistencia = session.getAttribute("clAsistencia").toString();

                        }
                    }

                    if (strclUsr != null) {
                        daoRef = new DAOReferenciasxAsist();
                        ref = daoRef.getclAsistencia(StrclAsistencia);
                        //System.out.println("Ais " + StrclAsistencia);
                    }

                    if (strclUsr != null) {
                        daosg = new DAOConciergeG();
                        conciergeg = daosg.getConciergeGenerico(StrclConcierge);

                    }
                    if (request.getParameter("CodEnt") != null) {
                        CodEnt = request.getParameter("CodEnt").toString();
                    } else {
                        if (session.getAttribute("CodEnt") != null) {
                            CodEnt = session.getAttribute("CodEnt").toString();
                        }
                    }

                    if (request.getParameter("CodMD") != null) {
                        CodMD = request.getParameter("CodMD").toString();
                    } else {
                        if (session.getAttribute("CodMD") != null) {
                            CodMD = session.getAttribute("CodMD").toString();
                        }
                    }

                    if (request.getParameter("dsEntFed") != null) {
                        dsEntFed = request.getParameter("dsEntFed").toString();
                    } else {
                        if (session.getAttribute("dsEntFed") != null) {
                            dsEntFed = session.getAttribute("dsEntFed").toString();
                        }
                    }

                    if (request.getParameter("dsMunDel") != null) {
                        dsMunDel = request.getParameter("dsMunDel").toString();
                    } else {
                        if (session.getAttribute("dsMunDel") != null) {
                            dsMunDel = session.getAttribute("dsMunDel").toString();
                        }
                    }

                    if (request.getParameter("clSubservicio") != null) {
                        StrclSubservicio = request.getParameter("clSubservicio").toString();
                    } else {
                        if (session.getAttribute("clSubservicio") != null) {
                            StrclSubservicio = session.getAttribute("clSubservicio").toString();
                        }
                    }

                    if (request.getParameter("Descrip") != null) {
                        StrDescrip = request.getParameter("Descrip").toString();
                    } else {
                        if (session.getAttribute("Descrip") != null) {
                            StrDescrip = session.getAttribute("Descrip").toString();
                        }
                    }

                    if (request.getParameter("clPais") != null) {
                        StrclPais = request.getParameter("clPais").toString();
                    } else {
                        if (session.getAttribute("clPais") != null) {
                            StrclPais = session.getAttribute("clPais").toString();
                        }
                    }

                    String StrclPaginaWeb = "722";
                    session.setAttribute("clPaginaWebP", StrclPaginaWeb);

                    MyUtil.InicializaParametrosC(722, Integer.parseInt(strclUsr));

                    //-----------------------------------------------------
                    // SE AGREGA CODIGO PARA EL MANEJO DE LAS ASISTENCIAS DUPLICADAS.
                    String StrclAsistenciaVTR = "";
                    ResultSet rsTieneAsistMadre = null;
                    rsTieneAsistMadre = UtileriasBDF.rsSQLNP(" st_CSTieneAsistMadre " + StrclAsistencia);

                    if (rsTieneAsistMadre.next()) {
                        if (rsTieneAsistMadre.getString("TieneAsistMadre").equalsIgnoreCase("1")) {
                            StrclAsistenciaVTR = rsTieneAsistMadre.getString("Folio");
                        } else {
                            //StrclAsistenciaVTR = ConciergeInfTC!=null ? ConciergeInfTC.getClAsistencia().trim() : "";
                            StrclAsistenciaVTR = StrclAsistencia;
                        }
                        session.setAttribute("clAsistenciaVTR", StrclAsistenciaVTR);
                    }

                    rsTieneAsistMadre.close();
                    rsTieneAsistMadre = null;
                    //-----------------------------------------------------
        %>

        <script type="text/javascript" >fnOpenLinks()</script>

        <form id='Forma' name ='Forma'  action='CSAsignarProveedor.jsp?' method='post'>
            <div class='VTable' style='position:absolute; z-index:25; left:30px; top:10px;'>
                <input type="hidden" value="<%=strclUsr%>" id="clUsrApp" name="clUsrApp">
                <p><font color="navy" face="Arial" size="3" ><b><i> Búsqueda de Referencias</i></b></font>
                    <%=MyUtil.ObjComboMem("Pais", "clPais", "", "10", cbPais.GeneraHTML(20, StrclPais != null ? StrclPais : ""), true, true, 30, 50, "0", "fnLlenaEntidadAjaxFn(this.value);fnVerificaPais(this.value);", "", 30, false, false)%>
                <div id="DivArgentina">
                    <%=MyUtil.ObjComboMemDiv("Provincia", "CodEnt", dsEntFed != null ? dsEntFed : "", CodEnt != null ? CodEnt : "", cbEntidad.GeneraHTML(40, dsEntFed != null ? dsEntFed : "", Integer.parseInt(StrclPais != null ? StrclPais : "")), true, true, 30, 90, "", "fnLLenaComboMDAjax(this.value);", "", 40, false, false, "ProvinciaDiv")%>
                    <%=MyUtil.ObjComboMemDiv("Localidad", "CodMD", dsMunDel != null ? dsMunDel : "", CodMD != null ? CodMD : "", cbEntidad.GeneraHTMLMD(40, CodEnt != null ? CodEnt : "", dsMunDel != null ? dsMunDel : ""), true, true, 430, 90, "", "", "", 30, false, false, "LocalidadDiv")%>
                </div>
                <div id="DivOtroPais">
                    <%=MyUtil.ObjInput("Entidad / Provincia", "Entidad", "", true, true, 30, 90, "", false, false, 30)%>
                    <%=MyUtil.ObjInput("Ciudad", "Ciudad", "", true, true, 260, 90, "", false, false, 30)%>
                </div>
                <div class='VTable' style='position:absolute; z-index:5; left:30px; top:130px;'>
                    <p class='FTable'>Nombre del Establecimiento<br><INPUT class='VTable' id='Descrip' name='Descrip' type='text' class='VTable' value=''  maxlength="100" size="40" ></p>
                </div>
                <div class='VTable' style='position:absolute; z-index:5; left:260px; top:130px;'>
                    <p class='FTable'>Descripcion de Servicios<br><INPUT class='VTable' id='DescripS' name='DescripS' type='text' class='VTable' value=''  maxlength="100" size="40" ></p>
                </div>
                <div class='VTable' style='position:absolute; z-index:5; left:490px; top:140px;'>
                    <input type="button" onClick="fnBuscarProv()" class="cBtn" value="Buscar">
                </div>
                <%=MyUtil.DoBlock("Buscar Referencias", 150, 30)%>
            </div>
            <div class='VTable' style='position:absolute; z-index:25; left:30px; top:210px;'>
                <br><br><hr size="1">
                <p><font color="navy" face="Arial" size="3" ><b><i>Referencias Asignadas</i></b> </font></p>
                <div  style='position:absolute; z-index:25; left:200px; top:35px;'>
                    <iframe src="CSPDFxPaginaWeb.jsp"  height="65" scrolling="no" frameborder="0" ></iframe>
                </div>
                <%
                            StringBuffer strSalida2 = new StringBuffer();
                            UtileriasBDF.rsTableNP("st_CSListaProveedoresAsignados " + StrclAsistencia, strSalida2);
                %>
                <%=strSalida2.toString()%>
                <%strSalida2.delete(0, strSalida2.length());%>
            </div>
        </form>

        <script  type="text/javascript" >

            document.all.clPaisC.disabled=false;
            document.all.CodEntC.disabled=false;
            document.all.CodMDC.disabled=false;
            document.all.Entidad.readOnly=false;
            document.all.Ciudad.readOnly=false;

            function fnEnviaDatos(){
                document.all.Forma.submit();
            }

            function fnChkArgentina(){
                if (document.all.clPaisC.value==0 || document.all.clPaisC.value==""){
                    document.all.clPaisC.value = 10;
                }
            }

            function fnVerificaPais(pais){

                //<<<<<<<<<<<<< Para ARG>>>>>>>>>>>>>>
                if (pais==10){
                    document.all.DivOtroPais.style.visibility='hidden';
                    document.all.DivArgentina.style.visibility='visible';

                    document.all.Entidad.value = '';
                    document.all.Ciudad.value = '';
                }
                //<<<<<<<<<<<< Resto del Mundo >>>>>>>>>>>>>>>>>>
                else{
                    document.all.DivArgentina.style.visibility='hidden';
                    document.all.DivOtroPais.style.visibility='visible'

                    document.all.CodEnt.value = '';
                    document.all.CodEntC.value = '';
                    document.all.CodMD.value = '';
                    document.all.CodMDC.value = '';
                }
            }

            function fnLlenaEntidadAjaxFn(cod){  /// Llena ComboMemDiv de Entidad segun pais seleccionado CON funcion
                IDCombo='CodEnt';
                Label='Provincia';
                IdDiv='ProvinciaDiv';
                FnCombo='fnLLenaComboMDAjax(this.value);';
                URL = "../../servlet/Combos.LlenaEntidadAjax?";
                Cadena = "Opcion="+cod+"&IdCombo="+IDCombo+"&Label="+Label+"&FnCombo="+FnCombo;
                fnLLenaInput(URL, Cadena, IdDiv);
            }

            function fnLLenaComboMDAjax(value){
                IDCombo= 'CodMD';
                Label='Localidad';
                IdDiv='LocalidadDiv';
                URL = "../../servlet/Combos.LlenaMDAjax?";
                Cadena = "Opcion="+value+"&IdCombo="+IDCombo+"&Label="+Label;
                fnLLenaInput(URL, Cadena, IdDiv);
            }

            function fnBuscarProv(){
                if (document.all.clPaisC.value==""){ alert("No se eligió Pais"); return;}
                //alert('CSBuscarProveedor.jsp?clConcierge=<%=StrclConcierge%>&clAsistencia=<%=StrclAsistencia%>&clSubServicio=<%=StrclSubservicio%>&CodEnt=' + document.all.CodEntC.value + '&CodMD=' + document.all.CodMDC.value + '&Descrip='+ document.all.Descrip.value + '&clPais=' + document.all.clPaisC.value  + '&DescripcionS='+ document.all.DescripS.value + '&Entidad=' + document.all.Entidad.value + '&ciudad='+ document.all.Ciudad.value,'Search','scrollbars=yes,status=yes,width=550,height=300').toString();
                window.open('CSBuscarProveedor.jsp?clConcierge=<%=StrclConcierge%>&clAsistencia=<%=StrclAsistencia%>&clSubServicio=<%=StrclSubservicio%>&CodEnt=' + document.all.CodEntC.value + '&CodMD=' + document.all.CodMDC.value + '&Descrip='+ document.all.Descrip.value + '&clPais=' + document.all.clPaisC.value  + '&DescripcionS='+ document.all.DescripS.value + '&Entidad=' + document.all.Entidad.value + '&ciudad='+ document.all.Ciudad.value,'Search','scrollbars=yes,status=yes,width=550,height=300');
            }

        </script>

        <%@ include file="csVentanaFlotante.jspf" %>
        <%
                    strclUsr = null;
                    StrclConcierge = null;
                    StrclAsistencia = null;
                    CodEnt = null;
                    CodMD = null;
                    dsEntFed = null;
                    dsMunDel = null;
                    StrclSubservicio = null;
                    StrDescrip = null;
                    StrclPais = null;
        %>
        <script type="text/javascript">
            initFloatingWindowWithTabs('window4',Array('Nuestro Usuario','Referencias'),350,250,700,20,false,false,true,true,false);
        </script>
    </body>
</html>
