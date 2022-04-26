<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="Seguridad.SeguridadC,java.sql.ResultSet,Utilerias.UtileriasBDF,com.ike.concierge.DAOCSFamilia,com.ike.concierge.ConciergeFamilia" errorPage="" %>
<html>
    <head>
        <title>Alta de Evento Composición Familiar </title>
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
                String StrclCompFam ="";
                String StrclPaginaWeb = "6138";

                DAOCSFamilia daos = null;
                ConciergeFamilia conciergeFam = null;

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

                session.setAttribute("clPaginaWebP", StrclPaginaWeb);
                
                MyUtil.InicializaParametrosC(719, Integer.parseInt(strclUsr));
                if (strclUsr != null) {
                    daos = new DAOCSFamilia();
                    conciergeFam = daos.getConciergeFamilia(StrclEvento);
                }
                
                StringBuffer sf = new StringBuffer();
                sf.append(" st_getCompFam ").append(StrclConcierge);
                ResultSet CF = UtileriasBDF.rsSQLNP(sf.toString());
                if (CF.next()) { 
                    StrclCompFam = CF.getString("clCompFam");
                }
                CF.close();
                CF = null;
        %>
        <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccion", "", "")%>

        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="CSAltaEventoFamilia2.jsp?"%>'>
        <INPUT id='clEvento' name='clEvento' type='hidden' value='<%=StrclEvento%>'>
        <INPUT id='clConcierge' name='clConcierge' type='hidden' value='<%=StrclConcierge%>'>
        <INPUT id='clUsrApp' name='clUsrApp' type='hidden' value='<%=strclUsr%>'>
        <INPUT id='clCompFam' name='clCompFam' type='hidden' value='<%=StrclCompFam%>'>

        <%=MyUtil.ObjComboC("Parentesco", "clParentesco", conciergeFam != null ? conciergeFam.getDsParentesco(): "", true, true, 30, 80, "", "select clParentesco,dsParentesco from CSParentesco", "", "", 30, true, false)%>
        <%=MyUtil.ObjComboC("Genero", "clGenero", conciergeFam != null ? conciergeFam.getDsGenero(): "", true, true, 200, 80, "", "select clGenero,dsGenero from CSGenero", "", "", 30, true, false)%>
        <%=MyUtil.ObjInput("Nombre", "NombreFam", conciergeFam != null ? conciergeFam.getNombreFam(): "", true, true, 30, 120, "", true, false, 80)%>
        <%=MyUtil.ObjInputFA("Fecha Nacimiento(AAAA-MM-DD)", "FechaNac", conciergeFam != null ? conciergeFam.getFechaNac(): "", true, true, 350, 85, "", true, true, 20, 2, "fnReqHoraReminder();")%>
        
        <%=MyUtil.DoBlock("Registro de Familia", 30, 0)%>

        <input type="button" class="cBtn" value="Cerrar" onclick="javascript:top.opener.location.reload();window.close();">

        <%=MyUtil.GeneraScripts()%>
        <%
                strclUsr = null;
                daos = null;
                conciergeFam = null;
        %>
        <input name='FechaFamMsk' id='FechaFamMsk' type='hidden' value=''>
        <script type="text/javascript" >
                        
            function fnReqHoraReminder(){
                var StrFechaReminder = document.all.FechaNac.value;
                if (document.all.clParentescoC.value===6){
                    //document.all.FechaReminderMsk.value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00';
                } else {
                    document.all.FechaNac.value=StrFechaReminder.substring(0,10);
                    //document.all.FechaReminderMsk.value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09';
                }
            }
            
        </script>
    </body>
</html>
