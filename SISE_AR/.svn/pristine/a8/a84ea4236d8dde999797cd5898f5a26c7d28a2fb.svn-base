/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
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
 * @author rfernandez
 */

public class CSGuardaStatus extends HttpServlet {
  /* Initializes the servlet.
   */
public void init(ServletConfig config) throws ServletException {
        super.init(config);

    }

    /* Destroys the servlet.
     */

    public void destroy() {
    }

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

        String StrclAsistencia ="0";
        String strclCSTipoConclucion = "";


        if (session.getAttribute("clAsistencia")!= null) {
            StrclAsistencia = session.getAttribute("clAsistencia").toString();
        }

        if (request.getParameter("clCSTipoConclucion")!=null){
           strclCSTipoConclucion = request.getParameter("clCSTipoConclucion").toString();
        }
       
        ResultSet rsEx = null;
        String StrURLBACK ="";

          if (request.getParameter("URLBACK1")!=null){
                   StrURLBACK = request.getParameter("URLBACK1").toString();
                }       
        try{
            //System.out.println("st_SCActualizaConclusion " + StrclAsistencia +"," + strclCSTipoConclucion);
            rsEx = UtileriasBDF.rsSQLNP("st_SCActualizaConclusion " + StrclAsistencia +"," + strclCSTipoConclucion);
          
            if (rsEx.next()){
                //System.out.println(rsEx);   
                if (rsEx.getString("Error").equalsIgnoreCase("0")){
                      //out.println("<p class='class='cssTitDet'>"+ rsEx.getString("Mensaje").toString() +"</p>");
                        out.println("</body>");
                        out.println("</html>");
                        out.println("<script>location.href=\"" + StrURLBACK + "\"</script>");
                        out.close();
                        return;                                       
                }else{
                    out.println("<p class='class='cssTitDet'>Error en la transacción, favor de consultarlo con su administrador</p>");
                    out.println("</body>");
                    out.println("</html>");
                    out.close();
                    return;
                }                
            }
            rsEx.close();
        }
        catch(Exception e){
            out.close();
            e.printStackTrace();
//            this.destroy();
        }
        finally
        {
          try{
            if (rsEx!=null)
            {
              rsEx.close();
              rsEx=null;
            }
          }
          catch(Exception ee)
          {
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

