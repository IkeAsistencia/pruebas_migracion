
package ar.com.ike.geo.ws.capa;

import java.util.ArrayList;
import java.util.List;
import javax.xml.bind.JAXBElement;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlElementRef;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Clase Java para ike_prestador complex type.
 * 
 * <p>El siguiente fragmento de esquema especifica el contenido que se espera que haya en esta clase.
 * 
 * <pre>
 * &lt;complexType name="ike_prestador">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="id_prestador" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="nombre" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="razon_social" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="titular" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="cuit" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="activo" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="pais" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="provincia" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="localidad" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="direccion" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="lat_lng" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="horario" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="email" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="telefonos" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="tipo" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="area" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="alias" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="envio_electronico" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="localidades" type="{http://www.w3.org/2001/XMLSchema}string" maxOccurs="1000"/>
 *         &lt;element name="servicios" type="{http://www.w3.org/2001/XMLSchema}string" maxOccurs="1000"/>
 *         &lt;element name="ids_localidades" type="{http://www.w3.org/2001/XMLSchema}string" maxOccurs="1000"/>
 *         &lt;element name="prioridades" type="{http://www.w3.org/2001/XMLSchema}string" maxOccurs="1000"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "ike_prestador", propOrder = {
    "idPrestador",
    "nombre",
    "razonSocial",
    "titular",
    "cuit",
    "activo",
    "pais",
    "provincia",
    "localidad",
    "direccion",
    "latLng",
    "horario",
    "email",
    "telefonos",
    "tipo",
    "area",
    "alias",
    "envioElectronico",
    "localidades",
    "servicios",
    "idsLocalidades",
    "prioridades"
})
public class IkePrestador {

    @XmlElementRef(name = "id_prestador", namespace = "tns", type = JAXBElement.class, required = false)
    protected JAXBElement<String> idPrestador;
    @XmlElementRef(name = "nombre", namespace = "tns", type = JAXBElement.class, required = false)
    protected JAXBElement<String> nombre;
    @XmlElementRef(name = "razon_social", namespace = "tns", type = JAXBElement.class, required = false)
    protected JAXBElement<String> razonSocial;
    @XmlElementRef(name = "titular", namespace = "tns", type = JAXBElement.class, required = false)
    protected JAXBElement<String> titular;
    @XmlElementRef(name = "cuit", namespace = "tns", type = JAXBElement.class, required = false)
    protected JAXBElement<String> cuit;
    @XmlElementRef(name = "activo", namespace = "tns", type = JAXBElement.class, required = false)
    protected JAXBElement<String> activo;
    @XmlElementRef(name = "pais", namespace = "tns", type = JAXBElement.class, required = false)
    protected JAXBElement<String> pais;
    @XmlElementRef(name = "provincia", namespace = "tns", type = JAXBElement.class, required = false)
    protected JAXBElement<String> provincia;
    @XmlElementRef(name = "localidad", namespace = "tns", type = JAXBElement.class, required = false)
    protected JAXBElement<String> localidad;
    @XmlElementRef(name = "direccion", namespace = "tns", type = JAXBElement.class, required = false)
    protected JAXBElement<String> direccion;
    @XmlElementRef(name = "lat_lng", namespace = "tns", type = JAXBElement.class, required = false)
    protected JAXBElement<String> latLng;
    @XmlElementRef(name = "horario", namespace = "tns", type = JAXBElement.class, required = false)
    protected JAXBElement<String> horario;
    @XmlElementRef(name = "email", namespace = "tns", type = JAXBElement.class, required = false)
    protected JAXBElement<String> email;
    @XmlElementRef(name = "telefonos", namespace = "tns", type = JAXBElement.class, required = false)
    protected JAXBElement<String> telefonos;
    @XmlElementRef(name = "tipo", namespace = "tns", type = JAXBElement.class, required = false)
    protected JAXBElement<String> tipo;
    @XmlElementRef(name = "area", namespace = "tns", type = JAXBElement.class, required = false)
    protected JAXBElement<String> area;
    @XmlElementRef(name = "alias", namespace = "tns", type = JAXBElement.class, required = false)
    protected JAXBElement<String> alias;
    @XmlElementRef(name = "envio_electronico", namespace = "tns", type = JAXBElement.class, required = false)
    protected JAXBElement<String> envioElectronico;
    @XmlElement(required = true)
    protected List<String> localidades;
    @XmlElement(required = true)
    protected List<String> servicios;
    @XmlElement(name = "ids_localidades", required = true)
    protected List<String> idsLocalidades;
    @XmlElement(required = true)
    protected List<String> prioridades;

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
     * Obtiene el valor de la propiedad nombre.
     * 
     * @return
     *     possible object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public JAXBElement<String> getNombre() {
        return nombre;
    }

