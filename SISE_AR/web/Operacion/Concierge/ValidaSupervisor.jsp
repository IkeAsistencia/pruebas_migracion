<%@page contentType="text/html"%>
<%@page pageEncoding="ISO-8859-1" import="java.sql.ResultSet,Utilerias.UtileriasBDF"%>


<html>
    <body>

        <%
                String StrUsr = "";
                String StrPwd = "";
                String StrMsgValidaSupervisor = "";
                boolean blnAutorizado = false;
                ResultSet rsAut = null;
                String StrclUsrAut = "";
                String StrVisible = "";

                if (request.getParameter("Usr") != null) {
                    StrUsr = request.getParameter("Usr").toString();
                }

                if (request.getParameter("Pwd") != null) {
                    StrPwd = request.getParameter("Pwd").toString();
                    //System.out.println("PAss " + StrPwd);
                }

                if (request.getParameter("MsgValidaSupervisor") != null) {
                    StrMsgValidaSupervisor = request.getParameter("MsgValidaSupervisor").toString();
                }


                try {
                    if (StrUsr.compareToIgnoreCase("") == 0) {
                        blnAutorizado = false;
                        StrMsgValidaSupervisor = StrMsgValidaSupervisor + "<br>Debe informar usuario...";
                    } else {
                        if (StrPwd.compareToIgnoreCase("") == 0) {
                            blnAutorizado = false;
                            StrMsgValidaSupervisor = StrMsgValidaSupervisor + "<br>Debe informar contraseña...";
                        } else {
                            rsAut = UtileriasBDF.rsSQLNP("sp_EncriptDesEncriptPassword '" + StrUsr + "',0,'', 0");
                            if (rsAut.next()) {
                                if (StrPwd.compareToIgnoreCase(rsAut.getString("password")) == 0) {
                                    if (rsAut.getString("AutorizaExp").compareToIgnoreCase("0") == 0) {
                                        blnAutorizado = false;
                                        StrMsgValidaSupervisor = StrMsgValidaSupervisor + "<br>Usuario no autorizado...";
                                    } else {
                                        blnAutorizado = true;
                                        StrclUsrAut = rsAut.getString("clUsrApp");
                                    }
                                } else {
                                    blnAutorizado = false;
                                    StrMsgValidaSupervisor = StrMsgValidaSupervisor + "<br>Contraseña Incorrecta...";
                                }
                            } else {
                                blnAutorizado = false;
                                StrMsgValidaSupervisor = StrMsgValidaSupervisor + "<br>Usuario Incorrecto...";
                            }
                        }
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }

                if (blnAutorizado) {
                    StrVisible = "display:none;";
                }
        %>

        <div style='position:absolute; z-index:3001; left:30%; top:5%; <%=StrVisible%>'>
            <center>
                <table  bgcolor="#E6F2F9" border="0" id="TableValidaSupervisor" ><tr>
                    <input type="hidden" id="clUsrAppValSup" name="clUsrAppValSup" value="<%=StrclUsrAut%>">
                    <td class='cssTitDet' colspan=2>Clave de Supervisor</td></tr>

                    <tr><td class='FTable'>Usuario:</td><td class='FTable'><input id='Usr' name ='Usr' value="<%=StrUsr%>"></td><tr>
                    <tr><td class='FTable'>Contraseña:</td><td class='FTable'><input type=password id='Pwd' name = 'Pwd' value=""></td><tr>
                    <tr><td class='FTable'></td><td class='FTable'><input type="button" value="Guardar" onclick="fnValidaClave()" class="cBtn"></td><tr>
                        <td class='TTable' colspan=2><%=StrMsgValidaSupervisor%></td></tr>
                </table>

            </center>
        </div>
    </body>
</html>
