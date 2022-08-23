
package ar.com.ike.geo.ws.capa;

import javax.xml.bind.JAXBElement;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElementRef;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Clase Java para asignar_servicioResponse complex type.
 * 
 * <p>El siguiente fragmento de esquema especifica el contenido que se espera que haya en esta clase.
 * 
 * <pre>
 * &lt;complexType name="asignar_servicioResponse">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="asignar_servicioResult" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "asignar_servicioResponse", propOrder = {
    "asignarServicioResult"
})
public class AsignarServicioResponse {

    @XmlElementRef(name = "asignar_servicioResult", namespace = "tns", type = JAXBElement.class, required = false)
    protected JAXBElement<String> asignarServicioResult;

    /**
     * Obtiene el valor de la propiedad asignarServicioResult.
     * 
     * @return
     *     possible object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public JAXBElement<String> getAsignarServicioResult() {
        return asignarServicioResult;
    }

    /**
     * Define el valor de la propiedad asignarServicioResult.
     * 
     * @param value
     *     allowed object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public void setAsignarServicioResult(JAXBElement<String> value) {
        this.asignarServicioResult = value;
    }

}
