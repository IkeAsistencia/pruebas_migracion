<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>

<html>
    <head><title>JSP Page</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody" onLoad="">

        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" />
        <script src='../../Utilerias/Util.js' ></script>
        <%
                String strclUsr = "0";
                String StrclConcierge = "0";

                if (session.getAttribute("clUsrApp") != null) {
                    strclUsr = session.getAttribute("clUsrApp").toString();
                }

                if (request.getParameter("clConcierge") != null) {
                    StrclConcierge = request.getParameter("clConcierge").toString();
                } else {
                    if (session.getAttribute("clConcierge") != null) {
                        StrclConcierge = session.getAttribute("clConcierge").toString();
                    }
                }
        %>


        <form id='Forma' name ='Forma'  action='CSWows.jsp?' method='post'> 
            <input type='hidden' id='clConcierge' name='clConcierge' value='<%=StrclConcierge%>'>
            <div class='VTable' style='position:absolute; z-index:25; left:10px; top:10px;'>
                <p><font color="navy" face="Arial" size="3" ><b><i> WOW's: (Concierge VIP only)</i></b></font><br>
                    <input type='button' value='Agregar Wow' onClick='{fnVentanaLlenaWow(<%=StrclConcierge%>,<%=strclUsr%>)}' class='cBtn'>
                </p>
            </div>
            <div class='VTable' style='position:absolute; z-index:25; left:10px; top:50px;'>
                <%StringBuffer strSalidaW = new StringBuffer();
                        //System.out.println("st_ObtenWowsConcierge " + StrclConcierge + "," + strclUsr);
                        UtileriasBDF.rsTableNP("st_ObtenWowsConcierge " + StrclConcierge + "," + strclUsr, strSalidaW);
                %>
                <%=strSalidaW.toString()%>
                <%strSalidaW.delete(0, strSalidaW.length());%>
        </form>

        <script>
            function fnVentanaLlenaWow(clConcierge,clUsrApp)
            {
                window.open('CSAltaEventoWow.jsp?clConcierge=<%=StrclConcierge%>&clUsrApp=<%=strclUsr%>', 'LlenaWow' ,'scrolling=yes, width= 700 ,height= 300');
            }
   
            function fnVentanaEditarWow(clEvento,clConcierge,clUsrApp)
            {
                window.open('CSAltaEventoWow.jsp?clConcierge='+clConcierge+'&clUsrApp='+clUsrApp+'&clEvento='+clEvento, 'LlenaWow' ,'scrolling=yes, width= 650 ,height= 300');
            }

        </script>
        <%
                // strSalidaW = null;
                StrclConcierge = null;
        %>

    </body>
</html>
