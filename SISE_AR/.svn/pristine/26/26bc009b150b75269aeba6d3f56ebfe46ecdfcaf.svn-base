package Utilerias;

import java.util.Timer;
//import javax.swing.Timer;
import java.util.TimerTask;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.Date;

public class TimerGeneraRpt extends TimerTask {

    private static Timer Reloj = new Timer();

    public TimerGeneraRpt() {
    }

    public static void Start() {
        TimerTask TimerGeneraRpt = new TimerGeneraRpt();
        Reloj.schedule(TimerGeneraRpt, getNextExec());
    }

    public void run() {
        Genera();
    }

    private synchronized static void Genera() {
        if (GeneraRpt.getEstatus() == true) {
            GeneraRpt.GeneraReportes();
            Start();
        }
    }

    public static Date getNextExec() {
        Calendar tomorrow = new GregorianCalendar();
        tomorrow.add(Calendar.DATE, 0);
        System.out.println(tomorrow.DATE);
        Calendar result = new GregorianCalendar(
                tomorrow.get(Calendar.YEAR),
                tomorrow.get(Calendar.MONTH),
                tomorrow.get(Calendar.DATE),
                tomorrow.get(Calendar.HOUR_OF_DAY),
                tomorrow.get(Calendar.MINUTE) + 3);
        System.out.println("--------------------------------------- TIMER ENVIO DE REPORTES " + result.getTime() + " ARG ---------------------------------------");
        return result.getTime();
    }
}