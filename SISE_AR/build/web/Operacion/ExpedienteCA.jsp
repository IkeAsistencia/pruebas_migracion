<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="Combos.cbAMIS,java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head><title>ALTA DE USUARIOS</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">

        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj" /> 
        <script src='../Utilerias/Util.js' ></script>
        <script src='../Utilerias/UtilDireccion.js' ></script>
        <script src='../Utilerias/UtilAuto.js'></script>
        <script src='../Utilerias/UtilMask.js' ></script>
        <%
            com.ike.util.I18N i18n = com.ike.util.I18N.getInstance("es", "AR");
            StringBuffer StrSql = new StringBuffer();
            String StrclUsrApp = "0";
            String StrclPaginaWeb = "0";
            String strclFolioCA = "0";
            String StrFecha = "";


            if (session.getAttribute("clUsrApp") != null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();
            }

            if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {
        %>Fuera de Horario<%
                       return;
                   }

                   if (request.getParameter("clFolioCA") != null) {
                       strclFolioCA = request.getParameter("clFolioCA").toString();

                   }
                   StrSql.append("Select convert(varchar(16),getdate(),120) as Fecha");
                   ResultSet rsFecha = UtileriasBDF.rsSQLNP(StrSql.toString());
                   if (rsFecha.next()) {
                       StrFecha = rsFecha.getString("Fecha");
                   }
                   StrSql.delete(0, StrSql.length());

                   StrSql.append(" select EF.dsentfed, MU.dsmundel, EF2.dsentfed as dsEntDest, MU2.dsMunDel as dsMunDest,TA.ClaveAMIS,MA.CodigoMarca,MA.dsMarcaAuto,");
                   StrSql.append(" TA.dsTipoAuto,CA.clFolioCA, convert(varchar(16),CA.FechaRegistro,120) FechaRegistro,CA.Poliza,SUB.dsSubservicio as Servicio, CA.Usuario,CA.Telefono, CA.CodMDUbicacion,");
                   StrSql.append(" CA.CodEntUbicacion,COALESCE(CA.ColoniaUbicacion,'')ColoniaUbicacion,coalesce(CA.CalleNumUbicacion,'')CalleNumUbicacion,coalesce(CA.ReferenciasUbicacion,'')ReferenciasUbicacion, ");
                   StrSql.append(" P.Empresa, coalesce(cast(CA.Modelo as varchar (4)),'')Modelo,coalesce(CA.Color,'')Color,coalesce(CA.Placas,'')Placas,");
                   StrSql.append(" CA.CodMDDest,CA.CodEntDest,");
                   StrSql.append(" coalesce(CA.ColoniaDest,'')ColoniaDest,coalesce(CA.CalleNumDest,'')CalleNumDest,coalesce(CA.ReferenciasDest,'')ReferenciasDest ");
                   StrSql.append(" from ExpedienteCA CA ");
                   StrSql.append(" inner join csubservicio SUB on (CA.clservicio=SUB.clsubservicio) ");
                   StrSql.append(" left join cEntFed EF on (CA.CodEntUbicacion=EF.CodEnt)  ");
                   StrSql.append(" left  join cMunDel MU on (CA.CodMDUbicacion=MU.CodMD and MU.CodEnt=CA.CodEntUbicacion) ");
                   StrSql.append(" left  join cEntFed EF2 on (CA.CodEntDest=EF2.CodEnt) ");
                   StrSql.append(" left  join cMunDel MU2 on (CA.CodMDDest=MU2.CodMD and MU2.CodEnt=CA.CodEntDest)");
                   StrSql.append(" left join cPoliza P on (CA.Poliza=P.Poliza)");
                   StrSql.append(" left join cMarcaAuto MA on (MA.CodigoMarca=CA.CodigoMarca)");
                   StrSql.append(" left join cTipoAuto TA on (TA.ClaveAMIS=CA.ClaveAMIS and TA.CodigoMarca=CA.CodigoMarca)");
                   StrSql.append(" where clFolioCA=").append(strclFolioCA);


                   ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
                   StrSql.delete(0, StrSql.length());

                   StrclPaginaWeb = "565";
                   MyUtil.InicializaParametrosC(565, Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina

                   session.setAttribute("clPaginaWebP", StrclPaginaWeb);

        %>
        <%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion", "")%>
        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%>ExpedienteCA.jsp?'>
        <%

            String StrdsEntFed = "";
            String StrdsMunDel = "";
            String StrdsEntFedDest = "";
            String StrdsMunDelDest = "";
            String StrClaveAMIS = "";
            String StrCodigoMarca = "";
            String StrdsMarcaAuto = "";
            String StrdsTipoAuto = "";

            if (rs.next()) {

                StrdsEntFed = rs.getString("dsentfed");
                if (StrdsEntFed == null) {
                    StrdsEntFed = "";
                }

                StrdsMunDel = rs.getString("dsMunDel");
                if (StrdsMunDel == null) {
                    StrdsMunDel = "";
                }

                StrdsEntFedDest = rs.getString("dsEntDest");
                if (StrdsEntFedDest == null) {
                    StrdsEntFedDest = "";
                }

                StrdsMunDelDest = rs.getString("dsMunDest");
                if (StrdsMunDelDest == null) {
                    StrdsMunDelDest = "";
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
        <%=MyUtil.ObjInput("Folio", "clFolioCA", rs.getString("clFolioCA"), false, false, 30, 80, "", false, false, 20)%>
        <%=MyUtil.ObjInput("Fecha Registro", "FechaRegistro", rs.getString("FechaRegistro"), false, false, 170, 80, StrFecha, true, true, 20)%>
        <%=MyUtil.ObjInput("Poliza", "Poliza", rs.getString("Poliza"), true, false, 300, 80, "", true, true, 25)%>                
        <%=MyUtil.ObjComboC("Servicio", "clServicio", rs.getString("Servicio"), true, true, 465, 80, "", "Select clsubservicio as clServicio, dssubservicio as dsServicio from cSubServicio where clservicio=1 order by dssubservicio ", "", "", 25, true, true)%>
        <%=MyUtil.ObjInput("Usuario", "Usuario", rs.getString("Usuario"), true, true, 30, 120, "", true, true, 40)%>        
        <%=MyUtil.ObjInput("Telefono", "Telefono", rs.getString("Telefono"), true, true, 265, 120, "", true, true, 15)%>         
        <%=MyUtil.DoBlock("Información General", 45, 0)%>                                

        <%=MyUtil.ObjComboC(i18n.getMessage("message.title.entidad"), "CodEntUbicacion", StrdsEntFed, true, true, 30, 210, "", "Select CodEnt, dsEntFed from cEntFed order by dsEntFed ", "fnLlenaMunPolizaUbi()", "", 40, true, true)%>
        <%=MyUtil.ObjComboC(i18n.getMessage("message.title.municipio"), "CodMDUbicacion", StrdsMunDel, true, true, 320, 210, "", "Select CodMD, dsMunDel from cMunDel where CodMD='" + rs.getString("CodMDUbicacion") + "' and CodEnt='" + rs.getString("CodEntUbicacion") + "' order by dsMunDel ", "", "", 40, true, true)%>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.colonia"), "ColoniaUbicacion", rs.getString("ColoniaUbicacion"), true, true, 30, 250, "", false, false, 30)%>         
        <%=MyUtil.ObjInput("Calle y Número", "CalleNumUbicacion", rs.getString("CalleNumUbicacion"), true, true, 320, 250, "", false, false, 40)%>
        <%=MyUtil.ObjTextArea("Referencias Visuales", "ReferenciasUbicacion", rs.getString("ReferenciasUbicacion"), "85", "5", true, true, 30, 290, "", false, false)%>
        <%=MyUtil.DoBlock("Ubicación", 40, 40)%>                        

        <%=MyUtil.ObjInput("<br>La Poliza <br>Pertenece a: ", "EmpresaVTR", rs.getString("Empresa"), true, true, 580, 210, "", false, false, 18)%>
        <%=MyUtil.DoBlock("Empresa", -70, 40)%>                        

        <%=MyUtil.ObjComboMem("Marca de Auto", "CodigoMarca", StrdsMarcaAuto, StrCodigoMarca, cbAMIS.GeneraHTML(50, StrdsMarcaAuto), true, true, 30, 420, "", "fnLlenaAMISAcumula()", "", 50, true, true)%>
        <%=MyUtil.ObjComboMem("Tipo de Auto", "ClaveAMIS", StrdsTipoAuto, StrClaveAMIS, cbAMIS.GeneraHTMLTA(50, StrCodigoMarca, StrClaveAMIS), true, true, 200, 420, "", "", "", 50, true, true)%>
        <INPUT id='ClaveAMISVTR' name='ClaveAMISVTR' type='hidden' value='<%=StrClaveAMIS%>'>
        <%=MyUtil.ObjInput("Modelo", "Modelo", rs.getString("Modelo"), true, true, 500, 420, "", false, false, 6)%>
        <%=MyUtil.ObjInput("Color", "Color", rs.getString("Color"), true, true, 560, 420, "", false, false, 10)%>
        <%=MyUtil.ObjInput("Placas", "Placas", rs.getString("Placas"), true, true, 640, 420, "", false, false, 8)%>
        <%=MyUtil.DoBlock("Datos del Automóvil", -120, 0)%>

        <%=MyUtil.ObjComboC(i18n.getMessage("message.title.entidad"), "CodEntDest", StrdsEntFedDest, true, true, 30, 510, "", "Select CodEnt, dsEntFed from cEntFed order by dsEntFed ", "fnLlenaMunPolizaDest()", "", 40, true, true)%>
        <%=MyUtil.ObjComboC(i18n.getMessage("message.title.municipio"), "CodMDDest", StrdsMunDelDest, true, true, 320, 510, "", "Select CodMD, dsMunDel from cMunDel where CodMD='" + rs.getString("CodMDDest") + "' and CodEnt='" + rs.getString("CodEntDest") + "' order by dsMunDel ", "", "", 40, true, true)%>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.colonia"), "ColoniaDest", rs.getString("ColoniaDest"), true, true, 30, 550, "", false, false, 35)%>
        <%=MyUtil.ObjInput("Calle y Número", "CalleNumDest", rs.getString("CalleNumDest"), true, true, 320, 550, "", false, false, 40)%>
        <%=MyUtil.ObjTextArea("Referencias Visuales", "ReferenciasDest", rs.getString("ReferenciasDest"), "105", "5", true, true, 30, 590, "", false, false)%>
        <%=MyUtil.DoBlock("Destino", 200, 40)%>
        <%
        } else {
        %>
        <%=MyUtil.ObjInput("Folio", "clFolioCA", "", false, false, 30, 80, "", false, false, 20)%>
        <%=MyUtil.ObjInput("Fecha Registro", "FechaRegistro", StrFecha, false, false, 170, 80, StrFecha, true, true, 20)%>
        <%=MyUtil.ObjInput("Poliza", "Poliza", "", true, false, 300, 80, "", true, true, 25)%>                
        <%=MyUtil.ObjComboC("Servicio", "clServicio", "", true, true, 465, 80, "", "Select clsubservicio as clServicio, dssubservicio as dsServicio from cSubServicio where clservicio=1 order by dssubservicio ", "", "", 25, true, true)%>
        <%=MyUtil.ObjInput("Usuario", "Usuario", "", true, true, 30, 120, "", true, true, 40)%>        
        <%=MyUtil.ObjInput("Telefono", "Telefono", "", true, true, 265, 120, "", true, true, 15)%>       
        <%=MyUtil.DoBlock("Información General", 45, 0)%>

        <%=MyUtil.ObjComboC(i18n.getMessage("message.title.entidad"), "CodEntUbicacion", "", true, true, 30, 210, "", "Select CodEnt, dsEntFed from cEntFed order by dsEntFed ", "fnLlenaMunPolizaUbi()", "", 40, true, true)%>
        <%=MyUtil.ObjComboC(i18n.getMessage("message.title.municipio"), "CodMDUbicacion", "", true, true, 320, 210, "", "Select CodMD, dsMunDel from cMunDel where CodMD='' and CodEnt='' order by dsMunDel ", "", "", 40, true, true)%>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.colonia"), "ColoniaUbicacion", "", true, true, 30, 250, "", false, false, 30)%>
        <%=MyUtil.ObjInput("Calle y Número", "CalleNumUbicacion", "", true, true, 320, 250, "", false, false, 40)%>
        <%=MyUtil.ObjTextArea("Referencias Visuales", "ReferenciasUbicacion", "", "85", "5", true, true, 30, 290, "", false, false)%>
        <%=MyUtil.DoBlock("Ubicación", 40, 40)%>                        

        <%=MyUtil.ObjInput("<br>La Poliza <br>Pertenece a: ", "EmpresaVTR", "", false, false, 580, 210, "", false, false, 15)%>
        <%=MyUtil.DoBlock("Empresa", -70, 40)%>                        

        <%=MyUtil.ObjComboMem("Marca de Auto", "CodigoMarca", "", "", cbAMIS.GeneraHTML(50, ""), true, true, 30, 420, "", "fnLlenaAMISAcumula()", "", 50, true, true)%>
        <%=MyUtil.ObjComboMem("Tipo de Auto", "ClaveAMIS", "", "", cbAMIS.GeneraHTMLTA(50, "", ""), true, true, 200, 420, "", "", "", 50, true, true)%>
        <INPUT id='ClaveAMISVTR' name='ClaveAMISVTR' type='hidden' value=''>
        <%=MyUtil.ObjInput("Modelo", "Modelo", "", true, true, 500, 420, "", false, false, 6)%>
        <%=MyUtil.ObjInput("Color", "Color", "", true, true, 560, 420, "", false, false, 10)%>
        <%=MyUtil.ObjInput("Placas", "Placas", "", true, true, 640, 420, "", false, false, 8)%>
        <%=MyUtil.DoBlock("Datos del Automóvil", -120, 0)%>

        <%=MyUtil.ObjComboC(i18n.getMessage("message.title.entidad"), "CodEntDest", "", true, true, 30, 510, "", "Select CodEnt, dsEntFed from cEntFed order by dsEntFed ", "fnLlenaMunPolizaDest()", "", 40, true, true)%>
        <%=MyUtil.ObjComboC(i18n.getMessage("message.title.municipio"), "CodMDDest", "", true, true, 320, 510, "", "Select CodMD, dsMunDel from cMunDel where CodMD='' and CodEnt='' order by dsMunDel ", "", "", 40, true, true)%>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.colonia"), "ColoniaDest", "", true, true, 30, 550, "", false, false, 35)%>
        <%=MyUtil.ObjInput("Calle y Número", "CalleNumDest", "", true, true, 320, 550, "", false, false, 40)%>
        <%=MyUtil.ObjTextArea("Referencias Visuales", "ReferenciasDest", "", "105", "5", true, true, 30, 590, "", false, false)%>
        <%=MyUtil.DoBlock("Destino", 200, 40)%>
        <%
            }
        %>
        <%=MyUtil.GeneraScripts()%>
        <%
            rs.close();
            rs = null;

            StrdsEntFed = null;
            StrdsMunDel = null;
            StrdsEntFedDest = null;
            StrdsMunDelDest = null;
            StrClaveAMIS = null;
            StrCodigoMarca = null;
            StrdsMarcaAuto = null;
            StrdsTipoAuto = null;
        %>

    </body>
</html>

<script>
</script>

