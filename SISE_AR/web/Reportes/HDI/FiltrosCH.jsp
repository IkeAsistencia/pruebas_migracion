<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Seguridad.SeguridadC,Utilerias.UtileriasBDF,Combos.cbServicio" errorPage="" %>
<html>
    <head>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <title>Filtros HDI</title>
    </head>
    <body topmargin=470 leftmargin=30 class="cssBody"  >
        <script src='../../Utilerias/Util.js'></script>
        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj" />
        <script src='../../Utilerias/UtilMask.js'></script>

        <%
            String StrclUsrApp = "0";
            String StrclPaginaWeb = "0";
            
            if (session.getAttribute("clUsrApp") != null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();
            }
            
            if (session.getAttribute("clPaginaWebP") != null) {
                StrclPaginaWeb = session.getAttribute("clPaginaWebP").toString();
            }
            
            if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {
                %> Fuera de Horario <%
                return;
            }
            MyUtil.InicializaParametrosC(1448, Integer.parseInt(StrclUsrApp));
        %>
        <form action="ListadoCH.jsp" id="Forma1" name="Forma1" target="ListadoCH">
            <INPUT id='clPaginaWeb' name='clPaginaWeb' type='hidden' value='<%=StrclPaginaWeb%>'>
            <!--%=MyUtil.ObjInput("Expediente", "clExpediente", "", true, true, 30, 20, "", true, true, 20, "")% -->
            <%=MyUtil.ObjInput("Fecha Incio <BR>AAAA/MM/DD", "FechaInicio", "", true, false, 30, 20, "", true, true, 22, "if(this.readOnly == false){ fnValMask(this, FechaMsk.value, this.name)}")%>
            <%=MyUtil.ObjInput("Fecha Fin <BR>AAAA/MM/DD", "FechaFin", "", true, false, 180, 20, "", true, true, 22, "if(this.readOnly == false){ fnValMask(this, FechaMsk.value, this.name)}")%>
            <%=MyUtil.ObjInput("<BR>Póliza", "Poliza", "", true, true, 330, 20, "", true, true, 20, "")%> 
            <%=MyUtil.ObjInput("<BR>Patente", "Patente", "", true, true, 470, 20, "", true, true, 20, "")%> 
            <%=MyUtil.DoBlock("Reporte HDI", 100, 30)%>
            <%=MyUtil.GeneraScripts()%>
            <div class='VTable' style='position:absolute; z-index:50; left:610px; top:43px; color: greenyellow'>
                <INPUT ID="Buscar" type='submit' VALUE='Buscar...'  class='cBtn'>
            </div>
            <div  class='VTable' style='position:absolute; z-index:4; left:150px; top:73px;'>
                <input type="button" value="Solicitar Reporte TXT" class='cBtn' onclick="fnSolicitaRPTTXT()"/>    
            </div>
            <div  class='VTable' style='position:absolute; z-index:4; left:300px; top:73px;'>
                <input type="button" value="Solicitar Reporte EXCEL" class='cBtn' onclick="fnSolicitaRPTCSV()"/>    
            </div>
        </form>
        <%
            StrclUsrApp = null;
        %>
        <input name='FechaMsk' id='FechaMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09'>
        <script>
            //------------------------------------------------------------------------------
            //document.all.clExpediente.readOnly = false;
            //document.all.Folio.readOnly = false;

            document.getElementById("FechaInicio").readOnly = false;
            document.getElementById("FechaFin").readOnly = false;
            document.getElementById("Poliza").readOnly = false;
            document.getElementById("Patente").readOnly = false;
            //------------------------------------------------------------------------------

            function fnSolicitaRPTTXT() {
                window.open('ProcesaHDI.jsp?Bandera=1&FechaIni=' + document.getElementById("FechaInicio").value + "&clPaginaWeb=" + document.getElementById("clPaginaWeb").value
                        + '&FechaFin=' + document.getElementById("FechaFin").value
                        + "&Poliza=" + document.getElementById("Poliza").value
                        + "&Patente=" + document.getElementById("Patente").value, '', 'resizable=yes,menubar=0,status=1,toolbar=1,screenY=100,height=200,width=400,scrollbars=1');
            }
            function fnSolicitaRPTCSV() {
                window.open('ProcesaHDI.jsp?Bandera=0&FechaIni=' + document.getElementById("FechaInicio").value + "&clPaginaWeb=" + document.getElementById("clPaginaWeb").value
                        + '&FechaFin=' + document.getElementById("FechaFin").value
                        + "&Poliza=" + document.getElementById("Poliza").value
                        + "&Patente=" + document.getElementById("Patente").value, '', 'resizable=yes,menubar=0,status=1,toolbar=1,screenY=100,height=200,width=400,scrollbars=1');
            }
        </script>
    </body>
</html>