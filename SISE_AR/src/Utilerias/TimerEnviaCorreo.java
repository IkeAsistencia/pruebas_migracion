/*
 * TimerEnviaCorreo.java
 *
 * Created on 19 de septiembre de 2006, 04:46 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */
package Utilerias;

import java.util.Timer;
import java.util.TimerTask;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.Date;

/*
 *
 * @author pereac
 */
/*
 *
 * Clase encargada de programar la siguiente ejecución de la tarea Envia correo
 *
 */
public class TimerEnviaCorreo extends TimerTask {

    /* Creates a new instance of TimerEnviaCorreo */
    public TimerEnviaCorreo() {
    }
    private static Timer Reloj = new Timer();

    public static void Start() {
        TimerTask TimerEnviaCorreo = new TimerEnviaCorreo();
        Reloj.schedule(TimerEnviaCorreo, getNextExec());
    }

    public void run() {
        Genera();
    }

    private synchronized static void Genera() {
        if (EnviaCorreo.getEstatus() == true) {
            EnviaCorreo.EnviaCorreos();
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
                tomorrow.get(Calendar.MINUTE) + 1,
                tomorrow.get(Calendar.SECOND));
        System.out.println(result.getTime());
        return result.getTime();
    }
}
