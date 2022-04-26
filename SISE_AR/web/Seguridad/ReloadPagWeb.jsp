<%@page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC,UtlHash.Pagina"%>


<html>
    <head>
        <title>Recarga la Página Web de Memoria</title>
    </head>
    <body class="cssBody">
    <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj"/>
    

    <%
        String StrclPaginaWebR="0";
                
        if (request.getParameter("clPaginaWebR")!=null){
            StrclPaginaWebR=request.getParameter("clPaginaWebR").toString();
        }
        
        if (!StrclPaginaWebR.equalsIgnoreCase("0")){
           
            UtlHash.LoadPagina.reLoadP(StrclPaginaWebR);
            System.out.println("Reload Pagina Web "+StrclPaginaWebR);
        }
        
        
    %>
        
    <script> window.close();</script>
        
    </body>
</html>
