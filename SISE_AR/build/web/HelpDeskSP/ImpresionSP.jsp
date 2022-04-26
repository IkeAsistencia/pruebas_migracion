<%@page contentType="text/html; charset=iso-8859-1" language="java" import="java.util.Iterator,java.util.ArrayList,com.ike.helpdeskSP.DAOHelpdeskSP,com.ike.helpdeskSP.HelpdeskSP,com.ike.helpdesk.HDActivxUsr,Seguridad.SeguridadC,com.ike.helpdeskSP.ImpresionPDF" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head><title>Impresión de Formato</title>
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
        String StrclEstatus="0";
        String StrCalificacion="0";
        
        if (session.getAttribute("clUsrApp")!= null) {
            StrclUsrApp = session.getAttribute("clUsrApp").toString();
        }
        
        if (session.getAttribute("clSolicitud")== null) {
        %>   No ha informado la solicitud <%
        return;
        }else{
            StrclSolicitud = session.getAttribute("clSolicitud").toString();
        }
        
        DAOHelpdeskSP daoHelpdeskSP = null;
        HelpdeskSP HD = null;
        
        daoHelpdeskSP = new DAOHelpdeskSP();
        HD = daoHelpdeskSP.getHelpdeskSP(StrclSolicitud.toString());
        
        StrclEstatus=HD.getclEstatus().toString();
        
        StrCalificacion=HD.getClAtencion().toString();
        
        if (StrclEstatus.equalsIgnoreCase("4") || !StrCalificacion.equalsIgnoreCase("0")) {
            
        /* ImpresionPDF PDF=new ImpresionPDF();
        PDF.ShowPDF(StrclSolicitud);//*/
            
            // llenaPDF.NombreCampos("C:\\Aplicaciones\\SISE_VE\\build\\web\\HelpDeskSP\\SP2.pdf");
            //llenaPDF.NombreCampos("C:\\Aplicaciones\\SISE_VE\\build\\web\\HelpDeskSP\\FormOutput1.pdf");
            ImpresionPDF.ShowPDF(StrclSolicitud);
        
        
        %><script>javascript:location.href('Impresion_'+<%=StrclSolicitud%>+'.pdf');</script><%
        } else{ %>
        
        *** NO SE PUEDE IMPRIMIR EL DOCUMENTO HASTA CONCLUIR Y/O CALIFICAR EL SERVICIO ***
        
        <% return; }
        
        %><SCRIPT>fnOpenLinks()</script><%
        String StrclPaginaWeb = "973";
        session.setAttribute("clPaginaWebP",StrclPaginaWeb);
        MyUtil.InicializaParametrosC(973,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
        %>
        <%
        StrclUsrApp = null;
        StrclSolicitud=null;
        StrclEstatus=null;
        StrCalificacion=null;
        
        daoHelpdeskSP=null;
        HD=null;
        %>
        
        //DeleteFile File=new  DeleteFile();
        //File.DeleteFile("C:\\PROYECTOS\\SISE_MX\\build\\web\\HelpDesk\\Liberacion.pdf");
        
    </body>
</html>