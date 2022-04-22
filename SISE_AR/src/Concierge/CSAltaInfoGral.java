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
import com.ike.concierge.to.ConciergeInfoGral;

public class CSAltaInfoGral extends HttpServlet {
    public void init(ServletConfig config) throws ServletException {
        super.init(config);    }
    public void destroy() {  }
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession sessionH = request.getSession(false);
        ConciergeInfoGral conciergeinfogral = new ConciergeInfoGral();
        PrintWriter out = response.getWriter();   
        String StrUsrApp = "0";
        String clConcierge="0";
        String FechaApAsist="";
        String clAsistencia="0";
        String clAsistenciaG="0";
        ResultSet rsEx = null;
        if (sessionH.getAttribute("clUsrApp")==null){
            out.println("<script> window.opener.fnValidaResponse(-1,'')</script>");
            out.println("Problema al registrar el movimiento, debe iniciar session");
            out.println("</body>");
            out.println("</html>");
	    }
        if (sessionH.getAttribute("clUsrApp")!=null){
            StrUsrApp = sessionH.getAttribute("clUsrApp").toString();   }
        conciergeinfogral.setclEstatus(request.getParameter("clEstatus"));
        conciergeinfogral.setclAsistencia(request.getParameter("clAsistencia"));
        conciergeinfogral.setComentarios(request.getParameter("Comentarios"));
        conciergeinfogral.setInfoSolicitada(request.getParameter("InfoSolicitada"));
        conciergeinfogral.setCiudad(request.getParameter("Ciudad"));
        conciergeinfogral.setEstado(request.getParameter("Estado"));
        conciergeinfogral.setPais(request.getParameter("Pais"));
        conciergeinfogral.setFechaInicio(request.getParameter("FechaInicio"));
        conciergeinfogral.setFechaTermino(request.getParameter("FechaTermino"));
        conciergeinfogral.setCorreo(request.getParameter("Correo"));
        conciergeinfogral.setOtro(request.getParameter("Otro"));
        conciergeinfogral.setArchEnviado(request.getParameter("ArchEnviado"));
        conciergeinfogral.setUbicacion(request.getParameter("Ubicacion"));
        conciergeinfogral.setClTipoInfoBrindada(request.getParameter("clTipoInfoBrindada"));
        if(request.getParameter("clConcierge")!=null){
            clConcierge = request.getParameter("clConcierge").trim();     }
        if(request.getParameter("FechaApAsist")!=null){
            FechaApAsist = request.getParameter("FechaApAsist").trim();     }
        if(request.getParameter("clAsistencia")!=null){
            clAsistenciaG = request.getParameter("clAsistencia").trim();     }
        response.setContentType("text/html");
        out.println("<html>");
        out.println("<head>");
        out.println("<title>RegistraLlamadaConcierge</title>");
        out.println("</head>");
        out.println("<body>");
        try{
            StringBuffer strSQL = new StringBuffer();
            String strUrlBack="";
            if(request.getParameter("URLBACK")!=null) {
                strUrlBack = request.getParameter("URLBACK");        }
            if (Integer.parseInt(request.getParameter("Action"))==1){
                strSQL.append("st_CSAltaInfoGral '").append(clConcierge).append("'");
		strSQL.append(",'").append(FechaApAsist).append("'");
		strSQL.append(",'").append(StrUsrApp).append("'");
                strSQL.append(",'").append(conciergeinfogral.getclEstatus()).append("'");
                strSQL.append(",'").append(conciergeinfogral.getComentarios()).append("'");
                strSQL.append(",'").append(conciergeinfogral.getInfoSolicitada()).append("'");
                strSQL.append(",'").append(conciergeinfogral.getCiudad()).append("'");
                strSQL.append(",'").append(conciergeinfogral.getEstado()).append("'");
                strSQL.append(",'").append(conciergeinfogral.getPais()).append("'");
                strSQL.append(",'").append(conciergeinfogral.getFechaInicio()).append("'");
                strSQL.append(",'").append(conciergeinfogral.getFechaTermino()).append("'");
                strSQL.append(",'").append(conciergeinfogral.getCorreo()).append("'");
                strSQL.append(",'").append(conciergeinfogral.getOtro()).append("'");
                strSQL.append(",'").append(conciergeinfogral.getArchEnviado()).append("'");
                strSQL.append(",'").append(conciergeinfogral.getUbicacion()).append("'");
                strSQL.append(",'").append(conciergeinfogral.getClTipoInfoBrindada()).append("'");
                rsEx = UtileriasBDF.rsSQLNP(strSQL.toString());
                
                System.out.println(strSQL);
                
                strSQL.delete(0,strSQL.length());
                if (rsEx.next()) {
                    clAsistencia=rsEx.getString("clAsistencia"); }
                if (!clAsistencia.equalsIgnoreCase("0")){
                    if(request.getParameter("URLBACK")!=null){
                        strUrlBack = request.getParameter("URLBACK");
                        strUrlBack=strUrlBack + "&clAsistencia=" + clAsistencia ;
                        out.println("<script> window.opener.fnValidaResponse(1,'"+ strUrlBack  +"')</script>");
                        }
                }else {
                    out.println("<script> window.opener.fnValidaResponse(-1,'')</script>");
                    out.println("Problema al registrar el movimiento,Consulte a su Administrador");
                    out.println("</body>");
                    out.println("</html>");
                    out.close();
                    return;
                }
            }
            if (Integer.parseInt(request.getParameter("Action"))==2){
                strSQL.append("st_CSUpdateInfoGral '").append(clAsistenciaG).append("'");               
                strSQL.append(",'").append(conciergeinfogral.getComentarios()).append("'");
                strSQL.append(",'").append(conciergeinfogral.getInfoSolicitada()).append("'");
                strSQL.append(",'").append(conciergeinfogral.getCiudad()).append("'");
                strSQL.append(",'").append(conciergeinfogral.getEstado()).append("'");
                strSQL.append(",'").append(conciergeinfogral.getPais()).append("'");
                strSQL.append(",'").append(conciergeinfogral.getFechaInicio()).append("'");
                strSQL.append(",'").append(conciergeinfogral.getFechaTermino()).append("'");
                strSQL.append(",'").append(conciergeinfogral.getCorreo()).append("'");
                strSQL.append(",'").append(conciergeinfogral.getOtro()).append("'");
                strSQL.append(",'").append(conciergeinfogral.getArchEnviado()).append("'");
                strSQL.append(",'").append(conciergeinfogral.getUbicacion()).append("'");
                strSQL.append(",'").append(conciergeinfogral.getclEstatus()).append("'");
                strSQL.append(",'").append(conciergeinfogral.getClTipoInfoBrindada()).append("'");
                rsEx = UtileriasBDF.rsSQLNP(strSQL.toString());
                strSQL.delete(0,strSQL.length());
                    if (rsEx.next()) {
                    clAsistencia=rsEx.getString("clAsistencia");  }
                if (!clAsistencia.equalsIgnoreCase("0")){
                    if(request.getParameter("URLBACK")!=null){
                        strUrlBack = request.getParameter("URLBACK");
                        strUrlBack=strUrlBack + "&clAsistencia=" + clAsistencia ;
                        out.println("<script> window.opener.fnValidaResponse(1,'"+ strUrlBack  +"')</script>");
                    }
                }else {
                    out.println("<script> window.opener.fnValidaResponse(-1,'')</script>");
                    out.println("Problema al Actualizar el Registro,Consulte a su Administrador");
                    out.println("</body>");
                    out.println("</html>");
                    out.close();
                    return;
                }
            }
            StrUsrApp = null;
            strSQL=null;
            clConcierge=null;
            FechaApAsist=null;
        } catch(Exception e){
            out.close();
            e.printStackTrace();
        } finally {
            try{
                if (rsEx!=null) {
                    rsEx.close();
                    rsEx=null;
                    conciergeinfogral=null;
                }
            } catch(Exception ee) {
                ee.printStackTrace();
            }
        }
        out.println("</body>");
        out.println("</html>");
        out.close();
    }
//------------------------------------------------------------------------------
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {    processRequest(request, response);  }
//------------------------------------------------------------------------------
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException { processRequest(request, response);  }
//------------------------------------------------------------------------------
    public String getServletInfo() {    return "Short description";   }
//------------------------------------------------------------------------------
}
