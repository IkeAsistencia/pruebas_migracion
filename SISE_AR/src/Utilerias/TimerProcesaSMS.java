package Utilerias;

import java.util.Timer;
import java.util.TimerTask;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.Date;

public class TimerProcesaSMS extends TimerTask {
//------------------------------------------------------------------------------

    public TimerProcesaSMS() {
    }
//------------------------------------------------------------------------------
    private static Timer Reloj = new Timer();
//------------------------------------------------------------------------------

    public static void StartSMS() {
        TimerTask TimerEnvioSMS = new TimerProcesaSMS();
        Reloj.schedule(TimerEnvioSMS, getNextExec());
    }
//------------------------------------------------------------------------------

    public void run() {
        Genera();
    }
//------------------------------------------------------------------------------

    private synchronized static void Genera() {
        if (EnviaSMS.getEstatus()) {
            try {
                EnviaSMS.EnviaSMS();                
            } catch (Exception e) {
                System.out.println(e);
            }
            StartSMS();
        }
        
    }
//------------------------------------------------------------------------------

    public static Date getNextExec() {
        Date Ahora = new Date();
        Calendar Fecha = new GregorianCalendar();
        Fecha.add(Calendar.DATE, 0);
        Calendar result = new GregorianCalendar(
                Fecha.get(Calendar.YEAR),
                Fecha.get(Calendar.MONTH),
                Fecha.get(Calendar.DATE),
                Fecha.get(Calendar.HOUR_OF_DAY),
                Fecha.get(Calendar.MINUTE) + 1,
                Fecha.get(Calendar.SECOND)
        );
        System.out.println("SISE AR TIMER=" + Ahora.toString() + " Proceso Envio de SMS ");
        Ahora = null;
        return result.getTime();
    }
//------------------------------------------------------------------------------
}