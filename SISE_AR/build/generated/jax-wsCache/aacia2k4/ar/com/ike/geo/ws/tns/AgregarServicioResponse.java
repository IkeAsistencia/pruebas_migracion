
package ar.com.ike.geo.ws.tns;

import javax.xml.bind.JAXBElement;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElementRef;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Clase Java para agregar_servicioResponse complex type.
 * 
 * <p>El siguiente fragmento de esquema especifica el contenido que se espera que haya en esta clase.
 * 
 * <pre>
 * &lt;complexType name="agregar_servicioResponse">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="agregar_servicioResult" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "agregar_servicioResponse", propOrder = {
    "agregarServicioResult"
})
public class AgregarServicioResponse {

    @XmlElementRef(name = "agregar_servicioResult", namespace = "tns", type = JAXBElement.class)
    protected JAXBElement<String> agregarServicioResult;

    /**
     * Obtiene el valor de la propiedad agregarServicioResult.
     * 
     * @return
     *     possible object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public JAXBElement<String> getAgregarServicioResult() {
        return agregarServicioResult;
    }

    /**
     * Define el valor de la propiedad agregarServicioResult.
     * 
     * @param value
     *     allowed object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public void setAgregarServicioResult(JAXBElement<String> value) {
        this.agregarServicioResult = value;
    }

}
