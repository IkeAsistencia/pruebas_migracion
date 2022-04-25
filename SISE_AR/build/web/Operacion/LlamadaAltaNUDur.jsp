<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="Combos.cbAMIS,java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head><title>LLAMADA ALTA DE USUARIOS DURACELL</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">

        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj" /> 
        <script src='../Utilerias/Util.js' ></script>
        <script src='../Utilerias/UtilAuto.js'></script>
        <script src='../Utilerias/UtilMask.js' ></script>
        <%
            com.ike.util.I18N i18n = com.ike.util.I18N.getInstance("es", "AR");
            String StrclExpediente = "0";
            StringBuffer StrSql = new StringBuffer();
            String StrclUsrApp = "0";
            String StrclPaginaWeb = "0";
            String StrclLlamaAltaNU = "0";
            String StrCalle = "";
            String StrColonia = "";
            String StrclAfiliadoNU = "0";
            String StrclCuenta = "0";
            String StrUltra = "0";

            if (session.getAttribute("clUsrApp") != null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();
            }

            if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {
        %>Fuera de Horario<%
                return;
            }


            if (request.getParameter("clLlamaAltaNU") != null) {
                StrclLlamaAltaNU = request.getParameter("clLlamaAltaNU").toString();

            }

            StrSql.append(" Select coalesce(L.clAfiliado,'') as clAfiliado,  ");
            StrSql.append(" coalesce (C.clCuenta,'0') clCuenta, COALESCE(C.NOMBRE,'')CUENTA, coalesce(L.Clave,'') Clave, ");
            StrSql.append(" coalesce(clLlamaAltaNU,'0') 'clLlamaAltaNU',coalesce(C.Nombre,'') 'NombreC', ");
            StrSql.append(" coalesce (L.Nombre,'') 'Nombre', coalesce (convert(varchar(16),AD.FechaIni,120) ,'') 'FechaCompra', ");
            StrSql.append(" coalesce(L.Telefono,'') as Telefono, coalesce(L.Empresa,'') as Empresa,         ");
            StrSql.append(" coalesce(AC.dsAcumulador,'') as dsAcumulador,case when AC.Ultra = 0 then '40' else '60' end  as Ultra, coalesce(INF.SerieAcumulador,'') as SerieAcumulador,        ");
            StrSql.append(" INF.ClaveAMIS ,INF.CodigoMarca ,MA.dsMarcaAuto,T.dsTipoAuto, coalesce(INF.Modelo,'')Modelo ,      ");
            StrSql.append(" coalesce(E.dsEntFed,'') as dsEntFed, coalesce (E.CodEnt,'') as CodEnt, ");
            StrSql.append(" coalesce(M.dsMunDel,'') as dsMunDel, M.CodMD,  ");
            StrSql.append(" coalesce(L.CP,'') as CP, coalesce(L.Calle,'') as Calle, coalesce(L.Colonia,'') as Colonia    ");
            StrSql.append(" from LlamaAltaNU L  ");
            StrSql.append(" INNER JOIN cAfiliadoDUR AD on (L.clAfiliado=AD.clAfiliado)  ");
            StrSql.append(" INNER JOIN AfiliadoInfoAdicionalDUR INF on (L.clAfiliado=INF.clAfiliado)  ");
            StrSql.append(" INNER JOIN cAcumulador AC on (INF.clAcumulador=AC.clAcumulador)  ");
            StrSql.append(" INNER JOIN cCuenta C on (L.clCuenta=C.clCuenta)  ");
            StrSql.append(" LEFT JOIN CMARCAAUTO MA ON(MA.CodigoMarca=INF.CodigoMarca)  ");
            StrSql.append(" LEFT JOIN CTIPOAUTO  T ON(T.ClaveAMIS=INF.ClaveAMIS)  ");
            StrSql.append(" left join cEntFed E ON (E.CodEnt=L.CodEnt)  ");
            StrSql.append(" left join cMunDel M ON (M.CodMD=L.CodMD and M.CodEnt=L.CodEnt)  ");

            StrSql.append(" where clLlamaAltaNU =").append(StrclLlamaAltaNU);


            ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());

            StrclPaginaWeb = "562";
            MyUtil.InicializaParametrosC(562, Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina

            session.setAttribute("clPaginaWebP", StrclPaginaWeb);

        %><%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaLlamAltaAfilDur", "")%>
       <!-- <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%>LlamadaAltaNUuuu.jsp?'>-->
        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%>LlamadaAltaNUDur.jsp?'>
        <%

            String StrClaveAMIS = "";
            String StrCodigoMarca = "";
            String StrdsMarcaAuto = "";
            String StrdsTipoAuto = "";


            if (rs.next()) {
                StrclAfiliadoNU = rs.getString("clAfiliado");
                session.setAttribute("clAfiliadoNU", StrclAfiliadoNU);

                if (StrclAfiliadoNU == null) {
                    StrclAfiliadoNU = "";
                }
                StrCalle = rs.getString("Calle");
                if (StrCalle == null) {
                    StrCalle = "";
                }

                StrColonia = rs.getString("Colonia");
                if (StrColonia == null) {
                    StrColonia = "";
                }
                StrclCuenta = rs.getString("clCuenta");
                if (StrclCuenta == null) {
                    StrclCuenta = "";
                }

                StrClaveAMIS = rs.getString("ClaveAMIS");
                if (StrClaveAMIS == null) {
                    StrClaveAMIS = "";
                }

                StrCodigoMarca = rs.getString("CodigoMarca");
                if (StrCodigoMarca == null) {
                    StrCodigoMarca = "";
                }

                StrdsMarcaAuto = rs.getString("dsMarcaAuto");
                if (StrdsMarcaAuto == null) {
                    StrdsMarcaAuto = "";
                }

                StrdsTipoAuto = rs.getString("dsTipoAuto");
                if (StrdsTipoAuto == null) {
                    StrdsTipoAuto = "";
                }



        %>

        <INPUT id='clAfiliadoNU' name='clAfiliadoNU' type='hidden' value='<%=StrclAfiliadoNU%>'>
        <%=MyUtil.ObjInput("Folio", "clLlamaAltaNU", rs.getString("clLlamaAltaNU"), false, false, 30, 70, "", false, false, 10)%>
        <%=MyUtil.ObjComboC("Cuenta", "clCuenta", rs.getString("Cuenta"), false, false, 180, 70, "1034", "Select clCuenta,Nombre from ccuenta where clcuenta = 1034", "", "", 50, false, false)%>        
        <%=MyUtil.ObjInput("Poliza", "Clave", rs.getString("Clave"), true, false, 30, 120, "", true, true, 20)%>
        <%=MyUtil.ObjInput("Nombre", "Nombre", rs.getString("Nombre"), true, true, 180, 120, "", true, true, 45)%>
        <%=MyUtil.ObjInput("Fecha de Compra<br>(aaaa/mm/dd)", "FechaCompra", rs.getString("FechaCompra"), true, true, 450, 105, "", true, true, 12, "if(this.readOnly==false){fnValMask(this,document.all.FechaCompraMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("Telefono", "Telefono", rs.getString("Telefono"), true, true, 30, 160, "", false, false, 15)%>
        <%=MyUtil.ObjInput("Empresa", "Empresa", rs.getString("Empresa"), true, true, 180, 160, "", false, false, 45)%>        
        <%=MyUtil.ObjComboC("Acumulador", "clAcumulador", rs.getString("dsAcumulador"), true, true, 30, 200, "", "Select clAcumulador, dsAcumulador from cAcumulador order by dsAcumulador ", "fnLlenaGarantia()", "", 15, true, true)%>
        <%=MyUtil.ObjInput("Meses de Garantia", "GarantiaVTR", rs.getString("Ultra"), false, false, 220, 200, "", true, true, 15)%>
        <%=MyUtil.ObjInput("No Serie", "SerieAcumulador", rs.getString("SerieAcumulador"), true, true, 450, 200, "", true, true, 41)%>
        <%=MyUtil.DoBlock("Alta de Usuario if", 50, 0)%>

        <%=MyUtil.ObjComboMem("Marca de Auto", "CodigoMarca", StrdsMarcaAuto, StrCodigoMarca, cbAMIS.GeneraHTML(50, StrdsMarcaAuto), true, true, 30, 285, "", "fnLlenaAMISAcumula()", "", 50, true, true)%>
        <%=MyUtil.ObjComboMem("Tipo de Auto", "ClaveAMIS", StrdsTipoAuto, StrClaveAMIS, cbAMIS.GeneraHTMLTA(50, StrCodigoMarca, StrClaveAMIS), true, true, 200, 285, "", "", "", 50, true, true)%>
        <INPUT id='ClaveAMISVTR' name='ClaveAMISVTR' type='hidden' value='<%=StrClaveAMIS%>'>                
        <%=MyUtil.ObjInput("Modelo", "Modelo", rs.getString("Modelo"), true, true, 515, 285, "", false, false, 6)%>    
        <%=MyUtil.DoBlock("Datos Vehiculo", 0, 0)%>

        <div class='VTable' style='position:absolute; z-index:25; left:100px; top:461px;'>
            <INPUT type='button' VALUE='Buscar..' onClick='fnBuscaColoniaN2();' class='cBtn'></div>
            <%=MyUtil.ObjInput(i18n.getMessage("message.title.entidad"), "dsEntFed", rs.getString("dsEntFed"), false, false, 30, 370, "", false, false, 50)%>
        <INPUT id='CodEnt' name='CodEnt' type='hidden' value=''>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.municipío"), "dsMunDel", rs.getString("dsMunDel"), false, false, 380, 370, "", false, false, 50)%>
        <INPUT id='CodMD' name='CodMD' type='hidden' value=''>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.colonia"), "Colonia", rs.getString("Colonia"), false, false, 30, 410, "", false, false, 50)%>                
        <%=MyUtil.ObjInput("Calle y Número", "Calle", rs.getString("Calle"), true, true, 380, 410, "", false, false, 50)%>     
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.cp"), "CP", rs.getString("CP"), false, false, 30, 450, "", false, false, 10)%>
        <%=MyUtil.DoBlock("Domicilio", 140, 0)%>



        <%
        } else {
            session.setAttribute("clAfiliadoNU", null);
        %>
        <%=MyUtil.ObjInput("Folio", "clLlamaAltaNUVTR", "", false, false, 30, 70, "", false, false, 10)%>
        <%=MyUtil.ObjComboC("Cuenta", "clCuenta", "", false, false, 180, 70, "1034", "Select clCuenta,Nombre from ccuenta where clcuenta = 1034 ", "", "", 50, false, false)%>
        <%=MyUtil.ObjInput("Poliza", "Clave", "", true, false, 30, 120, "", true, true, 20)%>
        <%=MyUtil.ObjInput("Nombre", "Nombre", "", true, false, 180, 120, "", true, true, 45)%>
        <%=MyUtil.ObjInput("Fechade Compra<br>(aaaa/mm/dd)", "FechaCompra", "", true, true, 450, 105, "", true, true, 12, "if(this.readOnly==false){fnValMask(this,document.all.FechaCompraMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("Telefono", "Telefono", "", true, false, 30, 160, "", false, false, 15)%>
        <%=MyUtil.ObjInput("Empresa", "Empresa", "", true, false, 180, 160, "", false, false, 45)%>        
        <%=MyUtil.ObjComboC("Acumulador", "clAcumulador", "", true, true, 30, 200, "", "Select clAcumulador, dsAcumulador from cAcumulador order by dsAcumulador ", "fnLlenaGarantia()", "", 15, true, true)%>
        <%=MyUtil.ObjInput("Meses de Garantia", "GarantiaVTR", "", false, false, 220, 200, "", true, true, 15)%>
        <%=MyUtil.ObjInput("No Serie", "SerieAcumulador", "", true, true, 450, 200, "", true, true, 41)%>
        <%=MyUtil.DoBlock("Alta de Usuario", 50, 0)%>

        <%=MyUtil.ObjComboMem("Marca de Auto", "CodigoMarca", "", "", cbAMIS.GeneraHTML(50, ""), true, true, 30, 285, "", "fnLlenaAMISAcumula()", "", 50, true, true)%>
        <%=MyUtil.ObjComboMem("Tipo de Auto", "ClaveAMIS", "", "", cbAMIS.GeneraHTMLTA(50, "", ""), true, true, 200, 285, "", "", "", 50, true, true)%>
        <INPUT id='ClaveAMISVTR' name='ClaveAMISVTR' type='hidden' value=''>
        <%=MyUtil.ObjInput("Modelo", "Modelo", "", true, true, 515, 285, "", false, false, 6)%>
        <%=MyUtil.DoBlock("Datos Vehiculo", 0, 0)%>

        <div class='VTable' style='position:absolute; z-index:25; left:100px; top:461px;'>
            <INPUT type='button' VALUE='Buscar..' onClick='fnBuscaColoniaN2();' class='cBtn'></div>
            <%=MyUtil.ObjInput(i18n.getMessage("message.title.entidad"), "dsEntFed", "", false, false, 30, 370, "", false, false, 50)%>
        <INPUT id='CodEnt' name='CodEnt' type='hidden' value=''>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.municipio"), "dsMunDel", "", false, false, 380, 370, "", false, false, 50)%>
        <INPUT id='CodMD' name='CodMD' type='hidden' value=''>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.colonia"), "Colonia", "", false, false, 30, 410, "", false, false, 50)%>                
        <%=MyUtil.ObjInput("Calle y Número", "Calle", "", true, true, 380, 410, "", false, false, 50)%>     
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.cp"), "CP", "", false, false, 30, 450, "", false, false, 10)%>
        <%=MyUtil.DoBlock("Domicilio", 140, 0)%>


        <%
            }
        %><%=MyUtil.GeneraScripts()%><%
            rs.close();
            rs = null;
        %>

    </body>
</html>
<input name='FechaCompraMsk' id='FechaCompraMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09'>
<script>

                function fnBuscaColoniaN2() {
                    if (document.all.btnGuarda.disabled == false) {
                        var pstrCadena = "../Utilerias/FiltrosDireccion.jsp?strSQL=sp_WebBuscaDir 1,'" + document.all.CP.value + "'";
                        pstrCadena = pstrCadena + "&Colonia=&CodMd=&dsMunDel=&CodEnt=&dsEntFed=&Tipo=1";
                        window.open(pstrCadena, 'newWin', 'scrollbars=yes,status=yes,width=1,height=1');
                    }
                }

                function fnActualizaDatosCP(pCP, dsColonia, CodMD, dsMunDel, CodEnt, dsEntFed) {
                    document.all.CP.value = pCP;
                    document.all.Colonia.value = dsColonia;
                    document.all.CodMD.value = CodMD;
                    document.all.dsMunDel.value = dsMunDel;
                    document.all.CodEnt.value = CodEnt;
                    document.all.dsEntFed.value = dsEntFed;
                }
                function fnLblCta()
                {
                    if (document.all.clCuenta.value = 1020)
                    {
                        alert(document.all.Clave.label);

                        document.all.sivamed.style.visibility = 'visible';
                        document.all.ace.style.visibility = 'hidden';
                    }
                    else
                    {

                        document.all.ace.style.visibility = 'visible';
                        document.all.sivamed.style.visibility = 'hidden';
                    }
                }
                function fnOcultaDiv()

                {
                    document.all.sivamed.style.visibility = 'hidden';
                    document.all.ace.style.visibility = 'hidden';
                }

                function fnLlenaGarantia()
                {
                    var pstrCadena = "ObtenGarantiaDur.jsp?";
                    pstrCadena = pstrCadena + "clAcumulador=" + document.all.clAcumulador.value
                    window.open(pstrCadena, 'newWin', 'resizable=no,menubar=0,status=0,toolbar=0,height=10,width=10,screenX=-50,screenY=0');
                }

                function fnActualizaGarantia(pGarantia)
                {
                    if (pGarantia == 0)
                    {
                        document.all.GarantiaVTR.value = "40";
                    }
                    else
                    {
                        document.all.GarantiaVTR.value = "60";
                    }
                }
</script>

