<%@page contentType="text/html" pageEncoding="ISO-8859-1" import="Utilerias.UtileriasBDF, java.sql.ResultSet, java.util.ArrayList, java.util.List, com.google.gson.Gson, com.google.gson.GsonBuilder, ar.com.ike.api.back.asignacion.ExpedienteTO"%><%
    System.out.println("web/api/v1/asignacion/listaExpAAsignar.jsp");
    String clGrupoCuenta = ( request.getParameter("grupoCuenta") != null ? request.getParameter("grupoCuenta") : "0");
    try {
        ResultSet rs = UtileriasBDF.rsSQLNP("st_getExpedientesAAsignar " + clGrupoCuenta);
        List<ExpedienteTO> recs = new ArrayList();
        Gson gsonBuilder = new GsonBuilder().create();
        while ( rs.next() ) {
            ExpedienteTO rec = new ExpedienteTO();
            rec.clExpediente = rs.getInt("clExpediente");
            rec.sSubServicio = rs.getString("SubServicio");
            rec.iMinSinAsignacion = rs.getInt("min");
            rec.sFechaApertura = rs.getString("fechaapertura");
            rec.sHoraApertura = rs.getString("HoraApertura");
            rec.sCuenta = rs.getString("Cuenta");
            rec.sLocalidad = rs.getString("Localidad");
            rec.sNombreOperador = rs.getString("NombreUsuario");
            rec.ColoniaDest = (rs.getString("Destino")!=null?rs.getString("Destino"):"");
            rec.clUsrAppAsignado = rs.getInt("clUsrAppAsignado");
            rec.sTomador = rs.getString("tomador");
            rec.sAProgramar = (rs.getBoolean("aprogramar")?"S":"N");
            rec.sConExcedente = (rs.getBoolean("ConExcedente")?"S":"N");
            rec.sConexion = (rs.getInt("clTipoServicio")==2?"S":"N");
            //rec.Estatus = rs.getInt("estatus");
            recs.add(rec);
        }
        rs.close();
        out.print(gsonBuilder.toJson(recs));
    }
    catch (Exception e) {
        System.out.println("/api/v1/asignacion/listaExpAAsignar.jsp:Error:" + e.toString());
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
    }%>