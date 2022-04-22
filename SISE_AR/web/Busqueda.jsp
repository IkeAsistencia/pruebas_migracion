<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%@ page import="Utilerias.UtileriasBDF,Seguridad.SeguridadC,java.sql.ResultSet,Utilerias.UtileriasObj,Combos.cbEntidad;" %>


<html>
    <head><title>ExportacionxProyecto</title>
        <link href="StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <script src='Utilerias/UtilAjax.js'></script>

    </head>

    <body class="cssBody" onload="">
        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj"/>


        <%
            String StrclUsr = "0";
            String StrclPaginaWeb = "0";

            if (session.getAttribute("clUsrApp") != null) {
                StrclUsr = session.getAttribute("clUsrApp").toString();
            }

            if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsr)) != true) {%> 
        Fuera de Horario <%
                StrclUsr = null;
                StrclPaginaWeb = null;
                return;
            }

            StrclPaginaWeb = "31";

            String dsEntFed = "";
            String CodEnt = "";
            String dsMunDel = "";
            String StrCodMD = "";

        %>

        <%MyUtil.InicializaParametrosC(155, Integer.parseInt(StrclUsr));%>
        <%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion", "", "")%>
        <input type="text" id="entrada" size="77"/>

        <input type="button" value="Consultar" onclick="recuperaResidencia()"/>
        <br/>
        <br/>
        Lugar de residencia: <span id="salida"></span>

        <br/>
        <br/>

        <%=MyUtil.ObjComboCDiv("Proyecto", "clProyecto", "", true, true, 350, 50, "", "select codent , dsentfed from cEntFed ", "fnLLenaCombo(this.value,'clImportaciones','Importaciones','fnCombo2(this.value);');", "", 30, true, true, "Pais")%> 
        <%=MyUtil.ObjComboCDiv("Importaciones", "clImportaciones", "", true, true, 350, 100, "", "select top 1 * from cPais", "", "", 20, true, true, "ImportacionesDiv")%> 

        <%=MyUtil.ObjComboMemDiv("Provincia", "CodEnt", dsEntFed, CodEnt, cbEntidad.GeneraHTML(20, dsEntFed), true, true, 350, 250, "", "fnLLenaComboMDAjax(this.value,'ProvinciaDiv','Localidad','');", "", 20, true, true, "ProvinciaDiv")%>                        
        <%=MyUtil.ObjComboMemDiv("Localidad", "CodMD", dsMunDel, StrCodMD, cbEntidad.GeneraHTMLMD(30, CodEnt, dsMunDel), true, true, 350, 300, "", "", "", 20, true, true, "LocalidadDiv")%>                

        <form  method="post">

            <input type="submit">
        </form>

        <script>

            document.all.clProyectoC.disabled = false;
            document.all.CodEntC.disabled = false;


            function fnLLenaCombo(value, IDCombo, Label, FnCombo) {
                URL = "pagina3.jsp?";
                Cadena = "Opcion=" + value + "&IdCombo=" + IDCombo + "&Label=" + Label + "&FnCombo=" + FnCombo;
                IdDiv = "ImportacionesDiv";
                fnLLenaInput(URL, Cadena, IdDiv);
            }

            function fnLLenaComboDIV(value, IDCombo, Label, FnCombo) {
                URL = "servlet/Combos.LlenaComboAjax?SqlQry=st_ajLlenaMunDel&";
                Cadena = "Opcion=" + value + "&IdCombo=" + IDCombo + "&Label=" + Label + "&FnCombo=" + FnCombo;
                IdDiv = "LocalidadDiv";
                fnLLenaInput(URL, Cadena, IdDiv);
            }

            function fnLLenaComboMDAjax(value, IDCombo, Label, FnCombo) {
                URL = "servlet/Combos.LlenaMDAjax?";
                Cadena = "Opcion=" + value + "&IdCombo=" + IDCombo + "&Label=" + Label + "&FnCombo=" + FnCombo;
                IdDiv = "LocalidadDiv";
                fnLLenaInput(URL, Cadena, IdDiv);
            }

            function fnCombo2(Value) {
                alert(Value);
            }
        </script>

    </body>
</html>
