<%@page contentType="text/html; charset=iso-8859-1" import="UtlHash.Usuario, UtlHash.LoadUsuario, Seguridad.SeguridadC"%>

<html>
    <head>
        <title></title></head>
    <link href="StyleClasses/Global.css" rel="stylesheet" type="text/css">

    <body topmargin="5" leftmargin="5" background="Imagenes/bgMenu.jpg" bgproperties="fixed">
        
        
        <table class="Table" width='240' cellspacing="0" cellpadding="5">
            <tr ><td class="TTable" colspan="2" >Men� de Opciones</td></tr>
            <%
                String strclUsr = "0";
                if (session.getAttribute("clUsrApp") != null) {
                    strclUsr = session.getAttribute("clUsrApp").toString();
                }

                if (SeguridadC.verificaHorarioC(Integer.parseInt(strclUsr)) != true) {
            %>Fuera de Horario<%
                            return;
                        }
            %>
        </table>
    </p>
    <%
        //Usuario UsuarioI = 
        StringBuffer strMenus = LoadUsuario.getstrMenus(strclUsr);
  //strMenus = UsuarioI.getstrMenus()    ;
    %><%=strMenus.toString()%><%
          //UsuarioI=null; 
          strMenus.delete(0, strMenus.length());
          strMenus = null;
    %>


</body>

</html>



