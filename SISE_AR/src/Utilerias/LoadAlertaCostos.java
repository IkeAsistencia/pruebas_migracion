/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Utilerias;

import java.sql.ResultSet;

/**
 *
 * @author gezequiel
 */
public class LoadAlertaCostos {
    /* Creates a new instance of LoadAlertaCostos */
    public LoadAlertaCostos() {
    }

    public static String getstrCostos(String strclUsrApp) {
        StringBuffer strSql = new StringBuffer();

        ResultSet rs = null;
        strSql.append("st_MuestraAlertaCostos '").append(strclUsrApp).append("'");
        //System.out.print(strSql);
        rs = UtileriasBDF.rsSQLNP(strSql.toString());
        strSql.delete(0, strSql.length());

        String strServicios = "";
        try {
            if (rs.next()) {
                strServicios = (rs.getString("dsServicioInfo").toString());
                //System.out.println("servicio " + strServicios.toString());
            } else {
            }
            return strServicios;
        } catch (Exception e) {
            //System.out.println("Error al consultar Servicios de información" + e.toString());
            return null;
        } finally {
            strSql = null;
            try {
                if (rs != null) {
                    rs.close();
                    rs = null;
                }
            } catch (Exception e) {
            }
        }
    }
}
