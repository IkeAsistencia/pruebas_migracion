<%@page import="com.ike.catalogos.to.ConceptosCosto"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Utilerias.ResultList"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<html>
    <head>
        <title>Excepciones</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <script src="http://code.jquery.com/jquery-1.10.2.min.js"></script>
        <script src='../Utilerias/Util.js' ></script>

        <script type="text/javascript">

            var count = 0;
            var countClick = 0;

            function fnMostrar() {
                if (count == 1) {
                    countClick = 0;
                } else {
                    //vaciar los valores del div cuando se oculte y tenga información
                    document.getElementById('nombre').value = '';
                    document.getElementById('estatusC').value = '';
                    this.disabled = true;
                    document.all.btnGuarda.disabled = true;
                    document.all.btnAlta.disabled = false;
                    document.all.btnCambio.disabled = false;
                    document.all.btnElimina.disabled = false;
                    countClick++;
                    count++;
                }
            }

            function fnModificacion(clExcepcion, nombreExcepcion, clCuenta, strServicio, strSubServicio, estatus) {
                //alert(countClick)
                if (countClick == 0) {
                    $("#btnAltaBoton").click();
                    $("#btnCambio").click();
                    countClick++;
                } 

                document.getElementById('clExcepcionPorCuenta').value = clExcepcion;
                document.getElementById('nombre').value = nombreExcepcion;
                document.getElementById('clCuenta').value = clCuenta;
                document.getElementById('nombreServicio').value = strServicio;
                document.getElementById('nombreSubServicio').value = strSubServicio;
                if (estatus == 'Activo') {
                    document.getElementById('estatusC').value = 1;
                } else {
                    document.getElementById('estatusC').value = 0;
                }
            }
        </script>

        <script type="text/javascript">
            $(document).ready(function () {
                $('#btnAltaBoton').click(function () {
                    $('#divAlta').slideToggle(2000);
                });
            });
        </script>

        <style>

            .etiquetaTabla{
                color: #FFFFFF;
                background-color: #FE7018;
                font-family: Arial, Helvetica, sans-serif;
                font-size: 11px;
                padding: 5px;
                text-transform: uppercase;
                text-align: center;
                width: 800px;
            }

            hr{ 
                height:5px; 
                background-color:#ff0000; 
                border:none; 
            }
            
            

        </style>
    </head>
    <body class="cssBody" >
        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj"/>

        <%
            String strclCuenta = "0";
            String StrclPaginaWeb = "6108";
            String strclUsr = "0";
            int strclExcepcion = 0;
            String strNombre = "";
            String strEstatus = "";
            String strDsCuenta = "";
            ResultSet resultSet = null;
            StringBuffer StrSql = new StringBuffer();

            if (session.getAttribute("clUsrApp") != null) {
                strclUsr = session.getAttribute("clUsrApp").toString();
            }

            if (request.getParameter("clExcepcionPorCuenta") != null) {
                strclExcepcion = Integer.parseInt(request.getParameter("clExcepcionPorCuenta"));
            }

            if (request.getParameter("clCuenta") != null) {
                strclCuenta = request.getParameter("clCuenta").toString();
            } else {
                if (session.getAttribute("clCuenta") != null) {
                    strclCuenta = session.getAttribute("clCuenta").toString();
                }
            }

            session.setAttribute("clCuenta:", strclCuenta);
            System.out.println("strclExcepcion " + strclExcepcion);
            System.out.println("strclExcepcion " + strclExcepcion);
            System.out.println("strclExcepcion " + strclExcepcion);
            System.out.println("strclExcepcion " + strclExcepcion);
            System.out.println("strclExcepcion " + strclExcepcion);
            System.out.println("strclExcepcion " + strclExcepcion);


        %>

        <%   
            StrSql.append("st_lista_conseptos");
            resultSet = UtileriasBDF.rsSQLNP(StrSql.toString());
            StrSql.delete(0, StrSql.length());
            StrSql = null;
            session.setAttribute("clPaginaWebP", StrclPaginaWeb);
            MyUtil.InicializaParametrosC(Integer.parseInt(StrclPaginaWeb), Integer.parseInt(strclUsr));
        %>
        <br><br>

        <div id="divBotonAlta">    
            <input id="btnAltaBoton" name="btnAltaBoton" onclick="fnMostrar()" class='cBtn' type='button' value=' Nueva Excepción ' style="position: absolute; z-index: 10; left: 10px; top: 30px;">
        </div>

        <div id="divAlta" style="display: none"> 
            <br><hr>
            <%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion", "")%>
            <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%>ExcepcionesNuevas.jsp?'>
            <input type="hidden" id="clCuenta" name="clCuenta" value="<%=strclCuenta%>">
            <input type="hidden" id="clExcepcionPorCuenta" name="clExcepcionPorCuenta" value="<%=strclExcepcion%>">

            <%=MyUtil.ObjInput("Nombre Excepción", "nombre", "", true, true, 30, 180, "", true, true, 18)%>
            <%=MyUtil.ObjComboC("Estatus", "estatus", "", true, true, 170, 180, "", "Select 1 as 'clOpcion','Activo' as 'dsOpcion' union Select 0 as 'clOpcion','Inactivo'", "", "", 25, true, true)%>
            <%=MyUtil.ObjInput("Nombre Servicio", "nombreServicio", "", true, true, 30, 220, "", true, true, 18)%>
            <%=MyUtil.ObjInput("Nombre sub-Servicio", "nombreSubServicio", "", true, true, 170, 220, "", true, true, 18)%>
            <%=MyUtil.DoBlock("Datos de la Excepción", 0, 0)%>
            <%=MyUtil.GeneraScripts()%>

            <br><br><br><br><br><br><br><br><br><hr>
        </div>

        <form id="fromSecundario">
            <br>
            <table>
                <tr>
                    <td>
                        <font size='4' style="text-transform: uppercase; color: #000000;">
                        <b>Listado de Excepciones Por Cuenta</b>
                        </font>
                    </td>
                </tr>
            </table>

            <TABLE id="PW_LST" Border=0 class="Lista" cellspacing='0'>
                <tr class="Columnas">
                    <th style="text-align: left;"><b>Nombre Excepcion</b></th>
                    <th style="text-align: left;"><b>Cuenta</b></th>
                    <th style="text-align: left;"><b>Servicio</b></th>
                    <th style="text-align: left;"><b>Sub-Servicio</b></th>
                    <th style="text-align: center; width: 100px"><b>Estatus</b></th>
                    <th style="text-align: center; width: 150px"><b>Modificar</b></th>
                </tr>

                <%
                    while (resultSet.next()) {
                %>

                <TR class="Contenido1" onMouseOut="this.className = 'Contenido1'" onMouseOver="this.className = 'ratonEncima'">  
                    <TD Valign=top><%=resultSet.getString(2)%></TD>
                    <TD Valign=top><%=resultSet.getString(4)%></TD>
                    <TD Valign=top><%=resultSet.getString(5)%></TD>
                    <TD Valign=top><%=resultSet.getString(6)%></TD>
                    <TD Valign=top style="text-align:center;"><%=resultSet.getString(7)%></TD>
                    <TD Valign=top style="text-align:center;"><a href="#" onclick="fnModificacion('<%=resultSet.getInt(1)%>', '<%=resultSet.getString(2)%>', '<%=resultSet.getString(3)%>', '<%=resultSet.getString(5)%>', '<%=resultSet.getString(6)%>', '<%=resultSet.getString(7)%>')">Seleccionar</a> </TD>
                </TR>

                <%}%>
            </table>
        </form>
    </body>

</html>