<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="com.ike.asistencias.DAOParamCostos"%>
<%@page import="com.ike.asistencias.to.ParamCostos"%>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC,com.ike.operacion.DAOAltaCitas,com.ike.operacion.to.AltaCitas" errorPage="" %>
<html>
    <head>
        <title>Crea Cita</title> 
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <link href="../../StyleClasses/Calendario.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody" >
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
        <script type="text/javascript" src='../../Utilerias/Util.js'></script>
        <script type="text/javascript" src='../../Utilerias/UtilMask.js'></script>
        <script type="text/javascript" src='../../Utilerias/UtilCalendario.js'></script>
     
        <%
            String StrclPaginaWeb = "6181";
            String strclUsr = "0";
            String StrclExpediente = "0";
            ResultSet rs = null;
            String StrFecha="";
            String gestionCat= "";
            String porcentajeRec = "";
            String Responsable = "";
            


            if (session.getAttribute("clUsrApp") != null) {
                    strclUsr = session.getAttribute("clUsrApp").toString();
                } else {
                    strclUsr = request.getAttribute("clUsrApp").toString();
                }
            
            if (SeguridadC.verificaHorarioC(Integer.parseInt(strclUsr)) != true) {
                %>Fuera de Horario<%
                strclUsr = null;
                StrclExpediente = null;
                return;
            }
            
            if (session.getAttribute("clExpediente") != null) {
                StrclExpediente = session.getAttribute("clExpediente").toString();
            }

            

            session.setAttribute("clPaginaWebP", StrclPaginaWeb);
           
            MyUtil.InicializaParametrosC(6181, Integer.parseInt(strclUsr));
         

            rs = UtileriasBDF.rsSQLNP("SELECT CONVERT (VARCHAR(10),GETDATE(),121) [Fecha]");
            if(rs.next()){ StrFecha=rs.getString("Fecha"); }
                    rs.close();
                    rs=null;

            //OBTENGO LOS PARÁMETROS GUARDADOS PARA MOSTRARLOS
            StringBuffer StrSql = new StringBuffer();
            StrSql.append(" st_BuscaParametros ");
            ResultSet rsDatosParam = UtileriasBDF.rsSQLNP(StrSql.toString());
            StrSql.delete(0, StrSql.length());
            if (rsDatosParam.next()) {
                gestionCat = rsDatosParam.getString("GestionCat");
                porcentajeRec = rsDatosParam.getString("PorcentajeRec");
            }


            //Se prepara una hora actual en el formato  2021-06-24 11:03:32
            DateFormat dateFormat = new SimpleDateFormat("HH:mm:ss");
            Date date = new Date();
            String finaldate = StrFecha +" "+dateFormat.format(date);


            ParamCostos ParamC = null;
            DAOParamCostos daoParam = null;
            ParamC = new ParamCostos();
            daoParam = new DAOParamCostos();
            ParamC = daoParam.getParamC();

            String GestionC =ParamC != null ? ParamC.getGestionCat() : "000";
            String PorcentajeR =ParamC != null ? ParamC.getPorcentajeRec() : "000";
            
                    
        %>
        
        
        <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccion", "", "")%>
       
            <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="ParametrosCostos.jsp?"%>'>
            <INPUT id='clUsrApp' name='Usuario' type='hidden' value='<%=strclUsr%>'>
        
            <input id='fechaCambio' name='fechaCambio' type='hidden' value='<%=finaldate%>'/>   
            <%=MyUtil.ObjInput("Gestion cat", "GestionCat", GestionC,true, true, 150, 120, "", true, true, 25)%>
            <%=MyUtil.ObjInput("% de recargo", "PorcentajeRec", PorcentajeR, true, true, 150, 180, "", true, true, 25)%>
            
            <%=MyUtil.DoBlock("PARAMETRIZACIÓN COSTOS", 200,50)%>
            
        <%=MyUtil.GeneraScripts()%>
        


        <script> 
            
            //SE DESHABILITAN BOTONES |CAMBIO| Y |ELIMINAR|
            document.getElementById('btnCambio').disabled = true;
            document.getElementById('btnElimina').disabled = true;
            
          </script>
    </body>
</html>
