/*
 * ActualizaTipoHrio.java
 *
 * Created on 22 de diciembre de 2004, 03:38 PM
 */

package Seguridad;

import java.sql.ResultSet;
import Utilerias.UtileriasBDF;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;

/*
 *
 * @author  sotelom
 * @version
 */
public class ActualizaTipoHrio extends HttpServlet {
   
    Horario horario = new Horario();

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
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        Connection con = null;
        
        con = UtileriasBDF.getConnection();
        
        String txtTipoHorario = request.getParameter("txtTipoHorario");
        String chkLunes = request.getParameter("chkLunes");
        String txtLunIni = EsNulo(request.getParameter("txtLunIni"));
        String txtLunFin = EsNulo(request.getParameter("txtLunFin"));
        String chkMartes = request.getParameter("chkMartes");
        String txtMarIni = EsNulo(request.getParameter("txtMarIni"));
        String txtMarFin = EsNulo(request.getParameter("txtMarFin"));
        String chkMiercoles = request.getParameter("chkMiercoles");
        String txtMierIni = EsNulo(request.getParameter("txtMierIni"));
        String txtMierFin = EsNulo(request.getParameter("txtMierFin"));
        String chkJueves = request.getParameter("chkJueves");
        String txtJueIni = EsNulo(request.getParameter("txtJueIni"));
        String txtJueFin = EsNulo(request.getParameter("txtJueFin"));
        String chkViernes = request.getParameter("chkViernes");
        String txtVieIni = EsNulo(request.getParameter("txtVieIni"));
        String txtVieFin = EsNulo(request.getParameter("txtVieFin"));
        String chkSabado = request.getParameter("chkSabado");
        String txtSabIni = EsNulo(request.getParameter("txtSabIni"));
        String txtSabFin = EsNulo(request.getParameter("txtSabFin"));
        String chkDomingo = request.getParameter("chkDomingo");
        String txtDomIni = EsNulo(request.getParameter("txtDomIni"));
        String txtDomFin = EsNulo(request.getParameter("txtDomFin"));

        
        // TODO output your page here
        
        out.println("<html>");
        out.println("<head>");
        out.println("<title>Servlet</title>");
        out.println("</head>");
        out.println("<body>");
        if (request.getParameter("Action")==null){
            out.println("Problema con la definición de la acción a realizar, por favor vuelva a intentarlo");
            out.println("</body>");            
            out.println("</html>");      
            out.close();
            return;            
        }
        String cveTipoHorario="";
        //Si es una Alta
        if (Integer.parseInt(request.getParameter("Action"))==1){
            cveTipoHorario=AltaTipoHorario(con, txtTipoHorario,chkLunes,txtLunIni,txtLunFin,chkMartes,txtMarIni,txtMarFin, 
                                           chkMiercoles,txtMierIni,txtMierFin,chkJueves,txtJueIni,txtJueFin, 
                                           chkViernes,txtVieIni,txtVieFin,chkSabado,txtSabIni,txtSabFin,
                                           chkDomingo,txtDomIni,txtDomFin);  
            
        }
        //Si es un cambio  
        if (Integer.parseInt(request.getParameter("Action"))==2){
            cveTipoHorario = request.getParameter("clTipoHorario");
            //String str="";

            CambioTipoHorario(con, txtTipoHorario,cveTipoHorario,chkLunes,txtLunIni,txtLunFin,chkMartes,txtMarIni,txtMarFin, 
                                           chkMiercoles,txtMierIni,txtMierFin,chkJueves,txtJueIni,txtJueFin, 
                                           chkViernes,txtVieIni,txtVieFin,chkSabado,txtSabIni,txtSabFin,
                                           chkDomingo,txtDomIni,txtDomFin);
            //out.println(str);
             
        }
       //Si es una Baja    
        if (Integer.parseInt(request.getParameter("Action"))==3){
           cveTipoHorario = request.getParameter("clTipoHorario");
           Elimina(con, cveTipoHorario);
          //  out.println("hola");            
        }
        String strUrlBack="";
        if(request.getParameter("URLBACK")!=null){
            strUrlBack = request.getParameter("URLBACK");
            out.println("<script> window.opener.fnValidaResponse(1,'"+ strUrlBack +"clTipoHorario="+ cveTipoHorario + "')</script>");
        }
        out.println("</body>");
        out.println("</html>");
        try 
        {
          con.close();
        }catch (Exception e)
        {
          e.printStackTrace();
        }
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
    
