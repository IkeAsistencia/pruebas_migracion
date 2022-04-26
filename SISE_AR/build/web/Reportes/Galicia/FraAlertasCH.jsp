<%@ page contentType="text/html;charset=windows-1252"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
        <title>Frame Reporte Galicia</title>
    </head>
    <%
        String strclTipoRpo = "0";
        String NombrePagFiltro = "";
        String NombrePagAlerta = "";
        
        if (session.getAttribute("clTipoRpo") != null) {
            strclTipoRpo = session.getAttribute("clTipoRpo").toString();
        }
        
        if (strclTipoRpo.equals("1")) {
            System.out.println("strclTipoRpo.equals");
            NombrePagFiltro = "FiltrosCH.jsp";
            NombrePagAlerta = "ListadoCH.jsp";
        }
    %>
    <frameset noresize  id='FraInbursa' name='FraChartis' rows='100,*'>";
        <frame bordercolor='#003366' frameborder='no' border='10' name='FiltrosCH' noresize id='FiltrosCH' scrolling='no' src='FiltrosCH.jsp' ></frame>
        <frame bordercolor='#003366' frameborder='no' border='10' name='ListadoCH' noresize id='ListadoCH' src='ListadoCH.jsp' ></frame>
    </frameset> 
    <%
        strclTipoRpo = null;
        NombrePagFiltro = null;
        NombrePagAlerta = null;
    %>
</html>