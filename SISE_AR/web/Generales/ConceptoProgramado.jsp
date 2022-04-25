<%-- 
    Document   : ConceptoProgramado
    Created on : 29/05/2017, 11:07:55 AM
    Author     : dmontaut
--%>

<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Utilerias.UtileriasObj" errorPage="" %>
<html>
    <head>
        <title>Programar Concepto</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
        <% 
        String strclProgramacion = "";
        String strUsrAppRegistra = "";
        String strConceptos = "";
        String StrCostoProg="";

        if (session.getAttribute("clProgramacion") != null) {
            strclProgramacion = session.getAttribute("clProgramacion").toString();
        }

        if (request.getParameter("clUsrAppRegistra") != null) {
            strUsrAppRegistra = request.getParameter("clUsrAppRegistra");
        }

        if (request.getParameter("Conceptos") != null) {
            strConceptos = request.getParameter("Conceptos");
        }
        
       System.out.println("st_GuardaConceptoProgramado " + strclProgramacion + "," + strUsrAppRegistra + "," + "'" + strConceptos + "'");
        
      Utilerias.UtileriasBDF.ejecutaSQLNP ("st_GuardaConceptoProgramado " + strclProgramacion + "," + strUsrAppRegistra + "," + "'" + strConceptos + "'");
           
      
      
        strclProgramacion = null;
        strUsrAppRegistra = null;
        strConceptos = null;
             
        %>
        <script>
//            top.opener.actualizar();
            window.close();
        </script>
    </body>
</html> 