    public String AltaTipoHorario(Connection con, String pstrDescTipoHrio ,String pDia1,String pstrHrIni1 ,String pstrHrFin1, 
                                                        String pDia2,String pstrHrIni2 ,String pstrHrFin2,
                                                        String pDia3,String pstrHrIni3 ,String pstrHrFin3,
                                                        String pDia4,String pstrHrIni4 ,String pstrHrFin4,
                                                        String pDia5,String pstrHrIni5 ,String pstrHrFin5,
                                                        String pDia6,String pstrHrIni6 ,String pstrHrFin6,
                                                        String pDia7,String pstrHrIni7 ,String pstrHrFin7
                                                        ){
        
         String strLlave="";  
          try{                                                  
              ResultSet rs = UtileriasBDF.rsSQLNP( "sp_AltaTipoHorario '" + pstrDescTipoHrio + "'," + pDia1 + ",'" + pstrHrIni1 + "','" + pstrHrFin1 
                                                                    + "'," + pDia2 + ",'" + pstrHrIni2 + "','" +pstrHrFin2 
                                                                    + "'," + pDia3 + ",'" + pstrHrIni3 + "','" +pstrHrFin3 
                                                                    + "'," + pDia4 + ",'" + pstrHrIni4 + "','" +pstrHrFin4 
                                                                    + "'," + pDia5 + ",'" + pstrHrIni5 + "','" +pstrHrFin5 
                                                                    + "'," + pDia6 + ",'" + pstrHrIni6 + "','" +pstrHrFin6 
                                                                    + "'," + pDia7 + ",'" + pstrHrIni7 + "','" +pstrHrFin7 + "'"); 
              if(rs.next()){
                 strLlave = rs.getString("Llave");
              }  
              rs.close();
           }catch(Exception e){
            e.printStackTrace();
            try 
            {
              con.close();
            }catch (Exception ee)
            {
              ee.printStackTrace();
            }
          }

           return strLlave;
           //return str; 
    }
    
    
    public void CambioTipoHorario(Connection con, String pstrDescTipoHrio,String  pintcvTipoHrio,String pDia1,String pstrHrIni1 ,String pstrHrFin1, 
                                                        String pDia2,String pstrHrIni2 ,String pstrHrFin2,
                                                        String pDia3,String pstrHrIni3 ,String pstrHrFin3,
                                                        String pDia4,String pstrHrIni4 ,String pstrHrFin4,
                                                        String pDia5,String pstrHrIni5 ,String pstrHrFin5,
                                                        String pDia6,String pstrHrIni6 ,String pstrHrFin6,
                                                        String pDia7,String pstrHrIni7 ,String pstrHrFin7
                                                        ){
                                                              
          try{
             UtileriasBDF.ejecutaSQLNP( "sp_CambioTipoHorario '" + pstrDescTipoHrio + "'," + pintcvTipoHrio + "," + pDia1 + ",'" + pstrHrIni1 + "','" +pstrHrFin1 
                                                                    + "'," + pDia2 + ",'" + pstrHrIni2 + "','" +pstrHrFin2 
                                                                    + "'," + pDia3 + ",'" + pstrHrIni3 + "','" +pstrHrFin3 
                                                                    + "'," + pDia4 + ",'" + pstrHrIni4 + "','" +pstrHrFin4 
                                                                    + "'," + pDia5 + ",'" + pstrHrIni5 + "','" +pstrHrFin5 
                                                                    + "'," + pDia6 + ",'" + pstrHrIni6 + "','" +pstrHrFin6 
                                                                    + "'," + pDia7 + ",'" + pstrHrIni7 + "','" +pstrHrFin7 + "'");                                                                  
          }catch( Exception e)
          {
            e.printStackTrace();
            try 
            {
              con.close();
            }catch (Exception ee)
            {
              ee.printStackTrace();
            }
          }
    }
    
    public void Elimina(Connection con, String pintcvTipoHrio){
      try{
        UtileriasBDF.ejecutaSQLNP( "sp_EliminaTipoHorario " + pintcvTipoHrio);
      }catch(Exception e)
      {
        e.printStackTrace();        
        try 
        {
          con.close();
        }catch (Exception ee)
        {
          ee.printStackTrace();
        }
      }
    }
    
    private String EsNulo(String pStr){
        if (pStr==null){
            return "";
        }else{
            if (pStr.equalsIgnoreCase("")){
                return "0";
            }
            else{
                return pStr;
            }
        }
    }
}
