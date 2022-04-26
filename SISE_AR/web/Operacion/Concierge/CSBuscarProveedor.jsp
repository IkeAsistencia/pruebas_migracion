<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head>
        <title>Lista de Eventos</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody" onLoad="">

        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" />
        <script type="text/javascript"  src='../../Utilerias/Util.js' ></script>
        <%
                    String strclUsr = "0";
                    String StrclConcierge = "0";
                    String StrclAsistencia = "0";
                    String StrclSubservicio = "0";
                    String StrclPais = "0";
                    String CodEnt = "0";
                    String CodMD = "0";
                    String StrDescrip = "";
                    String StrDescripcionS = "";
                    String StrEntidad = "";
                    String StrCiudad = "";

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

                    if (request.getParameter("clSubServicio") != null) {
                        StrclSubservicio = request.getParameter("clSubServicio").toString();
                    } else {
                        if (session.getAttribute("clSubServicio") != null) {
                            StrclSubservicio = session.getAttribute("clSubServicio").toString();
                        }
                    }

                    if (request.getParameter("clPais") != null) {
                        StrclPais = request.getParameter("clPais").toString();
                    } else {
                        if (session.getAttribute("clPais") != null) {
                            StrclPais = session.getAttribute("clPais").toString();
                        }
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

                    if (request.getParameter("Descrip") != null) {
                        StrDescrip = request.getParameter("Descrip").toString();
                    } else {
                        if (session.getAttribute("Descrip") != null) {
                            StrDescrip = session.getAttribute("Descrip").toString();
                        }
                    }

                    if (request.getParameter("DescripcionS") != null) {
                        StrDescripcionS = request.getParameter("DescripcionS").toString();
                    } else {
                        if (session.getAttribute("DescripcionS") != null) {
                            StrDescripcionS = session.getAttribute("DescripcionS").toString();
                        }
                    }

                    if (request.getParameter("Entidad") != null) {
                        StrEntidad = request.getParameter("Entidad").toString();
                    } else {
                        if (session.getAttribute("Entidad") != null) {
                            StrEntidad = session.getAttribute("Entidad").toString();
                        }
                    }

                    if (request.getParameter("ciudad") != null) {
                        StrCiudad = request.getParameter("ciudad").toString();
                    } else {
                        if (session.getAttribute("ciudad") != null) {
                            StrCiudad = session.getAttribute("ciudad").toString();
                        }
                    }
        %>      <form id='Forma' name ='Forma'  action='CSWows.jsp?' method='post'>
            <div class='VTable' style='position:absolute; z-index:25; left:10px; top:10px;'>
                <p align="center"><font color="navy" face="Arial" size="2" ><b><i>Referencias</i></b></font><br>
                </p>

                <div class='VTable' style='position:absolute; z-index:25; left:20px; top:45px;'>
                    <table align="center" border="1"><tr><td bgcolor="#FFFFFF"><font color="black" face="Arial" size="1" >No existen Referencias para esta zona</font><br>
                            </td></tr></table>
                </div>

                <div class='VTable' style='position:absolute; z-index:25; left:10px; top:30px;'>
                    <%StringBuffer strSalida = new StringBuffer();
                                System.out.println("st_CSListaProveedores '" + StrclConcierge + "','" + StrclAsistencia + "','" + StrclSubservicio + "','" + CodEnt + "','" + CodMD + "','"
                                        + StrDescrip + "','" + StrclPais + "','" + StrDescripcionS + "','" + StrEntidad + "','" + StrCiudad + "'");
                                UtileriasBDF.rsTableNP("st_CSListaProveedores '" + StrclConcierge + "','" + StrclAsistencia + "','" + StrclSubservicio + "','" + CodEnt + "','" + CodMD + "','"
                                        + StrDescrip + "','" + StrclPais + "','" + StrDescripcionS + "','" + StrEntidad + "','" + StrCiudad + "'", strSalida);
                    %>
                    <%=strSalida.toString()%>
                    <%strSalida.delete(0, strSalida.length());
                    %>

                    </form>

                   
                    <%
                                strclUsr = null;
                                StrclConcierge = null;
                                StrclAsistencia = null;
                                StrclSubservicio = null;
                                StrclPais = null;
                                CodEnt = null;
                                CodMD = null;
                                StrDescrip = null;
                                StrDescripcionS = null;
                                StrEntidad = null;
                                StrCiudad = null;
                    %>

                    </body>
                    </html>
