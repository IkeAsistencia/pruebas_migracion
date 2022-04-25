/*
 * AltaServExterno.java
 *
 * Created on 25 de julio de 2005, 12:59 PM
 */

package Utilerias;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.ServletConfig;
import java.sql.ResultSet;
import java.io.PrintWriter;

/*import java.io.*;
import java.net.*;
 
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
 */
/*
 *
 * @author  cabrerar
 * @version
 */
public class AltaServExterno extends HttpServlet
{
    
    /* Initializes the servlet.
     */
    
    public void init(ServletConfig config) throws ServletException
    {
        super.init(config);
    }
    
    /* Destroys the servlet.
     */
    public void destroy()
    {
        
    }
    
    /* Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException
    {
        HttpSession sessionH = request.getSession(false);
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        com.ike.util.I18N i18n = com.ike.util.I18N.getInstance("es","AR");
        
        out.println("<html>");
        out.println("<head>");
        out.println("<title>Alta Servicio</title>");
        out.println("</head>");
        out.println("<body>");
        
        String strclReporte = "";
        String strclSubservicio = "";
        String strclCuenta = "";
        String strNU = "";
        String strClave = "";
        String strCodEnt = "";
        String strContacto = "";
        String strOcurrido = "";
        String strRef = "";
        String strFechaSin = "";
        String strTel = "";
        String strclExpediente = "";
        String strBack="";
        
        if (request.getParameter("clRepSin")!=null)
        {
            strclReporte = request.getParameter("clRepSin").toString();
        }
        else
        {
            out.println("Debe Informar el Número de Reporte Assentia ");
            return;
        }
        
        if (request.getParameter("clSubServicio")!=null)
        {
            strclSubservicio = request.getParameter("clSubServicio").toString();
        }
        else
        {
            out.println("Debe Informar el Subservicio Solicitado ");
            return;
        }
        
        if (request.getParameter("clCuenta")!=null)
        {
            strclCuenta = request.getParameter("clCuenta").toString();
        }
        else
        {
            out.println("Debe Informar la Aseguradora ");
            return;
        }
        
        if (request.getParameter("NU")!=null)
        {
            strNU = request.getParameter("NU").toString();
        }
        else
        {
            out.println("Debe Informar el nombre de Nuestro Usuario ");
            return;
        }
        
        if (request.getParameter("Clave")!=null)
        {
            strClave = request.getParameter("Clave").toString();
        }
        else
        {
            out.println("Debe Informar el Número de Siniestro ");
            return;
        }
        
        if (request.getParameter("CodEnt")!=null)
        {
            strCodEnt = request.getParameter("CodEnt").toString();
        }
        else
        {
            out.println("Debe informar la " + i18n.getMessage("message.title.entidad"));
            return;
        }
        
        if (request.getParameter("Contacto")!=null)
        {
            strContacto = request.getParameter("Contacto").toString();
        }
        else
        {
            out.println("Debe Informar el Nombre de Quien Llama ");
            return;
        }
        
        if (request.getParameter("Ocurrido")!=null)
        {
            strOcurrido = request.getParameter("Ocurrido").toString();
        }
        
        if (request.getParameter("FechaReal")!=null)
        {
            strFechaSin = request.getParameter("FechaReal").toString();
        }
        else
        {
            out.println("Debe Informar La fecha real del Siniestro ");
            return;
        }
        
        if (request.getParameter("TelContacto")!=null)
        {
            strTel = request.getParameter("TelContacto").toString();
        }
        else
        {
            out.println("Debe Informar el Teléfono de Contacto");
            return;
        }
        
        if (request.getParameter("Referencia")!=null)
        {
            strRef= request.getParameter("Referencia").toString();
        }
        ResultSet rsEx = null;
//            out.println("sp_WebAddServicioSolicxRep 1, " + strclReporte +  ",18, " + strclSubservicio + "," + strclCuenta + ",'" + strNU + "','" + strClave + "','" + strCodEnt + "','" + strContacto + "','" + strOcurrido + "','" + strRef + "','" + strFechaSin + "','" + strTel + "'");
        try
        {
            rsEx = UtileriasBDF.rsSQLNP("sp_WebAddServicioSolicxRep 1, " + strclReporte +  ",18, " + strclSubservicio + "," + strclCuenta + ",'" + strNU + "','" + strClave + "','" + strCodEnt + "','" + strContacto + "','" + strOcurrido + "','" + strRef + "','" + strFechaSin + "','" + strTel + "'");
            if (rsEx.next())
            {
                if (rsEx.getString("clExpediente")!=null)
                {
                    strclExpediente = rsEx.getString("clExpediente").toString();
                    if (strclExpediente.compareToIgnoreCase("0")==0)
                    {
                        out.println("<p class='class='cssTitDet'>"+ rsEx.getString("Mensaje").toString() +"</p>");
                        out.println("</body>");
                        out.println("</html>");
                        return;
                    }
                }
                else
                {
                    out.println("<p class='class='cssTitDet'>Error en la transacción, favor de consultarlo con su administrador</p>");
                    out.println("</body>");
                    out.println("</html>");
                    return;
                }
            }
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        String strUrlBack="";
        if(request.getParameter("URLBACK")!=null)
        {
            strUrlBack = request.getParameter("URLBACK");
            //System.out.println(strUrlBack);
            out.println("<script> //'"+ strUrlBack +"'</script>");
            out.println("<script> window.opener.fnValidaResponse(1,'http://cabrerar/Des_Assentia/AltaServ.php?clRepSin="+strclReporte+"&clExpediente=" + strclExpediente + "&clSubservicio=" + strclSubservicio +"','11')</script>");
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
    throws ServletException, IOException
    {
        processRequest(request, response);
    }
    
    /* Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException
    {
        processRequest(request, response);
    }
    
    /* Returns a short description of the servlet.
     */
    public String getServletInfo()
    {
        return "Short description";
    }
    
}
