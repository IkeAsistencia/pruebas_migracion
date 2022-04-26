<%@page contentType="text/html; charset=iso-8859-1" language="java" %>
<!--%@ page import="java.util.Iterator,java.util.ArrayList,com.ike.helpdesk.DAOHelpdesk,com.ike.helpdesk.HDSolicitud,com.ike.helpdesk.HDActivxUsr,Seguridad.SeguridadC,com.ike.helpdesk.LiberacionPDF,Utilerias.DeleteFile" errorPage="" %-->
<%@ page import="com.ike.helpdesk.DAOHelpdesk,com.ike.helpdesk.HDSolicitud,Seguridad.SeguridadC,com.ike.helpdesk.LiberacionPDF" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head><title>Detalle Solicitud de Usuario</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        
        <SCRIPT LANGUAGE="JavaScript">

function varitext(text){
    text=document;
    print(text);
}
        </script>
        
    </head>
    <body >
        
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
        <script src='../Utilerias/Util.js' ></script>
        
        <%
        String StrclSolicitud = "0";
        String StrclUsrApp="0";
        
        if (session.getAttribute("clUsrApp")!= null) {
            StrclUsrApp = session.getAttribute("clUsrApp").toString();
        }
        
        if (session.getAttribute("clSolicitud")== null) {
        %>   No ha informado la solicitud <%
        return;
        }else{
            StrclSolicitud = session.getAttribute("clSolicitud").toString();
        }
        
        DAOHelpdesk daoh = null;
        HDSolicitud  Solicitud = null;
        if (StrclSolicitud.compareToIgnoreCase("0")!=0){
            daoh = new DAOHelpdesk();
            Solicitud = daoh.getSolicitud(StrclSolicitud);
        
        %><SCRIPT>fnOpenLinks()</script><%
        } else{ %> No ha informado la solicitud  <% return; }
        
        String StrclPaginaWeb = "609";
        session.setAttribute("clPaginaWebP",StrclPaginaWeb);
        MyUtil.InicializaParametrosC(609,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
        
        if (Solicitud==null) {
            StrclUsrApp = null;
            StrclSolicitud=null;
            
            daoh=null;
            Solicitud=null;
            
            return;
        }
        
        
        LiberacionPDF PDF=new LiberacionPDF();
        PDF.ShowPDF(StrclSolicitud);
        %><script>javascript:location.href('Liberacion.pdf');</script><%
        
        
        //DeleteFile File=new  DeleteFile();
        //File.DeleteFile("C:\\PROYECTOS\\SISE_MX\\build\\web\\HelpDesk\\Liberacion.pdf");
        
        StrclSolicitud = null;
        StrclUsrApp= null;
        StrclPaginaWeb=null;
        
        daoh=null;
        Solicitud=null;
        PDF=null;
        
        %>
        
    </body>
</html>