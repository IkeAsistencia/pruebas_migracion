<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="Seguridad.SeguridadC,com.ike.concierge.DAOConciergeReminder,com.ike.concierge.ConciergeReminder" errorPage="" %>
<html>
    <head>
        <title>Alta de Evento Reminder</title>
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

                DAOConciergeReminder daos = null;
                ConciergeReminder conciergereminder = null;

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

                String StrclPaginaWeb = "6129";
                session.setAttribute("clPaginaWebP", StrclPaginaWeb);

                MyUtil.InicializaParametrosC(719, Integer.parseInt(strclUsr));
                if (strclUsr != null) {
                    daos = new DAOConciergeReminder();
                    conciergereminder = daos.getConciergeReminder(StrclEvento);
                }
        %>
        <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccion", "", "")%>

        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="CSAltaEventoReminder2.jsp?"%>'>
        <INPUT id='clEvento' name='clEvento' type='hidden' value='<%=StrclEvento%>'>
        <INPUT id='clConcierge' name='clConcierge' type='hidden' value='<%=StrclConcierge%>'>
        <INPUT id='clUsrApp' name='clUsrApp' type='hidden' value='<%=strclUsr%>'>

        <%=MyUtil.ObjInput("Detalle del Recordatorio", "dsEvento", conciergereminder != null ? conciergereminder.getdsEvento() : "", true, true, 200, 80, "", true, false, 40)%>
        <%=MyUtil.ObjComboC("Recordatorio", "clReminder", conciergereminder != null ? conciergereminder.getdsReminder() : "", true, true, 30, 80, "", "select clReminder, dsReminder from CScReminder order by dsReminder", "", "", 30, true, false)%>
        <%=MyUtil.ObjInputFA("Fecha Evento/Vencimiento", "FechaReminder", conciergereminder != null ? conciergereminder.getFechaReminder() : "", true, true, 440, 80, "", true, true, 20, 2, "fnReqHoraReminder();")%>
        <%=MyUtil.DoBlock("Registro de Reminder", 30, 0)%>

        <input type="button" class="cBtn" value="Cerrar" onclick="javascript:top.opener.location.reload();window.close();">

        <%=MyUtil.GeneraScripts()%>
        <%
                strclUsr = null;
                daos = null;
                conciergereminder = null;
        %>
        <input name='FechaWowMsk' id='FechaWowMsk' type='hidden' value=''>
        <script type="text/javascript" >
            function fnReqHoraReminder(){
                var StrFechaReminder = document.all.FechaReminder.value;
                if (document.all.clReminderC.value==6){
                    //document.all.FechaReminderMsk.value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00';
                } else {
                    document.all.FechaReminder.value=StrFechaReminder.substring(0,10);
                    //document.all.FechaReminderMsk.value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09';
                }
            }
        </script>
    </body>
</html>
