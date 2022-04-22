<%@page contentType="text/html" pageEncoding="ISO-8859-1" import="Utilerias.UtileriasBDF, java.sql.ResultSet,Seguridad.SeguridadC"%><%
    String strclUsrApp = "0";
    if (session.getAttribute("clUsrApp") != null) {
        strclUsrApp = session.getAttribute("clUsrApp").toString();           }
    if(SeguridadC.verificaHorarioC(Integer.parseInt(strclUsrApp)) != true){
        %><font color="white"  style="font-family:Verdana,Arial,Helvetica,sans-serif; background-color:red;" size=3>LA SESION EXPIRO</font><%  
        strclUsrApp=null;
        return;
        }
    String cuitCuil = (request.getParameter("pCuitCuil")!=null?request.getParameter("pCuitCuil"): null);
    try {
        StringBuffer sqlControlCuit = new StringBuffer();
        sqlControlCuit.append("st_CuitCuilValido ").append(cuitCuil);
        ResultSet rs = UtileriasBDF.rsSQLNP(sqlControlCuit.toString() );
        if ( rs.next() ) {
            int esValido = (rs.getObject("valido")!=null?rs.getInt("valido"):3);
            //LOGICA DE CANTIDAD DE REPUBLICACIONES AUTOMATICAS
            if ( esValido == 1 ) {     response.setStatus(HttpServletResponse.SC_OK);
            } else {
                if ( esValido == 2 ) {    response.sendError(HttpServletResponse.SC_REQUEST_ENTITY_TOO_LARGE);
                } else {    response.sendError(HttpServletResponse.SC_FORBIDDEN);                    }
                }
            }
        rs.close();
        rs=null;
    }catch (Exception e) {  response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);   }
        
        %>