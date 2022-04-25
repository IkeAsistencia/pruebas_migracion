/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ar.com.ike.geo.hogar;

import java.io.IOException;
import java.util.regex.Pattern;

/**
 *
 * @author ddiez
 */
public class DireccionGeo {
    public double latitude;
    public double longitude;
    
    public static void main(String[] args) throws IOException, Exception {
        DireccionGeo dg = new DireccionGeo("-34.59144, -58.46867");
        System.out.println(dg.latitude);
        System.out.println(dg.longitude);
    }
    
    public DireccionGeo() {
        this.latitude = 0.0d;
        this.longitude = 0.0d;        
    }
    
    public DireccionGeo(String latLong) {
        try {
            String[] result = latLong.split( Pattern.quote(",") );
            this.latitude = Double.parseDouble(result[0]);
            this.longitude = Double.parseDouble(result[1]);
        }
        catch (Exception e) {
            System.out.println("DireccionGeo.java.Error:" + e.toString() );
            this.latitude = 0.0d;
            this.longitude = 0.0d;
        }
    }
    
    
    
}
