<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@ page pageEncoding="iso-8859-1"%>

<html>
    <head>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <style type="text/css">

            .texto{
                text-align: right;
                font-family: Sans-Serif;
                font-size: 17px;
                font-weight: bold;
                color: #233654;

            }

            .textoAsig{
                font-family: Sans-Serif;
                font-size: 16px;
                font-weight: bold;
                color: #233654;
                text-align: left;
                padding-left: 5px;
                /*padding-left: 5px*/
            }

        </style>
    </head>
    <body bgcolor="#ebf1f9">

        <%
                    StringBuffer StrSql = new StringBuffer();
                    //StringBuffer strSalida = new StringBuffer();

                    String pTipoInfo = "1";
                    String StrclUsrApp = "0";
                    String StrclPaginaWeb = "0";

                    if (request.getParameter("Tipo") != null) {
                        if (request.getParameter("Tipo").compareToIgnoreCase("") != 0) {
                            pTipoInfo = request.getParameter("Tipo");
                        }
                    }

                    if (session.getAttribute("clUsrApp") != null) {
                        StrclUsrApp = session.getAttribute("clUsrApp").toString();
                    }

                    if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {
        %>Fuera de Horario<%
                        return;
                    }
                    StringBuffer strSalida = new StringBuffer();


                    if (pTipoInfo.compareToIgnoreCase("1") == 0) {
        %>
        <div id="PlasmaMedicaAmbulancia">
            <table style="background: url(../Imagenes/banner_fondo.png); background-repeat:repeat-x;" width="100%">
                <tr style="height: 70px">
                    <td align="center" height="55px" width="210px">
                        <img alt="Ike Asistencia Argentina" src="../Imagenes/banner_arg.png">
                    </td>
                    <td align="center" width="100%" class="cssTituloPlasma" id="LabelMon" style="">Médico - Ambulancia</td>
                </tr>
            </table>
            <table width="760px">
                <tr>
                    <td width="200px">
                        <input class='cBtnPlasma' value='CERRAR...' onClick='top.window.close()' type='button'>
                    </td>
                    <td class="texto" width="150px" >ASIGNACIÓN:</td>
                    <td class="cssPlasmaVerde" width="50px"> </td><td class="textoAsig" width="70px">0 a 5</td>
                    <td class="cssPlasmaAmarillo" width="50px" > </td><td class="textoAsig" width="70px">6 a 10</td>
                    <td class="cssPlasmaRojo" width="50px" > </td><td class="textoAsig" width="70px">> 11</td>
                </tr>
                <tr style="height: 25px;">
                    <td width="200px"></td>
                    <td class="texto" width="150px" >CONTACTO:</td>
                    <td class="cssPlasmaVerde" width="50px"></td><td class="textoAsig" width="70px">0 a 15</td>
                    <td class="cssPlasmaAmarillo" width="50px"></td><td class="textoAsig" width="70px">16 a 20</td>
                    <td class="cssPlasmaRojo" width="50px"></td><td class="textoAsig" width="70px">> 20</td>
                    <td ></td>
                </tr>
            </table>
            <div style="height: 25px"></div>
            <table>
                <%
                                        //  EXP. SIN ASIGNACION DE PROVEEDOR
                                        StrSql.append("sp_PlasmaExpSinProvxServicio 2");%>
                <%UtileriasBDF.rsTablePlasmaNP(StrSql.toString(), 10, "Sin Asignación de Proveedor", strSalida);%>
                <%=strSalida.toString()%>
                <%strSalida.delete(0, strSalida.length());
                                        StrSql.delete(0, StrSql.length());

                                        //  EXP. SIN CONTACTO
                                        StrSql.append("sp_PlasmaAsisAbSPMonit 2");%>
                <%UtileriasBDF.rsTablePlasmaNP(StrSql.toString(), 10, "Sin Contacto", strSalida);%>
                <%=strSalida.toString()%>
                <%strSalida.delete(0, strSalida.length());
                                        StrSql.delete(0, StrSql.length());

                                        pTipoInfo = "2";
                                    } else if (pTipoInfo.compareToIgnoreCase("2") == 0) {
                %>
            </table>
        </div>

        <div id="PlasmaVialAsignacion">
            <table style="background: url(../Imagenes/banner_fondo.png); background-repeat:repeat-x;" width="100%">
                <tr style="height: 70px">
                    <td align="center" height="55px" width="210px">
                        <img alt="Ike Asistencia Argentina" src="../Imagenes/banner_arg.png">
                    </td>
                    <td align="center" width="100%" class="cssTituloPlasma" id="LabelMon" style="">Vial Asignación</td>
                </tr>
            </table>
            <table width="660px" cellpadding="0px" >
                <tr>
                    <td width="200px">
                        <input class='cBtnPlasma' value='CERRAR...' onClick='top.window.close()' type='button'>
                    </td>
                    <td class="texto" width="150px">ASIGNACIÓN:</td>
                    <td class="cssPlasmaVerde" width="50px" style="max-width: 30px"></td><td class="textoAsig" width="70px">0 a 7</td>
                    <td class="cssPlasmaAmarillo" width="50px" style="max-width: 30px"></td><td class="textoAsig" width="70px">8 a 10</td>
                    <td class="cssPlasmaRojo" width="50px" style="max-width: 30px"></td><td class="textoAsig" width="70px">> 10</td>
                    <td ></td>
                </tr>
            </table>
            <div style="height: 25px"></div>
            <table>
                <%
                                        //  EXP. SIN ASIGNACION DE PROVEEDOR
                                        StrSql.append("sp_PlasmaExpSinProvxServicio 1");%>
                <%UtileriasBDF.rsTablePlasmaNP(StrSql.toString(), 15, "Sin Asignación de Proveedor", strSalida);%>
                <%=strSalida.toString()%>
                <%strSalida.delete(0, strSalida.length());
                                        StrSql.delete(0, StrSql.length());

                                        pTipoInfo = "3";
                                    } else if (pTipoInfo.compareToIgnoreCase("3") == 0) {
                %>
            </table>
        </div>

        <div id="PlasmaHogarAsignacion">
            <table style="background: url(../Imagenes/banner_fondo.png); background-repeat:repeat-x;" width="100%">
                <tr style="height: 70px">
                    <td align="center" height="55px" width="210px">
                        <img alt="Ike Asistencia Argentina" src="../Imagenes/banner_arg.png">
                    </td>
                    <td align="center" width="100%" class="cssTituloPlasma" id="LabelMon" style="">Hogar Asignación</td>
                </tr>
            </table>
            <table width="660px" cellpadding="0px" >
                <tr>
                    <td width="200px">
                        <input class='cBtnPlasma' value='CERRAR...' onClick='top.window.close()' type='button'>
                    </td>
                    <td class="texto" width="150px">ASIGNACIÓN:</td>
                    <td class="cssPlasmaVerde" width="50px" style="max-width: 30px"></td><td class="textoAsig" width="70px">0 a 7</td>
                    <td class="cssPlasmaAmarillo" width="50px" style="max-width: 30px"></td><td class="textoAsig" width="70px">8 a 10</td>
                    <td class="cssPlasmaRojo" width="50px" style="max-width: 30px"></td><td class="textoAsig" width="70px">> 10</td>
                    <td ></td>
                </tr>
            </table>
            <div style="height: 25px"></div>
            <table>
                <%
                                        //  EXP. HOGAR SIN ASIGNACION DE PROVEEDOR
                                        StrSql.append("sp_PlasmaExpSinProvxServicio 5");%>
                <%UtileriasBDF.rsTablePlasmaNP(StrSql.toString(), 15, "Sin Asignación de Proveedor", strSalida);%>
                <%=strSalida.toString()%>
                <%strSalida.delete(0, strSalida.length());
                                        StrSql.delete(0, StrSql.length());
                                        pTipoInfo = "4";
                                    } else if (pTipoInfo.compareToIgnoreCase("4") == 0) {
                %>
            </table>
        </div>

        <div id="PlasmaVialMonitoreo">
            <table style="background: url(../Imagenes/banner_fondo.png); background-repeat:repeat-x;" width="100%">
                <tr style="height: 70px">
                    <td align="center" height="55px" width="210px">
                        <img alt="Ike Asistencia Argentina" src="../Imagenes/banner_arg.png">
                    </td>
                    <td align="center" width="100%" class="cssTituloPlasma" id="LabelMon" style="">Vial 1er Monitoreo</td>
                </tr>
            </table>
            <table width="710px" cellpadding="0px" >
                <tr>
                    <td width="200px">
                        <input class='cBtnPlasma' value='CERRAR...' onClick='top.window.close()' type='button'>
                    </td>
                    <td class="texto" width="200px">TIEMPO RESTANTE:</td>
                    <td class="cssPlasmaVerde" width="50px" style="max-width: 30px"></td><td class="textoAsig" width="70px">0 a 15</td>
                    <td class="cssPlasmaAmarillo" width="50px" style="max-width: 30px"></td><td class="textoAsig" width="70px">16 a 20</td>
                    <td class="cssPlasmaRojo" width="50px" style="max-width: 30px"></td><td class="textoAsig" width="70px">>20</td>
                    <td ></td>
                </tr>
            </table>
            <div style="height: 25px"></div>
            <table>
                <%
                                        //  EXP. VIALES SIN MONITOREO
                                        StrSql.append("st_PlasmaExpMonitoreoVial 1");%>
                <%UtileriasBDF.rsTablePlasmaNP(StrSql.toString(), 15, "Expedientes sin Monitoreo", strSalida);%>
                <%=strSalida.toString()%>
                <%strSalida.delete(0, strSalida.length());
                                        StrSql.delete(0, StrSql.length());

                                        pTipoInfo = "5";
                                    } else if (pTipoInfo.compareToIgnoreCase("5") == 0) {
                %>
            </table>
        </div>

        <div id="PlasmaHogarCitas">
            <table style="background: url(../Imagenes/banner_fondo.png); background-repeat:repeat-x;" width="100%">
                <tr style="height: 70px">
                    <td align="center" height="55px" width="210px">
                        <img alt="Ike Asistencia Argentina" src="../Imagenes/banner_arg.png">
                    </td>
                    <td align="center" width="100%" class="cssTituloPlasma" id="LabelMon" style="">Hogar Citas</td>
                </tr>
            </table>
            <table width="710px" cellpadding="0px" >
                <tr>
                    <td width="200px">
                        <input class='cBtnPlasma' value='CERRAR...' onClick='top.window.close()' type='button'>
                    </td>
                    <td class="texto" width="200px">TIEMPO RESTANTE:</td>
                    <td class="cssPlasmaVerde" width="50px" style="max-width: 30px"></td><td class="textoAsig" width="70px">> 60</td>
                    <td class="cssPlasmaAmarillo" width="50px" style="max-width: 30px"></td><td class="textoAsig" width="70px">60 a 15</td>
                    <td class="cssPlasmaRojo" width="50px" style="max-width: 30px"></td><td class="textoAsig" width="70px">14 a 0</td>
                    <td ></td>
                </tr>
            </table>
            <div style="height: 25px"></div>
            <table>
                <%
                                        //  CITAS de HOGAR PENDIENTES
                                        StrSql.append("sp_PlasmaCitasSinContacto 5");%>
                <%UtileriasBDF.rsTablePlasmaNP(StrSql.toString(), 15, "Sin Asignación de Proveedor", strSalida);%>
                <%=strSalida.toString()%>
                <%strSalida.delete(0, strSalida.length());
                                        StrSql.delete(0, StrSql.length());

                                        pTipoInfo = "6";
                                    } else if (pTipoInfo.compareToIgnoreCase("6") == 0) {
                %>
            </table>
        </div>

        <div id="PlasmaVialContacto">
            <table style="background: url(../Imagenes/banner_fondo.png); background-repeat:repeat-x;" width="100%">
                <tr style="height: 70px">
                    <td align="center" height="55px" width="210px">
                        <img alt="Ike Asistencia Argentina" src="../Imagenes/banner_arg.png">
                    </td>
                    <td align="center" width="100%" class="cssTituloPlasma" id="LabelMon" style="">Vial Contacto</td>
                </tr>
            </table>
            <table width="1000px" cellpadding="0px" >
                <tr>
                    <td width="200px">
                        <input class='cBtnPlasma' value='CERRAR...' onClick='top.window.close()' type='button'>
                    </td>
                    <td class="texto" width="150px">EXPEDIENTE:</td>
                    <td class="cssPlasmaVerde" width="50px" style="max-width: 30px"></td><td class="textoAsig" width="200px">30 min antes contacto</td>
                    <td class="cssPlasmaAmarillo" width="50px" style="max-width: 30px"></td><td class="textoAsig" width="200px">15 min antes contacto</td>
                    <td class="cssPlasmaRojo" width="50px" style="max-width: 30px"></td><td class="textoAsig" width="150px">tiempo cumplido</td>
                    <td ></td>
                </tr>
            </table>
            <div style="height: 25px"></div>
            <table>
                <%
                                        //  EXP. VIALES SIN CONTACTO
                                        StrSql.append("st_PlasmaExpSinContacto 1");%>
                <%UtileriasBDF.rsTablePlasmaNP(StrSql.toString(), 15, "Expedientes sin Contacto", strSalida);%>
                <%=strSalida.toString()%>
                <%strSalida.delete(0, strSalida.length());
                                        StrSql.delete(0, StrSql.length());

                                        pTipoInfo = "7";
                                    } else if (pTipoInfo.compareToIgnoreCase("7") == 0) {
                %>
            </table>
        </div>

        <div id="PlasmaExpContacto">
            <table style="background: url(../Imagenes/banner_fondo.png); background-repeat:repeat-x;" width="100%">
                <tr style="height: 70px">
                    <td align="center" height="55px" width="210px">
                        <img alt="Ike Asistencia Argentina" src="../Imagenes/banner_arg.png">
                    </td>
                    <td align="center" width="100%" class="cssTituloPlasma" id="LabelMon" style="">Expedientes sin Proveedor</td>
                </tr>
            </table>
            <table width="660px" cellpadding="0px" >
                <tr>
                    <td width="200px">
                        <input class='cBtnPlasma' value='CERRAR...' onClick='top.window.close()' type='button'>
                    </td>
                    <td class="texto" width="150px">ASIGNACIÓN:</td>
                    <td class="cssPlasmaVerde" width="50px" style="max-width: 30px"></td><td class="textoAsig" width="70px">0 a 7</td>
                    <td class="cssPlasmaAmarillo" width="50px" style="max-width: 30px"></td><td class="textoAsig" width="70px">8 a 10</td>
                    <td class="cssPlasmaRojo" width="50px" style="max-width: 30px"></td><td class="textoAsig" width="70px">> 10</td>
                    <td ></td>
                </tr>
            </table>
            <div style="height: 25px"></div>
            <table>
                <%
                                        //  TOTAL DE EXPEDIENTES SIN PROVEEDOR
                                        StrSql.append("sp_PlasmaExpSinProvxServicio 10");%>
                <%UtileriasBDF.rsTablePlasmaNP(StrSql.toString(), 15, "Sin Asignación de Proveedor", strSalida);%>
                <%=strSalida.toString()%>
                <%strSalida.delete(0, strSalida.length());
                                        StrSql.delete(0, StrSql.length());

                                        //pTipoInfo = "3";
                                    }
                %>
            </table>
        </div>

    </body>
</html>