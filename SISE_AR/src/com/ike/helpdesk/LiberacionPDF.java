/*
 * LiberacionPDF.java
 *
 * Created on 14 de agosto de 2008, 21:02
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */
package com.ike.helpdesk;

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
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfPageEventHelper;
import com.lowagie.text.pdf.PdfWriter;
import java.awt.Color;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.Iterator;

/*
 *
 * @author vsampablo
 */
public class LiberacionPDF extends PdfPageEventHelper {

    private static DAOHelpdesk daoh = null;
    private static HDSolicitud Solicitud = null;
    private static String Path = "";
    private static String Imagen = "";

    /* Creates a new instance of LiberacionPDF */
    public LiberacionPDF() {
    }

    public void ShowPDF(String clSolicitud) {

        int clUsrReg = 0;

        try {

            //<<<<<<<<<<<<<< Ruta Para TEST >>>>>>>>>>>> 
            //Path="C:\\PROYECTOS\\MundoJoven\\public_html\\PDF\\Poliza.pdf";
            //Path="C:\\Aplicaciones\\SISE_AR\\build\\web\\HelpDesk\\Liberacion.pdf";
            //Imagen="C:\\Aplicaciones\\SISE_AR\\build\\web\\Imagenes\\IKE-M.gif";


            //<<<<<<<<<<<<< Ruta para Produccion >>>>>>>>>>>>>
            Path = "/opt/app/apache-tomcat-7.0.35/webapps/SISE_AR/HelpDesk/Liberacion.pdf";
            Imagen = "/opt/app/apache-tomcat-7.0.35/webapps/SISE_AR/Imagenes/IKE-M.gif";

            daoh = new DAOHelpdesk();
            Solicitud = daoh.getSolicitud(clSolicitud);

            Document document = new Document(PageSize.A4, 50, 60, 248, 250);
            //Document document = new Document(PageSize.A4, 40,40,21,21);
            PdfWriter writer = PdfWriter.getInstance(document, new FileOutputStream(Path.replace(".pdf", "") + ".pdf"));
            //PdfWriter writer=PdfWriter.getInstance(document,new FileOutputStream(Path));

            writer.setPageEvent(new LiberacionPDF());
            document.open();

            //<<<<<<<<<<<<<<<<<<<< Detalle de la Solicitud >>>>>>>>>>>>>>>>>>>>
            Font font = new Font(Font.HELVETICA, 9);
            font.setColor(new Color(0x00, 0x00, 0x00));
            Chunk fox = new Chunk(Solicitud.getDetalleSolicitud(), font);

            Paragraph paragraph = new Paragraph(fox);
            document.setMargins(50, 60, 150, 100);

            paragraph.setLeading(10f);
            paragraph.setAlignment(paragraph.ALIGN_JUSTIFIED);

            document.add(paragraph);

            //<<<<<<<<<<<<<<<<<< \n  >>>>>>>>>>>>>>>>>
            document.add(new Paragraph("\n"));

            Font font2 = new Font(font.HELVETICA, 9f, font.BOLD);
            font2.setColor(new Color(0x00, 0x00, 0x00));

            Chunk fox2 = new Chunk("DETALLE DE LIBERACIÓN:", font2);

            paragraph.clear();
            paragraph.setLeading(10f);
            paragraph.add(fox2);
            paragraph.setAlignment(paragraph.ALIGN_JUSTIFIED);
            document.add(paragraph);

            //<<<<<<<<<<<<<<<<<< \n  >>>>>>>>>>>>>>>>>
            document.add(new Paragraph("\n"));
            //<<<<<<<<<<<<<<<<<< Observaciones >>>>>>>>>>>>>>>>>>
            paragraph.clear();
            fox = new Chunk(Solicitud.getObservacionesSist(), font);
            paragraph.add(fox);
            paragraph.setAlignment(paragraph.ALIGN_JUSTIFIED);
            document.add(paragraph);

            //<<<<<<<<<<<<<<<<<< \n  >>>>>>>>>>>>>>>>>
            //document.add(new Paragraph("\n"));

            //if ( writer.getPageNumber()==1 ){
            document.newPage();
            //}

            //<<<<<<<<<<<<<<<<<<<<< Construir y llenar la tabla >>>>>>>>>>>>>>>>>>>>>
            //<<<<<<<<<<<<<<<<<< Actividades desarrolladas >>>>>>>>>>>>>>>>>>
            paragraph.clear();
            fox = new Chunk("ACTIVIDADES DESARROLLADAS", font2);
            paragraph.add(fox);

            PdfPTable table = new PdfPTable(5);
            table.setWidthPercentage(100);

            PdfPCell cell = new PdfPCell(paragraph);
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            cell.setColspan(5);
            table.addCell(cell);

            PdfPCell cellG = new PdfPCell(new Paragraph("Fecha Inicio", font2));
            cellG.setHorizontalAlignment(Element.ALIGN_CENTER);
            cellG.setColspan(1);
            table.addCell(cellG);
            cellG.setPhrase(new Paragraph("Fecha Término", font2));
            table.addCell(cellG);
            cellG.setPhrase(new Paragraph("Grupo", font2));
            table.addCell(cellG);
            cellG.setPhrase(new Paragraph("Actividad", font2));
            table.addCell(cellG);
            cellG.setPhrase(new Paragraph("Responsable", font2));
            table.addCell(cellG);

            Font font3 = new Font(font.HELVETICA, 8f);
            font3.setColor(new Color(0x00, 0x00, 0x00));

            if (Solicitud.getClEstatus() == 5) {
                //<<<<<<<<<<< Obtener la actividades por usuario >>>>>>>>>>>
                ArrayList lstActividades = null;
                lstActividades = (ArrayList) daoh.getActividades(clSolicitud);
                Iterator It = lstActividades.iterator();
                HDActivxUsr Actividad = null;
                int iC = 0;

                while (iC < lstActividades.size()) {
                    Actividad = (HDActivxUsr) lstActividades.get(iC);
                    iC++;

                    cellG.setPhrase(new Paragraph(Actividad.getFechaInicio(), font3));
                    table.addCell(cellG);
                    cellG.setPhrase(new Paragraph(Actividad.getFechaTermino(), font3));
                    table.addCell(cellG);
                    cellG.setPhrase(new Paragraph(Actividad.getGrupo(), font3));
                    table.addCell(cellG);
                    cellG.setPhrase(new Paragraph(Actividad.getObservaciones(), font3));
                    table.addCell(cellG);
                    cellG.setPhrase(new Paragraph(Actividad.getColaborador(), font3));
                    table.addCell(cellG);

                }
            }
            document.add(table);

            PdfContentByte cb = writer.getDirectContent();
            document.close();
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public void onOpenDocument(PdfWriter writer, Document document) {

        try {


            PdfContentByte cb = writer.getDirectContent();

            // <<<<<<<<<<<<<<<<< Insertar  una linea en el PDF >>>>>>>>>>>>>>>>>
            cb.setLineWidth(0.05f);
            cb.moveTo(35, 218);
            cb.lineTo(230, 218);
            cb.stroke();

            cb.beginText();
            cb.setFontAndSize(BaseFont.createFont(BaseFont.HELVETICA, BaseFont.WINANSI, BaseFont.EMBEDDED), 9.5f);
            cb.setRGBColorFill(0, 0, 0);
            cb.showTextAligned(Element.ALIGN_LEFT, "FIRMAS DE CONFORMIDAD", 240, 216, 0);
            cb.endText();

            cb.setLineWidth(0.05f);
            cb.moveTo(375, 218);
            cb.lineTo(570, 218);
            cb.stroke();


            cb.beginText();
            cb.setFontAndSize(BaseFont.createFont(BaseFont.HELVETICA_BOLD, BaseFont.WINANSI, BaseFont.EMBEDDED), 7.5f);
            cb.setRGBColorFill(0, 0, 0);
            cb.showTextAligned(Element.ALIGN_LEFT, "RESPONSABLE SOLICITANTE", 100, 200, 0);
            cb.showTextAligned(Element.ALIGN_LEFT, Solicitud.getUsrRegistra().toString(), 95, 150, 0);
            cb.showTextAligned(Element.ALIGN_LEFT, "ENCARGADO DESARROLLADOR", 390, 200, 0);
            cb.showTextAligned(Element.ALIGN_LEFT, Solicitud.getTitular().toString(), 385, 150, 0);
            cb.endText();

            // <<<<<<<<<<<<<<<<< Insertar  una linea en el PDF >>>>>>>>>>>>>>>>>
            cb.setLineWidth(0.5f);
            cb.moveTo(80, 160);
            cb.lineTo(230, 160);
            cb.stroke();

            // <<<<<<<<<<<<<<<<< Insertar  una linea en el PDF >>>>>>>>>>>>>>>>>
            cb.setLineWidth(0.5f);
            cb.moveTo(370, 160);
            cb.lineTo(530, 160);
            cb.stroke();

            // <<<<<<<<<<<<<<<<< Insertar  una linea en el PDF >>>>>>>>>>>>>>>>>
            cb.setLineWidth(0.8f);
            cb.moveTo(25, 750);
            cb.lineTo(370, 750);
            cb.stroke();

            String TDatos[] = {"Solicitud:", "Fecha de Solicitud:", "Fecha Compromiso:", "Fecha de Liberación:", "Area Solicitante:", "Responsable Solicitante:"};
            String Datos[] = {Solicitud.getAsunto().toUpperCase().toString(), Solicitud.getFechaRegistro().toString(), Solicitud.getFechaCompromiso().toString(), Solicitud.getFechaTermino().toString(), Solicitud.getAreaSolicitante().toUpperCase().toString(), Solicitud.getUsrRegistra().toUpperCase().toString()};

            float ptx = 0, pty = 0, ptyD = 0;

            String Px[] = {"45", "45", "45", "45", "45", "45"};
            String Py[] = {"695", "683", "671", "659", "647", "635"};

            String PyD[] = {"715", "700", "685", "670", "655", "640"};

            cb.beginText();
            cb.setFontAndSize(BaseFont.createFont(BaseFont.HELVETICA_BOLD, BaseFont.WINANSI, BaseFont.EMBEDDED), 9f);
            cb.setRGBColorFill(0, 0, 0);

            //<<<<<<<<<<<<<<<<<  Llenar Origional y Copia de los datos en el PDF >>>>>>>>>>>>>>>>
            for (int i = 0; i < TDatos.length; i++) {
                ptx = Float.parseFloat(Px[i]);
                pty = Float.parseFloat(Py[i]);
                ptyD = Float.parseFloat(PyD[i]);
                cb.showTextAligned(Element.ALIGN_LEFT, TDatos[i], ptx, pty, 0);
            }
            cb.endText();


            cb.beginText();
            cb.setFontAndSize(BaseFont.createFont(BaseFont.HELVETICA, BaseFont.WINANSI, BaseFont.EMBEDDED), 9f);
            cb.setRGBColorFill(0, 0, 0);

            //<<<<<<<<<<<<<<<<<  Llenar Origional y Copia de los datos en el PDF >>>>>>>>>>>>>>>>
            for (int i = 0; i < TDatos.length; i++) {
                ptx = Float.parseFloat(Px[i]);
                pty = Float.parseFloat(Py[i]);
                ptyD = Float.parseFloat(PyD[i]);
                //cb.showTextAligned(Element.ALIGN_LEFT, TDatos[i], ptx, pty, 0);
                cb.showTextAligned(Element.ALIGN_LEFT, Datos[i], 160, pty, 0);
            }
            cb.endText();

            // <<<<<<<<<<<<<<<<< Insertar  una linea en el PDF >>>>>>>>>>>>>>>>>
            cb.setLineWidth(0.95f);
            cb.moveTo(25, 623);
            cb.lineTo(570, 623);
            cb.stroke();

            cb.beginText();
            cb.setFontAndSize(BaseFont.createFont(BaseFont.HELVETICA_BOLD, BaseFont.WINANSI, BaseFont.EMBEDDED), 9f);
            cb.setRGBColorFill(0, 0, 0);
            cb.showTextAligned(Element.ALIGN_LEFT, "DETALLE DE LA SOLICITUD:", 45, 605, 0);
            cb.endText();

            //-----------------------------------------  IMPORTANTE --------------------------------------------------

            // <<<<<<<<<<<<<<<<< Insertar  una linea en el PDF >>>>>>>>>>>>>>>>>
            cb.setLineWidth(0.5f);
            cb.moveTo(35, 130);
            cb.lineTo(260, 130);
            cb.stroke();

            //<<<<<<<<<<<<<<<<<<<< Importante >>>>>>>>>>>>>>>>>>>>>
            cb.beginText();
            cb.setFontAndSize(BaseFont.createFont(BaseFont.HELVETICA_BOLD, BaseFont.WINANSI, BaseFont.EMBEDDED), 9f);
            cb.setRGBColorFill(0, 0, 0);
            cb.showTextAligned(Element.ALIGN_LEFT, "IMPORTANTE", 268, 128, 0);
            cb.endText();

            // <<<<<<<<<<<<<<<<< Insertar  una linea en el PDF >>>>>>>>>>>>>>>>>
            cb.setLineWidth(0.3f);
            cb.moveTo(337, 130);
            cb.lineTo(570, 130);
            cb.stroke();

            cb.beginText();
            cb.setFontAndSize(BaseFont.createFont(BaseFont.HELVETICA, BaseFont.WINANSI, BaseFont.EMBEDDED), 8f);
            cb.setRGBColorFill(0, 0, 0);
            cb.showTextAligned(Element.ALIGN_LEFT, "La Subdirección de Desarrollo de Sistemas podrá modificar la Fecha Compromiso de Entrega por razones de prioridad de la Presidencia o", 50, 115, 0);
            cb.showTextAligned(Element.ALIGN_LEFT, "  por razones estratégicas de la Dirección de Tecnologías de Información, que obliguen a modificar los desarrollos convenidos. Al Usuario", 50, 105, 0);
            cb.showTextAligned(Element.ALIGN_LEFT, "  Solicitante se le notificará vía correo electrónico la nueva Fecha Compromiso, para que al momento de la entrega de la liberación pueda", 50, 95, 0);
            cb.showTextAligned(Element.ALIGN_LEFT, "  corroborar la fecha informada por la Subdirección de Desarrollo de Sistemas.", 50, 85, 0);
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

            //<<<<<<<<<<<<<<<<<< Insertar Texto con Formato >>>>>>>>>>>>>>>>>>
            cb.beginText();
            cb.setFontAndSize(BaseFont.createFont(BaseFont.HELVETICA, BaseFont.WINANSI, BaseFont.EMBEDDED), 9);
            cb.setRGBColorFill(0, 0, 0);
            cb.showTextAligned(Element.ALIGN_LEFT, "CONTROL DE LIBERACIONES DE DESARROLLO DE SISTEMAS", 280, 760, 0);
            cb.endText();

            // <<<<<<<<<<<<<<<<< Insertar  una linea en el PDF >>>>>>>>>>>>>>>>>
            cb.setLineWidth(1f);
            cb.moveTo(18, 750);
            cb.lineTo(580, 750);
            cb.stroke();

            // <<<<<<<<<<<<<<<<< Insertar  una linea en el PDF >>>>>>>>>>>>>>>>>
            cb.setLineWidth(0.95f);
            cb.moveTo(25, 710);
            cb.lineTo(570, 710);
            cb.stroke();

            //<<<<<<<<<<<<<<<<< Insertar Titulos de la Liberación >>>>>>>>>>>>>>>>
            cb.beginText();
            cb.setFontAndSize(BaseFont.createFont(BaseFont.HELVETICA_BOLD, BaseFont.WINANSI, BaseFont.EMBEDDED), 10);
            cb.setRGBColorFill(0, 0, 0);
            cb.showTextAligned(Element.ALIGN_LEFT, "NÚMERO DE CONTROL DE DIRECCIÓN DE T.I:", 45, 735, 0);
            cb.showTextAligned(Element.ALIGN_LEFT, "REGISTRO ELECTRÓNICO:", 45, 720, 0);
            cb.showTextAligned(Element.ALIGN_LEFT, "L-" + Solicitud.getFolioLibera(), 300, 735, 0);
            cb.showTextAligned(Element.ALIGN_LEFT, "Sí", 300, 720, 0);
            cb.endText();

            // <<<<<<<<<<<<<<<<< Insertar  una linea en el PDF >>>>>>>>>>>>>>>>>
            cb.setLineWidth(0.8f);
            cb.moveTo(25, 75);
            cb.lineTo(580, 75);
            cb.stroke();

            cb.beginText();
            cb.setFontAndSize(BaseFont.createFont(BaseFont.HELVETICA_BOLD, BaseFont.WINANSI, BaseFont.EMBEDDED), 7);
            cb.setRGBColorFill(0, 0, 0);
            cb.showTextAligned(Element.ALIGN_LEFT, "CONTROL DE LIBERACIONES DE DE LA SUBDIRECCIÓN DE", 45, 51, 0);
            cb.showTextAligned(Element.ALIGN_LEFT, "TECNOLOGÍAS DE INFORMACIÓN", 85, 43, 0);
            //cb.showTextAligned(Element.ALIGN_LEFT, ""+Solicitud.getClSolicitud(), 160, 730, 0);
            //cb.showTextAligned(Element.ALIGN_LEFT, "DETALLE DE LA SOLICITUD :", 30, 610, 0);
            cb.endText();

            // <<<<<<<<<<<<<<<<< Insertar  una linea en el PDF >>>>>>>>>>>>>>>>>
            cb.setLineWidth(0.8f);
            cb.moveTo(25, 35);
            cb.lineTo(25, 75);
            cb.stroke();

            cb.setLineWidth(0.8f);
            cb.moveTo(260, 35);
            cb.lineTo(260, 75);
            cb.stroke();

            cb.setLineWidth(0.8f);
            cb.moveTo(332, 35);
            cb.lineTo(332, 75);
            cb.stroke();

            cb.setLineWidth(0.8f);
            cb.moveTo(425, 35);
            cb.lineTo(425, 75);
            cb.stroke();

            cb.setLineWidth(0.8f);
            cb.moveTo(525, 35);
            cb.lineTo(525, 75);
            cb.stroke();

            cb.setLineWidth(0.8f);
            cb.moveTo(580, 35);
            cb.lineTo(580, 75);
            cb.stroke();

            cb.setLineWidth(0.8f);
            cb.moveTo(25, 60);
            cb.lineTo(580, 60);
            cb.stroke();

            cb.setLineWidth(0.8f);
            cb.moveTo(25, 35);
            cb.lineTo(580, 35);
            cb.stroke();

            //<<<<<<<<<<<<<<<<<<<<<<<< Lineas PDF >>>>>>>>>>>>>>>>>>>>>>>
            cb.beginText();
            cb.setFontAndSize(BaseFont.createFont(BaseFont.HELVETICA_BOLD, BaseFont.WINANSI, BaseFont.EMBEDDED), 10);
            cb.setRGBColorFill(0, 0, 0);
            cb.showTextAligned(Element.ALIGN_LEFT, "Clave", 280, 62, 0);
            cb.showTextAligned(Element.ALIGN_LEFT, "SSI08F01", 272, 40, 0);
            cb.showTextAligned(Element.ALIGN_LEFT, "Elaboración", 350, 62, 0);
            cb.showTextAligned(Element.ALIGN_LEFT, "Actualización", 442, 62, 0);
            cb.showTextAligned(Element.ALIGN_LEFT, "Hoja", 540, 62, 0);
            cb.endText();

            cb.beginText();
            cb.setFontAndSize(BaseFont.createFont(BaseFont.HELVETICA, BaseFont.WINANSI, BaseFont.EMBEDDED), 9);
            cb.showTextAligned(Element.ALIGN_LEFT, "01 / 12 / 2005", 352, 40, 0);
            cb.endText();

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
            cb.showTextAligned(Element.ALIGN_LEFT, text, 550, 40, 0);
            cb.endText();


        } catch (Exception e) {
        }
    }

    public void onCloseDocument(PdfWriter writer, Document document) {
        if (daoh != null) {
            daoh = null;
            Solicitud = null;
            Path = null;
            Imagen = null;
        }
    }
}
