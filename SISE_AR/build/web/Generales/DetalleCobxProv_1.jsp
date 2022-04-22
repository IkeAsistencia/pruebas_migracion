<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC,Utilerias.UtileriasObj" errorPage="" %>
<html>
    <head>
        <title>Detalle Cobertura del Proveedor</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody" onload="fnValidaCobertura();">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" />
        <script src='../Utilerias/Util.js' ></script>
        <script src='../Utilerias/UtilDireccion.js' ></script>
        <%
            String StrclProveedor = "0";
            String StrclCoberturaxProveedor = "0";
            String StrNomOpe = "";
            String StrclUsrApp = "0";

            int iCont = 0;

            if (session.getAttribute("clUsrApp") != null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();
            }

            if (session.getAttribute("clProveedor") != null) {
                StrclProveedor = session.getAttribute("clProveedor").toString();
            }

            if (request.getParameter("clCoberturaxProveedor") != null) {
                StrclCoberturaxProveedor = request.getParameter("clCoberturaxProveedor").toString();
            }

            if (session.getAttribute("NombreOpe") != null) {
                StrNomOpe = session.getAttribute("NombreOpe").toString();
            }

            if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {
        %>Fuera de Horario<%
                StrclProveedor = null;
                StrclCoberturaxProveedor = null;
                StrNomOpe = null;
                StrclUsrApp = null;

                return;
            }
            StringBuffer StrSql = new StringBuffer();
            StrSql.append("select CxP.CodEnt, EF.dsEntFed, coalesce(CxP.CodMD,'') CodMD, ");
            StrSql.append(" coalesce(MD.dsMunDel,'') dsMunDel  ");
            StrSql.append(" from  CoberturaxProveedor CxP ");
            StrSql.append(" inner join cEntFed EF on (CxP.CodEnt = EF.CodEnt) ");
            StrSql.append(" left join cMunDel MD on (MD.CodEnt = EF.CodEnt ");
            StrSql.append("                          and CxP.CodMD = MD.CodMD ) ");
            StrSql.append(" where CxP.clCoberturaxProveedor = ").append(StrclCoberturaxProveedor);
            ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
            StrSql.delete(0, StrSql.length());

            String StrclPaginaWeb = "262";

            // se checan permisos de alta,baja,cambio,consulta de esta pagina
            MyUtil.InicializaParametrosC(262, Integer.parseInt(StrclUsrApp));
        %>
        <form target='VistaPrevia' method='post' action='AsignarCobertura.jsp'>
            <div style='position:absolute; z-index:303; left:30px; top:175px' id="btnVistaPrevia">
                <input type='submit' value='Vista Previa' name="VistaPrevia" onclick=''>
            </div>
            <!--
            <div style='position:absolute; z-index:303; left:30px; top:175px' id="btnAsignar">
                <input type='submit' value='Asignar Cobertura Completa' name="Asignar" onclick=''>
            </div>
            -->
            <input id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="DetalleCobxProv.jsp?"%>'>
            <input id='clProveedor' name='clProveedor' type='hidden' value='<%=StrclProveedor%>'>
            <input id='clCoberturaxProveedor' name='clCoberturaxProveedor' type='hidden' value='<%=StrclCoberturaxProveedor%>'>
            <%
            if (rs.next()) {
            %>
            <%=MyUtil.ObjInput("Nombre Operativo", "NombreOpe", StrNomOpe, false, false, 30, 80, StrNomOpe, false, false, 70)%>
            <%=MyUtil.ObjComboC("Tipo de Cobertura", "clTipoCobertura", "", true, true, 30, 125, "0", "select '1' as 'clTipoCobertura', 'POR PROVINCIA' as 'dsTipoCobertura' union select '2' as 'clTipoCobertura', 'POR LOCALIDAD' as 'dsTipoCobertura'union select '3' as 'clTipoCobertura', 'TODO EL PAIS' as 'dsTipoCobertura'", "fnValidaCobertura();", "", 50, true, true)%>
            <%=MyUtil.ObjComboC("Provincia", "CodEnt", "", true, false, 200, 125, "", "Select CodEnt, dsEntFed from cEntFed ", "", "", 25, false, false)%>
            <%
            } else {
            %>
            <%=MyUtil.ObjInput("Nombre Operativo", "NombreOpe", StrNomOpe, false, false, 30, 80, StrNomOpe, false, false, 70)%>
            <%=MyUtil.ObjComboC("Tipo de Cobertura", "clTipoCobertura", "", true, true, 30, 125, "0", "select '1' as 'clTipoCobertura', 'POR PROVINCIA' as 'dsTipoCobertura' union select '2' as 'clTipoCobertura', 'POR LOCALIDAD' as 'dsTipoCobertura'union select '3' as 'clTipoCobertura', 'TODO EL PAIS' as 'dsTipoCobertura'", "fnValidaCobertura();", "", 50, true, true)%>
            <%=MyUtil.ObjComboC("Provincia", "CodEnt", "", true, false, 200, 125, "", "Select CodEnt, dsEntFed from cEntFed ", "", "", 25, false, false)%>
            <%  }%>
            <%=MyUtil.DoBlock("Detalle de Cobertura Regional del Proveedor", 190, 40)%>
            <%
            rs.close();
            rs = null;

            StrSql = null;

            StrclProveedor = null;
            StrclCoberturaxProveedor = null;
            StrNomOpe = null;
            StrclUsrApp = null;
            StrclPaginaWeb = null;
            %>
        </form>
        
        <script>
            document.all.clTipoCoberturaC.disabled=false;
            document.getElementById('btnVistaPrevia').style.visibility = 'hidden';
            document.all.D5.style.visibility="hidden";
            document.all.CodEntC.disabled=false;

            function fnValidaCobertura(){
                //parent.VistaPrevia.location.reload(true);
                if(document.all.clTipoCoberturaC.value==1 || document.all.clTipoCoberturaC.value==2){
                    document.getElementById('btnVistaPrevia').style.visibility = 'visible';
                    if(document.all.clTipoCoberturaC.value==2){
                        document.all.D5.style.visibility="visible";  
                    } else {
                        document.all.D5.style.visibility="hidden";  
                    }
                } else {
                    document.getElementById('btnVistaPrevia').style.visibility = 'hidden';
                    document.all.D5.style.visibility="hidden";  
                }
                
                if(document.all.clTipoCoberturaC.value==3){
                    document.getElementById('btnAsignar').style.visibility = 'visible';
                    
                } else {
                    document.getElementById('btnAsignar').style.visibility = 'hidden';
                }
            }
        </script>
    </body>
</html>