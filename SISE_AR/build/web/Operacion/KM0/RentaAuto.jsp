<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<!--%@page pageEncoding="iso-8859-1"%-->
<html>
    <head><title>JSP Page</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">

        <%-- <jsp:useBean id="beanInstanceName" scope="session" class="beanPackage.BeanClassName" /> --%>
        <%-- <jsp:getProperty name="beanInstanceName"  property="propertyName" /> --%>

        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
        <script src='../../Utilerias/Util.js' ></script>
        <script src='../../Utilerias/UtilDireccion.js' ></script>
        <script src='../../Utilerias/UtilAuto.js' ></script>

        <%
            String StrclUsrApp = "0";

            if (session.getAttribute("clUsrApp") != null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();
            }

            if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {
        %>
        <%="Fuera de Horario"%>
        <%
                StrclUsrApp = null;

                return;
            }
            String StrclExpediente = "0";
            String StrclPaginaWeb = "0";
            String StrFecha = "";

            if (session.getAttribute("clExpediente") != null) {
                StrclExpediente = session.getAttribute("clExpediente").toString();
            }
            StringBuffer StrSql1 = new StringBuffer();
            // checar si ya existe asistencia para el expediente, si existe, ya no procede la alta
            StrSql1.append(" Select TieneAsistencia From Expediente");
            StrSql1.append(" Where clExpediente=").append(StrclExpediente);
            ResultSet rs2 = UtileriasBDF.rsSQLNP(StrSql1.toString());
            StrSql1.delete(0, StrSql1.length());

            if (rs2.next()) {
            } else {
        %>
        <%="El expediente no existe"%>
        <%
                rs2.close();
                rs2 = null;
                StrclExpediente = null;
                StrclPaginaWeb = null;
                StrFecha = null;
                StrclUsrApp = null;

                return;
            }

            ResultSet rs3 = UtileriasBDF.rsSQLNP("Select convert(varchar(20),getdate(),120) FechaApertura");
            if (rs3.next()) {
                StrFecha = rs3.getString("FechaApertura");
            }

            StrSql1.append("Select R.clExpediente, ");
            StrSql1.append(" coalesce(convert(varchar(20), R.FechaApertura,120),'') as FechaApertura, ");
            StrSql1.append(" coalesce(convert(varchar(20), R.FechaRegistro,120),'') as FechaRegistro, ");
            StrSql1.append(" coalesce(C.dsCausaAsistencia,'') as dsCausaAsistencia, ");
            StrSql1.append(" coalesce(R.TiempoReparacion,'') as TiempoReparacion, ");
            StrSql1.append(" coalesce(ERes.dsEntFed,'') as dsEntFedResid, ");
            StrSql1.append(" coalesce(MRes.dsMunDel,'') as dsMunDelResid, ");
            StrSql1.append(" R.CodEntResid, ");
            StrSql1.append(" coalesce(MA.dsMarcaAuto,'') as dsMarcaAuto, ");
            StrSql1.append(" coalesce(TA.dsTipoAuto,'') as dsTipoAuto, ");
            StrSql1.append(" coalesce(R.CodigoMarca,'') as CodigoMarca, ");
            StrSql1.append(" coalesce(R.ClaveAMIS,'') as ClaveAMIS, ");
            StrSql1.append(" coalesce(R.ReservacionA,'') as ReservacionA, ");
            StrSql1.append(" coalesce(R.HorasReservacion,'') as HorasReservacion, ");
            StrSql1.append(" coalesce(R.NumTarjCredito,'') as NumTarjCredito, ");
            StrSql1.append(" coalesce(R.CodigoSeguridad,'') as CodigoSeguridad, ");
            StrSql1.append(" coalesce(R.Banco,'') as Banco, ");
            StrSql1.append(" coalesce(R.MesVmtoTarj,'') as MesVmtoTarj, ");
            StrSql1.append(" coalesce(R.AnioVmtoTarj,'') as AnioVmtoTarj, ");
            StrSql1.append(" coalesce(R.NumPersonasViajan,'') as NumPersonasViajan, ");
            StrSql1.append(" R.TieneLicencia, ");
            StrSql1.append(" coalesce(ERen.dsEntFed,'') as dsEntFed, ");
            StrSql1.append(" coalesce(MRen.dsMunDel,'') as dsMunDel, ");
            StrSql1.append(" R.CodEnt, ");
            StrSql1.append(" coalesce(R.CalleNum,'') as CalleNum, ");
            StrSql1.append(" R.CostoCotizacion as CostoCotizacion, ");
            StrSql1.append(" R.CostoFinal as CostoFinal ");
            StrSql1.append(" From ");
            StrSql1.append(" RentaAuto R ");
            StrSql1.append(" left join cCausaAsistenciaKM0 C ON (C.clCausaAsistencia=R.clCausaAsistencia) ");
            StrSql1.append(" left join cEntFed ERes ON (ERes.CodEnt=R.CodEntResid) ");
            StrSql1.append(" left join cMunDel MRes ON (MRes.CodMD=R.CodMDResid and MRes.CodEnt=R.CodEntResid) ");
            StrSql1.append(" left join cEntFed ERen ON (ERen.CodEnt=R.CodEnt) ");
            StrSql1.append(" left join cMunDel MRen ON (MRen.CodMD=R.CodMD and MRen.CodEnt = R.CodEnt) ");
            StrSql1.append(" left join cTipoAuto TA ON (TA.ClaveAMIS=R.ClaveAMIS and TA.CodigoMarca=R.CodigoMarca) ");
            StrSql1.append(" left join cMarcaAuto MA ON (MA.CodigoMarca=R.CodigoMarca) ");
            StrSql1.append(" Where R.clExpediente =").append(StrclExpediente);
            ResultSet rs = UtileriasBDF.rsSQLNP(StrSql1.toString());
            StrSql1.delete(0, StrSql1.length());
        %>    
        <script>fnOpenLinks()</script>
        <%
            StrclPaginaWeb = "143";
            MyUtil.InicializaParametrosC(143, Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina

            session.setAttribute("clPaginaWebP", StrclPaginaWeb);
        %>
        <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist", "")%>        
        <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="RentaAuto.jsp?'>"%>
        <%
            if (rs.next()) {
             // El siguiente campo llave no se mete con MyUtil.ObjInput  
%>
        <script>document.all.btnAlta.disabled = true;</script>
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>  

        <%=MyUtil.ObjInput("Fecha Apertura", "FechaApertura", rs.getString("FechaApertura"), false, false, 320, 430, StrFecha, true, true, 25)%>
        <%=MyUtil.ObjInput("Fecha Registro", "FechaRegistroVTR", rs.getString("FechaRegistro"), false, false, 470, 430, "", false, true, 25)%>                
        <%=MyUtil.ObjComboC("Causa", "clCausaAsistencia", rs.getString("dsCausaAsistencia"), true, true, 30, 70, "", "Select clCausaAsistencia, dsCausaAsistencia From cCausaAsistenciaKM0 Order by dsCausaAsistencia", "", "", 100, false, false)%>
        <%=MyUtil.ObjInput("Hrs estimadas reparación", "TiempoReparacion", rs.getString("TiempoReparacion"), true, true, 210, 70, "", false, false, 20)%>
        <%=MyUtil.ObjComboC("Entidad de Residencia de N/U", "CodEntResid", rs.getString("dsEntFedResid"), true, true, 30, 110, "", "Select CodEnt, dsEntFed From cEntFed Order by dsEntFed", "fnLlenaMunResiden()", "", 70, false, false)%>
        <%=MyUtil.ObjComboC("Municipio de Residencia de N/U", "CodMDResid", rs.getString("dsMunDelResid"), true, true, 250, 110, "", "Select CodMD, dsMunDel From cMunDel Where CodEnt='" + rs.getString("CodEntResid") + "' Order by dsMunDel", "", "", 160, false, false)%>
        <%=MyUtil.ObjComboC("Marca de Auto que Maneja", "CodigoMarca", rs.getString("dsMarcaAuto"), true, true, 30, 150, "", "Select CodigoMarca, dsMarcaAuto From cMarcaAuto Order by dsMarcaAuto", "fnLlenaAMIS()", "", 70, false, false)%>
        <%=MyUtil.ObjComboC("Tipo de Auto que Maneja", "ClaveAMIS", rs.getString("dsTipoAuto"), true, true, 205, 150, "", "Select ClaveAMIS, dsTipoAuto From cTipoAuto Where CodigoMarca='" + rs.getString("CodigoMarca") + "' Order by dsTipoAuto", "fnActualizaAMIS()", "", 160, false, false)%>
        <%=MyUtil.ObjInput("Clave AMIS", "ClaveAMISVTR", rs.getString("ClaveAMIS"), false, false, 540, 150, "", false, false, 10)%>
        <%=MyUtil.ObjInput("Reservación a nombre de", "ReservacionA", rs.getString("ReservacionA"), true, true, 30, 190, "", false, false, 100)%>
        <%=MyUtil.ObjInput("Horas de Reservación", "HorasReservacion", rs.getString("HorasReservacion"), true, true, 30, 230, "", false, false, 5)%>
        <%=MyUtil.ObjInput("Núm.Tarjeta Crédito", "NumTarjCredito", rs.getString("NumTarjCredito"), true, true, 185, 230, "", false, false, 20)%>
        <%=MyUtil.ObjInput("Código Seguridad", "CodigoSeguridad", rs.getString("CodigoSeguridad"), true, true, 340, 230, "", false, false, 10)%> 
        <%=MyUtil.ObjInput("Banco", "Banco", rs.getString("Banco"), true, true, 30, 270, "", false, false, 50)%>
        <%=MyUtil.ObjInput("Mes", "MesVmtoTarj", rs.getString("MesVmtoTarj"), true, true, 360, 270, "", false, false, 5, "fnRango(document.all.MesVmtoTarj,1,12)")%>
        <%=MyUtil.ObjInput("y Año Vencimiento Tarjeta (mm)(aaaa)", "AnioVmtoTarj", rs.getString("AnioVmtoTarj"), true, true, 390, 270, "", false, false, 10, "fnRango(document.all.AnioVmtoTarj,1970,2050)")%>
        <%=MyUtil.ObjInput("# Personas viajan", "NumPersonasViajan", rs.getString("NumPersonasViajan"), true, true, 30, 310, "", false, false, 10, "EsNumerico(document.all.NumPersonasViajan)")%>
        <%=MyUtil.ObjChkBox("Tiene Licencia Conducir", "TieneLicencia", rs.getString("TieneLicencia"), true, true, 160, 310, "0", "SI", "NO", "")%>
        <%=MyUtil.ObjComboC("Entidad de su Ubicación Actual", "CodEnt", rs.getString("dsEntFed"), true, true, 30, 350, "", "Select CodEnt, dsEntFed From cEntFed Order by dsEntFed", "fnLlenaMunicipiosOper()", "", 70, false, false)%>
        <%=MyUtil.ObjComboC("Municipio de su Ubicación Actual", "CodMD", rs.getString("dsMunDel"), true, true, 250, 350, "", "Select CodMD, dsMunDel From cMunDel Where CodEnt='" + rs.getString("CodEnt") + "' Order by dsMunDel", "", "", 160, false, false)%>
        <%=MyUtil.ObjInput("Calle y Número de su Ubicación Actual", "CalleNum", rs.getString("CalleNum"), true, true, 30, 390, "", false, false, 60)%>
        <%=MyUtil.ObjInput("Costo de Cotización", "CostoCotizacion", rs.getString("CostoCotizacion"), true, true, 30, 430, "", true, true, 15, "EsNumerico(document.all.CostoCotizacion)")%>
        <%=MyUtil.ObjInput("Costo Final", "CostoFinal", rs.getString("CostoFinal"), true, true, 180, 430, "", true, true, 15, "EsNumerico(document.all.CostoFinal)")%>
		<%=MyUtil.DoBlock("Detalle de Renta de Auto", -90, 0)%> 
        <%
        } else {
        %>
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>

        <%=MyUtil.ObjInput("Fecha Apertura", "FechaApertura", "", false, false, 320, 430, StrFecha, true, true, 25)%>                
        <%=MyUtil.ObjInput("Fecha Registro", "FechaRegistroVTR", "", false, false, 470, 430, "", false, true, 25)%>                
        <%=MyUtil.ObjComboC("Causa", "clCausaAsistencia", "", true, true, 30, 70, "", "Select clCausaAsistencia, dsCausaAsistencia From cCausaAsistenciaKM0 Order by dsCausaAsistencia", "", "", 100, false, false)%>
        <%=MyUtil.ObjInput("Hrs estimadas reparación", "TiempoReparacion", "", true, true, 210, 70, "", false, false, 20)%>
        <%=MyUtil.ObjComboC("Entidad de Residencia de N/U", "CodEntResid", "", true, true, 30, 110, "", "Select CodEnt, dsEntFed From cEntFed Order by dsEntFed", "fnLlenaMunResiden()", "", 70, false, false)%>
        <%=MyUtil.ObjComboC("Municipio de Residencia de N/U", "CodMDResid", "", true, true, 250, 110, "", "Select CodMD, dsMunDel From cMunDel Where CodEnt=0", "", "", 160, false, false)%>
        <%=MyUtil.ObjComboC("Marca de Auto que Maneja","CodigoMarca","",true,true,30,150,"","Select CodigoMarca, dsMarcaAuto From cMarcaAuto Order by dsMarcaAuto","fnLlenaAMIS()","",70,false,false)%>
        <%=MyUtil.ObjComboC("Tipo de Auto que Maneja","ClaveAMIS","",true,true,205,150,"","Select ClaveAMIS, dsTipoAuto From cTipoAuto Where CodigoMarca=0","fnActualizaAMIS()","",160,false,false)%>
        <%=MyUtil.ObjInput("Clave AMIS", "ClaveAMISVTR", "", false, false, 540, 150, "", false, false, 10)%>
        <%=MyUtil.ObjInput("Reservación a nombre de", "ReservacionA", "", true, true, 30, 190, "", false, false, 100)%>
        <%=MyUtil.ObjInput("Horas de Reservación", "HorasReservacion", "", true, true, 30, 230, "", false, false, 5)%>
        <%=MyUtil.ObjInput("Núm.Tarjeta Crédito", "NumTarjCredito", "", true, true, 185, 230, "", false, false, 20)%> 
        <%=MyUtil.ObjInput("Código Seguridad", "CodigoSeguridad", "", true, true, 340, 230, "", false, false, 10)%>
        <%=MyUtil.ObjInput("Banco", "Banco", "", true, true, 30, 270, "", false, false, 50)%>
        <%=MyUtil.ObjInput("Mes", "MesVmtoTarj", "", true, true, 360, 270, "", false, false, 5, "fnRango(document.all.MesVmtoTarj,1,12)")%>
        <%=MyUtil.ObjInput("y Año Vencimiento Tarjeta (mm)(aaaa)", "AnioVmtoTarj", "", true, true, 390, 270, "", false, false, 10, "fnRango(document.all.AnioVmtoTarj,1970,2050)")%>
        <%=MyUtil.ObjInput("# Personas viajan", "NumPersonasViajan", "", true, true, 30, 310, "", false, false, 10, "EsNumerico(document.all.NumPersonasViajan)")%>
        <%=MyUtil.ObjChkBox("Tiene Licencia Conducir", "TieneLicencia", "", true, true, 160, 310, "0", "SI", "NO", "")%>
        <%=MyUtil.ObjComboC("Entidad de su Ubicación Actual", "CodEnt", "", true, true, 30, 350, "", "Select CodEnt, dsEntFed From cEntFed Order by dsEntFed", "fnLlenaMunicipiosOper()", "", 70, false, false)%>
        <%=MyUtil.ObjComboC("Municipio de su Ubicación Actual","CodMD","",true,true,250,350,"","Select CodMD, dsMunDel From cMunDel Where CodEnt=0","","",160,false,false)%>
        <%=MyUtil.ObjInput("Calle y Número de su Ubicación Actual", "CalleNum", "", true, true, 30, 390, "", false, false, 60)%>
        <%=MyUtil.ObjInput("Costo de Cotización", "CostoCotizacion", "", true, true, 30, 430, "", true, true, 15, "EsNumerico(document.all.CostoCotizacion)")%>
        <%=MyUtil.ObjInput("Costo Final", "CostoFinal", "", true, true, 180, 430, "", true, true, 15, "EsNumerico(document.all.CostoFinal)")%>
		<%=MyUtil.DoBlock("Detalle de Renta de Auto", -90, 0)%> 
        <%
            }
        %>

    
        <%=MyUtil.GeneraScripts()%>
        <%
            rs2.close();
            rs3.close();
            rs.close();
            rs2 = null;
            rs3 = null;
            rs = null;
            StrclExpediente = null;
            StrSql1 = null;
            StrclPaginaWeb = null;
            StrFecha = null;
            StrclUsrApp = null;

        %>

        <script>
            document.all.TiempoReparacion.maxLength = 30;
            document.all.ReservacionA.maxLength = 100;
            document.all.NumPersonasViajan.maxLength = 2;
            document.all.CalleNum.maxLength = 60;
            document.all.HorasReservacion.maxLength = 2;
            document.all.NumTarjCredito.maxLength = 30;
            document.all.Banco.maxLength = 50;
            document.all.MesVmtoTarj.maxLength = 2;
            document.all.AnioVmtoTarj.maxLength = 4;
            document.all.CodigoSeguridad.maxLength = 20;
        </script>

    </body>
</html>
