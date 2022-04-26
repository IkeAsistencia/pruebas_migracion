
package ar.com.ike.geo.ws.tns;

import javax.xml.bind.JAXBElement;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElementRef;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Clase Java para prestadores_servicioResponse complex type.
 * 
 * <p>El siguiente fragmento de esquema especifica el contenido que se espera que haya en esta clase.
 * 
 * <pre>
 * &lt;complexType name="prestadores_servicioResponse">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="prestadores_servicioResult" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "prestadores_servicioResponse", propOrder = {
    "prestadoresServicioResult"
})
public class PrestadoresServicioResponse {

    @XmlElementRef(name = "prestadores_servicioResult", namespace = "tns", type = JAXBElement.class)
    protected JAXBElement<String> prestadoresServicioResult;

    /**
     * Obtiene el valor de la propiedad prestadoresServicioResult.
     * 
     * @return
     *     possible object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public JAXBElement<String> getPrestadoresServicioResult() {
        return prestadoresServicioResult;
    }

    /**
     * Define el valor de la propiedad prestadoresServicioResult.
     * 
     * @param value
     *     allowed object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public void setPrestadoresServicioResult(JAXBElement<String> value) {
        this.prestadoresServicioResult = value;
    }

}
