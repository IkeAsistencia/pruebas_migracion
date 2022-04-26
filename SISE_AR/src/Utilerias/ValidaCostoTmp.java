/*
 * ValidaCondNU.java
 *
 * Created on 1 de junio de 2005, 10:32 AM
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
import java.sql.Connection;

/*
 *
 * @author  cabrerar
 * @version
 */
public class ValidaCostoTmp extends HttpServlet {

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

        String StrclCosto = "";
        String StrclExpediente = "";
        String StrclProveedor = "";
        String StrclConcepto = "";
        String StrConcepto = "";
        String StrCostoConv = "";
        String StrCostoSEA = "";
        String StrCostoNU = "";
        String StrCostoExced = "";
        String StrKMExcedente = "";
        String StrKmRecorridos = "";
        String StrExcepcion = "";
        String StrUsr = "";
        String StrPwd = "";
        String StrclUsrApp = "";
        Connection con = null;

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        out.println("<html>");
        out.println("<head>");
        out.println("<title>Validar el Registro de Costo</title>");
        out.println("</head>");
        out.println("<link href=\"../StyleClasses/Global.css\" rel=\"stylesheet\" type=\"text/css\">");
        out.println("<body class='cssBody'>");

        if (request.getParameter("clCosto") != null) {
            StrclCosto = request.getParameter("clCosto").toString();
        }

        if (request.getParameter("clExpediente") != null) {
            StrclExpediente = request.getParameter("clExpediente").toString();
        }

        if (request.getParameter("clProveedor") != null) {
            StrclProveedor = request.getParameter("clProveedor").toString();
        }

        if (request.getParameter("clConcepto") != null) {
            StrclConcepto = request.getParameter("clConcepto").toString();
        }

        if (request.getParameter("Concepto") != null) {
            StrConcepto = request.getParameter("Concepto").toString();
        }

        if (request.getParameter("CostoConv") != null) {
            StrCostoConv = request.getParameter("CostoConv").toString();
        }

        if (request.getParameter("CostoSEA") != null) {
            StrCostoSEA = request.getParameter("CostoSEA").toString();
        }

        if (request.getParameter("CostoNU") != null) {
            StrCostoNU = request.getParameter("CostoNU").toString();
        }

        if (request.getParameter("CostoExced") != null) {
            StrCostoExced = request.getParameter("CostoExced").toString();
        }

        if (request.getParameter("KMExcedente") != null) {
            StrKMExcedente = request.getParameter("KMExcedente").toString();
        }

        if (request.getParameter("KmRecorridos") != null) {
            StrKmRecorridos = request.getParameter("KmRecorridos").toString();
        }
        
        if (request.getParameter("Excepcion") != null) {
            StrExcepcion = request.getParameter("Excepcion").toString();
        }
        
        if (request.getParameter("Usr") != null) {
            StrUsr = request.getParameter("Usr").toString();
        }
        if (request.getParameter("Pwd") != null) {
            StrPwd = request.getParameter("Pwd").toString();
        }
        String strMess = "";
        boolean blnAutorizado = false;
        con = UtileriasBDF.getConnection();
        ResultSet rsAut = null;

