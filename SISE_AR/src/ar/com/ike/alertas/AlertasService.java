package ar.com.ike.alertas;

import Utilerias.UtileriasBDF;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.util.Date;

public class AlertasService {
//------------------------------------------------------------------------------ 
    /**
     * Devuelve el listado de alertas vigentes (en orden) para un usuario determinado
     * 
     * @param clUsrApp
     * @return
     * @throws SQLException 
     */
    public static Alertas ObtenerAlertas(int clUsrApp) throws SQLException, ParseException {
        String strClUsrApp = Integer.toString(clUsrApp);
        ResultSet rsAlertas = null;
        Alertas resultado  = new Alertas();
        rsAlertas = UtileriasBDF.rsSQLNP("st_ObtenerAlertas " + strClUsrApp);
        while(rsAlertas.next()) {
            Alerta alerta = new Alerta();
            alerta.clAlerta = rsAlertas.getLong("clAlerta");
            alerta.clExpediente = rsAlertas.getInt("clExpediente");
            alerta.clCita = rsAlertas.getInt("clCita");
            if (rsAlertas.wasNull()) {             alerta.clCita = null;           }
            alerta.clRecordatorio = rsAlertas.getInt("clRecordatorio");
            if (rsAlertas.wasNull()) {                alerta.clRecordatorio = null;            }
            alerta.FechaCreacion = new Date(rsAlertas.getTimestamp("FechaCreacion").getTime());
            alerta.FechaNivelUno = new Date(rsAlertas.getTimestamp("FechaNivelUno").getTime());
            alerta.FechaNivelDos = new Date(rsAlertas.getTimestamp("FechaNivelDos").getTime());
            alerta.FechaVencimiento = new Date(rsAlertas.getTimestamp("FechaVencimiento").getTime());
            alerta.FechaCaducidad = new Date(rsAlertas.getTimestamp("FechaCaducidad").getTime());
            Timestamp tsFechaCumplimiento = rsAlertas.getTimestamp("FechaCumplimiento");
            if (rsAlertas.wasNull()) {           alerta.FechaCumplimiento = null;         
            } else {        alerta.FechaCumplimiento = new Date(tsFechaCumplimiento.getTime());     }
            alerta.Cumplida = rsAlertas.getBoolean("Cumplida");
            if (rsAlertas.wasNull()) {      alerta.Cumplida = null;            }
            alerta.clUsrApp_Cumplimiento = rsAlertas.getInt("clUsrApp_Cumplimiento");
            if (rsAlertas.wasNull()) {                alerta.clUsrApp_Cumplimiento = null;            }           
            alerta.Titulo = rsAlertas.getString("Titulo");
            alerta.Mensaje = rsAlertas.getString("Mensaje");            
            alerta.completarBooleanosNivelAlerta();                        
            if (alerta.nivelUno || alerta.nivelDos || alerta.vencida) {       resultado.add(alerta);            }        
            }        
        return resultado;
    }
//------------------------------------------------------------------------------    
    public static void CrearAlerta(int clExpediente, Integer clCita, Integer clRecordatorio, String Titulo, String Mensaje ) {
        String strClExpediente = Integer.toString(clExpediente);
        String strClCita = clCita == null ? "NULL" : clCita.toString();
        String strClRecordatorio = clRecordatorio == null ? "NULL" : clRecordatorio.toString();
        // TODO: Escapar las comillas simples en Titulo y Mensaje
        UtileriasBDF.ejecutaSQLNP("st_CrearAlerta " + strClCita + "," + strClExpediente + "," + strClRecordatorio + ", '" + Titulo + "', '" + Mensaje + "'");
    }
//------------------------------------------------------------------------------
    public static void CrearAlerta(Alerta alerta) {  
        AlertasService.CrearAlerta(  alerta.clExpediente, alerta.clCita, alerta.clRecordatorio, alerta.Titulo, alerta.Mensaje );
    }
//------------------------------------------------------------------------------    
    public static void CumplirAlerta(long clAlerta, int clUsrApp) {
       String strClAlerta = Long.toString(clAlerta);
       String strClUsrApp = Integer.toString(clUsrApp);
       UtileriasBDF.ejecutaSQLNP("st_CumplirAlerta " + strClAlerta + ", " + strClUsrApp);
    }
//------------------------------------------------------------------------------    
}
