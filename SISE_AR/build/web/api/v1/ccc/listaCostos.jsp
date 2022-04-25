<%@page contentType="application/json" pageEncoding="ISO-8859-1" import="Seguridad.SeguridadC,Utilerias.UtileriasBDF, java.sql.ResultSet, java.util.ArrayList, java.util.List, com.google.gson.Gson, com.google.gson.GsonBuilder, ar.com.ike.api.centrocosto.CentroCostoTO, java.math.BigDecimal"%><%
    String strclUsr = "0";
    if (session.getAttribute("clUsrApp") != null) {
        strclUsr = session.getAttribute("clUsrApp").toString();        }
    if(SeguridadC.verificaHorarioC(Integer.parseInt(strclUsr)) != true){
        %><font color="white"  style="font-family:Verdana,Arial,Helvetica,sans-serif; background-color:red;" size=3>LA SESION EXPIRO</font><%  
        strclUsr=null;
        return;
        }
    System.out.println("web/api/v1/ccc/listaCostos.jsp");
    try {
        ResultSet rs = UtileriasBDF.rsSQLNP("st_getExpedientesValidarCC ");
        List<CentroCostoTO> recs = new ArrayList();
        Gson gsonBuilder = new GsonBuilder().create();
        int tmpClExp = 0;
        CentroCostoTO rec = null;
        int i = 0;
        boolean lastMultiple=false;
        while ( rs.next() && !lastMultiple  ) {
            i++;
            if ( tmpClExp != rs.getInt("clExpediente") ) {
                rec = new CentroCostoTO();
                //arranca nuevo expediente
                rec.check = true;
                rec.link = false;
                rec.clExpediente = rs.getInt("clExpediente");
                rec.cuenta = rs.getString("cuenta");
                rec.fecha = rs.getString("fecha");
                rec.proveedor = rs.getString("proveedor");
                rec.subServicio = rs.getString("subservicio");
                rec.conceptoCosto = rs.getString("conceptoCosto");
                rec.costo = rs.getBigDecimal("costo");
                tmpClExp = rec.clExpediente;
                recs.add(rec);
                lastMultiple=false;
            }
            else {
                //Tengo mas de un registro para el mismo expediente              
                rec.check = false;
                rec.link = true;
                rec.proveedor = " ";
                rec.conceptoCosto = " ";
                rec.costo = new BigDecimal (0);
                if (i>600){ 
                    //Para evitar falsas evaluacion de UNO/VARIOS costos del ultimo registros, corto antes.
                    lastMultiple=true;
                    i=0;
                }
            }
        }
        rs.close();
        out.print(gsonBuilder.toJson(recs));
    }
    catch (Exception e) {
        System.out.println("/api/v1/seguimiento/listaCostos.jsp:Error:" + e.toString());
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
    }%>