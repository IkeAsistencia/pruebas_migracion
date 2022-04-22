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
 * @author  rodrigus
 * @version
 */
public class EjecutaLlamAltaAfilDur extends HttpServlet {
    
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

        //VARIABLES DECLARADAS SEGUN LOS CAMPOS QUE LA PÁGINA LLAMADAALTANUDUR.JSP CAPTURA

        String clAfiliadoNU = "0";
        String StrclLlamaAltaNU ="0";
        String StrclCuenta = "0";
        String StrClave = "";
        String StrNombre = "";
        String StrFechaCompra = "";
        String StrTelefono = "";
        String StrEmpresa = "";
        String StrclAcumulador = "";
        String StrSerieAcumulador = "";
        String StrCodigoMarca = "";
        String StrClaveAMIS = "";
        String StrModelo = "";
        String StrCodEnt = "";
        String StrCodMD = "0"; 
        String StrColonia = "";
        String StrCalle = "";
        String StrCP = "";
      
        ResultSet rsEx = null;
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        out.println("<html>");
        out.println("<head>");
        out.println("<title>Llamada Alta Duracell</title>");
        out.println("</head>");
        out.println("<body>");

       /*if (sessionH.getAttribute("clUsrApp")!=null){
                   StrUsrApp = sessionH.getAttribute("clUsrApp").toString();
                } */
        if(request.getParameter("clAfiliadoNU")!=null){
            clAfiliadoNU = request.getParameter("clAfiliadoNU"); 
        }
       
       if(request.getParameter("clLlamaAltaNU")!=null){
            StrclLlamaAltaNU = request.getParameter("clLlamaAltaNU");
        }

        if(request.getParameter("clCuenta")!=null){
            StrclCuenta = request.getParameter("clCuenta"); 
        }

        if(request.getParameter("Clave")!=null){
            StrClave = request.getParameter("Clave");
        }

         if(request.getParameter("Nombre")!=null){
            StrNombre = request.getParameter("Nombre");
        }
         if(request.getParameter("FechaCompra")!=null){
            StrFechaCompra = request.getParameter("FechaCompra");
        }
        if(request.getParameter("Telefono")!=null){
            StrTelefono = request.getParameter("Telefono");
        }

        if(request.getParameter("Empresa")!=null){
            StrEmpresa = request.getParameter("Empresa");
        }

        if(request.getParameter("clAcumulador")!=null){
            StrclAcumulador = request.getParameter("clAcumulador");
        }
      
        if(request.getParameter("SerieAcumulador")!=null){
            StrSerieAcumulador = request.getParameter("SerieAcumulador");
        }

        if(request.getParameter("CodigoMarca")!=null){
            StrCodigoMarca = request.getParameter("CodigoMarca");
        }

        if(request.getParameter("ClaveAMIS")!=null){
            StrClaveAMIS = request.getParameter("ClaveAMIS");
        }

        if(request.getParameter("Modelo")!=null){
            StrModelo = request.getParameter("Modelo");
        }

        if(request.getParameter("CodEnt")!=null){
           StrCodEnt = request.getParameter("CodEnt");
        }

        if(request.getParameter("CodMD")!=null){
            StrCodMD = request.getParameter("CodMD");
        }
        if(request.getParameter("Colonia")!=null){
            StrColonia = request.getParameter("Colonia");
        }
        
        if(request.getParameter("Calle")!=null){
            StrCalle = request.getParameter("Calle");
        
        }
          if(request.getParameter("CP")!=null){
            StrCP = request.getParameter("CP");
        }
        
              try{
                    String strUrlBack=""; 
                    if(request.getParameter("URLBACK")!=null)
                    {
                          strUrlBack = request.getParameter("URLBACK");
                          
                    }
                   if (Integer.parseInt(request.getParameter("Action"))==1)
                   {
                   
                      rsEx = UtileriasBDF.rsSQLNP("sp_AddLlamAltaAfilDur '','" + StrclCuenta + "','" + StrClave + "','" + StrNombre + "','" + StrFechaCompra + "','" + StrTelefono + "','" + StrEmpresa + "','" + StrclAcumulador + "','" + StrSerieAcumulador + "','" + StrCodigoMarca + "','" + StrClaveAMIS + "','" + StrModelo + "','" + StrCodEnt + "','" + StrCodMD +  "','" + StrColonia + "','" + StrCalle + "','" +  StrCP + "'");
                      if (rsEx.next())
                        {
                             StrclLlamaAltaNU = rsEx.getString("clLlamaAltaNU"); 
                        }  
                       strUrlBack=strUrlBack + "&clLlamaAltaNU=" + StrclLlamaAltaNU ;
                       out.println("<script>window.opener.fnValidaResponse(1,'"+ strUrlBack +"')</script>");  
                   }
                   else
                   {
                      if(Integer.parseInt(request.getParameter("Action"))==2)
                        {
                          rsEx = UtileriasBDF.rsSQLNP("sp_UpdateLlamAltaAfilDur '" + StrclLlamaAltaNU +"','" + clAfiliadoNU + "','" + StrNombre + "','"  + StrTelefono + "','" +  StrEmpresa + "','" + StrclAcumulador + "','" + StrSerieAcumulador + "','" + StrCodigoMarca + "','" + StrClaveAMIS + "','" + StrModelo + "','" + StrCodEnt + "','" + StrCodMD +  "','" + StrColonia + "','" + StrCalle + "','" +  StrCP + "'");
                          strUrlBack=strUrlBack + "&clLlamaAltaNU=" + StrclLlamaAltaNU ;
                          out.println("<script>window.opener.fnValidaResponse(1,'"+ strUrlBack +"')</script>");  
                        }
                   }
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