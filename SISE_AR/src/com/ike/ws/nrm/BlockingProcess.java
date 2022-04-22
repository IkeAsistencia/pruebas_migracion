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

@WebServlet(name = "BlockingProcess", urlPatterns = {"/servlet/com.ike.ws.nrm.BlockingProcess"}, asyncSupported = true)
public class BlockingProcess extends HttpServlet{
    
    private String command = "";
    private Integer clVinTspPseudo = 0;
    private String vinTspPseudo = "";
    private String event = "";
    
     protected void processRequest(HttpServletRequest request, final HttpServletResponse response) {
         if (request.getParameter("command") != null) {
            command = request.getParameter("command");
        }
        if (request.getParameter("clVinTspPseudo") != null) {
            clVinTspPseudo = Integer.parseInt(request.getParameter("clVinTspPseudo"));
        }
        if (request.getParameter("vinTspPseudo") != null) {
            vinTspPseudo = request.getParameter("vinTspPseudo");
        }
        if (request.getParameter("event") != null) {
            event = request.getParameter("event");
        }

        System.out.println("Command: " + command);
        System.out.println("ClVinTspPseudo: " + clVinTspPseudo);
        System.out.println("VinTspPseudo: " + vinTspPseudo);
        System.out.println("Event: " + event);
        
        if(event.equals("blocking")){
            try (PrintWriter salida = response.getWriter()) {
                WSBlockingNrm blockingNrm = new WSBlockingNrm();
                JSONObject result = blockingNrm.blocking(command, vinTspPseudo, clVinTspPseudo);
                System.out.println("JSON Blocking: " + result);
                salida.println(result.toString());
            } catch (IOException ex) {
                Logger.getLogger(TrackingProcess.class.getName()).log(Level.SEVERE, null, ex);
            }
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
