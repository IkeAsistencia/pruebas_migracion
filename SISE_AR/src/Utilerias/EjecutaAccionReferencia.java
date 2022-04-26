/*
 * Referencia.java
 * 
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
 * @author  cabrerar
 * @version
 */
public class EjecutaAccionReferencia extends HttpServlet {
    
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
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        out.println("<html>");
        out.println("<head>");
        out.println("<title>Guarda Referencia por Expediente</title>");
        out.println("</head>");
        out.println("<body>");
                        
        String StrclExpediente ="";
        String StrclReferencia ="";
        String StrclRefxCta ="";
        String StrURLBACK =""; 
        String StrclUsrApp="";
        String StrclServicio = ""; 
        String StrclSubservicio = "";  
        String StrSentence = "";
        String StrLlave =""; 
        
        if (sessionH.getAttribute("clUsrApp")!=null){
            StrclUsrApp = sessionH.getAttribute("clUsrApp").toString();
        }else{
            out.println("<p class='class='cssTitDet'>No se ha iniciado sesión, favor de consultarlo con su administrador</p>");
            out.println("</body>");
            out.println("</html>");
            out.close();
            return;
        }                
        
        if (sessionH.getAttribute("clExpediente")!=null){
            StrclExpediente = sessionH.getAttribute("clExpediente").toString();
            //out.println("Exp="+StrclExpediente);
        }else{
            out.println("<p class='class='cssTitDet'>No existe el expediente, favor de consultarlo con su administrador</p>");
            out.println("</body>");
            out.println("</html>");
            out.close();
            return;
        }  
        
        if (sessionH.getAttribute("clServicio")!=null){
            StrclServicio = sessionH.getAttribute("clServicio").toString();
            //out.println("Ser="+StrclServicio);
        }else{
            out.println("<p class='class='cssTitDet'>No se ha encontrado Servicio, favor de consultarlo con su administrador</p>");
            out.println("</body>");
            out.println("</html>");
            out.close();
            return;
        }  
        if (sessionH.getAttribute("clSubServicio")!=null){
            StrclSubservicio = sessionH.getAttribute("clSubServicio").toString();
            //out.println("Subser="+StrclSubservicio);
        }else{
            out.println("<p class='class='cssTitDet'>No se ha encontrado Subservicio, favor de consultarlo con su administrador</p>");
            out.println("</body>");
            out.println("</html>");
            out.close();
            return;
        }  
        
        if (request.getParameter("clReferencia")!= null) {
            StrclReferencia = request.getParameter("clReferencia").toString();
            //out.println("Ref="+StrclReferencia);
        }else{
            out.println("<p class='class='cssTitDet'>No se encuentra clReferencia, favor de consultarlo con su administrador</p>");
            out.println("</body>");
            out.println("</html>");
            out.close();
            return;
        }  
        
         if (request.getParameter("clRefxCta")!= null) {
            StrclRefxCta = request.getParameter("clRefxCta").toString();            
            //out.println("RefCta="+StrclRefxCta);
        }
        if (StrclRefxCta.equals("")){
            StrclRefxCta = "''";
        }
               
    
        StrSentence = "sp_GuardaReferenciaxExp " + StrclExpediente +"," + StrclReferencia + "," + StrclRefxCta + "," + StrclServicio + "," + StrclSubservicio;
        //rsEx = UtileriasBDF.rsSQL("sp_GuardaReferenciaxExp " + StrclExpediente +"," + StrclReferencia + "," + StrclRefxCta);            
        
        try{
            ResultSet rsEx = UtileriasBDF.rsSQLNP(StrSentence + " Select @@Identity Llave ");
            if(rsEx.next()){
                StrLlave="clReferenciaxExpediente=" + rsEx.getString("Llave");
                //out.println("StrLlave="+StrLlave);
            }
        }catch(Exception e){
            out.close();
            e.printStackTrace();
        }

        if(request.getParameter("URLBACK")!=null){
            StrURLBACK = request.getParameter("URLBACK");
            out.println(StrURLBACK + StrLlave);
            //out.println("<script> //'"+ strUrlBack + strBack +"'</script>");             
            out.println("<script> window.opener.fnValidaResponse(1,'"+ StrURLBACK + StrLlave +"')</script>");                    
        }        
        else{
            out.println("<p class='class='cssTitDet'>Error en la transacción, favor de consultarlo con su administrador</p>");
            out.println("</body>");
            out.println("</html>");
            out.close();
            return;
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
