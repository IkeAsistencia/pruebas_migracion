package ar.com.ike.alertas;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.TimeZone;

public class Alerta {
//------------------------------------------------------------------------------
    public long clAlerta;
    public int clExpediente;
    public Integer clCita;
    public Integer clRecordatorio;   
    public Date FechaCreacion;
    public Date FechaNivelUno;
    public Date FechaNivelDos;
    public Date FechaVencimiento;
    public Date FechaCaducidad;    
    public Boolean Cumplida;
    public Date FechaCumplimiento;
    public Integer clUsrApp_Cumplimiento;    
    public String Titulo;
    public String Mensaje;    
    public boolean nivelUno;
    public boolean nivelDos;
    public boolean vencida;
//------------------------------------------------------------------------------    
    private Date getNow() throws ParseException {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        sdf.setTimeZone(TimeZone.getTimeZone("GMT-3:00")); // Timezone de buenos aires
        SimpleDateFormat ldf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date d = ldf.parse(sdf.format(new Date()));
        return d;
        }
//------------------------------------------------------------------------------
    public boolean isNivelUno() throws ParseException {
        Date now = this.getNow();
        return isNivelUno(now);
        }
//------------------------------------------------------------------------------    
    public boolean isNivelUno(Date now) {
        return (now.after(FechaNivelUno) || now.equals(FechaNivelUno)) && 
                now.before(FechaNivelDos);
        }
//------------------------------------------------------------------------------    
    public boolean isNivelDos() throws ParseException {
        Date now = this.getNow();
        return isNivelDos(now);
        }
//------------------------------------------------------------------------------    
    public boolean isNivelDos(Date now) {
        return (now.after(FechaNivelDos) || now.equals(FechaNivelDos)) && 
                now.before(FechaVencimiento);
        }
//------------------------------------------------------------------------------    
    public boolean isVencida() throws ParseException {
        Date now = this.getNow();
        return isVencida(now);
        }
//------------------------------------------------------------------------------    
    public boolean isVencida(Date now) {
        return (now.after(FechaVencimiento) || now.equals(FechaVencimiento));
    }
//------------------------------------------------------------------------------    
    public void completarBooleanosNivelAlerta() throws ParseException {
        Date now = this.getNow();
        nivelUno = isNivelUno(now);
        nivelDos = isNivelDos(now);
        vencida = isVencida(now);
    }
//------------------------------------------------------------------------------    
}