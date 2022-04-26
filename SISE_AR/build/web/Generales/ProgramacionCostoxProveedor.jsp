<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<html>
    <head>
        <title></title>
    </head>
    <body class="cssBody" onunload="fnCierra();">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <script src='../Utilerias/Util.js'></script>

        <%
            String StrclUsrApp = "0";
            String StrclPaginaWeb = "6084";
            String StrclProveedor = "0";
            String StrclSubServicio = "0";
            String StrclProgramacion = "0";
            
            if (session.getAttribute("clUsrApp") != null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();
            }

            if (session.getAttribute("clProgramacion") != null) {
                StrclProgramacion = session.getAttribute("clProgramacion").toString();
            }

            if (session.getAttribute("clProveedor") != null) {
                StrclProveedor = session.getAttribute("clProveedor").toString();
            }

            if (session.getAttribute("clSubServicio") != null) {
                StrclSubServicio = session.getAttribute("clSubServicio").toString();
            }

            if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {
                %><%="Fuera de Horario"%><%
                StrclUsrApp = null;
                StrclPaginaWeb = null;
                StrclProveedor = null;
                StrclSubServicio = null;
                StrclProgramacion = null;
                return;
                }

            session.setAttribute("clPaginaWebP", StrclPaginaWeb);

            MyUtil.InicializaParametrosC(Integer.parseInt(StrclPaginaWeb), Integer.parseInt(StrclUsrApp));
        %>
        <%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion", "")%>
        <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="ProgramacionCostoxProveedor.jsp?'>"%>  
        <INPUT id='clProgramacionCosto' name='clProgramacionCosto' type='hidden' value=''>
        <INPUT id='clProgramacion' name='clProgramacion' type='hidden' value='<%=StrclProgramacion%>'>
        <INPUT id='clSubServicio' name='clSubServicio' type='hidden' value='<%=StrclSubServicio%>'>
        <INPUT id='clProveedor' name='clProveedor' type='hidden' value='<%=StrclProveedor%>'>
        <INPUT id='clUsrAppRegistra' name='clUsrAppRegistra' type='hidden' value='<%=StrclUsrApp%>'>
        <%=MyUtil.ObjComboC("Concepto", "clConcepto", "", true, true, 30, 80, "", "st_PGgetComboCostos " + StrclProveedor + "," + StrclSubServicio, "fnObtenPrioridad(this.value)", "", 50, true, true)%>
        <%=MyUtil.ObjInput("Costo<br>Actual", "CostoActual", "", false, false, 326, 80, "", false, false, 9)%>
        <%=MyUtil.ObjInput("<b>Nuevo Costo Base</b>", "NuevoCosto", "", true, true, 30, 120, "", true, true, 10)%>    
        <%=MyUtil.DoBlock("Costo x Proveedor", -50, 0)%>

        <%
            StrclUsrApp = null;
            StrclPaginaWeb = null;
        %>
        <%=MyUtil.GeneraScripts()%>
        <script>
        xresnow = 312;// dimencion del popup
        yresnow = 50;// dimencion del popup

        moveTo(((screen.availWidth / 2) - (xresnow / 2)), ((screen.availHeight / 2) - (yresnow / 2)));
        window.focus();

        document.all.btnCambio.disabled = true;
        document.all.btnElimina.disabled = true;

        function fnCierra() {
            window.opener.fnReload();
            window.close();
        }

        function fnObtenPrioridad(clConcepto) {
            window.open('ObtenProgramacionxProveedor.jsp?Tipo=2&clProveedor=' + document.all.clProveedor.value + '&clSubServicio=' + document.all.clSubServicio.value + '&clConcepto=' + clConcepto, '', 'resizable=yes,menubar=0,status=1,toolbar=1,screenY=100,height=200,width=400,scrollbars=1');
        }

        function fnRegresaActual(Actual,ExistePendiente) {
            document.all.CostoActual.value = Actual;
        }
        </script>
    </body>
</html>