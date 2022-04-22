<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@page import="Utilerias.UtileriasBDF" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="java.util.ArrayList" %>
<%@page import="java.util.List" %>
<%@page import="com.google.gson.Gson" %>
<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="ar.com.ike.api.RegistroWarningTec"%>
<%
    try {
        ResultSet rsEx = UtileriasBDF.rsSQLNP("st_getExpSinAsigCercaTEC ");
        List<RegistroWarningTec> recs = new ArrayList<RegistroWarningTec>();
        Gson gsonBuilder = new GsonBuilder().create();

        while ( rsEx.next() ) {
            RegistroWarningTec rec = new RegistroWarningTec();
            rec.clexpediente = rsEx.getString("clexpediente");
            System.out.println( rec.clexpediente );
            rec.RecepcionCaso = rsEx.getString("RecepcionCaso");
            rec.TECmenosX  = rsEx.getString("TECmenosX");
            rec.TEC = rsEx.getString("TEC");
            rec.AsignacionMovil = rsEx.getString("AsignacionMovil");
            rec.estado = rsEx.getString("estado");
            rec.clestatus = rsEx.getString("clestatus");
            rec.observaciones = rsEx.getString("observaciones");
            rec.estado2 = rsEx.getString("estado2");
            rec.Info = rsEx.getString("Info");
            rec.idprestador = rsEx.getString("idprestador");
            rec.nombreope = rsEx.getString("nombreope");
            rec.WarnLevel = rsEx.getString("WarnLevel");
            recs.add(rec);
        }
        rsEx.close();
        out.println(gsonBuilder.toJson(recs));
    }
    catch (Exception e) {
        System.out.println("/api/v1/tec/warnings.jsp:Error:" + e.toString());
    }
%>