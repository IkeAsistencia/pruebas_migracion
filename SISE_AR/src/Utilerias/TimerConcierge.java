package Utilerias;

import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Timer;
import java.util.TimerTask;

public class TimerConcierge extends  TimerTask {
//------------------------------------------------------------------------------
    public TimerConcierge() { }
//------------------------------------------------------------------------------    
    private static Timer Reloj = new Timer();
//------------------------------------------------------------------------------    
    public static void Start() {
        TimerTask TimerConcierge = new TimerConcierge();
        Reloj.schedule(TimerConcierge, getNextExec());
        }
//------------------------------------------------------------------------------    
    public void run(){
        Genera();    }
//------------------------------------------------------------------------------
    private synchronized static void Genera() {
        if (ProcesoConcierge.getEstatus()==true) {
            ProcesoConcierge.ProcesaInfo();
            Start();
            }
        }
//------------------------------------------------------------------------------    
    public static Date getNextExec(){
        Date Ahora = new Date();
        Calendar tomorrow = new GregorianCalendar();
        tomorrow.add(Calendar.DATE, 0);
        Calendar result = new GregorianCalendar(
                tomorrow.get(Calendar.YEAR),
                tomorrow.get(Calendar.MONTH),
                tomorrow.get(Calendar.DATE),
                tomorrow.get(Calendar.HOUR_OF_DAY),
                tomorrow.get(Calendar.MINUTE)+1,
                tomorrow.get(Calendar.SECOND)
                );
        System.out.println("SISE ARG TIMER:"+Ahora.toString()+" Proceso Concierge ");
        Ahora=null;
        return result.getTime();
        }
//------------------------------------------------------------------------------    
}