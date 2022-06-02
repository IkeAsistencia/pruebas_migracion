<%@page import="java.io.PrintWriter"%>
<%@page contentType="application/json; charset=UTF-8" pageEncoding="UTF-8" import="Utilerias.UtileriasBDF, java.sql.ResultSet"%><%
   
   String clUsrApp = request.getParameter("clUsrApp");
   String clExpediente =request.getParameter("Expediente");
   String detExp = request.getParameter("detExp");
   final String COMA = ",";
   int id = 0;    
    try {
        StringBuffer sqlInsertUpdateInfoCRI = new StringBuffer();
        sqlInsertUpdateInfoCRI.append("st_InsertInfoAdicionalCRI ")
                       .append(clUsrApp).append(COMA)
                       .append(clExpediente).append(COMA)
                       .append(detExp);
        ResultSet rs = UtileriasBDF.rsSQLNP(sqlInsertUpdateInfoCRI.toString() );
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
    } catch (Exception e) {
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);        
    }%>
