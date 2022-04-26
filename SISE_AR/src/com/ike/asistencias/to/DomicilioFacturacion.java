package com.ike.asistencias.to;

/*Datos del domicilio  que salen de el detalle  de la base de afiliados o  del detalle de expediente y  detalle de la asistencia.
 Se agregar una propiedada para guardar el tipo de comprobante que deberá generarse al momento de la facturación.*/
public class DomicilioFacturacion {
//------------------------------------------------------------------------------
    	private String clExpediente="";
	private String prefijo="";
	private String clcuenta="";
	private String clave="";
	private String clAfiliado="";
	private String nombre="";
	private String dni="";
	private String correo="";
	private String direccion="";
	private String provincia="";
	private String localidad="";
        private String localidadExpediente="";
        private String provinciaExpediente="";
        private String detalleServicio = "";
//------------------------------------------------------------------------------
    public String getLocalidadExpediente() {        return localidadExpediente;    }
    public void setLocalidadExpediente(String localidadExpediente) {        this.localidadExpediente = localidadExpediente;    }
//------------------------------------------------------------------------------
    public String getProvinciaExpediente() {        return provinciaExpediente;    }
    public void setProvinciaExpediente(String provinciaExpediente) {        this.provinciaExpediente = provinciaExpediente;    }
//------------------------------------------------------------------------------
    public String getClExpediente() {        return clExpediente;    }
    public void setClExpediente(String clExpediente) {        this.clExpediente = clExpediente;    }
//------------------------------------------------------------------------------
    public String getPrefijo() {        return prefijo;    }
    public void setPrefijo(String prefijo) {        this.prefijo = prefijo;    }
//------------------------------------------------------------------------------
    public String getClcuenta() {        return clcuenta;    }
    public void setClcuenta(String clcuenta) {        this.clcuenta = clcuenta;    }
//------------------------------------------------------------------------------
    public String getClave() {        return clave;    }
    public void setClave(String clave) {        this.clave = clave;    }
//------------------------------------------------------------------------------
    public String getClAfiliado() {        return clAfiliado;    }
    public void setClAfiliado(String clAfiliado) {        this.clAfiliado = clAfiliado;    }
//------------------------------------------------------------------------------
    public String getNombre() {        return nombre;    }
    public void setNombre(String nombre) {        this.nombre = nombre;    }
//------------------------------------------------------------------------------
    public String getDni() {        return dni;    }
    public void setDni(String dni) {        this.dni = dni;    }
//------------------------------------------------------------------------------
    public String getCorreo() {        return correo;    }
    public void setCorreo(String correo) {        this.correo = correo;    }
//------------------------------------------------------------------------------
    public String getDireccion() {        return direccion;    }
    public void setDireccion(String direccion) {        this.direccion = direccion;    }
//------------------------------------------------------------------------------
    public String getProvincia() {        return provincia;    }
    public void setProvincia(String provincia) {        this.provincia = provincia;    }
//------------------------------------------------------------------------------
    public String getLocalidad() {        return localidad;    }
    public void setLocalidad(String localidad) {        this.localidad = localidad;    }
//------------------------------------------------------------------------------
    public String getDetalleServicio() {        return detalleServicio;    }
    public void setDetalleServicio(String detalleServicio) {        this.detalleServicio = detalleServicio;    }
//------------------------------------------------------------------------------
    @Override
    public String toString() {
        return "DomicilioFacturacion{" + "clExpediente=" + clExpediente +
                ", prefijo=" + prefijo + ", clcuenta=" + clcuenta +
                ", clave=" + clave + ", clAfiliado=" + clAfiliado +
                ", nombre=" + nombre + ", dni=" + dni + ", correo=" +
                correo + ", direccion=" + direccion + 
                ", provincia=" + provincia +
                ", localidad=" + localidad + 
                ", provinciaExpediente=" + provinciaExpediente +
                ", localidadExpediente=" + localidadExpediente +
                ", detalleServicio =" + detalleServicio +
                '}';
    }
//------------------------------------------------------------------------------        
}