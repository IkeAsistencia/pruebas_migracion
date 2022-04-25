<%@page contentType="application/json; charset=UTF-8" pageEncoding="UTF-8" import="Seguridad.SeguridadC,Utilerias.UtileriasBDF, java.sql.ResultSet,java.io.PrintWriter"%><%
            String StrclUsrApp = "0";
            if (session.getAttribute("clUsrApp") != null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();            }
            if (SeguridadC.verificaHorarioC((Integer.parseInt(StrclUsrApp))) != true) {
                %> Fuera de Horario <%
                StrclUsrApp = null;
                return;
                }
            String idSubservicio =request.getParameter("idSubServicio");
            String cobertura     =request.getParameter("cobertura");
            int rclSubServicio = 0;
            String rdsSubServicio = "";
            try {
                StringBuffer sqlConsultaSubSevAsoc = new StringBuffer();
                sqlConsultaSubSevAsoc.append("Select S.clSubServicio, S.dsSubServicio ")
                    .append(" From cSubServicio S, ")
                    .append(" SubServicioxCobertura SSC ")
                    .append(" where S.clSubServicio = SSC.clSubServicio ")
                    .append(" AND SSC.clCobertura =  ")
                    .append(cobertura)
                    .append(" AND SSC.clSubServicioAsociado = ")
                    .append(idSubservicio);
                ResultSet rs = UtileriasBDF.rsSQLNP(sqlConsultaSubSevAsoc.toString() );
                if ( rs.next() ) {
                    rclSubServicio = (rs.getObject("clSubServicio")!=null?rs.getInt("clSubServicio"):0);
                    rdsSubServicio = (rs.getObject("dsSubServicio")!=null?rs.getString("dsSubServicio"):"");
                    StringBuilder sReturn = new StringBuilder();
                    sReturn.append("{ \"rclSubServicio\": \""+String.valueOf( rclSubServicio )+"\",");
                    sReturn.append("  \"rdsSubServicio\": \""+String.valueOf( rdsSubServicio )+"\"}");
                    out.println(sReturn.toString());
                    response.setStatus(HttpServletResponse.SC_OK); 
                    rs.close();
                } else {     response.sendError(HttpServletResponse.SC_NOT_FOUND);   }       
            } catch (Exception e) {      response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);    }%>
