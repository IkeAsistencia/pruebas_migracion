/*
 * EjecutaLlamAltaAfil.java
 *
 * Created on 7 de Febrero de 2006, 05:02 PM
 */
package Utilerias;

import java.sql.ResultSet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import java.io.IOException;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;

/*
 *
 * @author  perezern
 * @version
 */
public class EjecutaAccionCorrigeCto extends HttpServlet {

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
        //cAfiliado
        String StrUsrApp = "0";
        String strclCosto = "0";
        String strCostoSEA = "0";
        String strclExpediente = "0";
        String strConcepto = "0";
        String strComentarios = "0";
        String StrResultado = "0";
        String strCostoNU = "0";
        String strClConcepto = "0";

        ResultSet rsEx = null;

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        out.println("<html>");
        out.println("<head>");
        out.println("<title>Retenciones</title>");
        out.println("</head>");
        out.println("<body>");

        if (sessionH.getAttribute("clUsrApp") != null) {
            StrUsrApp = sessionH.getAttribute("clUsrApp").toString();
        }

        if (request.getParameter("clCosto") != null) {
            strclCosto = request.getParameter("clCosto");
        }

        if (request.getParameter("CostoSEA") != null) {
            strCostoSEA = request.getParameter("CostoSEA");
        }
        
        if (request.getParameter("CostoNU") != null) {
            strCostoNU = request.getParameter("CostoNU");
        }

        if (request.getParameter("clExpediente") != null) {
            strclExpediente = request.getParameter("clExpediente");
        }

        if (request.getParameter("Concepto") != null) {
            strConcepto = request.getParameter("Concepto");
        }

        if (request.getParameter("Comentarios") != null) {
            strComentarios = request.getParameter("Comentarios");
        }
        
        if (request.getParameter("clConcepto") != null ) {
            strClConcepto = request.getParameter("clConcepto");
        }

        try {
            String strUrlBack = "";
            if (request.getParameter("URLBACK") != null) {
                strUrlBack = request.getParameter("URLBACK");
            }

            if (Integer.parseInt(request.getParameter("Action")) == 2) {

                rsEx = UtileriasBDF.rsSQLNP("sp_CorrigeCosto '" + strclCosto + "','" + strCostoSEA + "','" + strCostoNU + "','" + strclExpediente + "','" + strConcepto + "','" + strComentarios + "','" + StrUsrApp + "'," + strClConcepto );
                System.out.println("sp_CorrigeCosto '" + strclCosto + "','" + strCostoSEA + "','" + strCostoNU + "','" + strclExpediente + "','" + strConcepto + "','" + strComentarios + "','" + StrUsrApp + "'," + strClConcepto );
                if (rsEx.next()) {
                    StrResultado = rsEx.getString("Resultado");
                    //System.out.println("aqui neto : " + StrResultado);
                }

                if (!StrResultado.equalsIgnoreCase("0")) {
                    //strUrlBack=strUrlBack + "&clRetencTmk=" + StrclRetencTmk ;
                    strUrlBack = strUrlBack + "clCosto=" + strclCosto + "&clExpediente=" + strclExpediente;
                    out.println("<script>window.opener.fnValidaResponse(1,'" + strUrlBack + "')</script>");
                } else {
                    out.println("Problemas al Generar el Movimiento Favor de Comunicarse con su Administrador");
                    out.close();
                }
            }
            /*else
            {
            if(Integer.parseInt(request.getParameter("Action"))==2)
            {
            rsEx = UtileriasBDF.rsSQL("sp_UpdateLlamAltaAfil '" + StrclLlamaAlta +"','" + clAfiliadoNU + "','" + StrclCuenta + "','" + StrClave + "','" + StrNombre + "','" + StrFechNac + "','" + StrCodEnt + "','" + StrCodMD + "','" + StrColonia + "','" + StrCalle + "','" + StrCP + "','" + StrTelefono + "','" + StrEmpresa + "'");

            strUrlBack=strUrlBack + "&clLlamaAltaNU=" + StrclLlamaAlta ;
            out.println("<script>window.opener.fnValidaResponse(1,'"+ strUrlBack +"')</script>");
            }
            }*/
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
