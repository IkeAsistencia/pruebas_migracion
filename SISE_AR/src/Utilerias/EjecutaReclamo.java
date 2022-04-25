package Utilerias;

import java.sql.ResultSet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import java.io.IOException;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;

/*
 *
 * @author
 * fcerqueda
 */
public class EjecutaReclamo extends HttpServlet {

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
    }

    @Override
    public void destroy() {
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession sessionH = request.getSession(false);

        String StrUsrApp = "";
        String StrClcuenta = "";
        String StrclAfiliado = "";
        String StrNomAfiliado = "";
        String StrDNI = "";
        String StrclAfilTMK = "";
        String StrClsector = "";
        String StrclTipoReclamo = "";
        String StrclEstatusReclamo = "";
        String StrObservaciones = "";
        String StrMonto = "";
        String StrAplicaReclamo = "";
        String StrUrlBack = "";
        String StrclReclamo = "";
        String StrValidador = "";
        String StrOpeVend = "";
        String StrReintegro = "";
        String StrClave = "";
        String StrFechaVal = "";
        String StrCanalVenta = "";
        String StrtipoTarjeta = "";
        String StrNoTarjeta = "";
        String StrBanco = "";
        String StrNoCuenta = "";
        String StrNoCBU = "";
        String StrCategoriaReclamo = "";
        String StrclUsrAppAut = "";
        String StrclGpoCuenta = "";
        String StrAutorizaReintegro = "";

        ResultSet rs = null;
        StringBuilder strSQL = new StringBuilder();

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        out.println("<html>");
        out.println("<head>");
        out.println("<title>Reclamos</title>");
        out.println("</head>");
        out.println("<body>");

        if (sessionH.getAttribute("clUsrApp") != null) {
            StrUsrApp = sessionH.getAttribute("clUsrApp").toString();
        }

        if (request.getParameter("clReclamo") != null) {
            StrclReclamo = request.getParameter("clReclamo");
        }

        if (request.getParameter("clCuenta") != null) {
            StrClcuenta = request.getParameter("clCuenta");
        }

        if (request.getParameter("clAfiliado") != null) {
            StrclAfiliado = request.getParameter("clAfiliado");
        }

        if (request.getParameter("NombreAfiliado") != null) {
            StrNomAfiliado = request.getParameter("NombreAfiliado");
        }

        if (request.getParameter("DNI") != null) {
            StrDNI = request.getParameter("DNI");
        }

        if (request.getParameter("Clave") != null) {
            StrClave = request.getParameter("Clave");
        }

        if (request.getParameter("clAfiltmk") != null) {
            StrclAfilTMK = request.getParameter("clAfiltmk");
        }

        if (request.getParameter("clSector") != null) {
            StrClsector = request.getParameter("clSector");
        }

        if (request.getParameter("clTipoReclamo") != null) {
            StrclTipoReclamo = request.getParameter("clTipoReclamo");
        }

        if (request.getParameter("clEstatusReclamo") != null) {
            StrclEstatusReclamo = request.getParameter("clEstatusReclamo");
        }

        if (request.getParameter("Observaciones") != null) {
            StrObservaciones = request.getParameter("Observaciones");
        }

        if (request.getParameter("Reintegro") != null) {
            StrReintegro = request.getParameter("Reintegro");
        }

        if (request.getParameter("Monto") != null) {
            StrMonto = request.getParameter("Monto");
        }

        if (request.getParameter("AplicaReclamo") != null) {
            StrAplicaReclamo = request.getParameter("AplicaReclamo");
        }

        if (request.getParameter("FechaValida") != null) {
            StrFechaVal = request.getParameter("FechaValida");
        }

        if (request.getParameter("Operador") != null) {
            StrOpeVend = request.getParameter("Operador");
        }

        if (request.getParameter("Validador") != null) {
            StrValidador = request.getParameter("Validador");
        }

        if (request.getParameter("CanalVenta") != null) {
            StrCanalVenta = request.getParameter("CanalVenta");
        }

        if (request.getParameter("tipoTarjeta") != null) {
            StrtipoTarjeta = request.getParameter("tipoTarjeta");
        }

        if (request.getParameter("noTarjeta") != null) {
            StrNoTarjeta = request.getParameter("noTarjeta");
        }

        if (request.getParameter("noCuenta") != null) {
            StrNoCuenta = request.getParameter("noCuenta");
        }

        if (request.getParameter("banco") != null) {
            StrBanco = request.getParameter("banco");
        }

        if (request.getParameter("noCBU") != null) {
            StrNoCBU = request.getParameter("noCBU");
        }
        
        if (request.getParameter("CategoriaReclamo") != null) {
            StrCategoriaReclamo = request.getParameter("CategoriaReclamo");
        }       
           
        if (request.getParameter("clUsrAppAut") != null) {
            StrclUsrAppAut = request.getParameter("clUsrAppAut");
        }  
        
        if (request.getParameter("clGpoCuenta") != null) {
            StrclGpoCuenta = request.getParameter("clGpoCuenta");
        } 
        
        if (request.getParameter("AutorizaReintegro") != null) {
            StrAutorizaReintegro = request.getParameter("AutorizaReintegro");
        }        
        
        try {
            if (request.getParameter("URLBACK") != null) {
                StrUrlBack = request.getParameter("URLBACK");
            }

            if (Integer.parseInt(request.getParameter("Action")) == 1) {
                strSQL.append("'").append(StrUsrApp).append("','").append(StrClcuenta).append("','");
                strSQL.append(StrclAfiliado).append("','").append(StrNomAfiliado).append("','").append(StrDNI).append("','");
                strSQL.append(StrclAfilTMK).append("','").append(StrClsector).append("','").append(StrclTipoReclamo).append("','");
                strSQL.append(StrclEstatusReclamo).append("','").append(StrObservaciones).append("','").append(StrMonto).append("','");
                strSQL.append(StrAplicaReclamo).append("','").append(StrOpeVend).append("','").append(StrValidador).append("','");
                strSQL.append(StrReintegro).append("','").append(StrClave).append("','").append(StrFechaVal).append("','").append(StrCanalVenta).append("','");
                strSQL.append(StrtipoTarjeta).append("','").append(StrNoTarjeta).append("','").append(StrBanco).append("','");
                strSQL.append(StrNoCuenta).append("','").append(StrNoCBU).append("','").append(StrCategoriaReclamo).append("','");
                strSQL.append(StrclUsrAppAut).append("','").append(StrclGpoCuenta).append("','").append(StrAutorizaReintegro).append("'");
                System.out.print("st_AddReclamo " + strSQL.toString());
                rs = UtileriasBDF.rsSQLNP("st_AddReclamo " + strSQL.toString());
                
                if (rs.next()) {
                    StrclReclamo = rs.getString("clReclamo");
                }

                if (!StrclReclamo.equalsIgnoreCase("0")) {
                    StrUrlBack = StrUrlBack + "&clReclamo=" + StrclReclamo;
                    out.println("<script>window.opener.fnValidaResponse(1,'" + StrUrlBack + "')</script>");
                } else {
                    out.println("Problemas al registrar el reclamo, Favor de Comunicarse con su Administrador.");
                    out.close();
                }
            } else if (Integer.parseInt(request.getParameter("Action")) == 2) {
                strSQL.append("'").append(StrclReclamo).append("','").append(StrUsrApp).append("','").append(StrClsector).append("','");
                strSQL.append(StrclTipoReclamo).append("','").append(StrclEstatusReclamo).append("','").append(StrObservaciones).append("','");
                strSQL.append(StrMonto).append("','").append(StrAplicaReclamo).append("','").append(StrOpeVend).append("','");
                strSQL.append(StrValidador).append("','").append(StrReintegro).append("','");
                strSQL.append(StrBanco).append("','").append(StrNoCuenta).append("','").append(StrNoCBU).append("','").append(StrCategoriaReclamo);
                strSQL.append("','").append(StrclUsrAppAut).append("','").append(StrclGpoCuenta).append("','").append(StrAutorizaReintegro).append("'");
                System.out.print("st_updateReclamo " + strSQL.toString());

                rs = UtileriasBDF.rsSQLNP("st_updateReclamo " + strSQL.toString());

                if (rs.next()) {

                    if (rs.getString("Error").equalsIgnoreCase("0")) {
                        StrclReclamo = rs.getString("clReclamo");
                        StrUrlBack = StrUrlBack + "&clReclamo=" + StrclReclamo;
                        out.println("<script>window.opener.fnValidaResponse(1,'" + StrUrlBack + "')</script>");
                    } else {
                        out.println("<script>");
                        out.println("alert(\"Error al actualizar los datos\");");
                        out.println("</script>");
                        out.println("<script>window.opener.fnValidaError()</script>");
                    }
                }
            }

        } catch (Exception e) {
            System.out.println("Error EjecutaReclamo :" + e);
            out.close();
        } finally {

            StrUsrApp = null;
            StrClcuenta = null;
            StrclAfiliado = null;
            StrNomAfiliado = null;
            StrDNI = null;
            StrclAfilTMK = null;
            StrClsector = null;
            StrclTipoReclamo = null;
            StrclEstatusReclamo = null;
            StrObservaciones = null;
            StrMonto = null;
            StrAplicaReclamo = null;
            StrUrlBack = null;
            StrclReclamo = null;
            StrValidador = null;
            StrOpeVend = null;
            StrReintegro = null;
            StrClave = null;
            StrFechaVal = null;
            StrCanalVenta = null;
            StrtipoTarjeta = null;
            StrNoTarjeta = null;
            StrBanco = null;
            StrNoCuenta = null;
            StrNoCBU = null;
            StrCategoriaReclamo = null;
            StrAplicaReclamo = null;
            StrclGpoCuenta = null;
            
            try {
                if (rs != null) {
                    rs.close();
                    rs = null;
                }
            } catch (Exception ee) {
            }

        }

        out.println("</body>");
        out.println("</html>");

        out.close();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
