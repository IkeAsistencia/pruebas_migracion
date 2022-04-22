/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ar.com.ike.geo.hogar.api.to;

import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author ddiez
 */
                   
@XmlRootElement
public class Cita {
    public Integer id;
    public Integer id_sise;
    public String nombre_cliente;
    public String clave_sise_cliente;
    public String email_cliente;
    public String telefono_cliente;
    public String dia;
    public String hora_desde;
    public String hora_hasta;
    public Integer clservicio;
    public Integer clsubservicio;
    public String descripcion_servicio;
    public String direccion;
    public DireccionGeo direccion_geo;
    public String localidad;
    public boolean urgente;
    public boolean vip;
    public Integer codigo_proveedor;
    public Integer[] proveedores_excluidos;
    public Integer expediente;
    public String creacion;  //FORMATO:: "2019-10-15T12:09:17.1234567-03:00"
    public String short_id; 
    public String estado;
    public String fecha_en_camino; //FORMATO:: "2019-10-15T12:09:17.1234567-03:00"
    public String fecha_inicio_servicio; //FORMATO:: "2019-10-15T12:09:17.1234567-03:00"
    public String fecha_finalizacion_servicio; //FORMATO:: "2019-10-15T12:09:17.1234567-03:00"
    public String hora_estimada_llegada; //FORMATO:: "2019-10-15T12:09:17.1234567-03:00"
    public String tecnico;
    public Double costo;
    public String trabajo_realizado;
    public Integer Estado_llamada_sise;
    public String Obs_llamada_sise;
    
}
