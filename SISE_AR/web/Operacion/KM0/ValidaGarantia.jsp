<%@page import="java.io.PrintWriter"%>
<%@page contentType="application/json; charset=UTF-8" pageEncoding="UTF-8" import="Utilerias.UtileriasBDF, java.sql.ResultSet"%><%
   String clExpediente = request.getParameter("clExpediente");
   String clInfoAdicKM0 = request.getParameter("clInfoAdicKM0");
   String clCuenta = request.getParameter("clCuenta");
   String clServicio = request.getParameter("clServicio");
   String clSubServicio = request.getParameter("clSubServicio");
   String clTipoServicio = request.getParameter("clTipoServicio");
   String codEntOrigen = request.getParameter("codEntOrigen");
   String codMDOrigen = request.getParameter("codMDOrigen");
   String codEntDestino = request.getParameter("codEntDestino");
   String codMDDestino = request.getParameter("codMDDestino");
   String tieneCarga = request.getParameter("tieneCarga");
   String tieneModif = request.getParameter("tieneModif");
   String clCantPersona = request.getParameter("clCantPersona");
   String clUbicacionAuto = request.getParameter("clUbicacionAuto");
   final String COMA = ",";
   int res = 0;  
    try {
        StringBuffer sqlString = new StringBuffer();
        sqlString.append("st_ValidaGarantia ")
                       .append(clExpediente).append(COMA)
                       .append(clInfoAdicKM0).append(COMA)
                       .append(clCuenta).append(COMA)
                       .append(clServicio).append(COMA)
                       .append(clSubServicio).append(COMA)
                       .append(clTipoServicio).append(COMA)
                       .append("'")
                       .append(codEntOrigen)
                       .append("'").append(COMA)
                       .append("'")
                       .append(codMDOrigen)
                       .append("'").append(COMA)
                       .append("'")
                       .append(codEntDestino)
                       .append("'").append(COMA)
                       .append("'")
                       .append(codMDDestino)
                       .append("'").append(COMA)
                       .append(tieneCarga).append(COMA)
                       .append(tieneModif).append(COMA)
                       .append(clCantPersona).append(COMA)
                       .append(clUbicacionAuto);
                       
        ResultSet rs = UtileriasBDF.rsSQLNP(sqlString.toString() );
        if ( rs.next() ) {            
            res = (rs.getObject("RES")!=null?rs.getInt("RES"):0);
            //LOGICA DE CANTIDAD DE REPUBLICACIONES AUTOMATICAS
            StringBuilder sReturn = new StringBuilder();
            sReturn.append("{ \"minutosCubiertos\": \""+String.valueOf( res )+"\" }");
            out.println(sReturn.toString());
            response.setStatus(HttpServletResponse.SC_OK);
        }
        rs.close();
    } catch (Exception e) {
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
    }%>
