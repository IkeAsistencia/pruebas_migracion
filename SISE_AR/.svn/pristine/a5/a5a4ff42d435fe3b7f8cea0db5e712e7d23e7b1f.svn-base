<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head><title>Cambio de claves</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj"/>
        <script src='../Utilerias/Util.js' ></script>
        <script src='../Utilerias/UtilMask.js'></script>
        <%
            String strclExpediente = "0";
            String strclTipoClave = "0";
            String strClave = "";
            String strClaveAnt = "";
            String strclCuenta = "0";
            String strclUsrApp = "0";

            if (request.getParameter("clExpediente") != null) {
                strclExpediente = request.getParameter("clExpediente").toString();
            }
            
            ResultSet rs = UtileriasBDF.rsSQLNP("select Clave from Expediente where clExpediente = " + strclExpediente);
            
            if(rs.next()){
                strClaveAnt = rs.getString("Clave");
            }else{
                %>Error al obtener la clave<%
                return;
            }

            if (session.getAttribute("clUsrApp") != null) {
                strclUsrApp = session.getAttribute("clUsrApp").toString();
            }

            if (SeguridadC.verificaHorarioC(Integer.parseInt(strclUsrApp)) != true) {
        %>
        <b>Fuera de Horario</b>
        <%
                strclUsrApp = null;
                return;
            }


            String StrclPaginaWeb = "708";
            session.setAttribute("clPaginaWebP", StrclPaginaWeb);
            MyUtil.InicializaParametrosC(708, Integer.parseInt(strclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina 

        %>

        <script>fnOpenLinks()</script>

        <%=MyUtil.doMenuAct("../servlet/Utilerias.GuardaCambioClave", "", "")%>
        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%>CambioClave.jsp?clTipoClave=<%=strclTipoClave%>'>
        <INPUT id='clUsrApp' name='clUsrApp' type='hidden' value='<%=strclUsrApp%>'>
        <%=MyUtil.ObjInput("Expediente", "clExpediente", strclExpediente, false, false, 30, 80, strclExpediente, false, true, 11)%>
        <%=MyUtil.ObjInput("Clave a corregir", "ClaveVTR", strClaveAnt, false, false, 120, 80, strClave, false, false, 35)%>
        <%=MyUtil.ObjInput("Clave correcta", "Clave", "", false, true, 30, 125, "", false, true, 35, "if(this.readOnly==false){fnValMask(this,document.all.ClaveMsk.value,this.name)}")%>
        <%=MyUtil.DoBlock("INFORMACION ACTUAL", 10, 0)%>

        <%=MyUtil.GeneraScripts()%>
        
        <script>
            document.all.btnAlta.disabled=true;
            document.all.btnElimina.disabled=true;
        </script>
    </body>
</html>

