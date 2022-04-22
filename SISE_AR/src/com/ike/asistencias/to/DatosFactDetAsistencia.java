package com.ike.asistencias.to;

/* Datos obtenidos del detalle de asistencia  para los casos en que falte información de calle, localidad y provincia en expediente
 o base de datos de clientes.*/
public class DatosFactDetAsistencia {
//------------------------------------------------------------------------------
    private String detAsistTabla;
    private String detAsistCalle;
    private String detAsistLocalidad;
    private String detAsistProvincia;
    private String detAsistUsuarioExpediente;
    private String detAsistEmailExpediente;
//------------------------------------------------------------------------------    
    public String getDetAsistTabla() {        return detAsistTabla;    }
    public void setDetAsistTabla(String detAsistTabla) {        this.detAsistTabla = detAsistTabla;    }
//------------------------------------------------------------------------------
    public String getDetAsistCalle() {        return detAsistCalle;    }
    public void setDetAsistCalle(String detAsistCalle) {        this.detAsistCalle = detAsistCalle;    }
//------------------------------------------------------------------------------
    public String getDetAsistLocalidad() {        return detAsistLocalidad;    }
    public void setDetAsistLocalidad(String detAsistLocalidad) {        this.detAsistLocalidad = detAsistLocalidad;    }
//------------------------------------------------------------------------------
    public String getDetAsistProvincia() {        return detAsistProvincia;    }
    public void setDetAsistProvincia(String detAsistProvincia) {        this.detAsistProvincia = detAsistProvincia;    }
//------------------------------------------------------------------------------
    public String getDetAsistUsuarioExpediente() {        return detAsistUsuarioExpediente;    }
    public void setDetAsistUsuarioExpediente(String detAsistUsuarioExpediente) {        this.detAsistUsuarioExpediente = detAsistUsuarioExpediente;    }
//------------------------------------------------------------------------------
    public String getDetAsistEmailExpediente() {        return detAsistEmailExpediente;    }
    public void setDetAsistEmailExpediente(String detAsistEmailExpediente) {        this.detAsistEmailExpediente = detAsistEmailExpediente;    }
//------------------------------------------------------------------------------
    @Override
    public String toString() {
        return "DatosFactDetAsistencia{" + "detAsistTabla=" + detAsistTabla + ", detAsistCalle=" + detAsistCalle + ", detAsistLocalidad=" + detAsistLocalidad + ", detAsistProvincia=" + detAsistProvincia + ", detAsistUsuarioExpediente=" + detAsistUsuarioExpediente + ", detAsistEmailExpediente=" + detAsistEmailExpediente + '}';
    }
//------------------------------------------------------------------------------   
}