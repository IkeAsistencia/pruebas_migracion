package ar.com.ike.geo.hogar;

/**
 * @author ddiez
 */
public class ConsultaHogarResponse {
/*  {
    "id": 44,
    "direccion_geo": {
        "latitude": -34.61051,
        "longitude": -58.47725
    },
    "localidad": "11862",
    "tecnico": null,
    "id_sise": 2300168,
    "clservicio": 3,
    "clsubservicio": 218,
    "codigo_proveedor": 14,
    "hora_desde": "09:00",
    "hora_hasta": "12:00",
    "short_id": "a2kpNLh9G_WP",
    "nombre_cliente": "Gabriel Gonzalez",
    "email_cliente": "a@a.com",
    "telefono_cliente": "11    1121607775",
    "dia": "2019-11-14",
    "descripcion_servicio": "",
    "direccion": "Camarones 2617",
    "urgente": false,
    "vip": false,
    "expediente": 2300168,
    "estado": "aceptada",
    "fecha_en_camino": null,
    "fecha_inicio_servicio": null,
    "fecha_finalizacion_servicio": null,
    "hora_estimada_llegada_desde": null,
    "hora_estimada_llegada_hasta": null,
    "creacion": "2019-11-13T10:45:00.790458-03:00"
}    */

    public int id;
    public DireccionGeo direccion_geo;
    public String localidad;
    public String tecnico;
    public int id_sise;
    public int clservicio;
    public int clsubservicio;
    public String codigo_proveedor;
    public String hora_desde;
    public String hora_hasta;
    public String short_id; //Ej:  "a2kpNLh9G_WP"
    public String nombre_cliente;
    public String email_cliente;
    public String telefono_cliente;
    public String dia;
    public String descripcion_servicio;
    public String direccion;
    public boolean urgente;
    public boolean vip;
    public int expediente;
    public String estado;
    public String fecha_en_camino;
    public String fecha_inicio_servicio;
    public String fecha_finalizacion_servicio;
    public String hora_estimada_llegada_desde;
    public String hora_estimada_llegada_hasta;
    public String creacion; // "2019-11-13T10:45:00.790458-03:00"
}
