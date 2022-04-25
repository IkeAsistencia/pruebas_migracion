<%@page contentType="text/html" pageEncoding="UTF-8" import="Utilerias.UtileriasBDF,java.sql.ResultSet,java.util.ArrayList,java.util.List,com.google.gson.Gson,com.google.gson.GsonBuilder,ar.com.ike.api.v1.gestionguardia.GestionGuardiaTO"%>
<%  try {
        ResultSet rsEx = UtileriasBDF.rsSQLNP("st_getExpGuardiaGeneral");
        List<GestionGuardiaTO> recs = new ArrayList();
        Gson gsonBuilder = new GsonBuilder().create();
        while ( rsEx.next() ) {
            // ex.clexpediente, cs.dsServicio, horad, horah, clestatuscita, 
            // css.dsSubServicio, ex.fechaapertura,
	    // ex.clestatus, p.NombreOpe,  cast( cxe.fecha as date) as fechacita
            GestionGuardiaTO rec = new GestionGuardiaTO();
            rec.clExpediente = rsEx.getString("clexpediente");
            //rec.clServicio = rsEx.getString("clservicio");
            rec.dsServicio = rsEx.getString("dsServicio");
            rec.horaDesde = rsEx.getString("horaD");
            rec.horaHasta = rsEx.getString("horaH");
            rec.clEstatusCita = rsEx.getInt("clEstatusCita");
            rec.dsSubServicio = rsEx.getString("dsSubServicio");
            rec.fechaApertura = rsEx.getString("fechaapertura");
            rec.clEstatus = rsEx.getString("clestatus");
            rec.nombreOpe = rsEx.getString("NombreOpe");           
            rec.fechaCita = rsEx.getString("fechacita");
            rec.evento = rsEx.getString("evento");
            //rec.cita = rsEx.getString("cita");
            recs.add(rec);
        }
        rsEx.close();
        out.println(gsonBuilder.toJson(recs));
    }
    catch (Exception e) {
        System.out.println("/api/v1/gestionGuardia/expedientes.jsp:Error:" + e.toString());
    }%>