<%@page contentType="text/html; charset=iso-8859-1" language="java" import="com.ike.helpdesk.DAOHelpdesk,com.ike.helpdesk.HDSolicitud,Seguridad.SeguridadC,com.ike.helpdesk.MemoPDF;" errorPage="" %>
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
            return;
        }
        
        MemoPDF PDF=new MemoPDF();
        
        if(Solicitud.getRevisadaxSistemas().compareToIgnoreCase("Si")==0){
                        
            PDF.ShowPDF(StrclSolicitud);
        %><script>javascript:location.href('Memorando_'+<%=StrclSolicitud%>+'.pdf');</script><%
        
        }else{
            out.println("<div style='position:absolute; z-index:40; left:200px; top:350px;'><center><font size='3'><b>");
            out.println("No puede imprimir el memorando hasta que la solicitud no haya sido revisada por Sistemas");
            out.println("</center></font></b></div>");
        }
        
        
        StrclSolicitud = null;
        StrclUsrApp=null;
        StrclPaginaWeb=null;
        
        daoh=null;
        Solicitud=null;
                
        PDF=null;
        %>
        
    </body>
</html>