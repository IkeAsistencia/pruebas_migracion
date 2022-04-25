/*
 * TDTarjeta.java
 *
 * Created on 13 de diciembre de 2011, 07:02
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package Concierge;

import com.ike.concierge.DAOCSSchengenLetter;
import com.ike.concierge.to.CSSchengenLetter;
import com.lowagie.text.pdf.AcroFields;
import com.lowagie.text.pdf.PdfReader;
import com.lowagie.text.pdf.PdfStamper;
import java.io.FileOutputStream;

/*
 *
 * @author mmartinez
 */
public class CSLlenaSchengenLetter {
    private static DAOCSSchengenLetter daoSchengenLetter = null;
    private static CSSchengenLetter SchengenLetter = null;
    private static String Path = "";
    private static String Imagen = "";
    
    /*
     * Creates a new instance of CSLlenaSchengenLetter
     */
    public CSLlenaSchengenLetter()  {
    }
    
    public void LlenaPDF(String ScrclAsistencia){
        try{
            System.out.println("Inicia llenado pdf....");
            // RUTA PARA PRUEBAS - PROYECTO LOCAL
            
//            Path = "D:\\01 Desarrollo\\SISE_BR\\build\\web\\Operacion\\Concierge\\SchengenLetter.pdf";
            Path="/opt/app/apache-tomcat-7.0.35/webapps/SISE_AR/Operacion/Concierge/SchengenLetter.pdf";
            
            System.out.println("Ruta llenado pdf...."+Path);
            
            daoSchengenLetter = new DAOCSSchengenLetter();
            SchengenLetter = daoSchengenLetter.getCSSchengenPDF(ScrclAsistencia);
            
            PdfReader reader = new PdfReader(Path);
            PdfStamper stamper = new PdfStamper(reader,new FileOutputStream(Path.replace(".pdf","")+"_"+ScrclAsistencia.toString()+".pdf"));
            AcroFields form = stamper.getAcroFields();
            
            form.setField("NombreBanco",SchengenLetter.getBanco().toString().trim());
            form.setField("NumeroBin",SchengenLetter.getNumeroBin().toString().trim());
            form.setField("TipoTarjeta",SchengenLetter.getTipoTarjeta().toString().trim());
            form.setField("NuestroUsr",SchengenLetter.getNuestroUsuario().toString().trim());
            form.setField("NombreConyuje",SchengenLetter.getNombreConyuge().toString().trim());
            form.setField("NombreHijos",SchengenLetter.getNombresHijos().toString().trim());
            form.setField("FechaIni",SchengenLetter.getFechaIniViaje().toString().trim());
            form.setField("dsPais",SchengenLetter.getDsPais().toString().trim());
            form.setField("Telefono1",SchengenLetter.getTelefono().toString().trim());
            form.setField("Telefono2",SchengenLetter.getTelefono2().toString().trim());
            form.setField("MailContacto1",SchengenLetter.getMailContacto().toString().trim());
//            form.setField("Mailcontacto2",SchengenLetter.getMailContacto().toString().trim());
            form.setField("UserConcierge",SchengenLetter.getNombreConcierge().toString().trim());
            form.setField("MailConcierge",SchengenLetter.getEmailConcierge().toString().trim());
            
            stamper.setFormFlattening(true);
            stamper.close();
            reader = null;
            form = null;
        }
        
        catch( Exception e){
            System.out.println(e);
        }
    }
}