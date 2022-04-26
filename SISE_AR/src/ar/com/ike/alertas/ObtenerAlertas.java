package ar.com.ike.alertas;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.ParseException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "ObtenerAlertas", urlPatterns = "/servlet/ObtenerAlertas")
public class ObtenerAlertas extends HttpServlet {
//------------------------------------------------------------------------------    
    private Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
//------------------------------------------------------------------------------    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        HttpSession sessionH = request.getSession(false);
        // Si no hay session devolvemos forbidden
        if (sessionH == null) {
            response.setStatus(403);
            return;
            }        
        Object objClUsrApp = sessionH.getAttribute("clUsrApp");
        Integer clUsrApp = objClUsrApp == null ? null : Integer.parseInt(objClUsrApp.toString());
        // Si la session no tiene usuario, devolvemos  forbidden
        if (clUsrApp == null || clUsrApp == 0) {
            response.setStatus(403);
            return;
            }
        Alertas alertas;
        try {    alertas = AlertasService.ObtenerAlertas(clUsrApp);
        } catch(SQLException e) {
            response.setStatus(500);
            return;
        } catch(ParseException e) {
            response.setStatus(500);
            return;
        }        
        String alertasJsonString = gson.toJson(alertas);
        PrintWriter out = response.getWriter();
        out.print(alertasJsonString);
        out.flush();
    }
//------------------------------------------------------------------------------    
    @Override
    protected void doGet(
      HttpServletRequest request, 
      HttpServletResponse response) throws IOException {
        processRequest(request, response);
    }
//------------------------------------------------------------------------------
}