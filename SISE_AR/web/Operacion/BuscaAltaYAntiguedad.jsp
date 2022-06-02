<%@page import="java.io.PrintWriter" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8" import="Utilerias.UtileriasBDF, java.sql.ResultSet"%>
<%
    String nombre = request.getParameter("nombre");
    String clCuenta = request.getParameter("clCuenta");
    String texto = "";
    try {
        StringBuffer buscaAltaYAntiguedad = new StringBuffer();
        buscaAltaYAntiguedad.append("st_getAltaYAntiguedad ")
                .append("'").append(nombre).append("'").append(",")
                .append("'").append(clCuenta).append("'");
        ResultSet rs = UtileriasBDF.rsSQLNP(buscaAltaYAntiguedad.toString());
        if ( rs.next() ) {            
            texto = (rs.getObject("altaYAntiguedad") != null ? rs.getString("altaYAntiguedad") : "");            
            StringBuilder sReturn = new StringBuilder();
            sReturn.append("{ \"msg\": \""+String.valueOf( texto )+"\" }");
            out.println(sReturn.toString());
            response.setStatus(HttpServletResponse.SC_OK); 
        }
        rs.close();
    }
    catch (Exception e){     response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);   }
%>
