
package ar.com.ike.geo.ws.capa;

import javax.xml.bind.JAXBElement;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElementRef;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Clase Java para asignar_servicio complex type.
 * 
 * <p>El siguiente fragmento de esquema especifica el contenido que se espera que haya en esta clase.
 * 
 * <pre>
 * &lt;complexType name="asignar_servicio">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="nombre_origen" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="id_prestador" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="demora_comprometida" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="codigo_de_autorizacion" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="telefono" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="denunciante" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="cobertura" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="tipo_srv_inicial" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="desperfecto" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="ubicacion" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="localidad" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="destino" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="origengeo" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="destinogeo" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="patente" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="titular" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="modelo" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="color" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="hora_inicio" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="operador" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="observaciones" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "asignar_servicio", propOrder = {
    "nombreOrigen",
    "idPrestador",
    "demoraComprometida",
    "codigoDeAutorizacion",
    "telefono",
    "denunciante",
    "cobertura",
    "tipoSrvInicial",
    "desperfecto",
    "ubicacion",
    "localidad",
    "destino",
    "origengeo",
    "destinogeo",
    "patente",
    "titular",
    "modelo",
    "color",
    "horaInicio",
    "operador",
    "observaciones"
})
public class AsignarServicio {

    @XmlElementRef(name = "nombre_origen", namespace = "tns", type = JAXBElement.class, required = false)
    protected JAXBElement<String> nombreOrigen;
    @XmlElementRef(name = "id_prestador", namespace = "tns", type = JAXBElement.class, required = false)
    protected JAXBElement<String> idPrestador;
    @XmlElementRef(name = "demora_comprometida", namespace = "tns", type = JAXBElement.class, required = false)
    protected JAXBElement<String> demoraComprometida;
    @XmlElementRef(name = "codigo_de_autorizacion", namespace = "tns", type = JAXBElement.class, required = false)
    protected JAXBElement<String> codigoDeAutorizacion;
    @XmlElementRef(name = "telefono", namespace = "tns", type = JAXBElement.class, required = false)
    protected JAXBElement<String> telefono;
    @XmlElementRef(name = "denunciante", namespace = "tns", type = JAXBElement.class, required = false)
    protected JAXBElement<String> denunciante;
    @XmlElementRef(name = "cobertura", namespace = "tns", type = JAXBElement.class, required = false)
    protected JAXBElement<String> cobertura;
    @XmlElementRef(name = "tipo_srv_inicial", namespace = "tns", type = JAXBElement.class, required = false)
    protected JAXBElement<String> tipoSrvInicial;
    @XmlElementRef(name = "desperfecto", namespace = "tns", type = JAXBElement.class, required = false)
    protected JAXBElement<String> desperfecto;
    @XmlElementRef(name = "ubicacion", namespace = "tns", type = JAXBElement.class, required = false)
    protected JAXBElement<String> ubicacion;
    @XmlElementRef(name = "localidad", namespace = "tns", type = JAXBElement.class, required = false)
    protected JAXBElement<String> localidad;
    @XmlElementRef(name = "destino", namespace = "tns", type = JAXBElement.class, required = false)
    protected JAXBElement<String> destino;
    @XmlElementRef(name = "origengeo", namespace = "tns", type = JAXBElement.class, required = false)
    protected JAXBElement<String> origengeo;
    @XmlElementRef(name = "destinogeo", namespace = "tns", type = JAXBElement.class, required = false)
    protected JAXBElement<String> destinogeo;
    @XmlElementRef(name = "patente", namespace = "tns", type = JAXBElement.class, required = false)
    protected JAXBElement<String> patente;
    @XmlElementRef(name = "titular", namespace = "tns", type = JAXBElement.class, required = false)
    protected JAXBElement<String> titular;
    @XmlElementRef(name = "modelo", namespace = "tns", type = JAXBElement.class, required = false)
    protected JAXBElement<String> modelo;
    @XmlElementRef(name = "color", namespace = "tns", type = JAXBElement.class, required = false)
    protected JAXBElement<String> color;
    @XmlElementRef(name = "hora_inicio", namespace = "tns", type = JAXBElement.class, required = false)
    protected JAXBElement<String> horaInicio;
    @XmlElementRef(name = "operador", namespace = "tns", type = JAXBElement.class, required = false)
    protected JAXBElement<String> operador;
    @XmlElementRef(name = "observaciones", namespace = "tns", type = JAXBElement.class, required = false)
    protected JAXBElement<String> observaciones;

