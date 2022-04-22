
package ar.com.ike.geo.ws.tns;

import javax.xml.bind.JAXBElement;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElementRef;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Clase Java para ike_prestador_processResponse complex type.
 * 
 * <p>El siguiente fragmento de esquema especifica el contenido que se espera que haya en esta clase.
 * 
 * <pre>
 * &lt;complexType name="ike_prestador_processResponse">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="ike_prestador_processResult" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "ike_prestador_processResponse", propOrder = {
    "ikePrestadorProcessResult"
})
public class IkePrestadorProcessResponse {

    @XmlElementRef(name = "ike_prestador_processResult", namespace = "tns", type = JAXBElement.class)
    protected JAXBElement<String> ikePrestadorProcessResult;

    /**
     * Obtiene el valor de la propiedad ikePrestadorProcessResult.
     * 
     * @return
     *     possible object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public JAXBElement<String> getIkePrestadorProcessResult() {
        return ikePrestadorProcessResult;
    }

    /**
     * Define el valor de la propiedad ikePrestadorProcessResult.
     * 
     * @param value
     *     allowed object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public void setIkePrestadorProcessResult(JAXBElement<String> value) {
        this.ikePrestadorProcessResult = value;
    }

}
