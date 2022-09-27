<%@page import="java.io.PrintWriter"%>
<%@page contentType="application/json; charset=UTF-8" pageEncoding="UTF-8" import="Utilerias.UtileriasBDF, java.sql.ResultSet"%><%
   String clInfoAdicKMO	=request.getParameter("clInfoAdicKMO");
   String clExpediente =request.getParameter("clExpediente");
   String clUbicacionAuto =request.getParameter("clUbicacionAuto");
   String clUbicacionAutoGaraje =request.getParameter("clUbicacionAutoGaraje");
   String aNivelAbierto =request.getParameter("aNivelAbierto");
   String nivelSubsuelo =request.getParameter("nivelSubsuelo");
   String clTipoFalla =request.getParameter("clTipoFalla");
   String detalleFalla =request.getParameter("detalleFalla");
   String automatico =request.getParameter("automatico");
   String ruedaBloqueada =request.getParameter("ruedaBloqueada");
   String cantBloqueadas =request.getParameter("cantBloqueadas");
   String delanteraIzq =request.getParameter("delanteraIzq");
   String delanteraDer =request.getParameter("delanteraDer");
   String traseraIzq =request.getParameter("traseraIzq");
   String traseraDer =request.getParameter("traseraDer");
   String tieneCarga =request.getParameter("tieneCarga");
   String pesoCarga =request.getParameter("pesoCarga");
   String tipoCarga =request.getParameter("tipoCarga");
   String clCantPersona =request.getParameter("clCantPersona");
   String cedulaVerdeVig =request.getParameter("cedulaVerdeVig");
   String recibeNombre =request.getParameter("recibeNombre");
   String recibeCodArea =request.getParameter("recibeCodArea");
   String recibeNroTelef =request.getParameter("recibeNroTelef");
   String clModifAuto =request.getParameter("clModifAuto");
   String distanciaPiso =request.getParameter("distanciaPiso");
   String largo =request.getParameter("largo");
   String alto =request.getParameter("alto");
   String detalleModif =request.getParameter("detalleModif");
   String ruedasDuales =request.getParameter("ruedasDuales");
   String lugarEncajado = request.getParameter("lugarEncajado");
   String lucesEncienden = request.getParameter("lucesEncienden");
   String ruedaAuxEnCond = request.getParameter("ruedaAuxEnCond");
   String tuercaSeguridad = request.getParameter("tuercaSeguridad");
   String llaveTuercaSeg = request.getParameter("llaveTuercaSeg");
   String clTipoGasolina = request.getParameter("clTipoGasolina");
   String clCantLitros = request.getParameter("clCantLitros");
   String detExpediente = request.getParameter("detExpediente");
   String vehiculoLiberado = request.getParameter("vehiculoLiberado");
   String clUsrApp = request.getParameter("clUsrApp");
   String estadoVehiculo  = request.getParameter("estadoVehiculo");
   String distTierraFirme = request.getParameter("distTierraFirme");
   String compraBateria   = request.getParameter("compraBateria");
   String servicioProgramado= request.getParameter("servicioProgramado");
   String fechaProgramado = request.getParameter("fechaProgramado");
   String horaDesdeProg   = request.getParameter("horaDesdeProg");
   String horaHastaProg   = request.getParameter("horaHastaProg");
   String peajesCubiertos = request.getParameter("peajesCubiertos");
   String montoCubierto   = request.getParameter("montoCubierto");
   String clEstacionamiento = request.getParameter("clEstacionamiento");
   String cambiosOrigenDest = request.getParameter("cambiosOrigenDest");
   String kmAsistencia      = request.getParameter("kmAsistencia");
   String coberturaTotalPeaje = request.getParameter("coberturaTotalPeaje");
   final String COMA = ",";
   int id = 0;  
    try {
        StringBuffer sqlInsertUpdateInfoAdicKM0 = new StringBuffer();
        sqlInsertUpdateInfoAdicKM0.append("st_InsertInfoAdicionalKM0 ")
                       .append(clInfoAdicKMO).append(COMA)
                       .append(clExpediente).append(COMA)
                       .append(clUbicacionAuto).append(COMA)
                       .append(clUbicacionAutoGaraje).append(COMA)
                       .append(aNivelAbierto).append(COMA)
                       .append(nivelSubsuelo).append(COMA)
                       .append(clTipoFalla).append(COMA)
                       .append("'")
                       .append(detalleFalla)
                       .append("'").append(COMA)
                       .append(automatico).append(COMA)
                       .append(ruedaBloqueada).append(COMA)
                       .append(cantBloqueadas).append(COMA)
                       .append(delanteraIzq).append(COMA)
                       .append(delanteraDer).append(COMA)
                       .append(traseraIzq).append(COMA)
                       .append(traseraDer).append(COMA)
                       .append(tieneCarga).append(COMA)
                       .append(pesoCarga).append(COMA)
                       .append("'")
                       .append(tipoCarga)
                       .append("'").append(COMA)
                       .append(clCantPersona).append(COMA)
                       .append(cedulaVerdeVig).append(COMA)
                       .append("'")
                       .append(recibeNombre)
                       .append("'").append(COMA)
                       .append(recibeCodArea).append(COMA)
                       .append(recibeNroTelef).append(COMA)
                       .append(clModifAuto).append(COMA)
                       .append(distanciaPiso).append(COMA)
                       .append(largo).append(COMA)
                       .append(alto).append(COMA)
                       .append("'")
                       .append(detalleModif)
                       .append("'").append(COMA)
                       .append(ruedasDuales).append(COMA)
                       .append(lugarEncajado).append(COMA)
                       .append(lucesEncienden).append(COMA)
                       .append(ruedaAuxEnCond).append(COMA)
                       .append(tuercaSeguridad).append(COMA)
                       .append(llaveTuercaSeg).append(COMA)
                       .append(clTipoGasolina).append(COMA)
                       .append(clCantLitros).append(COMA)
                       .append("'")
                       .append(detExpediente)
                       .append("'").append(COMA)
                       .append(vehiculoLiberado).append(COMA)
                       .append(clUsrApp).append(COMA)
                       .append("'")
                       .append(estadoVehiculo)
                       .append("'").append(COMA)
                       .append(distTierraFirme).append(COMA)
                       .append(compraBateria).append(COMA)
                       .append(servicioProgramado).append(COMA)
                       .append("'")
                       .append(fechaProgramado)
                       .append("'").append(COMA)
                       .append("'")
                       .append(horaDesdeProg)
                       .append("'").append(COMA)
                       .append("'")
                       .append(horaHastaProg)
                       .append("'").append(COMA)
                       .append(peajesCubiertos).append(COMA)
                       .append(montoCubierto).append(COMA)
                       .append(clEstacionamiento).append(COMA)
                       .append("'")
                       .append(cambiosOrigenDest)
                       .append("'")
                       .append(COMA)
                       .append(kmAsistencia)
                       .append(COMA)
                       .append(coberturaTotalPeaje);
                       
        ResultSet rs = UtileriasBDF.rsSQLNP(sqlInsertUpdateInfoAdicKM0.toString() );
        if ( rs.next() ) {            
            id = (rs.getObject("CLAVE")!=null?rs.getInt("CLAVE"):0);
            //LOGICA DE CANTIDAD DE REPUBLICACIONES AUTOMATICAS
            if ( id == 0 ) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN); 
            } else {
                StringBuilder sReturn = new StringBuilder();
                sReturn.append("{ \"clave\": \""+String.valueOf( id )+"\" }");
                out.println(sReturn.toString());
                response.setStatus(HttpServletResponse.SC_OK); 
            }
        }
        rs.close();
    } catch (Exception e) {
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
    }%>
