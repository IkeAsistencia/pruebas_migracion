/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ar.com.ike.geo.hogar;

/**
 * @author ddiez
 * {
    "id": 32,
    "direccion_geo": {
        "latitude": -34.63353,
        "longitude": -58.399186
    },
    "localidad": "00141",
    "id_sise": 22212,
    "clservicio": 3,
    "clsubservicio": 218,
    "codigo_proveedor": 14,
    "hora_desde": "09:00",
    "hora_hasta": "12:00",
    "nombre_cliente": "Juan Perez",
    "email_cliente": "juan.perez@interinnovacion.com",
    "telefono_cliente": "541198764321",
    "dia": "2019-11-05",
    "descripcion_servicio": "Pierde agua por el sifón de la bacha de la cocina",
    "direccion": "Avenida Álvarez Thomas 3021 4º A, Buenos Aires, Argentina",
    "urgente": true,
    "vip": false,
    "expediente": 9876,
    "creacion": "2019-11-04T10:54:48.118245-03:00"
}
 */
public class ServicioHogarResponse {
    public int id;
    public DireccionGeo direccion_geo;
    public String localidad;
    public int id_sise;
    public int clservicio;
    public int clsubservicio;
    public int codigo_proveedor;
    public String hora_desde;
    public String hora_hasta;
    public String nombre_cliente;
    public String email_cliente;
    public String telefono_cliente;
    public String dia;
    public String descripcion_servicio;
    public String direccion;
    public boolean urgente;
    public boolean vip;
    public int expediente;
    public String creacion;
    
}
