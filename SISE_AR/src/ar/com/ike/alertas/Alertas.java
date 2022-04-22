package ar.com.ike.alertas;

import java.util.LinkedList;
import java.util.List;

public class Alertas {
//------------------------------------------------------------------------------
    public List<Alerta> alertas = new LinkedList<Alerta>();
    public int nivelUno = 0;
    public int nivelDos = 0;
    public int vencidas = 0;
//------------------------------------------------------------------------------
    public boolean add(Alerta alerta) {
        nivelUno += (alerta.nivelUno ? 1 : 0);
        nivelDos += (alerta.nivelDos ? 1 : 0);
        vencidas += (alerta.vencida ? 1 : 0);
        return alertas.add(alerta);
    }
//------------------------------------------------------------------------------
}