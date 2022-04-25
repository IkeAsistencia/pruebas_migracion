/*
 * MemoPDF.java
 *
 * Created on 14 de agosto de 2008, 21:02
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */
package com.ike.helpdesk;

import Utilerias.UtileriasBDF;
import com.lowagie.text.Chunk;
import com.lowagie.text.Document;
import com.lowagie.text.Element;
import com.lowagie.text.ExceptionConverter;
import com.lowagie.text.Font;
import com.lowagie.text.Image;
import com.lowagie.text.PageSize;
import com.lowagie.text.Paragraph;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.pdf.PdfContentByte;
import com.lowagie.text.pdf.PdfPageEventHelper;
import com.lowagie.text.pdf.PdfWriter;
import java.awt.Color;
import java.io.FileOutputStream;
import java.sql.ResultSet;

/*
 *
 * @author vsampablo
 */
public class MemoPDF extends PdfPageEventHelper {

    private static String CCP = "";
    private static String VoBoNom = "";
    private static DAOHelpdesk daoh = null;
    private static HDSolicitud Solicitud = null;
    private static String Path = "";
    private static String Imagen = "";

    /* Creates a new instance of MemoPDF */
    public MemoPDF() {
    }

    public void ShowPDF(String clSolicitud) {

        int clUsrReg = 0;

        try {

            //<<<<<<<<<<<<<< Ruta Para TEST >>>>>>>>>>>>

            //Path="C:\\Aplicaciones\\SISE_AR\\build\\web\\HelpDesk\\Memorando.pdf";
            //Imagen="C:\\Aplicaciones\\SISE_AR\\build\\web\\Imagenes\\IKE-M.gif";

            //<<<<<<<<<<<<< Ruta para Produccion >>>>>>>>>>>>>
            Path = "/opt/app/apache-tomcat-7.0.35/webapps/SISE_AR/HelpDesk/Memorando.pdf";
            Imagen = "/opt/app/apache-tomcat-7.0.35/webapps/SISE_AR/Imagenes/IKE-M.gif";

            daoh = new DAOHelpdesk();
            Solicitud = daoh.getSolicitud(clSolicitud);

            clUsrReg = Solicitud.getClUsrRegistra();

            StringBuffer StrSql = new StringBuffer();
            StrSql.append("sp_MemoCPP ").append(clSolicitud).append(",").append(clUsrReg);
            ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());


            try {
                if (rs.next()) {
                    CCP = rs.getString("CPP");
                    VoBoNom = rs.getString("Nombre");
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try {
                    //<<<<<<<<<<<<<<<<<<<  Cerrar conexiones >>>>>>>>>>>>>>>>>>>
                    if (rs != null) {
                        rs.close();
                        rs = null;
                    }
                    //<<<<<<<<<<<<<<<<<<<< Limpiar Variables >>>>>>>>>>>>>>>>>>
                    // CCP=null;
                    StrSql = null;
                } catch (Exception ee) {
                    ee.printStackTrace();
                }
            }

            Document document = new Document(PageSize.A4, 50, 60, 246, 190);
            //Document document = new Document(PageSize.A4, 40,40,21,21);
            PdfWriter writer = PdfWriter.getInstance(document, new FileOutputStream(Path.replace(".pdf", "") + "_" + clSolicitud + ".pdf"));
            //PdfWriter writer=PdfWriter.getInstance(document,new FileOutputStream(Path));

            writer.setPageEvent(new MemoPDF());
            document.open();

            //<<<<<<<<<<<<<<<<<<<< Detalle de la Solicitud >>>>>>>>>>>>>>>>>>>>
            Font font = new Font(Font.HELVETICA, 10);
            font.setColor(new Color(0x00, 0x00, 0x00));
            Chunk fox = new Chunk(Solicitud.getDetalleSolicitud(), font);

            Paragraph paragraph = new Paragraph(fox);

            document.setMargins(50, 60, 130, 80);

            paragraph.setLeading(10f);
            paragraph.setAlignment(paragraph.ALIGN_JUSTIFIED);

            document.add(paragraph);

            PdfContentByte cb = writer.getDirectContent();

            //<<<<<<<<<<<<<<<<<< \n  >>>>>>>>>>>>>>>>>
            //document.add(new Paragraph("\n\n\n\n\n\n"));

            document.close();
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public void onOpenDocument(PdfWriter writer, Document document) {


        try {

            // initialization of the header table
            Image jpg = Image.getInstance(Imagen);
            //jpg.setAlignment(1);
            jpg.setAbsolutePosition(30, 760);
            jpg.scaleAbsolute(230, 60);
            document.add(jpg);

            PdfContentByte cb = writer.getDirectContent();
            cb.beginText();
            cb.setFontAndSize(BaseFont.createFont(BaseFont.HELVETICA_BOLD, BaseFont.WINANSI, BaseFont.EMBEDDED), 8);
            cb.setRGBColorFill(0, 0, 0);
            cb.showTextAligned(Element.ALIGN_LEFT, "ATENTAMENTE", 110, 140, 0);

            cb.showTextAligned(Element.ALIGN_LEFT, "Vo.Bo.", 420, 140, 0);
            cb.endText();

            // <<<<<<<<<<<<<<<<< Insertar  una linea en el PDF >>>>>>>>>>>>>>>>>
            cb.setLineWidth(0.5f);
            cb.moveTo(80, 95);
            cb.lineTo(205, 95);
            cb.stroke();

            // <<<<<<<<<<<<<<<<< Insertar  una linea en el PDF >>>>>>>>>>>>>>>>>
            cb.setLineWidth(0.5f);
            cb.moveTo(370, 95);
            cb.lineTo(490, 95);
            cb.stroke();

            // <<<<<<<<<<<<<<<<< Insertar  una linea en el PDF >>>>>>>>>>>>>>>>>
            cb.setLineWidth(1f);
            cb.moveTo(25, 750);
            cb.lineTo(370, 750);
            cb.stroke();


            //<<<<<<<<<<<<<<<<<< Insertar Texto con Formato >>>>>>>>>>>>>>>>>>
            cb.beginText();
            cb.setFontAndSize(BaseFont.createFont(BaseFont.HELVETICA_BOLD, BaseFont.WINANSI, BaseFont.EMBEDDED), 30);
            cb.setRGBColorFill(0, 0, 0);
            cb.showTextAligned(Element.ALIGN_LEFT, "MEMORANDO", 375, 743, 0);
            cb.endText();

            // <<<<<<<<<<<<<<<<< Insertar  una linea en el PDF >>>>>>>>>>>>>>>>>
            cb.setLineWidth(0.95f);
            cb.moveTo(25, 625);
            cb.lineTo(570, 625);
            cb.stroke();

            //<<<<<<<<<<<<<<<<< Insertar Titulos del Memorando >>>>>>>>>>>>>>>>
            cb.beginText();
            cb.setFontAndSize(BaseFont.createFont(BaseFont.HELVETICA_BOLD, BaseFont.WINANSI, BaseFont.EMBEDDED), 12);
            cb.setRGBColorFill(0, 0, 0);
            cb.showTextAligned(Element.ALIGN_LEFT, "Folio de Solicitud:", 25, 730, 0);
            cb.showTextAligned(Element.ALIGN_LEFT, "" + Solicitud.getClSolicitud(), 160, 730, 0);
            cb.showTextAligned(Element.ALIGN_LEFT, "DETALLE DE LA SOLICITUD:", 25, 610, 0);
            cb.endText();

            String TDatos[] = {"DE:", "PARA:", "C.C.P:", "TIPO DE SOLICITUD:", "ASUNTO:", "FECHA DE SOLICITUD:"};
            String Datos[] = {Solicitud.getUsrRegistra().toUpperCase().toString(), "RICARDO CABRERA SÁNCHEZ", CCP.toString(), Solicitud.getDsTipoSol().toUpperCase().toString(), Solicitud.getAsunto().toUpperCase().toString(), Solicitud.getFechaRegistro().substring(0, 10).toString()};

            float ptx = 0, pty = 0, ptyD = 0;

            String Px[] = {"50", "50", "50", "50", "50", "50"};
            String Py[] = {"715", "700", "685", "670", "655", "640"};

            String PyD[] = {"715", "700", "685", "670", "655", "640"};

            cb.beginText();
            cb.setFontAndSize(BaseFont.createFont(BaseFont.HELVETICA_BOLD, BaseFont.WINANSI, BaseFont.EMBEDDED), 8f);
            cb.setRGBColorFill(0, 0, 0);

            //<<<<<<<<<<<<<<<<<  Llenar Origional y Copia de los datos en el PDF >>>>>>>>>>>>>>>> 
            for (int i = 0; i < TDatos.length; i++) {
                ptx = Float.parseFloat(Px[i]);
                pty = Float.parseFloat(Py[i]);

                ptyD = Float.parseFloat(PyD[i]);

                cb.showTextAligned(Element.ALIGN_LEFT, TDatos[i], ptx, pty, 0);

                cb.showTextAligned(Element.ALIGN_LEFT, Datos[i], 160, pty, 0);
            }

            cb.endText();


            //<<<<<<<<<<<<<<<< Atentamente     >>>>>>>>>>>>>>>>
            //<<<<<<<<<<<<<<<< Vo.Bo     >>>>>>>>>>>>>>>>
            cb.beginText();
            cb.setFontAndSize(BaseFont.createFont(BaseFont.HELVETICA_BOLD, BaseFont.WINANSI, BaseFont.EMBEDDED), 8);
            cb.setRGBColorFill(0, 0, 0);
            cb.showTextAligned(Element.ALIGN_LEFT, Solicitud.getUsrRegistra().toUpperCase(), 85, 80, 0);
            cb.showTextAligned(Element.ALIGN_LEFT, VoBoNom.toUpperCase(), 372, 80, 0);
            cb.endText();

        } catch (Exception e) {
            throw new ExceptionConverter(e);
        }
    }

    public void onStartPage(PdfWriter writer, Document document) {
        try {
            // initialization of the header table
            Image jpg = Image.getInstance(Imagen);
            //jpg.setAlignment(1);
            jpg.setAbsolutePosition(30, 760);
            jpg.scaleAbsolute(230, 60);
            document.add(jpg);

            PdfContentByte cb = writer.getDirectContent();

            // <<<<<<<<<<<<<<<<< Insertar  una linea en el PDF >>>>>>>>>>>>>>>>>
            cb.setLineWidth(1f);
            cb.moveTo(25, 750);
            cb.lineTo(370, 750);
            cb.stroke();

            //<<<<<<<<<<<<<<<<<< Insertar Texto con Formato >>>>>>>>>>>>>>>>>>
            cb.beginText();
            cb.setFontAndSize(BaseFont.createFont(BaseFont.HELVETICA_BOLD, BaseFont.WINANSI, BaseFont.EMBEDDED), 30);
            cb.setRGBColorFill(0, 0, 0);
            cb.showTextAligned(Element.ALIGN_LEFT, "MEMORANDO", 375, 743, 0);
            cb.endText();

            String text = "" + writer.getPageNumber();

        } catch (Exception e) {
            throw new ExceptionConverter(e);
        }
    }

    public void onEndPage(PdfWriter writer, Document document) {
        PdfContentByte cb = writer.getDirectContent();
        String text = "" + writer.getPageNumber();
        try {
            cb.beginText();
            cb.setFontAndSize(BaseFont.createFont(BaseFont.HELVETICA, BaseFont.WINANSI, BaseFont.EMBEDDED), 9);
            cb.setRGBColorFill(0, 0, 0);
            cb.showTextAligned(Element.ALIGN_LEFT, text, 560, 30, 0);
            cb.endText();

            //<<<<<<<<<<<<<< Si hay mas de una Hoja >>>>>>>>>>>>>>
            if (!text.equalsIgnoreCase("1")) {
                //<<<<<<<<<<<<<<<<<<<< Continuación >>>>>>>>>>>>>>>>>>>>
                cb.beginText();
                cb.setFontAndSize(BaseFont.createFont(BaseFont.HELVETICA, BaseFont.WINANSI, BaseFont.EMBEDDED), 10);
                cb.setRGBColorFill(0, 0, 0);
                cb.showTextAligned(Element.ALIGN_LEFT, "Continuación...", 80, 730, 0);
                cb.endText();
            }
        } catch (Exception e) {
        }
    }

    public void onCloseDocument(PdfWriter writer, Document document) {
        if (daoh != null) {
            daoh = null;
            Solicitud = null;
            Path = null;
            Imagen = null;
            CCP = null;
            VoBoNom = null;
        }
    }
}
