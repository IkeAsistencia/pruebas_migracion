
package ar.com.ike.geo.ws.capa;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Clase Java para ike_prestador_delete complex type.
 * 
 * <p>El siguiente fragmento de esquema especifica el contenido que se espera que haya en esta clase.
 * 
 * <pre>
 * &lt;complexType name="ike_prestador_delete">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="id_prestador" type="{http://www.w3.org/2001/XMLSchema}string"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "ike_prestador_delete", propOrder = {
    "idPrestador"
})
public class IkePrestadorDelete {

    @XmlElement(name = "id_prestador", required = true)
    protected String idPrestador;

    /**
     * Obtiene el valor de la propiedad idPrestador.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getIdPrestador() {
        return idPrestador;
    }

    /**
     * Define el valor de la propiedad idPrestador.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setIdPrestador(String value) {
        this.idPrestador = value;
    }

}
