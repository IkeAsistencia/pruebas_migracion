<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="Seguridad.SeguridadC,com.ike.concierge.DAOConciergeWow,com.ike.concierge.ConciergeWow" errorPage="" %>
<html>
    <head>
        <title>Alta de Evento Wow</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <link href="../../StyleClasses/Calendario.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
        <script type="text/javascript" src='../../Utilerias/Util.js'></script>
        <script type="text/javascript" src='../../Utilerias/UtilMask.js'></script>
        <script type="text/javascript" src='../../Utilerias/UtilCalendarioV.js'></script>
        <%
                String strclUsr = "0";
                String StrclConcierge = "0";
                String StrclEvento = "0";

                DAOConciergeWow daos = null;
                ConciergeWow conciergewow = null;

                if (session.getAttribute("clUsrApp") != null) {
                    strclUsr = session.getAttribute("clUsrApp").toString();
                } else {
                    strclUsr = request.getParameter("clUsrApp").toString();
                }

                if (request.getParameter("clConcierge") != null) {
                    StrclConcierge = request.getParameter("clConcierge").toString();
                }

                if (request.getParameter("clEvento") != null) {
                    StrclEvento = request.getParameter("clEvento").toString();
                }

                String StrclPaginaWeb = "719";
                session.setAttribute("clPaginaWebP", StrclPaginaWeb);

                MyUtil.InicializaParametrosC(719, Integer.parseInt(strclUsr));
                if (strclUsr != null) {
                    daos = new DAOConciergeWow();
                    conciergewow = daos.getConciergeWow(StrclEvento);
                }
        %>
        <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccion", "", "")%>

        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="CSAltaEventoWow2.jsp?"%>'>
        <INPUT id='clEvento' name='clEvento' type='hidden' value='<%=StrclEvento%>'>
        <INPUT id='clConcierge' name='clConcierge' type='hidden' value='<%=StrclConcierge%>'>
        <INPUT id='clUsrApp' name='clUsrApp' type='hidden' value='<%=strclUsr%>'>

        <%=MyUtil.ObjInput("Detalle del Evento", "dsEvento", conciergewow != null ? conciergewow.getdsEvento() : "", true, true, 200, 80, "", true, false, 40)%>
        <%=MyUtil.ObjComboC("Evento", "clWow", conciergewow != null ? conciergewow.getdsWow() : "", true, true, 30, 80, "", "select clWow, dsWow from CScWow order by dsWow", "", "", 30, true, false)%>
        <%=MyUtil.ObjInputFA("Fecha (AAAA-MM-DD HH:MM)", "FechaWow", conciergewow != null ? conciergewow.getFechaWow() : "", true, true, 420, 80, "", true, true, 20, 2, "fnReqHoraWow();if(this.readOnly==false){fnValMask(this,document.all.FechaWowMsk.value,this.name)};")%>
        <%=MyUtil.DoBlock("Registro de Wow", 30, 0)%>

        <input type="button" class="cBtn" value="Cerrar" onclick="javascript:top.opener.location.reload();window.close();">

        <%=MyUtil.GeneraScripts()%>
        <%
                strclUsr = null;
                daos = null;
                conciergewow = null;
        %>
        <input name='FechaWowMsk' id='FechaWowMsk' type='hidden' value=''>
        <script type="text/javascript" >
            function fnReqHoraWow(){
                var StrFechaWow = document.all.FechaWow.value;
                if (document.all.clWowC.value==6){
                    document.all.FechaWowMsk.value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00';
                } else {
                    document.all.FechaWow.value=StrFechaWow.substring(0,10);
                    document.all.FechaWowMsk.value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09';
                }
            }
        </script>
    </body>
</html>
