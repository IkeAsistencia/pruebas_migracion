/*
 * ImpresionPDF.java
 *
 * Created on 14 de agosto de 2008, 21:02
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */
package com.ike.helpdeskSP;

import com.lowagie.text.pdf.AcroFields;
import com.lowagie.text.pdf.PdfReader;
import com.lowagie.text.pdf.PdfStamper;
import java.io.FileOutputStream;

/*
 *
 * @author vsampablo
 */
public class ImpresionPDF {

    private static DAOHelpdeskSP daoh = null;
    private static HelpdeskSP Solicitud = null;
    private static String Path = "";

    /* Creates a new instance of ImpresionPDF */
    public ImpresionPDF() {
    }

    public static void ShowPDF(String clSolicitud) {

        try {

            //<<<<<<<<<<<<<< Ruta Para TEST >>>>>>>>>>>>
            //Path = "C:\\PROYECTOS\\SISE_AR\\build\\web\\HelpDeskSP\\Impresion.pdf";
            //Path="C:\\SISE\\build\\web\\HelpDeskSP\\Impresion.pdf";

            //<<<<<<<<<<<<< Ruta para Produccion >>>>>>>>>>>>>
            Path = "/opt/app/apache-tomcat-7.0.50/webapps/SISE_AR/HelpDeskSP/Impresion.pdf";

            String clAtencion = "";
            String clDominio = "";
            String clActitud = "";
            String clServicio = "";
            String clTiempodeEspera = "";

            daoh = new DAOHelpdeskSP();
            Solicitud = daoh.getHelpdeskSP(clSolicitud);

            // Document document = new Document(PageSize.A4,50,60,248,250);
            //Document document = new Document(PageSize.A4, 40,40,21,21);
            //PdfWriter writer=PdfWriter.getInstance(document,new FileOutputStream(Path.replace(".pdf","")+".pdf"));
            //PdfWriter writer=PdfWriter.getInstance(document,new FileOutputStream(Path));

            PdfReader reader = new PdfReader(Path);
            PdfStamper stamper = new PdfStamper(reader, new FileOutputStream(Path.replace(".pdf", "") + "_" + clSolicitud.toString() + ".pdf"));
            AcroFields form = stamper.getAcroFields();

            form.setField("NombreUsr", Solicitud.getNombreUsrSP().toString());
            form.setField("NombreUsrR", Solicitud.getNombre().toString());
            form.setField("Ext", Solicitud.getExtencion().toString());
            form.setField("FechaR", Solicitud.getFechaRegistro().toString());
            form.setField("FechaCon", Solicitud.getFechaTermino().toString());
            form.setField("Folio", Solicitud.getclSolicitud().toString());
            form.setField("Area", Solicitud.getdsAreaOperativa().toString());
            form.setField("Descripcion", Solicitud.getDetalleSol().toString());
            form.setField("Seguimiento", Solicitud.getSeguimiento().toString());
            form.setField("FechaC", Solicitud.getFechaCompromiso().toString());
            form.setField("Asignado", Solicitud.getdsColaboradorAsignadoSP().toString());
            form.setField("Status", Solicitud.getdsEstatus().toString());
            form.setField("FechaT", Solicitud.getFechaTermino().toString());
            form.setField("Actividad", Solicitud.getActividadR().toString());

            clAtencion = Solicitud.getClAtencion().toString();
            clDominio = Solicitud.getClDominio().toString();
            clActitud = Solicitud.getClActitud().toString();
            clServicio = Solicitud.getClServicio().toString();
            clTiempodeEspera = Solicitud.getClTiempodeEspera().toString();

            //<<<<<<<<<<<< Llenado de Calificacion >>>>>>>>>
            //  12/06/2013  RUA
            //  SE CAMBIA EL TIPO DE VALOR DE 1/0 A YES/NO
            form.setField("Atencion" + clAtencion, "Yes");
            form.setField("Dominio" + clDominio, "Yes");
            form.setField("Actitud" + clActitud, "Yes");
            form.setField("Servicio" + clServicio, "Yes");
            form.setField("TRespuesta" + clTiempodeEspera, "Yes");

            stamper.setFormFlattening(true);
            stamper.close();

            reader = null;
            form = null;

            Path = null;
            clAtencion = null;
            clDominio = null;
            clActitud = null;
            clServicio = null;
            clTiempodeEspera = null;
            Solicitud = null;

            daoh = null;
            Solicitud = null;

        } catch (Exception e) {
            System.out.println("ShowPDF Error: " + e);
        }
    }
}
