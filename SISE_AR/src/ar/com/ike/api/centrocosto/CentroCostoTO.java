package ar.com.ike.api.centrocosto;

import java.math.BigDecimal;
public class CentroCostoTO {
    public int clExpediente;
    public String cuenta;
    public String fecha;
    public String proveedor;
    public String subServicio;
    public String clOrigen;
    public String dsOrigen;
    public String clDestino;
    public String dsDestino;
    public String conceptoCosto;
    public BigDecimal costo;
    public int clPagoProveedor;
    public int estatus;
    public boolean check;
    public boolean link;
    //public String motivo;       //COMENTADO JOA (ORIGINAL
    public String comentarios;    //AGREGADO JOA
}