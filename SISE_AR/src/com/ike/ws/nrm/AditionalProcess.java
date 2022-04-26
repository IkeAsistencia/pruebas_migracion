package com.ike.ws.nrm;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.simple.JSONObject;

/**
 *
 * @author vrayon
 */
@WebServlet(name = "AditionalProcess", urlPatterns = {"/servlet/com.ike.ws.nrm.AditionalProcess"})
public class AditionalProcess extends HttpServlet{
    
    private String vinTspPseudo = "";
    private String vin = "";
    private String event = "";
    
    protected void processRequest(HttpServletRequest request, final HttpServletResponse response) {
        
        if (request.getParameter("vinTspPseudo") != null) {
            vinTspPseudo = request.getParameter("vinTspPseudo");
        }
        
        if (request.getParameter("vin") != null) {
            vin = request.getParameter("vin");
        }
        
        if(request.getParameter("event") != null){
            event = request.getParameter("event");
        }
        
        System.out.println("VinTspPseudo: " + vinTspPseudo);
        System.out.println("Event: " + event);
        
        if (event.equals("crypt")) {
            try (PrintWriter salida = response.getWriter()) {
                WSClientsNrm clientsNrm = new WSClientsNrm();
                String result = clientsNrm.getVinTspPSeudoXVin(vin);
                System.out.println("VinTspPseudo: " + result);
                salida.println(result);
            } catch (IOException ex) {
                Logger.getLogger(TrackingProcess.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        
        if (event.equals("decrypt")) {
             try (PrintWriter salida = response.getWriter()) {
                WSClientsNrm clientsNrm = new WSClientsNrm();
                String result = clientsNrm.getVinXVinTspPseudo(vinTspPseudo);
                System.out.println("Vin: " + result);
                salida.println(result);
            } catch (IOException ex) {
                Logger.getLogger(TrackingProcess.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        
        if (event.equals("vehicleInfo")) {
            
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }
}
