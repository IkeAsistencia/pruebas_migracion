
package ar.com.ike.geo.ws.capa;

import javax.xml.bind.JAXBElement;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElementRef;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Clase Java para prestadores_servicio complex type.
 * 
 * <p>El siguiente fragmento de esquema especifica el contenido que se espera que haya en esta clase.
 * 
 * <pre>
 * &lt;complexType name="prestadores_servicio">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="id_origen" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="id_destino" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="id_caso" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="id_servicio" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="id_subservicio" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "prestadores_servicio", propOrder = {
    "idOrigen",
    "idDestino",
    "idCaso",
    "idServicio",
    "idSubservicio"
})
public class PrestadoresServicio {

    @XmlElementRef(name = "id_origen", namespace = "tns", type = JAXBElement.class, required = false)
    protected JAXBElement<String> idOrigen;
    @XmlElementRef(name = "id_destino", namespace = "tns", type = JAXBElement.class, required = false)
    protected JAXBElement<String> idDestino;
    @XmlElementRef(name = "id_caso", namespace = "tns", type = JAXBElement.class, required = false)
    protected JAXBElement<String> idCaso;
    @XmlElementRef(name = "id_servicio", namespace = "tns", type = JAXBElement.class, required = false)
    protected JAXBElement<String> idServicio;
    @XmlElementRef(name = "id_subservicio", namespace = "tns", type = JAXBElement.class, required = false)
    protected JAXBElement<String> idSubservicio;

    /**
     * Obtiene el valor de la propiedad idOrigen.
     * 
     * @return
     *     possible object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public JAXBElement<String> getIdOrigen() {
        return idOrigen;
    }

    /**
     * Define el valor de la propiedad idOrigen.
     * 
     * @param value
     *     allowed object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public void setIdOrigen(JAXBElement<String> value) {
        this.idOrigen = value;
    }

    /**
     * Obtiene el valor de la propiedad idDestino.
     * 
     * @return
     *     possible object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public JAXBElement<String> getIdDestino() {
        return idDestino;
    }

    /**
     * Define el valor de la propiedad idDestino.
     * 
     * @param value
     *     allowed object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public void setIdDestino(JAXBElement<String> value) {
        this.idDestino = value;
    }

    /**
     * Obtiene el valor de la propiedad idCaso.
     * 
     * @return
     *     possible object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public JAXBElement<String> getIdCaso() {
        return idCaso;
    }

    /**
     * Define el valor de la propiedad idCaso.
     * 
     * @param value
     *     allowed object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public void setIdCaso(JAXBElement<String> value) {
        this.idCaso = value;
    }

    /**
     * Obtiene el valor de la propiedad idServicio.
     * 
     * @return
     *     possible object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public JAXBElement<String> getIdServicio() {
        return idServicio;
    }

    /**
     * Define el valor de la propiedad idServicio.
     * 
     * @param value
     *     allowed object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public void setIdServicio(JAXBElement<String> value) {
        this.idServicio = value;
    }

    /**
     * Obtiene el valor de la propiedad idSubservicio.
     * 
     * @return
     *     possible object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public JAXBElement<String> getIdSubservicio() {
        return idSubservicio;
    }

    /**
     * Define el valor de la propiedad idSubservicio.
     * 
     * @param value
     *     allowed object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public void setIdSubservicio(JAXBElement<String> value) {
        this.idSubservicio = value;
    }

}
