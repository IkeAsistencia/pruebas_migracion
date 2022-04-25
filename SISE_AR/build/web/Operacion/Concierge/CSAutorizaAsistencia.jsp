<%-- 
    Document   : CSActorizaAsistencia
    Created on : 19-oct-2011, 16:40:34
    Author     : rfernandez
--%>

<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%@ page import="java.sql.ResultSet,Utilerias.UtileriasBDF,java.sql.ResultSet"%>

<html>
    <head>
        <title>Clave de Concierge (Activacion de Asistencia)</title>
    </head>
    <body class="cssBody">
    <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj"/>

<%
                StringBuffer StrSql = new StringBuffer();
                String StrclUsrApp = "0";
                String StrUsr = ""; //Usuario del Supervisior
                String StrclAsistencia = "0";
                String StrPwd = "";
                String strMess = "";
                String strclSupervisor = "";

                if (session.getAttribute("clUsrApp") != null) {
                    StrclUsrApp = session.getAttribute("clUsrApp").toString();
                }

                if (request.getParameter("clAsistencia") != null) {
                    StrclAsistencia = request.getParameter("clAsistencia").toString();
                }

                if (request.getParameter("Usr") != null) {
                    StrUsr = request.getParameter("Usr").toString();
                }

                if (request.getParameter("Pwd") != null) {
                    StrPwd = request.getParameter("Pwd").toString();
                }

                ResultSet rsAut = null;
                ResultSet rsPermisoAut = null;
                String strAutoriza = "0";

                                    
                boolean blnAutorizado = false;

                if (StrUsr.compareToIgnoreCase("") == 0) {
                    // No entró por la página de autorización, es directamente del expediente
                    blnAutorizado = false;
                    strMess = "Debe informar usuario para Autorizar Concierto";
                } else {
                    if (StrPwd.compareToIgnoreCase("") == 0) {
                        blnAutorizado = false;
                        strMess = "Debe informar contraseña para autorizar el servicio";
                    } else {
                        rsAut = UtileriasBDF.rsSQLNP("sp_EncriptDesEncriptPassword '" + StrUsr + "',0,'', 0");
                        if (rsAut.next()) {
                            if (StrPwd.compareToIgnoreCase(rsAut.getString("password")) == 0) {

                                    rsPermisoAut = UtileriasBDF.rsSQLNP("sp_CSAutorizaAsistencia '" + rsAut.getString("clUsrApp") + "','" + StrclAsistencia + "'");
                                         
                                     if (rsPermisoAut.next()) {
                                        strAutoriza = rsPermisoAut.getString("Autoriza");
                                    }
                                    
                                    rsPermisoAut.close();
                                    rsPermisoAut = null;
                                
                                if (strAutoriza.compareToIgnoreCase("0") == 0) {
                                    blnAutorizado = false;
                                    strMess = "Usuario no autorizado";
                                } else {
                                    strclSupervisor = rsAut.getString("clUsrApp");
                                    blnAutorizado = true;
                                }
                            } else {
                                blnAutorizado = false;
                                strMess = "Contraseña Incorrecta";
                            }
                        } else {
                            blnAutorizado = false;
                            strMess = "Usuario Incorrecto";
                        }
                    }
                }
    %>
    <%  if (blnAutorizado == false) {%>

    <font class = 'cssTitDet'><br><strong><center>Autorizacion (TC) de Asistencia: <%=StrclAsistencia%></center></strong></font>
    <font class= 'TTable'><br><center><%=strMess%></center></font>
    <center>
        <form action='CSAutorizaAsistencia.jsp?' method='post'>
            <table>
                <tr><td class='cssTitDet' colspan=2>Clave de autorización...</td></tr>
                <tr><td class='FTable'>Usuario:</td><td class='FTable'><input id='Usr' name = 'Usr'></td><tr>
                <tr><td class='FTable'>Contraseña:</td><td class='FTable'><input type=password id='Pwd' name = 'Pwd'></td><tr>
                <tr><td class='FTable'><input class='cBtn' VALUE='Autorizar' type='submit'></input></td><td class='FTable'><input value ='Cancelar' class='cBtn' type='button' onClick='window.close()'></td><tr>

                <input id='clConcierto' name='clAsistencia' type='hidden' value='<%=StrclAsistencia%>'></input>

                <script>window.focus();window.resizeTo(350,280);window.moveTo(300,150)</script>
                <BGSOUND SRC='../UTOPIA.WAV'>
            </table>
        </form>
    </center>
    <%} else {%>

   <%
          UtileriasBDF.ejecutaSQLNP("st_CSAutAsistencia '" + strclSupervisor + "','" + StrclAsistencia + "'");
    %>
    <script>
        top.opener.location.reload();
        window.close();
    </script>
    <%}%>
</body>
</html>

        

