   /*
 * GuardaSeguimiento.java
 *
 * Created on 19 de mayo de 2005, 09:30 PM

 */
package Concierge;

import java.sql.ResultSet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import java.io.IOException;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;
import Utilerias.UtileriasBDF;

/*
 *
 * @author  cabrerar
 * @version
 */
public class CSGuardaSeguimiento extends HttpServlet {

    /* Initializes the servlet.
     */
    public void init(ServletConfig config) throws ServletException {
        super.init(config);

    }

    /* Destroys the servlet.
     */
    public void destroy() {
    }

    /* Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession sessionH = request.getSession(false);
        HttpSession session = request.getSession(false);

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        out.println("<html>");
        out.println("<head>");
        out.println("<title>CSGuarda Seguimiento</title>");
        out.println("</head>");
        out.println("<body>");
        //out.println(request.getParameter("URLBACK1"));
        String strTipoSeguimiento = "";
        if (request.getParameter("TipoSeg0") != null) {
            strTipoSeguimiento = request.getParameter("TipoSeg0").toString();
        } else {
            if (request.getParameter("TipoSeg1") != null) {
                strTipoSeguimiento = request.getParameter("TipoSeg1").toString();
            } else {
                out.println("<p class='class='cssTitDet'>Error. Por favor, consulte a su Administrador.</p>");
                out.println("</body>");
                out.println("</html>");
                return;
            }
        }
        ResultSet rsEx = null;
        String StrclAsistencia = "0";
        String StrclAsistenciaBK = "0";
        String StrclEstatus = "0";
        String StrclProveedor = "0";
        String StrObservaciones = "";
        String StrDetalleConclucion = "";
        String StrclRefxAsistOpcOtros = "";
        String StrclReferenciaxAsistencia = "";

        String StrURLBACK = "";
        String StrclUsrApp = "0";
        String StrFechaP = "";
        String StrEvaluacionC = "";
        String StrclUsrAppValSup = "";

        if (request.getParameter("clUsrAppValSup") != null) {
            StrclUsrAppValSup = request.getParameter("clUsrAppValSup").toString();
        }

        if (request.getParameter("FechaProgramada") != null) {
            StrFechaP = request.getParameter("FechaProgramada").toString();
        }

        if (sessionH.getAttribute("clUsrApp") != null) {
            StrclUsrApp = sessionH.getAttribute("clUsrApp").toString();
        } else {
            out.println("<p class='class='cssTitDet'>Sin sesión. Por favor, consulte a su Administrador.</p>");
            out.println("</body>");
            out.println("</html>");
            out.close();
            return;
        }

        switch (Integer.parseInt(strTipoSeguimiento)) {
            case 0:
                if (request.getParameter("clEstatus0") != null) {
                    StrclEstatus = request.getParameter("clEstatus0").toString();
                    if (request.getParameter("clEstatus0").toString().compareToIgnoreCase("") != 0) {
                        StrclEstatus = request.getParameter("clEstatus0").toString();
                    } else {
                        out.println("<p class='class='cssTitDet'>Debe informar Estatus.</p>");
                        out.println("</body>");
                        out.println("</html>");
                        out.close();
                        return;
                    }
                } else {
                    out.println("<p class='class='cssTitDet'>Debe informar un Estatus.</p>");
                    out.println("</body>");
                    out.println("</html>");
                    out.close();
                    return;
                }

                if (session.getAttribute("clAsistencia") != null) {
                    StrclAsistencia = session.getAttribute("clAsistencia").toString();
                }

                if (request.getParameter("URLBACK0") != null) {
                    StrURLBACK = request.getParameter("URLBACK0").toString();
                } else {
                    out.println("<p class='class='cssTitDet'>Ocurrió un error al regresar información. Por favor consulte a sus Administrador.</p>");
                    out.println("</body>");
                    out.println("</html>");
                    out.close();
                    return;
                }
                if (request.getParameter("Observaciones0") != null) {
                    StrObservaciones = request.getParameter("Observaciones0").toString();
                }

                if (request.getParameter("DetalleConclucion") != null) {
                    StrDetalleConclucion = request.getParameter("DetalleConclucion").toString();
                }

                if (request.getParameter("clRefxAsistOpcOtrosC") != null) {
                    StrclRefxAsistOpcOtros = request.getParameter("clRefxAsistOpcOtrosC").toString();
                }

                if (request.getParameter("EvaluacionC") != null) {
                    StrEvaluacionC = request.getParameter("EvaluacionC").toString();
                }
                
                if(request.getParameter("clReferenciaxAsistencia") != null){
                    StrclReferenciaxAsistencia = request.getParameter("clReferenciaxAsistencia").toString();
                }


                break;

            case 1:
                if (request.getParameter("clEstatus1") != null) {
                    StrclEstatus = request.getParameter("clEstatus1").toString();
                    if (request.getParameter("clEstatus1").toString().compareToIgnoreCase("") != 0) {
                        StrclEstatus = request.getParameter("clEstatus1").toString();
                    } else {
                        out.println("<p class='class='cssTitDet'>Debe informar Estatus.</p>");
                        out.println("</body>");
                        out.println("</html>");
                        out.close();
                        return;
                    }
                } else {
                    out.println("<p class='class='cssTitDet'>Debe informar Estatus.</p>");
                    out.println("</body>");
                    out.println("</html>");
                    out.close();
                    return;
                }

                if (session.getAttribute("clAsistencia") != null) {
                    StrclAsistencia = session.getAttribute("clAsistencia").toString();
                }
                if (request.getParameter("URLBACK1") != null) {
                    StrURLBACK = request.getParameter("URLBACK1").toString();
                } else {
                    out.println("<p class='class='cssTitDet'>Ocurrió un error al regresar información. Por favor consulte a sus Administrador.</p>");
                    out.println("</body>");
                    out.println("</html>");
                    out.close();
                    return;
                }

                if (request.getParameter("clProveedor1") != null) {
                    StrclProveedor = request.getParameter("clProveedor1").toString();
                } else {
                    if (request.getParameter("clProveedor1").toString().compareToIgnoreCase("") != 0) {
                        StrclProveedor = request.getParameter("clProveedor1").toString();
                    } else {
                        out.println("<p class='class='cssTitDet'>Debe informar Estatus.</p>");
                        out.println("</body>");
                        out.println("</html>");
                        return;
                    }
                }
                if (request.getParameter("Observaciones1") != null) {
                    StrObservaciones = request.getParameter("Observaciones1").toString();
                }
                break;
            default:
                break;
        }
        try {
            //System.out.println("st_CSGuardaSeguimiento " + strTipoSeguimiento + "," + StrclAsistencia + "," + StrclEstatus + ",'" + StrObservaciones + "'," + StrclUsrApp + "," + StrclProveedor + ",'" + StrFechaP + "','" + StrEvaluacionC + "','" + StrDetalleConclucion + "','" + StrclUsrAppValSup + "','" + StrclRefxAsistOpcOtros + "'");
            rsEx = UtileriasBDF.rsSQLNP("st_CSGuardaSeguimientoM " + strTipoSeguimiento + "," + StrclAsistencia + "," + StrclEstatus + ",'" + StrObservaciones + "'," + StrclUsrApp + "," + StrclProveedor + ",'" + StrFechaP + "','" + StrEvaluacionC + "','" + StrDetalleConclucion + "','" + StrclUsrAppValSup + "','" + StrclRefxAsistOpcOtros + "','" + StrclReferenciaxAsistencia + "'");
            if (rsEx.next()) {
                String strclAsistenciaRt = rsEx.getString("clAsistencia");
                if (strclAsistenciaRt != null) {
                    StrclAsistenciaBK = strclAsistenciaRt.toString();
                    if (StrclAsistenciaBK.compareToIgnoreCase("0") == 0) {
                        out.println("<p class='class='cssTitDet'>" + rsEx.getString("Mensaje").toString() + "</p>");
                        out.println("</body>");
                        out.println("</html>");
                        out.close();
                        return;
                    }
                    out.println("<script>location.href=\"" + StrURLBACK + "\"</script>");
                } else {
                    out.println("<p class='class='cssTitDet'>Falló la transacción. Por favor consulte a su Administrador.</p>");
                    out.println("</body>");
                    out.println("</html>");
                    out.close();
                    return;
                }
                rsEx.close();
            }
        } catch (Exception e) {
            out.close();
            e.printStackTrace();
//            this.destroy();
        } finally {
            try {
                if (rsEx != null) {
                    rsEx.close();
                    rsEx = null;
                }
            } catch (Exception ee) {
                ee.printStackTrace();
            }
        }

        out.println("</body>");
        out.println("</html>");
        out.close();
//        this.destroy();
    }

    /* Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /* Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /* Returns a short description of the servlet.
     */
    public String getServletInfo() {
        return "Short description";
    }
}
