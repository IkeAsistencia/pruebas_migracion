<%--
 Document   : CSConcierto
 Create on  : 2010-09-14
 Author     : rfernandez
--%>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%@ page import="Utilerias.UtileriasBDF,Seguridad.SeguridadC,javax.servlet.http.HttpSession,java.sql.ResultSet,com.ike.concierge.DAOCSConcierto,com.ike.concierge.to.CSConcierto;" %>

<html>
    <head>
            <title>CSConcierto</title>
    </head>
    <body class="cssBody">
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj"/>
        <script type="text/javascript" src='../../Utilerias/Util.js' ></script>
     
        <%
                String StrclUsr = "0";                
                String StrclConcierto = "0";

                if (session.getAttribute("clUsrApp") != null) {
                    StrclUsr = session.getAttribute("clUsrApp").toString();
                        }
                        if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsr)) != true) {
                        %>Fuera de Horario <%
                    StrclUsr = null;
                    return;
                }
                if (request.getParameter("clConcierto") != null) {
                    StrclConcierto = request.getParameter("clConcierto").toString();
                    %>
                    <script>
                                top.opener.fnLlenaDespuesdeGuardarConcierto('Concierto');
                                window.close();
                    </script>
                    <%                    
                 }
                
                DAOCSConcierto daoCSConcierto = null;
                CSConcierto CSC = null;

                daoCSConcierto = new DAOCSConcierto();
                CSC = daoCSConcierto.getclConcierto(StrclConcierto.toString());
     
           String StrclPaginaWeb = "1231";
           session.setAttribute("clPaginaWebP", StrclPaginaWeb);
       
    %>
    
    <%MyUtil.InicializaParametrosC(1231, Integer.parseInt(StrclUsr));%>
    <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccion","")%>

    <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="CSConcierto.jsp?'>"%>
    <%  int iY = 10;%>

    <INPUT id='clConcierto' name='clConcierto' type='hidden' value='<%=StrclConcierto%>'>

    <%=MyUtil.ObjInput("Tipo Concierto", "dsConcierto", CSC != null ? CSC.getdsConcierto() : "", true, true, 30, iY + 70, "", false, false, 60, "")%>
    <%=MyUtil.ObjChkBox("Activo", "Activo", "", false, false, 410, iY + 70, "", "SI", "NO", "")%>
    <%=MyUtil.DoBlock("Concierto", 10, 10)%>

    <%=MyUtil.GeneraScripts()%>

    <%  //<<<<<<<<<<<<<<<< Limpiar Variables >>>>>>>>>
    StrclConcierto = null;
    StrclPaginaWeb = null;
    daoCSConcierto = null;
    CSC = null;%>
  </body>
</html>
