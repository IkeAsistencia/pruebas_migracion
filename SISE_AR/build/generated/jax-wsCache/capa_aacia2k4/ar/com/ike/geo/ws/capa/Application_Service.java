
package ar.com.ike.geo.ws.capa;

import java.net.MalformedURLException;
import java.net.URL;
import javax.xml.namespace.QName;
import javax.xml.ws.Service;
import javax.xml.ws.WebEndpoint;
import javax.xml.ws.WebServiceClient;
import javax.xml.ws.WebServiceException;
import javax.xml.ws.WebServiceFeature;


/**
 * This class was generated by the JAX-WS RI.
 * JAX-WS RI 2.2.6-1b01 
 * Generated source version: 2.2
 * 
 */
@WebServiceClient(name = "Application", targetNamespace = "tns", wsdlLocation = "http://gps.ikeasistencia.com.ar:9000/soap/capa_aacia2k4?wsdl")
public class Application_Service
    extends Service
{

    private final static URL APPLICATION_WSDL_LOCATION;
    private final static WebServiceException APPLICATION_EXCEPTION;
    private final static QName APPLICATION_QNAME = new QName("tns", "Application");

    static {
        URL url = null;
        WebServiceException e = null;
        try {
            url = new URL("http://gps.ikeasistencia.com.ar:9000/soap/capa_aacia2k4?wsdl");
        } catch (MalformedURLException ex) {
            e = new WebServiceException(ex);
        }
        APPLICATION_WSDL_LOCATION = url;
        APPLICATION_EXCEPTION = e;
    }

    public Application_Service() {
        super(__getWsdlLocation(), APPLICATION_QNAME);
    }

    public Application_Service(WebServiceFeature... features) {
        super(__getWsdlLocation(), APPLICATION_QNAME, features);
    }

    public Application_Service(URL wsdlLocation) {
        super(wsdlLocation, APPLICATION_QNAME);
    }

    public Application_Service(URL wsdlLocation, WebServiceFeature... features) {
        super(wsdlLocation, APPLICATION_QNAME, features);
    }

    public Application_Service(URL wsdlLocation, QName serviceName) {
        super(wsdlLocation, serviceName);
    }

    public Application_Service(URL wsdlLocation, QName serviceName, WebServiceFeature... features) {
        super(wsdlLocation, serviceName, features);
    }

    /**
     * 
     * @return
     *     returns Application
     */
    @WebEndpoint(name = "Application")
    public Application getApplication() {
        return super.getPort(new QName("tns", "Application"), Application.class);
    }

    /**
     * 
     * @param features
     *     A list of {@link javax.xml.ws.WebServiceFeature} to configure on the proxy.  Supported features not in the <code>features</code> parameter will have their default values.
     * @return
     *     returns Application
     */
    @WebEndpoint(name = "Application")
    public Application getApplication(WebServiceFeature... features) {
        return super.getPort(new QName("tns", "Application"), Application.class, features);
    }

    private static URL __getWsdlLocation() {
        if (APPLICATION_EXCEPTION!= null) {
            throw APPLICATION_EXCEPTION;
        }
        return APPLICATION_WSDL_LOCATION;
    }

}
