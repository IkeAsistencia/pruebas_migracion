<%@page contentType="text/html; charset=iso-8859-1" language="java" import="java.util.Iterator,java.util.ArrayList,Seguridad.SeguridadC,Utilerias.DeleteFile,com.ike.concierge.DAOCSSchengenLetter,com.ike.concierge.to.CSSchengenLetter,Concierge.CSLlenaSchengenLetter" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head><title>Impresión de Schengen Letter</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <style type="text/css">
        .style1 {font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 10px; font-weight: bold; color: #000066;}
        .style2 {font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 10px; color: #000066;}
        .style3 {font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 10px; font-weight: bold; color: #000066;}
        .style4 {font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 10px; color: #000066; text-transform: uppercase;}
    </style>  
    <body>
        
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
        <script src='../Utilerias/Util.js' ></script>
        
        <%
        String StrclAsistencia = "";
        String StrclPaginaWeb = "1444";
        String strclUsr = "";

        DAOCSSchengenLetter daoSchengenLetter = null;
        CSSchengenLetter SchengenLetter = null;

        if(request.getParameter("clAsistencia") != null){
            StrclAsistencia = request.getParameter("clAsistencia");
        }

        if(session.getAttribute("clUsrApp") != null){
            strclUsr = session.getAttribute("clUsrApp").toString();
        }

        if(StrclAsistencia.equalsIgnoreCase("")){
            %>No ha informado la asistencia (carta) a imprimir<%
            return;
        }

        daoSchengenLetter = new DAOCSSchengenLetter();
        SchengenLetter = daoSchengenLetter.getCSSchengenPDF(StrclAsistencia);

        // se checan permisos de alta,baja,cambio,consulta de esta pagina
        session.setAttribute("clPaginaWebP",StrclPaginaWeb);
        MyUtil.InicializaParametrosC(Integer.parseInt(StrclPaginaWeb),Integer.parseInt(strclUsr));
        %>
        
        <input id="clAsistencia" name="clAsistencia" type="hidden" value="<%=StrclAsistencia%>">
        
        <p class="style1">
            Si no puede visualizar su tarjeta, será necesario que descargue e instale <a href="http://get.adobe.com/es/reader/thankyou/activex/?installer=Reader_9.3_Spanish_for_Windows&i=McAfee_Security_Scan_Plus&d=Google_Toolbar_6.3">este</a> plug in.
        </p>
        
        <%
        CSLlenaSchengenLetter PDF = new CSLlenaSchengenLetter();
        PDF.LlenaPDF(StrclAsistencia);
        %>
        <script>
            location.href('SchengenLetter_'+document.all.clAsistencia.value+'.pdf');
        </script>
        <%
        StrclAsistencia = null;
        daoSchengenLetter = null;
        SchengenLetter = null;
        %>
    </body>
    <script>
        function varitext(text){
            text=document;
            print(text);
        }
    </script>    
</html>