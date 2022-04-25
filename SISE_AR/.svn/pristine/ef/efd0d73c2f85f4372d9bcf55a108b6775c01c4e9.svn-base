<%@page import="com.ike.retencion.DAORetencion"%>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC,com.ike.catalogos.to.ConceptosCosto,com.ike.catalogos.DAOConceptosCosto" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head><title>Conceptos Costo</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
        <script src='../Utilerias/Util.js' ></script>
        <%
            String StrclPaginaWeb = "28";
            String StrclUsrApp = "0";
            String StrclConcepto = "0";

            if (session.getAttribute("clUsrApp") != null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();
            }

            if (request.getParameter("clConcepto") != null) {
                StrclConcepto = request.getParameter("clConcepto").toString().trim();
            }

            if (SeguridadC.verificaHorarioC((Integer.parseInt(StrclUsrApp))) != true) {
                %>Fuera de Horario<%
                StrclPaginaWeb = null;
                StrclUsrApp = null;
                return;
            }

            DAOConceptosCosto DAOCC = null;
            ConceptosCosto CC = null;

            if (!StrclConcepto.equalsIgnoreCase("0")) {
                DAOCC = new DAOConceptosCosto();
                CC = DAOCC.getConceptosCosto(StrclConcepto);
            }

            session.setAttribute("clPaginaWebP", StrclPaginaWeb);
            %>
            <script type="text/javascript">fnOpenLinks()</script>
            <%
            MyUtil.InicializaParametrosC(Integer.parseInt(StrclPaginaWeb), Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina 
        %>
        <%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion", "")%>
        <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="ConceptoCosto.jsp?'>"%>

        <INPUT id='clConcepto' name='clConcepto' type='hidden' value='<%=StrclConcepto%>'><br><br><br><br>
        <%=MyUtil.ObjInput("Concepto", "dsConcepto", CC != null ? CC.getDsConcepto() : "", true, true, 20, 100, "", true, true, 70)%>
        <%=MyUtil.ObjInput("Codigo", "Codigo", CC != null ? CC.getCodigo() : "", true, true, 395, 100, "", false, false, 10)%>
        <%=MyUtil.ObjComboC("Area Operativa", "clAreaOperativa", CC != null ? CC.getDsAreaOperativa() : "", true, false, 470, 100, "", "Select clAreaOperativa, dsAreaOperativa From cAreaOperativa Order by dsAreaOperativa", "", "", 60, true, true)%>
        <%=MyUtil.ObjChkBox("Activo en Estatus", "EstatusAct", CC != null ? CC.getEstatusAct() : "0", false, false, 20, 150, "", "")%>
        <%=MyUtil.ObjChkBox("Activo", "Activo", CC != null ? CC.getActivo() : "0", true, true, 180, 150, "", "")%>
        <%=MyUtil.ObjComboC("Categoria", "clCategoria", CC != null ? CC.getDsCategoria() : "", true, true, 280, 150, "", "select clCategoria, dsCategoria from CatConceptosCosto order by 2", "", "", 60, true, true)%>
        <%=MyUtil.ObjChkBox("Excepcion", "Excepcion", CC != null ? CC.getExcepcion() : "0", true, true, 470, 150, "", "")%>
        <%=MyUtil.DoBlock("Detalle del Concepto Costo")%>

        <%=MyUtil.GeneraScripts()%> 

        <%
            StrclUsrApp = null;
        %>
        <script>
            //document.all.dsServicio.maxLength = 60;
        </script>
    </body>
</html>