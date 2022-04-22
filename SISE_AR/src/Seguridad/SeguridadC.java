package Seguridad;

import Utilerias.UtileriasBDF;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Connection;
import java.sql.SQLException;

public class SeguridadC {
//------------------------------------------------------------------------------
    private SeguridadC() {    }
//------------------------------------------------------------------------------
    public static boolean[] VerificaC(int pclPage, int pclUsrApp) {
        boolean[] blnReturn = new boolean[5];
        Connection con = null;
        Statement stmt = null;
        ResultSet rs = null;
        try {
            con = UtileriasBDF.getConnection();
            stmt = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
            try { rs = stmt.executeQuery("Select sum(cast(alta as tinyint)), sum(cast(baja as tinyint)),sum(cast(cambio as tinyint)), sum(cast(consulta as tinyint)) from AccesoGpoXPag AxP inner join usrxgpo UxG on (UxG.clGpoUsr = AxP.clGpoUsr) where UxG.clUsrApp = " + pclUsrApp + " and clPaginaweb = " + pclPage + " group by UxG.clUsrApp");
            } catch (SQLException sqle) {
                do { sqle = sqle.getNextException();
                } while (sqle != null);
                }
            try {
                if (rs.next()) {
                    blnReturn[0] = rs.getBoolean(1); //Alta
                    blnReturn[1] = rs.getBoolean(2); //Baja
                    blnReturn[2] = rs.getBoolean(3); //Cambio
                    blnReturn[3] = rs.getBoolean(4); //Consulta
                    blnReturn[4] = blnReturn[0] || blnReturn[1] || blnReturn[2];
                } else {
                    blnReturn[0] = false;
                    blnReturn[1] = false;
                    blnReturn[2] = false;
                    blnReturn[3] = false;
                    blnReturn[4] = false;
                }
                rs.close();
                con.close();
                stmt.close();
            } catch (Exception e) {
                //Fallo carga driver JDBC/ODBC.;
                e.printStackTrace();
                blnReturn[0] = false;
                blnReturn[1] = false;
                blnReturn[2] = false;
                blnReturn[3] = false;
                blnReturn[4] = false;
            }
        } catch (Exception e) {    e.printStackTrace();
        } finally {
        }
        return blnReturn;
    }
//------------------------------------------------------------------------------
    public static boolean verificaHorarioC(int intclUsrApp ){
        boolean blnReturn=false;
	try{
	    if(intclUsrApp>0){
	        blnReturn=true;    }  
	}catch(Exception e){
		e.printStackTrace();   }
        return blnReturn;
        }
//------------------------------------------------------------------------------
    public static boolean verificaRequest(String Request) {
        boolean blnValidaRequest = false;
        if (Request.indexOf("<") != -1 || Request.indexOf("%3C") != -1) {
            blnValidaRequest = false;
        } else {     blnValidaRequest = true;        }
        return blnValidaRequest;
    }
//------------------------------------------------------------------------------
    public static String VerificaBitacoraC(int pclPage) {
        String strReturn = "";
        ResultSet rs = UtileriasBDF.rsSQLNP("Select coalesce(TablaBitacora,'') TablaBitacora from cPaginaWeb where clPaginaweb = " + pclPage);
        try {    if (rs.next()) {     strReturn = rs.getString("TablaBitacora");          }
            rs.close();
            return strReturn;
        } catch (Exception e) {
            e.printStackTrace();
            return strReturn;
        }
    }
//------------------------------------------------------------------------------
}