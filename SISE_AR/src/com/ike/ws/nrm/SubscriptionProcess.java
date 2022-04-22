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

@WebServlet(name = "SubscriptionProcess", urlPatterns = {"/servlet/com.ike.ws.nrm.SubscriptionProcess"}, asyncSupported = true)
public class SubscriptionProcess extends HttpServlet {

    private String event = "";
    private String json = "";
    private String vin = "";
    private WSUserNrm userNrm;

    public SubscriptionProcess() {
        super();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) {
        if (request.getParameter("event") != null) {
            event = request.getParameter("event");
        }
        if (request.getParameter("json") != null) {
            json = request.getParameter("json");
        }
        if (request.getParameter("vin") != null) {
            vin = request.getParameter("vin");
        }
        
        System.out.println("Event: " + event);
        System.out.println("Json: " + json);
        System.out.println("Vin: " + vin);

        if (event.equals("request")) {
            try (PrintWriter salida = response.getWriter()) {
                userNrm = new WSUserNrm();
                JSONObject result = userNrm.request(json, vin);
                if(result != null){
                    salida.println(result.toString());
                }
            } catch (IOException ex) {
                Logger.getLogger(SubscriptionProcess.class.getName()).log(Level.SEVERE, null, ex);
            } 
        }

        if (event.equals("forward")) {
             try (PrintWriter salida = response.getWriter()) {
                userNrm = new WSUserNrm();
                JSONObject jSONObject = userNrm.forward(json);
                if(jSONObject != null){
                    salida.println(jSONObject.get("message").toString());
                }else{
                    salida.println("LA PETICION NO HA SIDO REALIZADA SATISFACTORIAMENTE.");
                }
            } catch (IOException ex) {
                Logger.getLogger(SubscriptionProcess.class.getName()).log(Level.SEVERE, null, ex);
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
