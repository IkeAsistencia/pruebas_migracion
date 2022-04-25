
package ar.com.ike.geo.ws.tns;

import javax.xml.bind.JAXBElement;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElementRef;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Clase Java para ike_prestadorResponse complex type.
 * 
 * <p>El siguiente fragmento de esquema especifica el contenido que se espera que haya en esta clase.
 * 
 * <pre>
 * &lt;complexType name="ike_prestadorResponse">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="ike_prestadorResult" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "ike_prestadorResponse", propOrder = {
    "ikePrestadorResult"
})
public class IkePrestadorResponse {

    @XmlElementRef(name = "ike_prestadorResult", namespace = "tns", type = JAXBElement.class)
    protected JAXBElement<String> ikePrestadorResult;

    /**
     * Obtiene el valor de la propiedad ikePrestadorResult.
     * 
     * @return
     *     possible object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public JAXBElement<String> getIkePrestadorResult() {
        return ikePrestadorResult;
    }

    /**
     * Define el valor de la propiedad ikePrestadorResult.
     * 
     * @param value
     *     allowed object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public void setIkePrestadorResult(JAXBElement<String> value) {
        this.ikePrestadorResult = value;
    }

}
