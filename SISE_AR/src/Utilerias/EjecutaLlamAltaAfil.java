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
public class EjecutaLlamAltaAfil extends HttpServlet {
    
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
        String StrclCuenta = "0";
        String clAfiliadoNU = "0";
        String StrclLlamaAlta = "0";//Variable Update
        String StrClave = "";
        String StrNombre = "";
        String StrclLlamaAltaNU ="0";//Variable de URLBack
        String StrFechNac = "";
        String StrCodEnt = "";
        String StrCodMD = "0";
        String StrColonia = "";
        String StrCalle = "";
        String StrCP ="";
        String StrTelefono ="";
        String StrEmpresa ="";
        String StrFechaAlt = "";
        String StrRfc = "";
        String StrCelular = "";
        
        ResultSet rsEx = null;

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        out.println("<html>");
        out.println("<head>");
        out.println("<title>Ejecuta Llam Alta Afil</title>");
        out.println("</head>");
        out.println("<body>");
        
        if(request.getParameter("clCuenta")!=null){
            StrclCuenta = request.getParameter("clCuenta");
        }
        if(request.getParameter("clAfiliadoNU")!=null){
            clAfiliadoNU = request.getParameter("clAfiliadoNU");
        }
        
        if(request.getParameter("clLlamaAltaNU")!=null){
            StrclLlamaAlta = request.getParameter("clLlamaAltaNU");
            
        }
        if(request.getParameter("Clave")!=null){
            StrClave = request.getParameter("Clave");
            
        }
        
        if(request.getParameter("Nombre")!=null){
            StrNombre = request.getParameter("Nombre");
            
        }
        if(request.getParameter("FechNac")!=null){
            StrFechNac = request.getParameter("FechNac");
            
        }
        if(request.getParameter("CodEnt")!=null){
            StrCodEnt = request.getParameter("CodEnt");
            
        }
        if(request.getParameter("CodMD")!=null){
            StrCodMD = request.getParameter("CodMD");
            
        }
        if(request.getParameter("Colonia")!=null){
            StrColonia = request.getParameter("Colonia");
            
        } if(request.getParameter("Calle")!=null){
            StrCalle = request.getParameter("Calle");
            
        }
        if(request.getParameter("CP")!=null){
            StrCP = request.getParameter("CP");
            
        }
        if(request.getParameter("Telefono")!=null){
            StrTelefono = request.getParameter("Telefono");
            
        }
        if(request.getParameter("Empresa")!=null){
            StrEmpresa = request.getParameter("Empresa");
            
        }
        if(request.getParameter("FechaAlta")!=null){
            StrFechaAlt = request.getParameter("FechaAlt");
            
        }
        if(request.getParameter("RFC")!=null){
            StrRfc = request.getParameter("RFC");
            
        }
        if(request.getParameter("Celular")!=null){
            StrCelular = request.getParameter("Celular");
            
        }
        
        try{
            String strUrlBack="";
            if(request.getParameter("URLBACK")!=null) {
                strUrlBack = request.getParameter("URLBACK");
                
            }
            if (Integer.parseInt(request.getParameter("Action"))==1) {
                rsEx = UtileriasBDF.rsSQLNP("sp_AddLlamAltaAfil '" + StrclCuenta.toString().trim() + "','" + StrClave.toString().trim() + "','" + StrNombre.toString().trim() + "','" + StrFechNac.toString().trim() + "','" + StrCodEnt.toString().trim() + "','" + StrCodMD.toString().trim() + "','" + StrColonia.toString().trim() + "','" + StrCalle.toString().trim() + "','" + StrCP.toString().trim() + "','" + StrTelefono.toString().trim() + "','" + StrEmpresa.toString().trim() + "','" + StrFechaAlt.toString().trim() + "','" + StrRfc.toString().trim() + "','" + StrCelular.toString().trim() + "'");
           System.out.println("sp_AddLlamAltaAfil '" + StrclCuenta.toString().trim() + "','" + StrClave.toString().trim() + "','" + StrNombre.toString().trim() + "','" + StrFechNac.toString().trim() + "','" + StrCodEnt.toString().trim() + "','" + StrCodMD.toString().trim() + "','" + StrColonia.toString().trim() + "','" + StrCalle.toString().trim() + "','" + StrCP.toString().trim() + "','" + StrTelefono.toString().trim() + "','" + StrEmpresa.toString().trim() + "','" + StrFechaAlt.toString().trim() + "','" + StrRfc.toString().trim() + "','" + StrCelular.toString().trim() + "'");
                if (rsEx.next()) {
                    if(rsEx.getString("clLlamaAltaNU").equalsIgnoreCase("-1")){
                        out.println("<script>alert('La clave "+StrClave+" ya existe en la base de datos, porfavor verifiquela');</script>");                      
                        strUrlBack=strUrlBack + "&clLlamaAltaNU=" + StrclLlamaAltaNU ;
                        out.println("<script>window.opener.fnValidaResponse1(-1,'"+ strUrlBack +"')</script>");
                    }else{ 
                        StrclLlamaAltaNU = rsEx.getString("clLlamaAltaNU"); 
                        strUrlBack=strUrlBack + "&clLlamaAltaNU=" + StrclLlamaAltaNU ;
                        out.println("<script>window.opener.fnValidaResponse1(1,'"+ strUrlBack +"')</script>");
                    }
                }
                
            } else {
                if(Integer.parseInt(request.getParameter("Action"))==2) {
                    rsEx = UtileriasBDF.rsSQLNP("sp_UpdateLlamAltaAfil '" + StrclLlamaAlta.toString().trim() +"','" + clAfiliadoNU.toString().trim() + "','" + StrclCuenta.toString().trim() + "','" + StrClave.toString().trim() + "','" + StrNombre.toString().trim() + "','" + StrFechNac.toString().trim() + "','" + StrCodEnt.toString().trim() + "','" + StrCodMD.toString().trim() + "','" + StrColonia.toString().trim() + "','" + StrCalle.toString().trim() + "','" + StrCP.toString().trim() + "','" + StrTelefono.toString().trim() + "','" + StrEmpresa.toString().trim() + "','" + StrRfc.toString().trim() + "','" + StrCelular.toString().trim() + "'");
             System.out.println("sp_UpdateLlamAltaAfil '" + StrclLlamaAlta.toString().trim() +"','" + clAfiliadoNU.toString().trim() + "','" + StrclCuenta.toString().trim() + "','" + StrClave.toString().trim() + "','" + StrNombre.toString().trim() + "','" + StrFechNac.toString().trim() + "','" + StrCodEnt.toString().trim() + "','" + StrCodMD.toString().trim() + "','" + StrColonia.toString().trim() + "','" + StrCalle.toString().trim() + "','" + StrCP.toString().trim() + "','" + StrTelefono.toString().trim() + "','" + StrEmpresa.toString().trim() + "','" + StrRfc.toString().trim() + "','" + StrCelular.toString().trim() + "'");
                    strUrlBack=strUrlBack + "Cambio=1&clLlamaAltaNU=" + StrclLlamaAlta ;
                    out.println("<script>window.opener.fnValidaResponse(1,'"+ strUrlBack +"')</script>");
                }
            }
        } catch(Exception e){
            out.close();
            e.printStackTrace();
//            this.destroy();
        } finally {
            try{
                if (rsEx!=null) {
                    rsEx.close();
                    rsEx=null;
                }
            } catch(Exception ee) {
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