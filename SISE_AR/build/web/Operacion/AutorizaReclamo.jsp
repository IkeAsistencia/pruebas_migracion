<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<html>
    <head>
        <title></title>
    </head>
    <body class="cssBody">
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <%
            String StrclUsrApp = "0";
            String StrUsr = "";
            String StrPwd = "";
            StringBuffer StrSql = new StringBuffer();

            String StrNombrePagina = "";
            String StrMensaje = "";
            String StrAutoriza = "1";

            if (session.getAttribute("clUsrApp") != null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();
            }

            if (request.getParameter("NombrePagina") != null) {
                StrNombrePagina = request.getParameter("NombrePagina").toString();
            }
            if (request.getParameter("Usr") != null) {
                StrUsr = request.getParameter("Usr").toString();
                System.out.println("StrUsr  " + StrUsr);
            }
            if (request.getParameter("Pwd") != null) {
                StrPwd = request.getParameter("Pwd").toString();
                System.out.println("StrPwd  " + StrPwd);
            }
            if (request.getParameter("Mensaje") != null) {
                StrMensaje = request.getParameter("Mensaje").toString();
            }

            if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {
                %>Fuera de Horario<%
                StrclUsrApp = null;
                StrclUsrApp = null;
                StrUsr = null;
                StrPwd = null;
                StrSql = null;
                StrNombrePagina = null;
                StrMensaje = null;
                StrAutoriza = null;
                return;
            }

            StrSql.append("st_PermieAltaReclamo ").append(StrUsr);

            ResultSet rs2 = UtileriasBDF.rsSQLNP(StrSql.toString());
            StrSql.delete(0, StrSql.length());
            if (rs2.next()) {

                if (request.getParameter("Usr") != null) {
                    StrSql.append("sp_EncriptDesEncriptPassword '").append(StrUsr.toUpperCase()).append("',0,'',0");

                    ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
                    StrSql.delete(0, StrSql.length());
                    if (rs.next()) {
                        if (rs.getString("clUsrApp") != null) {
                            if (StrPwd.equalsIgnoreCase(rs.getString("password"))) {
                                if (StrAutoriza.equals(rs2.getString("AutorizaRec"))) {%>
                                    <script>
                                        opener.fnSubmitOK(<%=rs.getString("clUsrApp")%>);
                                    </script>

                                <%
                                } else {
                                    StrMensaje = "USUARIO NO AUTORIZADO";
                                }
                            } else {
                                StrMensaje = "CONTRASEÑA INCORRECTA";
                            }
                        } else {
                            StrMensaje = "USUARIO INCORRECTO";
                        }
                    }
                    rs.close();
                    rs = null;
                }
            }
            rs2.close();
            rs2 = null;

        %>
        <p class='TTable'>AFILIADO NO ENCONTRADO EN BASE DE DATOS.<br><%=StrMensaje%></p>
            <%
                String url = response.encodeURL("AutorizaReclamo.jsp");
            %>
        <form action="<%=url%>" method='post'>
            <INPUT id='NombrePagina' name='NombrePagina' type='hidden' value='<%=StrNombrePagina%>'>

            <table>
                <tr><td class='cssTitDet' colspan=2>Clave de autorización...</td></tr>
                <tr>
                    <td class='FTable'>Usuario:</td>
                    <td class='FTable'><input id="Usr" name="Usr" type="text" size="10" maxlength="15" onblur="fnReplaceScripting();"/></td>
                    
                <tr>
                <tr>
                    <td class='FTable'>Contraseña:</td>
                    <td class='FTable'><input id="Pwd" name="Pwd" type="password" autocomplete="off" size="10" maxlength="10" onblur="fnReplaceScripting(this.value, this.id);" /></td>
                <tr>
                <tr>
                    <td class='FTable'><input class='cBtn' VALUE='Autorizar' type='submit'></td>
                    <td class='FTable'><input value ='Cancelar' class='cBtn' type='button' onClick='fnRedirecciona()'></td>
                </tr>
            </table>
        </form>

        <script>
            window.focus();
            window.resizeTo(350, 300);
            window.moveTo(300, 150);


            function fnRedirecciona() {
                //location.href = 'AutorizaReclamo.jsp';
                location.reload();
            }

            function fnReplaceScripting() {
                var usr = document.all.Usr.value;
                var pass = document.all.Pwd.value;
                usr = usr.replace(/select /gi, "");
                usr = usr.replace(/insert /gi, "");
                usr = usr.replace(/ into /gi, "");
                usr = usr.replace(/values/gi, "");
                usr = usr.replace(/delete /gi, "");
                usr = usr.replace(/update /gi, "");
                usr = usr.replace(/drop /gi, "");
                usr = usr.replace(/exec /gi, "");
                usr = usr.replace(/execute /gi, "");
                usr = usr.replace(/truncate /gi, "");
                usr = usr.replace(/alter /gi, "");
                usr = usr.replace(/ table /gi, "");
                usr = usr.replace(/'/gi, "");
                usr = usr.replace(/"/gi, "");
                usr = usr.replace(/</gi, "");
                usr = usr.replace(/>/gi, "");
                pass = pass.replace(/select /gi, "");
                pass = pass.replace(/insert /gi, "");
                pass = pass.replace(/ into /gi, "");
                pass = pass.replace(/values/gi, "");
                pass = pass.replace(/delete /gi, "");
                pass = pass.replace(/update /gi, "");
                pass = pass.replace(/drop /gi, "");
                pass = pass.replace(/exec /gi, "");
                pass = pass.replace(/execute /gi, "");
                pass = pass.replace(/truncate /gi, "");
                pass = pass.replace(/alter /gi, "");
                pass = pass.replace(/ table /gi, "");
                pass = pass.replace(/'/gi, "");
                pass = pass.replace(/"/gi, "");
                pass = pass.replace(/</gi, "");
                pass = pass.replace(/>/gi, "");
                document.all.Usr.value = usr;
                document.all.Pwd.value = pass;
                /*document.getElementById("frm1").submit();*/
            }
            
            
        </script>
    </body>
    <%
        StrUsr = null;
        StrPwd = null;
        StrSql = null;
        StrNombrePagina = null;
        StrMensaje = null;
        StrAutoriza = null;
        url = null;
    %>
</html>
