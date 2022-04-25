/*
 * TimerEnviaCorreo.java
 *
 * Created on 19 de septiembre de 2006, 04:46 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

/*
 *
 * @author escobarm
 */
package Utilerias;

import java.util.Timer;
import java.util.TimerTask;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.Date;


/*
 *
 * Clase encargada de programar la siguiente ejecución de la tarea Envia correo
 *
 */
public class TimerEnviaCorreoPDF extends TimerTask {

    /* Creates a new instance of TimerEnviaCorreo */
    public TimerEnviaCorreoPDF() {
    }
    private static Timer Reloj = new Timer();

    public static void Start() {
        TimerTask timer = new TimerEnviaCorreoPDF();
        Reloj.schedule(timer, getNextExec());
    }

    public void run() {
        Genera();
    }

    private synchronized static void Genera() {
        if (EnviaCorreoPDF.getEstatus() == true) {
            EnviaCorreoPDF.EnviaCorreos();
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
                tomorrow.get(Calendar.MINUTE) + 2,
                tomorrow.get(Calendar.SECOND));

        System.out.println(result.getTime());
        return result.getTime();
    }
}
