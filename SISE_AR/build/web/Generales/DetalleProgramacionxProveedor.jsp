<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head><title>Programacion x Proveedor</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <link href="../StyleClasses/Calendario.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody" onload="fnControlDIVCostos();">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
        <script src='../Utilerias/Util.js' ></script>
        <script src='../Utilerias/UtilCalendarioV.js'></script>
        <%
            String StrclProgramacion = "0";
            String StrclUsrApp = "0";
            String StrclProveedor = "0";
            String StrNomOpe = "";
            String StrclPaginaWeb = "6083";
            StringBuffer StrSql = new StringBuffer();
            String StrclSubServicio="0";

            if (session.getAttribute("clUsrApp") != null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();
            }

            if (session.getAttribute("clProveedor") != null) {
                StrclProveedor = session.getAttribute("clProveedor").toString();
            }

            if (session.getAttribute("NombreOpe") != null) {
                StrNomOpe = session.getAttribute("NombreOpe").toString();
            }

            if (request.getParameter("clProgramacion") != null) {
                StrclProgramacion = request.getParameter("clProgramacion");
            }
/*
            if (request.getParameter("clSubServicio") != null) {
                StrclSubServicio = request.getParameter("clSubServicio").toString();
            }
            if (StrclSubServicio.compareToIgnoreCase("0") == 0) {
                if (session.getAttribute("clSubServicio") != null) {
                    StrclSubServicio = session.getAttribute("clSubServicio").toString();
                }
                System.out.println("Subservicio: " + StrclSubServicio);
            }
            */
            if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {%>
        Fuera de Horario
        <%
                StrclProgramacion = null;
                StrclUsrApp = null;
                StrclProveedor = null;
                StrNomOpe = null;
                StrclPaginaWeb = null;
                StrSql = null;
                return;
            }

            StrSql.append("st_PGDetalleProgramacion ").append(StrclProgramacion);

            ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
            StrSql.delete(0, StrSql.length());

            session.setAttribute("clPaginaWebP", StrclPaginaWeb);
        
            MyUtil.InicializaParametrosC(Integer.parseInt(StrclPaginaWeb), Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
        %>
        <%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion", "fnControlDIVCostos();", "fnControlDIVCostos();", "")%>
        <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="DetalleProgramacionxProveedor.jsp?'>"%>
        <%
            session.setAttribute("clProgramacion", StrclProgramacion);
        %>
        <INPUT id='clProveedor' name='clProveedor' type='hidden' value='<%=StrclProveedor%>'>
        <INPUT id='clUsrAppRegistra' name='clUsrAppRegistra' type='hidden' value='<%=StrclUsrApp%>'>
        <INPUT id='clProgramacion' name='clProgramacion' type='hidden' value='<%=StrclProgramacion%>'>
        <INPUT id='ExistePendiente' name='ExistePendiente' type='hidden' value='0'>
        <INPUT id='conceptos' name='conceptos' type='hidden' value='0'>


        <%=MyUtil.ObjInput("Proveedor", "NombreOpe", StrNomOpe, true, false, 20, 100, StrNomOpe, false, false, 70)%>
        <% if (rs.next()) { %>
        <% session.setAttribute("clSubServicio", rs.getString("clSubServicio"));%>
        <%=MyUtil.ObjComboC("Subservicio", "clSubServicio", rs.getString("dsSubServicio"), true, false, 20, 140, "0", "st_PGgetComboSubServicio " + StrclProveedor, "fnObtenPrioridad(this.value);", "", 50, true, true)%>
        <%=MyUtil.ObjInput("Prioridad<br>Actual", "PrioridadActual", rs.getString("PrioridadActual"), false, false, 246, 140, "", false, false, 9)%>
        <%=MyUtil.ObjInput("Nueva<br>Prioridad", "NuevaPrioridad", rs.getString("NuevaPrioridad"), true, true, 326, 140, "", true, true, 9)%>
        <%=MyUtil.ObjInputF("Fecha Programada", "FechaProgramada", rs.getString("FechaProgramada"), true, true, 20, 180, "", true, true, 20, 1, "")%>
        <%=MyUtil.ObjChkBox("Procesado", "PROC", rs.getString("Procesado"), false, false, 326, 190, "", "SI", "NO", "")%>
        <div id="DIVCostos" style="display:none;">
            <div class='VTable' style='position:absolute; z-index:25; left:320px; top:245px;'>
                <!--<input class='cBtn' type='button' value='Agregar Nuevo Costo' onClick="window.open('ProgramacionCostoxProveedor.jsp', 'Costo', 'resizable=yes,scrollbars=yes,status=yes,width=450,height=200')">-->    
                <input class='cBtn' type='button' value='Agregar Nuevo Costo' onClick="fnConcatena('','conceptos')">    
         
            </div>
            <BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR>
            <%
                StringBuffer StrSql1 = new StringBuffer();
                StrSql1.append("st_PGListaCostos " + StrclProgramacion + "," + StrclProveedor + "," + rs.getString("clSubServicio"));

                StringBuffer strSalida = new StringBuffer();
                UtileriasBDF.rsTableNP(StrSql1.toString(), strSalida);
            %>
            <%=strSalida.toString()%>
        </div>
        <%
            strSalida.delete(0, strSalida.length());
            StrSql1.delete(0, StrSql1.length());
        %>

        <% } else {%>
        <%=MyUtil.ObjComboC("Subservicio", "clSubServicio", "", true, true, 20, 140, "0", "st_PGgetComboSubServicio " + StrclProveedor, "fnObtenPrioridad(this.value)", "", 50, true, true)%>
        <%=MyUtil.ObjInput("Prioridad<br>Actual", "PrioridadActual", "", false, false, 246, 140, "", false, false, 9)%>
        <%=MyUtil.ObjInput("Nueva<br>Prioridad", "NuevaPrioridad", "", true, true, 326, 140, "", true, true, 9)%>
        <%=MyUtil.ObjInputF("Fecha Programada", "FechaProgramada", "", true, true, 20, 180, "", true, true, 20, 1, "")%>
        <%=MyUtil.ObjChkBox("Procesado", "PROC", "", false, false, 326, 190, "", "SI", "NO", "")%>                
        <div id="DIVCostos" style="display:none;"></div>
        <% }%>
        <%=MyUtil.DoBlock("Detalle de Programacion", -20, 40)%>
        <%=MyUtil.GeneraScripts()%>

        <%
            rs.close();
            rs = null;
            StrSql = null;

            StrclProgramacion = null;
            StrclUsrApp = null;
            StrclProveedor = null;
            StrNomOpe = null;
        %>
        <script>
            function fnControlDIVCostos() {
                if (document.all.Action.value == '' && document.all.clProgramacion.value != '0') {
                    div = document.getElementById('DIVCostos');
                    div.style.display = '';
                } else {
                    div = document.getElementById('DIVCostos');
                    div.style.display = '';
                }
            }

            function fnObtenPrioridad(clSubServicio) {
                window.open('ObtenProgramacionxProveedor.jsp?Tipo=1&clProveedor=' + document.all.clProveedor.value + '&clSubServicio=' + clSubServicio, '', 'resizable=yes,menubar=0,status=1,toolbar=1,screenY=100,height=200,width=500,scrollbars=1');
            }
			
            function fnLimpaCo(clProgramacionCosto){
            var limpia = clProgramacionCosto.parentElement.parentElement.getElementsByTagName("input");
            for(var x=0;x<limpia.length-1;x++){
                limpia[x].value='';
                }
            }
			
            function fnRegresaActual(Actual, ExistePendiente) {
                document.all.PrioridadActual.value = Actual;
                document.all.ExistePendiente.value = ExistePendiente;
                
                fnValidaPendiente();
            }
            
            function fnValidaPendiente(){
                
                if (document.all.ExistePendiente.value == '1') {
                    alert('El SubServicio seleccionado tiene una programación pendiente de ser procesada.');
                    document.all.clSubServicio.value = '0';
                    document.all.clSubServicioC.value = '';
                    document.all.PrioridadActual.value = '';
                    document.all.clSubServicioC.focus();
                }
            }

            function fnConcatena (msg,idAsig){
                var registros=[];
                var tr=document.getElementById("ObjTable").getElementsByTagName("tr");
                
                for(var x=1;x<tr.length;x++){
                   var input= tr[x].getElementsByTagName("input");
                   var text =input[0].getAttribute("data-clConcepto")+"a"+input[0].getAttribute("data-costoActual")+"b"+input[0].value+"c"+input[1].value+"d"+input[0].getAttribute("data-clPrograCosto");
                   registros.push(text);
                }
                if (registros.length>0){
                    document.getElementById(idAsig).value=registros.join(",");
                    console.log(registros.join(","));
                    ///jsp o servlet
                    
                    var pstrConceptos = "ConceptoProgramado.jsp?strSQL=st_GuardaConceptoProgramado";
                    pstrConceptos = pstrConceptos + "&clProgramacion=" + document.all.clProgramacion.value + "&clUsrAppRegistra=" + document.all.clUsrAppRegistra.value + "&Conceptos=" + registros.join(",");
                    
            console.log(pstrConceptos);
            //System.out.println(pstrConceptos);
            
            window.open(pstrConceptos, 'newWin', 'scrollbars=yes,status=yes,width=640,height=300');
                    
                }
                else{
                    if(msg!=""){
                        alert(msg);
                        return;
                    }
                }
            }
        </script>
    </body>
</html>