package Utilerias;
import java.util.Timer;
import java.util.TimerTask;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.Date; 

public class  ApplicationTimer extends TimerTask {

    
  public  static long fUnDia = 1000*60*60*24;
  public  static long fUnMinuto = 1000*60;
  public  static long fUnaHora = 1000*60*60;
  public static int fDia = 0;
  public static int fHora = 17;
  public static int fMinutos = 48;
  
  public static void main ( String[] arguments ) {
    TimerTask ApplicationTimer  = new ApplicationTimer();
    Timer timer = new Timer();
    timer.scheduleAtFixedRate(ApplicationTimer, getNextExec(), fUnMinuto*3);
  }
  
  public void run(){
    System.out.println("Ejecurta el proceso ?????");
  }

  public static Date getNextExec(){
    Calendar tomorrow = new GregorianCalendar();
    tomorrow.add(Calendar.DATE, fDia);
    System.out.println(tomorrow.DATE);
    Calendar result = new GregorianCalendar(
      tomorrow.get(Calendar.YEAR),
      tomorrow.get(Calendar.MONTH),
      tomorrow.get(Calendar.DATE),
      fHora,
      fMinutos
    );
    System.out.println(result.getTime());
    return result.getTime();
  }

}