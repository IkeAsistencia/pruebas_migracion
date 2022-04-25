<%@page contentType="application/json; charset=UTF-8" pageEncoding="UTF-8" import="Utilerias.UtileriasBDF,java.sql.ResultSet,java.io.PrintWriter,Seguridad.SeguridadC"%><%
    String strclUsr = "0";
    if (session.getAttribute("clUsrApp") != null) {
        strclUsr = session.getAttribute("clUsrApp").toString();     }    
    if (SeguridadC.verificaHorarioC((Integer.parseInt(strclUsr))) != true) { 
        %>Fuera de Horario<%
        strclUsr = null;
        return;
        } 
    String dni	=request.getParameter("dni");
    String placas	=request.getParameter("placas");
    if ( dni == null ) {     dni = "NULL";    }
    if ( placas == null ) {        placas = "NULL";    }
    try {
        String sql = "st_BuscaClienteVIPPorClave '" + dni +"','"+placas+"'";
        ResultSet rs = UtileriasBDF.rsSQLNP( sql );
        if ( rs.next() ) {
            String categoriaVip = (rs.getObject("CATEGORIA_VIP")!=null?rs.getString("CATEGORIA_VIP"):"");
            String coberturaVip = (rs.getObject("COBERTURA_VIP")!=null?rs.getString("COBERTURA_VIP"):"");
            StringBuilder sReturn = new StringBuilder();
                sReturn.append("{ \"Clave\": \"" +  categoriaVip  + ", " +  coberturaVip + "\" }");
                out.println(sReturn.toString());
                response.setStatus(HttpServletResponse.SC_OK); 
                }
        rs.close();
    } catch (Exception e) {    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);  }%>
