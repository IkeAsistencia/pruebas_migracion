<%@page contentType="application/json" pageEncoding="ISO-8859-1" import="Utilerias.UtileriasBDF, java.sql.ResultSet, java.util.ArrayList, java.util.List, com.google.gson.Gson, com.google.gson.GsonBuilder, ar.com.ike.api.centrocosto.CentroCostoTO"%><%
    System.out.println("web/api/v1/ccc/listaCostos.jsp");
    try {
        ResultSet rs = UtileriasBDF.rsSQLNP("st_getExpSinCostoCargadoCC ");
        List<CentroCostoTO> recs = new ArrayList();
        Gson gsonBuilder = new GsonBuilder().create();
        CentroCostoTO rec = null;
        while ( rs.next() ) {
            rec = new CentroCostoTO();
            rec.clExpediente = rs.getInt("clExpediente");
            rec.cuenta = rs.getString("cuenta");
            rec.fecha = rs.getString("fecha");
            rec.proveedor = rs.getString("proveedor");
            rec.subServicio = rs.getString("subservicio");
            rec.clOrigen = rs.getString("origen");
            rec.clDestino = (rs.getString("destino")==null?"":rs.getString("destino") );
            rec.costo = rs.getBigDecimal("costo");
            recs.add(rec);
        }
        rs.close();
        out.print(gsonBuilder.toJson(recs));
    }
    catch (Exception e) {
        System.out.println("/api/v1/seguimiento/listaExpASeguir.jsp:Error:" + e.toString());
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
    }%>