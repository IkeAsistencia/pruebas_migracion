<%@page contentType="text/html; charset=iso-8859-1" import="java.sql.ResultSet,Seguridad.SeguridadC,Utilerias.UtileriasBDF"%>
<%@page import="java.util.List"%>
<%@page import="ar.com.ike.geo.proveedores.*"%>
<html>
    <head>
        <title>Envio de Proveedores via WS</title>
        <link href="StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body>
        <table class="Table" width='900' cellspacing="0" cellpadding="0">
            <%
                try {
                    Proveedores pvds = new Proveedores();
                    List<Proveedor> lstPvds = pvds.getProveedores();
                    pvds.send();
                    int i = 1;
                    for (Proveedor pvd : lstPvds) {
                        out.println(String.valueOf(i) + " = PVD:" + pvd.getClProveedor()+ "::" + pvd.getNombreOpe() + "<br />");
                        i++;
                        out.print("Localidades:");
                        int ii=0;
                        for ( String loc : pvd.getCobDsEntFed()){ 
                            out.print(loc + "::" +  pvd.getCobSubServicio().get(ii)+ ";<br />");
                            ii++;
                        }
                        out.println("<br />");
                        out.flush();
                    }
                    
                    //String err= pvds.send();
                } catch (Exception e) {
                    System.out.println("testws.error:" + e.toString() );
                }
            %>
        </table>
    </body>
</html>
