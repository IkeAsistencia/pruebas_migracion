<%@page import="java.io.PrintWriter"%>
<%@page contentType="application/json; charset=UTF-8" pageEncoding="UTF-8" import="Utilerias.UtileriasBDF, java.sql.ResultSet"%>
<%
    String clExpediente = request.getParameter("clExpediente");
    String clUsrApp = request.getParameter("clUsrApp");
    String descripcionOcurrido = request.getParameter("descripcionOcurrido");
    int id = 0;
    try {
        StringBuffer sqlInsertInfoAdicHogar = new StringBuffer();
        sqlInsertInfoAdicHogar.append("st_InsertInfoAdicionalHogar ")
                .append(clExpediente).append(",")
                .append(clUsrApp).append(",")
                .append("'")
                .append(descripcionOcurrido)
                .append("'");
        ResultSet rs = UtileriasBDF.rsSQLNP(sqlInsertInfoAdicHogar.toString() );
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
    }
    catch (Exception e){
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
    }
%>
