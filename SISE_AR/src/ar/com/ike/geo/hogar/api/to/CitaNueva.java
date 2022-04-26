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
public class CitaNueva {
    public Integer id;
    public Integer id_sise;
    public Integer expediente;
    public String dia;
    public String hora_desde;
    public String hora_hasta;
    
/* OBSOLETO:    
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
    public Integer[] codigos_proveedores_excluidos;
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
    
    public Monitoreo monitoreo;    
    public String otros; //": None,
    public Boolean cerrada; // False,
    public Boolean subasta; //": False,
    public String viaticos; //": None,
    public Boolean cancelada; //": False,
    public Integer prioridad; //": 1,
    public Boolean abandonada; //": False, 
    public String foto_antes; //": None,
    public String materiales; //": None,
    public Boolean nueva_cita; //": None,
    public String foto_despues; //": None,
    public String mano_de_obra; //: None,
    public String firma_cliente; //": None,
    public String dia_nueva_cita; //": None,
    public String[] mensajes_cliente; //": [],
    public Boolean subasta_desierta; //": False,
    public String requiere_otra_cita; //": "cita_no_finalizada",
    public Boolean tiene_estado_final; //": False,
    public Boolean conformidad_cliente; //": None,
    public Boolean requiere_nueva_cita; //": None,
    public Boolean recordatorio_enviado; //": False,
    public String hora_desde_nueva_cita; //": None,
    public String hora_hasta_nueva_cita; //": None,
    public String motivo_no_conformidad; //": None,
    public Boolean nueva_cita_coordinada; //": False,
    public Integer[] cancelaciones_tecnicos; //": [],
    public Boolean quiero_que_me_contacten; //": False,
    public Integer codigo_motivo_cancelacion; //": "",
    public String descripcion_no_conformidad; //": "",
    public Integer[] cancelaciones_coordinadores; //": [],
    public String descripcion_motivo_no_conformidad; //": None,
    public Boolean cancelacion_cliente_consume_servicio; //": False
*/
}
    