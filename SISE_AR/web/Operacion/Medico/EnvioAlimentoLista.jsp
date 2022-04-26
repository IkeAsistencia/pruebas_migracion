<%@ page contentType="text/html; charset=iso-8859-1" language="java" %>
<%@ page import="Seguridad.SeguridadC,java.sql.ResultSet,Utilerias.UtileriasBDF;"%>

<html>
    <head>
        <title>Envio Alimentos</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj"/>
        <script type="text/javascript" src='../../Utilerias/Util.js'></script>

        <%
            String StrclUsrApp = "0";
            String StrclPaginaWeb = "6070";
            String StrclExpediente = "0";
            String StrAccion = "0";

            if (session.getAttribute("clUsrApp") != null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();
            }

            if (session.getAttribute("clExpediente") != null) {
                StrclExpediente = session.getAttribute("clExpediente").toString();
            }

            if (request.getParameter("Action") != null) {
                StrAccion = request.getParameter("Action").toString();
            }

            if (StrAccion.equalsIgnoreCase("1")) {
                String StrclAlimento = "";
                String StrCantidad = "";
                String StrPrecioUnitario = "";

                if (request.getParameter("clAlimento") != null) {
                    StrclAlimento = request.getParameter("clAlimento").toString();

                    if (request.getParameter("Cantidad") != null) {
                        StrCantidad = request.getParameter("Cantidad").toString();

                        if (request.getParameter("PrecioUnitario") != null) {
                            StrPrecioUnitario = request.getParameter("PrecioUnitario").toString();

                            StringBuffer StrSql = new StringBuffer();

                            StrSql.append(" st_guardaAlimento ").append(StrclExpediente).append(",").append(StrclAlimento).append(",").append(StrCantidad).append(",'").append(StrPrecioUnitario).append("'");
                            ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
                            StrSql.delete(0, StrSql.length());

                            if (rs.next()) { %>
                                <script>
                                    alert('Alimento Guardado.');
                                    opener.location.reload(); //actualizo ventana 1 (padre) 
                                    window.close(); // cierro ventana 2 (hija)
                                </script>                        
                            <% } 
                        }
                    }
                } 
            } else { %>

        <%MyUtil.InicializaParametrosC(Integer.parseInt(StrclPaginaWeb), Integer.parseInt(StrclUsrApp));%>
        <%=MyUtil.doMenuAct("EnvioAlimentoLista.jsp?", "", "")%>

        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
        <INPUT id='Accion' name='Accion' type='hidden' value='<%=StrAccion%>'>
        <%=MyUtil.ObjComboC("Alimento", "clAlimento", "", true, true, 30, 80, "", "select clAlimento, dsAlimento from cAlimentos order by 2 asc", "", "", 100, false, false)%>
        <%=MyUtil.ObjInput("Cantidad", "Cantidad", "", true, true, 225, 80, "", false, false, 10)%>
        <%=MyUtil.ObjInput("Precio Unitario", "PrecioUnitario", "", true, true, 350, 80, "", false, false, 10)%>
        <%=MyUtil.DoBlock("Detalle de alimentos", 0, 0)%>

        <div class='VTable' style='position:absolute; z-index:25; left:10px; top:180px;'>
            <%
                StringBuffer StrSql1 = new StringBuffer();
                StrSql1.append("st_getAlimentosExpediente ").append(StrclExpediente);

                StringBuffer strSalida = new StringBuffer();
                UtileriasBDF.rsTableNP(StrSql1.toString(), strSalida);
            %>
            <%=strSalida.toString()%>
        </div>

        <%=MyUtil.GeneraScripts()%>
        <script>
            document.all.btnCambio.style.visibility='hidden';
            document.all.btnElimina.style.visibility='hidden';
        </script>
        <% }%>
    </body>
    <script>
        function fnReload() {
            opener.location.reload(); //actualizo ventana 1 (padre) 
            window.close(); // cierro ventana 2 (hija)
        }
    </script>
</html>
