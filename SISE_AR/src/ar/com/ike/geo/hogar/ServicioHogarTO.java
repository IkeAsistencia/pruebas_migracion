/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ar.com.ike.geo.hogar;

/**
 * @author ddiez
 * {
    "id_sise": 22212,
    "nombre_cliente": "Juan Perez",
    "clave_sise_cliente": "0000000000",
    "email_cliente": "juan.perez@interinnovacion.com",
    "telefono_cliente": "541198764321",
    "localidad": "00141",
    "dia": "2019-11-05",
    "hora_desde": "09:00",
    "hora_hasta": "12:00",
    "servicio": "hogar",
    "subservicio": "plomeria",
    "descripcion_servicio": "Pierde agua por el sifón de la bacha de la cocina",
    "direccion": "Avenida Álvarez Thomas 3021 4º A, Buenos Aires, Argentina",
    "direccion_geo": {
        "latitude": -34.633530, 
        "longitude": -58.399186
    },
    "zona": "villa_urquiza",
    "expediente": "9876",
    "urgente": true,
    "clservicio": 3,
    "clsubservicio": 218,
    "codigo_proveedor": "14"
}
 */
public class ServicioHogarTO {
    public int id_sise;
    public String nombre_cliente;
    public String clave_sise_cliente;
    public String email_cliente;
    public String telefono_cliente;
    public String localidad;
    public String dia;
    public String hora_desde;
    public String hora_hasta;
    public String servicio;
    public String subservicio;
    public String descripcion_servicio;
    public String direccion;
    public DireccionGeo direccion_geo;
    public String zona;
    public String expediente;
    public boolean urgente;
    public int clservicio;
    public int clsubservicio;
    public boolean vip;
    public String codigo_proveedor;
    public String canal_chat;
    public String cliente_chat_id;
}
