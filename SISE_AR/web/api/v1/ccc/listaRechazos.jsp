<%@page contentType="application/json" pageEncoding="ISO-8859-1" import="Utilerias.UtileriasBDF,Seguridad.SeguridadC,java.sql.ResultSet,java.util.ArrayList,java.util.List,com.google.gson.Gson,com.google.gson.GsonBuilder,ar.com.ike.api.centrocosto.CentroCostoTO"%><%
    String strclUsr = "0";
    if (session.getAttribute("clUsrApp") != null) {
        strclUsr = session.getAttribute("clUsrApp").toString();        }
    if(SeguridadC.verificaHorarioC(Integer.parseInt(strclUsr)) != true){
        %><font color="white"  style="font-family:Verdana,Arial,Helvetica,sans-serif; background-color:red;" size=3>LA SESION EXPIRO</font><%  
        strclUsr=null;
        return;
        }    
    try {
        ResultSet rs = UtileriasBDF.rsSQLNP("st_getExpedientesRechazadosCC ");
        List<CentroCostoTO> recs = new ArrayList();
        Gson gsonBuilder = new GsonBuilder().create();
        CentroCostoTO rec = null;
        while ( rs.next()  ) {
            rec = new CentroCostoTO();
            rec.check = true;
            rec.link = false;
            rec.clExpediente = rs.getInt("clExpediente");
            rec.cuenta = rs.getString("Cuenta");
            rec.fecha = rs.getString("fechaApertura");
            rec.proveedor = rs.getString("NombreOpe");
            rec.subServicio = rs.getString("dsSubServicio");
            rec.costo = rs.getBigDecimal("costoExpediente");
            rec.clPagoProveedor = rs.getInt("clPagoProveedor");
            rec.comentarios = rs.getString("Comentarios"); //AGREGADO JOA
            recs.add(rec);
        }
        rs.close();
        out.print(gsonBuilder.toJson(recs));
    }catch (Exception e) {
        System.out.println("/api/v1/seguimiento/listaRechazos.jsp:Error:" + e.toString());
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
    }%>