    /**
     * Define el valor de la propiedad nombre.
     * 
     * @param value
     *     allowed object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public void setNombre(JAXBElement<String> value) {
        this.nombre = value;
    }

    /**
     * Obtiene el valor de la propiedad razonSocial.
     * 
     * @return
     *     possible object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public JAXBElement<String> getRazonSocial() {
        return razonSocial;
    }

    /**
     * Define el valor de la propiedad razonSocial.
     * 
     * @param value
     *     allowed object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public void setRazonSocial(JAXBElement<String> value) {
        this.razonSocial = value;
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
     * Obtiene el valor de la propiedad cuit.
     * 
     * @return
     *     possible object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public JAXBElement<String> getCuit() {
        return cuit;
    }

    /**
     * Define el valor de la propiedad cuit.
     * 
     * @param value
     *     allowed object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public void setCuit(JAXBElement<String> value) {
        this.cuit = value;
    }

    /**
     * Obtiene el valor de la propiedad activo.
     * 
     * @return
     *     possible object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public JAXBElement<String> getActivo() {
        return activo;
    }

    /**
     * Define el valor de la propiedad activo.
     * 
     * @param value
     *     allowed object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public void setActivo(JAXBElement<String> value) {
        this.activo = value;
    }

    /**
     * Obtiene el valor de la propiedad pais.
     * 
     * @return
     *     possible object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public JAXBElement<String> getPais() {
        return pais;
    }

    /**
     * Define el valor de la propiedad pais.
     * 
     * @param value
     *     allowed object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public void setPais(JAXBElement<String> value) {
        this.pais = value;
    }

    /**
     * Obtiene el valor de la propiedad provincia.
     * 
     * @return
     *     possible object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public JAXBElement<String> getProvincia() {
        return provincia;
    }

    /**
     * Define el valor de la propiedad provincia.
     * 
     * @param value
     *     allowed object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public void setProvincia(JAXBElement<String> value) {
        this.provincia = value;
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
     * Obtiene el valor de la propiedad direccion.
     * 
     * @return
     *     possible object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public JAXBElement<String> getDireccion() {
        return direccion;
    }

    /**
     * Define el valor de la propiedad direccion.
     * 
     * @param value
     *     allowed object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public void setDireccion(JAXBElement<String> value) {
        this.direccion = value;
    }

    /**
     * Obtiene el valor de la propiedad latLng.
     * 
     * @return
     *     possible object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public JAXBElement<String> getLatLng() {
        return latLng;
    }

    /**
     * Define el valor de la propiedad latLng.
     * 
     * @param value
     *     allowed object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public void setLatLng(JAXBElement<String> value) {
        this.latLng = value;
    }

    /**
     * Obtiene el valor de la propiedad horario.
     * 
     * @return
     *     possible object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public JAXBElement<String> getHorario() {
        return horario;
    }

    /**
     * Define el valor de la propiedad horario.
     * 
     * @param value
     *     allowed object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public void setHorario(JAXBElement<String> value) {
        this.horario = value;
    }

    /**
     * Obtiene el valor de la propiedad email.
     * 
     * @return
     *     possible object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public JAXBElement<String> getEmail() {
        return email;
    }

    /**
     * Define el valor de la propiedad email.
     * 
     * @param value
     *     allowed object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public void setEmail(JAXBElement<String> value) {
        this.email = value;
    }

    /**
     * Obtiene el valor de la propiedad telefonos.
     * 
     * @return
     *     possible object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public JAXBElement<String> getTelefonos() {
        return telefonos;
    }

    /**
     * Define el valor de la propiedad telefonos.
     * 
     * @param value
     *     allowed object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public void setTelefonos(JAXBElement<String> value) {
        this.telefonos = value;
    }

    /**
     * Obtiene el valor de la propiedad tipo.
     * 
     * @return
     *     possible object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public JAXBElement<String> getTipo() {
        return tipo;
    }

    /**
     * Define el valor de la propiedad tipo.
     * 
     * @param value
     *     allowed object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public void setTipo(JAXBElement<String> value) {
        this.tipo = value;
    }

    /**
     * Obtiene el valor de la propiedad area.
     * 
     * @return
     *     possible object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public JAXBElement<String> getArea() {
        return area;
    }

    /**
     * Define el valor de la propiedad area.
     * 
     * @param value
     *     allowed object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public void setArea(JAXBElement<String> value) {
        this.area = value;
    }

    /**
     * Obtiene el valor de la propiedad alias.
     * 
     * @return
     *     possible object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public JAXBElement<String> getAlias() {
        return alias;
    }

    /**
     * Define el valor de la propiedad alias.
     * 
     * @param value
     *     allowed object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public void setAlias(JAXBElement<String> value) {
        this.alias = value;
    }

    /**
     * Obtiene el valor de la propiedad envioElectronico.
     * 
     * @return
     *     possible object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public JAXBElement<String> getEnvioElectronico() {
        return envioElectronico;
    }

    /**
     * Define el valor de la propiedad envioElectronico.
     * 
     * @param value
     *     allowed object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public void setEnvioElectronico(JAXBElement<String> value) {
        this.envioElectronico = value;
    }

    /**
     * Gets the value of the localidades property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the localidades property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getLocalidades().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link String }
     * 
     * 
     */
    public List<String> getLocalidades() {
        if (localidades == null) {
            localidades = new ArrayList<String>();
        }
        return this.localidades;
    }

    /**
     * Gets the value of the servicios property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the servicios property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getServicios().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link String }
     * 
     * 
     */
    public List<String> getServicios() {
        if (servicios == null) {
            servicios = new ArrayList<String>();
        }
        return this.servicios;
    }

    /**
     * Gets the value of the idsLocalidades property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the idsLocalidades property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getIdsLocalidades().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link String }
     * 
     * 
     */
    public List<String> getIdsLocalidades() {
        if (idsLocalidades == null) {
            idsLocalidades = new ArrayList<String>();
        }
        return this.idsLocalidades;
    }

    /**
     * Gets the value of the prioridades property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the prioridades property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getPrioridades().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link String }
     * 
     * 
     */
    public List<String> getPrioridades() {
        if (prioridades == null) {
            prioridades = new ArrayList<String>();
        }
        return this.prioridades;
    }

}
