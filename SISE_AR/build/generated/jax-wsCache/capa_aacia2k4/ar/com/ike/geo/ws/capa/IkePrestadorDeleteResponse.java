
package ar.com.ike.geo.ws.capa;

import javax.xml.bind.JAXBElement;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElementRef;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Clase Java para ike_prestador_deleteResponse complex type.
 * 
 * <p>El siguiente fragmento de esquema especifica el contenido que se espera que haya en esta clase.
 * 
 * <pre>
 * &lt;complexType name="ike_prestador_deleteResponse">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="ike_prestador_deleteResult" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "ike_prestador_deleteResponse", propOrder = {
    "ikePrestadorDeleteResult"
})
public class IkePrestadorDeleteResponse {

    @XmlElementRef(name = "ike_prestador_deleteResult", namespace = "tns", type = JAXBElement.class, required = false)
    protected JAXBElement<String> ikePrestadorDeleteResult;

    /**
     * Obtiene el valor de la propiedad ikePrestadorDeleteResult.
     * 
     * @return
     *     possible object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public JAXBElement<String> getIkePrestadorDeleteResult() {
        return ikePrestadorDeleteResult;
    }

    /**
     * Define el valor de la propiedad ikePrestadorDeleteResult.
     * 
     * @param value
     *     allowed object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public void setIkePrestadorDeleteResult(JAXBElement<String> value) {
        this.ikePrestadorDeleteResult = value;
    }

}