    /**
     * Obtiene el valor de la propiedad nombreOrigen.
     * 
     * @return
     *     possible object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public JAXBElement<String> getNombreOrigen() {
        return nombreOrigen;
    }

    /**
     * Define el valor de la propiedad nombreOrigen.
     * 
     * @param value
     *     allowed object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public void setNombreOrigen(JAXBElement<String> value) {
        this.nombreOrigen = value;
    }

    /**
     * Obtiene el valor de la propiedad idPrestador.
     * 
     * @return
     *     possible object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public JAXBElement<String> getIdPrestador() {
        return idPrestador;
    }

    /**
     * Define el valor de la propiedad idPrestador.
     * 
     * @param value
     *     allowed object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public void setIdPrestador(JAXBElement<String> value) {
        this.idPrestador = value;
    }

    /**
     * Obtiene el valor de la propiedad demoraComprometida.
     * 
     * @return
     *     possible object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public JAXBElement<String> getDemoraComprometida() {
        return demoraComprometida;
    }

    /**
     * Define el valor de la propiedad demoraComprometida.
     * 
     * @param value
     *     allowed object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public void setDemoraComprometida(JAXBElement<String> value) {
        this.demoraComprometida = value;
    }

    /**
     * Obtiene el valor de la propiedad codigoDeAutorizacion.
     * 
     * @return
     *     possible object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public JAXBElement<String> getCodigoDeAutorizacion() {
        return codigoDeAutorizacion;
    }

    /**
     * Define el valor de la propiedad codigoDeAutorizacion.
     * 
     * @param value
     *     allowed object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public void setCodigoDeAutorizacion(JAXBElement<String> value) {
        this.codigoDeAutorizacion = value;
    }

    /**
     * Obtiene el valor de la propiedad telefono.
     * 
     * @return
     *     possible object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public JAXBElement<String> getTelefono() {
        return telefono;
    }

    /**
     * Define el valor de la propiedad telefono.
     * 
     * @param value
     *     allowed object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public void setTelefono(JAXBElement<String> value) {
        this.telefono = value;
    }

    /**
     * Obtiene el valor de la propiedad denunciante.
     * 
     * @return
     *     possible object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public JAXBElement<String> getDenunciante() {
        return denunciante;
    }

    /**
     * Define el valor de la propiedad denunciante.
     * 
     * @param value
     *     allowed object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public void setDenunciante(JAXBElement<String> value) {
        this.denunciante = value;
    }

    /**
     * Obtiene el valor de la propiedad cobertura.
     * 
     * @return
     *     possible object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public JAXBElement<String> getCobertura() {
        return cobertura;
    }

    /**
     * Define el valor de la propiedad cobertura.
     * 
     * @param value
     *     allowed object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public void setCobertura(JAXBElement<String> value) {
        this.cobertura = value;
    }

    /**
     * Obtiene el valor de la propiedad tipoSrvInicial.
     * 
     * @return
     *     possible object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public JAXBElement<String> getTipoSrvInicial() {
        return tipoSrvInicial;
    }

    /**
     * Define el valor de la propiedad tipoSrvInicial.
     * 
     * @param value
     *     allowed object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public void setTipoSrvInicial(JAXBElement<String> value) {
        this.tipoSrvInicial = value;
    }

    /**
     * Obtiene el valor de la propiedad desperfecto.
     * 
     * @return
     *     possible object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public JAXBElement<String> getDesperfecto() {
        return desperfecto;
    }

    /**
     * Define el valor de la propiedad desperfecto.
     * 
     * @param value
     *     allowed object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public void setDesperfecto(JAXBElement<String> value) {
        this.desperfecto = value;
    }

    /**
     * Obtiene el valor de la propiedad ubicacion.
     * 
     * @return
     *     possible object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public JAXBElement<String> getUbicacion() {
        return ubicacion;
    }

    /**
     * Define el valor de la propiedad ubicacion.
     * 
     * @param value
     *     allowed object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public void setUbicacion(JAXBElement<String> value) {
        this.ubicacion = value;
    }

    /**
     * Obtiene el valor de la propiedad localidad.
     * 
     * @return
     *     possible object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public JAXBElement<String> getLocalidad() {
        return localidad;
    }

    /**
     * Define el valor de la propiedad localidad.
     * 
     * @param value
     *     allowed object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public void setLocalidad(JAXBElement<String> value) {
        this.localidad = value;
    }

    /**
     * Obtiene el valor de la propiedad destino.
     * 
     * @return
     *     possible object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public JAXBElement<String> getDestino() {
        return destino;
    }

    /**
     * Define el valor de la propiedad destino.
     * 
     * @param value
     *     allowed object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public void setDestino(JAXBElement<String> value) {
        this.destino = value;
    }

    /**
     * Obtiene el valor de la propiedad origengeo.
     * 
     * @return
     *     possible object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public JAXBElement<String> getOrigengeo() {
        return origengeo;
    }

    /**
     * Define el valor de la propiedad origengeo.
     * 
     * @param value
     *     allowed object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public void setOrigengeo(JAXBElement<String> value) {
        this.origengeo = value;
    }

    /**
     * Obtiene el valor de la propiedad destinogeo.
     * 
     * @return
     *     possible object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public JAXBElement<String> getDestinogeo() {
        return destinogeo;
    }

    /**
     * Define el valor de la propiedad destinogeo.
     * 
     * @param value
     *     allowed object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public void setDestinogeo(JAXBElement<String> value) {
        this.destinogeo = value;
    }

    /**
     * Obtiene el valor de la propiedad patente.
     * 
     * @return
     *     possible object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public JAXBElement<String> getPatente() {
        return patente;
    }

    /**
     * Define el valor de la propiedad patente.
     * 
     * @param value
     *     allowed object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public void setPatente(JAXBElement<String> value) {
        this.patente = value;
    }

    /**
     * Obtiene el valor de la propiedad titular.
     * 
     * @return
     *     possible object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public JAXBElement<String> getTitular() {
        return titular;
    }

    /**
     * Define el valor de la propiedad titular.
     * 
     * @param value
     *     allowed object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public void setTitular(JAXBElement<String> value) {
        this.titular = value;
    }

    /**
     * Obtiene el valor de la propiedad modelo.
     * 
     * @return
     *     possible object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public JAXBElement<String> getModelo() {
        return modelo;
    }

    /**
     * Define el valor de la propiedad modelo.
     * 
     * @param value
     *     allowed object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public void setModelo(JAXBElement<String> value) {
        this.modelo = value;
    }

    /**
     * Obtiene el valor de la propiedad color.
     * 
     * @return
     *     possible object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public JAXBElement<String> getColor() {
        return color;
    }

    /**
     * Define el valor de la propiedad color.
     * 
     * @param value
     *     allowed object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public void setColor(JAXBElement<String> value) {
        this.color = value;
    }

    /**
     * Obtiene el valor de la propiedad horaInicio.
     * 
     * @return
     *     possible object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public JAXBElement<String> getHoraInicio() {
        return horaInicio;
    }

    /**
     * Define el valor de la propiedad horaInicio.
     * 
     * @param value
     *     allowed object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public void setHoraInicio(JAXBElement<String> value) {
        this.horaInicio = value;
    }

    /**
     * Obtiene el valor de la propiedad operador.
     * 
     * @return
     *     possible object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public JAXBElement<String> getOperador() {
        return operador;
    }

    /**
     * Define el valor de la propiedad operador.
     * 
     * @param value
     *     allowed object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public void setOperador(JAXBElement<String> value) {
        this.operador = value;
    }

    /**
     * Obtiene el valor de la propiedad observaciones.
     * 
     * @return
     *     possible object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public JAXBElement<String> getObservaciones() {
        return observaciones;
    }

    /**
     * Define el valor de la propiedad observaciones.
     * 
     * @param value
     *     allowed object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public void setObservaciones(JAXBElement<String> value) {
        this.observaciones = value;
    }

}
