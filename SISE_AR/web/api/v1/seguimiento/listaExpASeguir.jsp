<%@page contentType="text/html" pageEncoding="ISO-8859-1" import="Utilerias.UtileriasBDF, java.sql.ResultSet, java.util.ArrayList, java.util.List, com.google.gson.Gson, com.google.gson.GsonBuilder, ar.com.ike.api.back.seguimiento.ExpedienteTO"%><%
    System.out.println("web/api/v1/seguimiento/listaExpASeguir.jsp");
    int tipoSeguimiento = (request.getParameter("tipo")!=null?Integer.parseInt(request.getParameter("tipo")):1);
    try {
        System.out.println("st_getExpedientesASeguir "+String.valueOf(tipoSeguimiento));
        ResultSet rs = UtileriasBDF.rsSQLNP("st_getExpedientesASeguir  " + String.valueOf(tipoSeguimiento));
        List<ExpedienteTO> recs = new ArrayList<ExpedienteTO>();
        Gson gsonBuilder = new GsonBuilder().create();
        while ( rs.next() ) {   
            ExpedienteTO rec = new ExpedienteTO();
            rec.clExpediente = rs.getInt("clExpediente");
            rec.sCuenta = rs.getString("cuenta");
            rec.sProveedor = rs.getString("Proveedor");
            rec.sProvincia = rs.getString("Provincia");
            rec.sLocalidad = rs.getString("Localidad");
            rec.sFechaApertura = rs.getString("fechaapertura");
            rec.sUsuario = rs.getString("Usuario");
            rec.sSubServicio = rs.getString("SubServicio");
            rec.sEstatus = rs.getString("Etapa");
            rec.iUsrAppAsignado = rs.getInt("clUsrAppAsignado");
            rec.iEstatusSeguimiento = rs.getInt("EstatusSeguimiento");
            rec.iMinSinAsignacion = rs.getInt("MinutosPendientes");
            recs.add(rec);
        }
        rs.close();
        out.print(gsonBuilder.toJson(recs));
    }
    catch (Exception e) {
        System.out.println("/api/v1/seguimiento/listaExpASeguir.jsp:Error:" + e.toString());
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
    }%>