        try {
            if (Float.parseFloat(StrCostoSEA) > Float.parseFloat(StrCostoConv)) {
                strMess = "El costo que paga SEA excede al costo en Convenio";
                blnAutorizado = false;
                String strUsuario = "";
                if (StrUsr.compareToIgnoreCase("") == 0) {
                    // No entró por la página de autorización, es directamente del expediente
                    blnAutorizado = false;
                    strMess = "Debe informar usuario para autorizar el costo";
                } else if (StrPwd.compareToIgnoreCase("") == 0) {
                    blnAutorizado = false;
                    strMess = "Debe informar contraseña para autorizar el costo";
                } else {
                    rsAut = UtileriasBDF.rsSQLNP("sp_EncriptDesEncriptPassword '" + StrUsr + "',0,'', 0");
                    if (rsAut.next()) {
                        StrclUsrApp = rsAut.getString("clUsrApp");
                        if (StrPwd.compareToIgnoreCase(rsAut.getString("password")) == 0) {
                            if (rsAut.getString("AutorizaCosto").compareToIgnoreCase("0") == 0) {
                                blnAutorizado = false;
                                strMess = "Usuario no autorizado";
                            } else {
                                blnAutorizado = true;
                            }
                        } else {
                            blnAutorizado = false;
                            strMess = "Contraseña Incorrecta";
                        }
                    } else {
                        blnAutorizado = false;
                        strMess = "Usuario Incorrecto";
                    }
                }

                if (blnAutorizado == false) {
                    out.println("<p class='TTable'>REGISTRO DE COSTO NO AUTORIZADO, MOTIVO:" + strMess);
                    out.println("</p>");
                    out.println("<form action='../servlet/Utilerias.ValidaCostoTmp' method='post'>");
                    out.println("<table><tr><td class='cssTitDet' colspan=2>Clave de autorización...</td></tr>");
                    out.println("<tr><td class='FTable'>Usuario:</td><td class='FTable'><input id='Usr' name = 'Usr'></input></td><tr>");
                    out.println("<tr><td class='FTable'>Contraseña:</td><td class='FTable'><input type=password id='Pwd' name = 'Pwd'></input></td><tr>");
                    out.println("<tr><td class='FTable'><input class='cBtn' VALUE='Autorizar' type='submit'></input></td><td class='FTable'><input value ='Cancelar' class='cBtn' type='button' onClick='window.close()'></input></td><tr>");
                    out.println("<input id='clCosto' name='clCosto' type='hidden' value='" + StrclCosto + "'></input>");
                    out.println("<input id='clProveedor' name='clProveedor' type='hidden' value='" + StrclProveedor + "'></input>");
                    out.println("<input id='clExpediente' name='clExpediente' type='hidden' value='" + StrclExpediente + "'></input>");
                    out.println("<input id='clConcepto' name='clConcepto' type='hidden' value='" + StrclConcepto + "'></input>");
                    out.println("<input id='Concepto' name='Concepto' type='hidden' value='" + StrConcepto + "'></input>");
                    out.println("<input id='CostoConv' name='CostoConv' type='hidden' value='" + StrCostoConv + "'></input>");
                    out.println("<input id='CostoSEA' name='CostoSEA' type='hidden' value='" + StrCostoSEA + "'></input>");
                    out.println("<input id='CostoNU' name='CostoNU' type='hidden' value='" + StrCostoNU + "'></input>");
                    out.println("<input id='CostoExced' name='CostoExced' type='hidden' value='" + StrCostoExced + "'></input>");
                    out.println("<input id='KMExcedente' name='KMExcedente' type='hidden' value='" + StrKMExcedente + "'></input>");
                    out.println("<input id='KmRecorridos' name='KmRecorridos' type='hidden' value='" + StrKmRecorridos + "'></input>");
                    out.println("<input id='Excepcion' name='Excepcion' type='hidden' value='" + StrExcepcion + "'></input>");
                    out.println("<script>window.focus();window.resizeTo(400,280);window.moveTo(300,150)</script>");
                    out.println("<BGSOUND SRC='../Music/UTOPIA.WAV'>");
                } else {
                    sessionH.removeAttribute("clPaginaWebP");
                    sessionH.setAttribute("clPaginaWebP", "240");
                    out.println("<script>window.opener.fnSubmitOK(" + rsAut.getString("clUsrApp") + ",'" + strMess + "')</script>");
                    UtileriasBDF.ejecutaSQLNP("Insert into Autorizacion (clExpediente, clUsrApp, Fecha, clTipoAutorizacion, Observaciones) values (" + StrclExpediente + "," + StrclUsrApp + ",getdate(),2,'" + strMess + "')");
                }
            } else {
                sessionH.removeAttribute("clPaginaWebP");
                sessionH.setAttribute("clPaginaWebP", "240");
                out.println("<script>window.opener.fnSubmitOK(0,'')</script>");
            }
            out.println("</body>");
            out.println("</html>");
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script> window.opener.fnValidaResponse(-1,'')</script>");
            out.println("Problema al registrar el movimiento (verifique formato de fechas y campos numéricos sin separador de coma)");
        } finally {
            try {
                if (rsAut != null) {
                    rsAut.close();
                    rsAut = null;
                }
                if (con != null) {
                    con.close();
                }
            } catch (Exception ee) {
                ee.printStackTrace();
                out.println("<script> window.opener.fnValidaResponse(-1,'')</script>");
                out.println("Problema al registrar el movimiento (verifique formato de fechas y campos numéricos sin separador de coma)");
            }
            out.close();
        }
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
