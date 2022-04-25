/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Utilerias;

import java.sql.ResultSet;

/*
 *
 * @author fcerqueda
 */
public class LoadServicios {

    /* Creates a new instance of LoadServicios */
    public LoadServicios() {
    }

    public static String getstrServicios(String strclUsrApp) {
        StringBuffer strSql = new StringBuffer();

        ResultSet rs = null;
        strSql.append("sp_MuestraServicios '").append(strclUsrApp).append("'");
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
