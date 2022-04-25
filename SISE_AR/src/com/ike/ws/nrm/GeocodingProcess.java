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

@WebServlet(name = "GeocodingProcess", urlPatterns = {"/servlet/com.ike.ws.nrm.GeocodingProcess"})
public class GeocodingProcess extends HttpServlet{
    
    private String latitud;
    private String longitud;
    
    protected void processRequest(HttpServletRequest request, final HttpServletResponse response) {
        System.out.println("Entro a Geocoding...");
        if (request.getParameter("latitud") != null) {
            latitud = request.getParameter("latitud");
        }
        if (request.getParameter("longitud") != null) {
            longitud = request.getParameter("longitud");
        }
        
        System.out.println("Latitud: " + latitud);
        System.out.println("Longitud: " + longitud);
        
        try (PrintWriter salida = response.getWriter()) {
                WSGeocodingNrm geocodingNrm = new WSGeocodingNrm();
                String result = geocodingNrm.geocoding(latitud, longitud);
                System.out.println("Geocoding Ubicacion: " + result);
                salida.println(result);
            } catch (IOException ex) {
                Logger.getLogger(TrackingProcess.class.getName()).log(Level.SEVERE, null, ex);
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


