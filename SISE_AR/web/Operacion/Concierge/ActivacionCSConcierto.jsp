<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%@ page import="java.sql.ResultSet,Utilerias.UtileriasBDF,java.sql.ResultSet"%>

<html>
    <head>
        <title>Clave de Concierge (Activacion de Concierto)</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj"/>

        <%
                StringBuffer StrSql = new StringBuffer();
                String StrclUsrApp = "0";
                String StrUsr = ""; //Usuario del Supervisior
                String StrclConcierto = "0";
                String StrPwd = "";
                String strMess = "";
                String strclSupervisor = "";
                String strAut = "";

                if (session.getAttribute("clUsrApp") != null) {
                    StrclUsrApp = session.getAttribute("clUsrApp").toString();
                }

                if (request.getParameter("clConcierto") != null) {
                    StrclConcierto = request.getParameter("clConcierto").toString();
                }

                if (request.getParameter("Aut") != null) {
                    strAut = request.getParameter("Aut").toString();
                }

                if (request.getParameter("Usr") != null) {
                    StrUsr = request.getParameter("Usr").toString();
                }

                if (request.getParameter("Pwd") != null) {
                    StrPwd = request.getParameter("Pwd").toString();
                }

                ResultSet rsAut = null;
                ResultSet rsPermisoAut = null;
                String strAutoriza = "0",
                        StrNombreConcierto = "0";

                rsPermisoAut = UtileriasBDF.rsSQLNP("sp_CSActivacionConcierto '" + StrclUsrApp + "','" + StrclConcierto + "'");


                if (rsPermisoAut.next()) {
                    StrNombreConcierto = rsPermisoAut.getString("dsConcierto");
                }

                rsPermisoAut.close();
                rsPermisoAut = null;

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

                                rsPermisoAut = UtileriasBDF.rsSQLNP("sp_CSActivacionConcierto '" + rsAut.getString("clUsrApp") + "','" + StrclConcierto + "'");

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

        <font class = 'cssTitDet'><br><strong><center>Activación de Concierto: <%=StrNombreConcierto%></center></strong></font>
        <font class= 'TTable'><br><center><%=strMess%></center></font>
        <center>
            <form action='ActivacionCSConcierto.jsp?' method='post'>
                <table>
                    <tr><td class='cssTitDet' colspan=2>Clave de autorización...</td></tr>
                    <tr><td class='FTable'>Usuario:</td><td class='FTable'><input id='Usr' name = 'Usr'></td><tr>
                    <tr><td class='FTable'>Contraseña:</td><td class='FTable'><input type=password id='Pwd' name = 'Pwd'></td><tr>
                    <tr><td class='FTable'><input class='cBtn' VALUE='Autorizar' type='submit'></td><td class='FTable'><input value ='Cancelar' class='cBtn' type='button' onClick='window.close()'></td><tr>
                    <input id='clConcierto' name='clConcierto' type='hidden' value='<%=StrclConcierto%>'>
                    <input id='Aut' name='Aut' type='hidden' value='<%=strAut%>'>

                    <script>window.focus();window.resizeTo(350,280);window.moveTo(300,150)</script>
                    <BGSOUND SRC='../UTOPIA.WAV'>
                </table>
            </form>
        </center>
        <%} else {%>

        <%
              //System.out.println(" Conciertos st_CSAutConcierto '" + StrclConcierto + "','" + StrclUsrApp + "','" + strAut + "'");
              UtileriasBDF.ejecutaSQLNP("st_CSAutConcierto '" + StrclConcierto + "','" + StrclUsrApp + "','" + strAut + "'");
        %>
        <script>
            top.opener.location.reload();
            window.close();
        </script>
        <%}%>
    </body>
</html>
