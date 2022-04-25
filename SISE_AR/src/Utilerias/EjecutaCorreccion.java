/*
 * EjecutaAltaAfiliado.java
 *
 * Created on 4 de Mayo de 2005, 04:27 PM
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
 * @author  
 * @version
 */
public class EjecutaCorreccion extends HttpServlet {

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
        String StrclTipo = "0";
        String StrPermiteEliminarSeg = "0";
        String StrclEstatus = "0";
        String StrclExpediente = "0";
        String StrFecha = "";
        String StrclSeguimientoProveedor = "0";
        String StrclProveedor = "0";
        String StrPermiteCumplirRec ="0";
        String StrclSeguimientoCita = "0";
        
        String StrclRecordatorio ="";
        
        ResultSet rsEx = null;

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        out.println("<html>");
        out.println("<head>");
        out.println("<title>Servicio de Correciones</title>");
        out.println("</head>");
        out.println("<body>");

        if (sessionH.getAttribute("clUsrApp") != null) {
            StrUsrApp = sessionH.getAttribute("clUsrApp").toString();
        }

        if (request.getParameter("clTipo") != null) {
            StrclTipo = request.getParameter("clTipo");
        }

        if (request.getParameter("PermiteEliminarSeg") != null) {
            StrPermiteEliminarSeg = request.getParameter("PermiteEliminarSeg");
        }

        if (request.getParameter("clEstatus") != null) {
            StrclEstatus = request.getParameter("clEstatus");
        }

        if (request.getParameter("clExpediente") != null) {
            StrclExpediente = request.getParameter("clExpediente");
        }

        if (request.getParameter("Fecha") != null) {
            StrFecha = request.getParameter("Fecha").toString();

        }

        if (request.getParameter("clSeguimientoProveedor") != null) {
            StrclSeguimientoProveedor = request.getParameter("clSeguimientoProveedor");
        }

        if (request.getParameter("clSeguimientoCita") != null) {
            StrclSeguimientoCita = request.getParameter("clSeguimientoCita");
        }

        if (request.getParameter("clProveedor") != null) {
            StrclProveedor = request.getParameter("clProveedor");
        }
        if (request.getParameter("PermiteCumplirRec") != null){
            StrPermiteCumplirRec= request.getParameter("PermiteCumplirRec");
        }
        
        if (request.getParameter("clRecordatorio") != null){
            StrclRecordatorio= request.getParameter("clRecordatorio");
        }

        if (StrclTipo.equalsIgnoreCase("1")) {
            if (StrPermiteEliminarSeg.equalsIgnoreCase("1")) {
                //String StrSentence="sp_CorrigeSeg " + StrclExpediente + "," + StrFecha + "," +  StrclEstatus + "," + StrUsrApp;
                rsEx = UtileriasBDF.rsSQLNP("sp_CorrigeSeg " + StrclExpediente + "," + StrclEstatus + "," + StrUsrApp);
//                 rsInfo = UtileriasBDF.rsSQLNP( "sp_GetInfoTabla " + rs.getString("Tabla"));
                //UtileriasBDF.ejecutaSQL(StrSentence);

                out.println("<script> location.href='../Operacion/BitacoraExpediente.jsp?clExpediente=" + StrclExpediente + "';</script>");
            } else {
                out.println("No cuenta con Privilegios suficientes para realizar la Operacion");
            }
        }

        if (StrclTipo.equalsIgnoreCase("2")) {
            if (StrPermiteEliminarSeg.equalsIgnoreCase("1")) {
                rsEx = UtileriasBDF.rsSQLNP("sp_CorrigeSegProv " + StrclSeguimientoProveedor + "," + StrclExpediente + "," + StrclEstatus + "," + StrclProveedor + "," + StrUsrApp);
                out.println("<script> location.href='../Operacion/BitacoraExpediente.jsp?clExpediente=" + StrclExpediente + "';</script>");
            } else {
                out.println("No cuenta con Privilegios suficientes para realizar la Operacion");
            }
        }
        if(StrclTipo.equalsIgnoreCase("3")){
            //if (StrPermiteCumplirRec.equalsIgnoreCase("1")) {
                //rsEx = UtileriasBDF.rsSQLNP("st_RecordaCita " + StrclSeguimientoCita + "," + StrclExpediente + "," + StrclEstatus + "," + StrclProveedor + "," + StrUsrApp + "," + StrclRecordatorio);                            
                rsEx = UtileriasBDF.rsSQLNP("st_RecordaCita " + StrclExpediente + "," + StrclEstatus + "," + StrUsrApp + "," + StrclRecordatorio);               
                out.println("<script> location.href='../Operacion/BitacoraExpediente.jsp?clExpediente=" + StrclExpediente + "';</script>");
            //} else {
                //out.println("No cuenta con Privilegios suficientes para realizar el Recordatorio");
            //}
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

    private void alert(String recordatorio_3) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
}
}
