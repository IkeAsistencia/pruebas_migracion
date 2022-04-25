package Utilerias;

import java.sql.ResultSet;

public class ProcesoConcierge {
//------------------------------------------------------------------------------    
    private static ResultSet rs = null;
//------------------------------------------------------------------------------    
    private static boolean isStarted = false;
//------------------------------------------------------------------------------    
    public ProcesoConcierge() { }
//------------------------------------------------------------------------------    
    public static boolean getEstatus() {
        return isStarted;    }
//------------------------------------------------------------------------------    
    public static synchronized void ProcesaInfo(){
        UtileriasBDF.ejecutaSQLNP("sp_CSProcesoConcierge ");        
        UtileriasBDF.ejecutaSQLNP("sp_CSProcesoPreventaAlta ");
        UtileriasBDF.ejecutaSQLNP("sp_CSProcesoPreventaConcierto ");
        }
//------------------------------------------------------------------------------    
    public static void Start() {
        chStatus(true);
        TimerConcierge.Start();
        }
//------------------------------------------------------------------------------    
    public static void Stop() {
        chStatus(false);    }
//------------------------------------------------------------------------------    
    private static void chStatus(boolean pEstatus) {
        isStarted=pEstatus;    }
//------------------------------------------------------------------------------    
}
