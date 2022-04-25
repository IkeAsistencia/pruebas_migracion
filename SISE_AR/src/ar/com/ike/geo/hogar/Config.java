/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ar.com.ike.geo.hogar;
import Utilerias.UtileriasBDF;
import java.sql.ResultSet;

/**
 *
 * @author ddiez
 */
public class Config  {
    private String EndPoint = null;
    private String ApiKey = null;
    
    public Config() {
        if (EndPoint == null || ApiKey == null) {
            try {
                ResultSet rs = UtileriasBDF.rsSQLNP( "st_getGeoHogarConfig" );
                if (rs.next() ){ 
                    this.EndPoint = rs.getString("URL");
                    this.ApiKey = rs.getString("ApiKey");
                }
                rs.close();
            }
            catch (Exception e) {
                System.out.println("ar.com.ike.geo.hogar.Config.Error:" + e.toString());
            }
        }
    }
            
    public String getEndPoint() {
        return this.EndPoint;
    }
    public String getApiKey() {
        return this.ApiKey;
    }
    
}
