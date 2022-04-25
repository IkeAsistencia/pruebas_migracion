/*
 * BitacoraLegalPDF.java
 *
 * Created on 29 de junio de 2009, 14:38
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */
package com.ike.Compras;

import Utilerias.UtileriasBDF;
import com.lowagie.text.Chunk;
import com.lowagie.text.Document;
import com.lowagie.text.Element;
import com.lowagie.text.ExceptionConverter;
import com.lowagie.text.PageSize;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Phrase;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.pdf.PdfContentByte;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfPageEventHelper;
import com.lowagie.text.pdf.PdfWriter;
import com.lowagie.text.Font;
import com.lowagie.text.Image;
import java.awt.Color;
import java.io.ByteArrayOutputStream;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.util.ArrayList;
import java.util.StringTokenizer;

/*
 *
 * @author vsampablo
 */
public class ImpresionPDF extends PdfPageEventHelper {

    public static String RutaImagenS = "";
    public static String StrEmpresa = "";
    public static String StrNITEmpresa = "";
    public static String StrRegimen = "";
    public static String StrCompra = "";
    public static String StrFecha = "";
    public static String StrProveedor = "";
    public static String StrNITProv = "";
    public static String StrDireccionProv = "";
    public static String StrTelProv = "";
    public static String StrContactosProv = "";
    public static String StrFechaEntrega = "";
    public static String StrFormaPago = "";
    public static String StrDescripcion = "";
    public static String StrDireccion = "";
    public static String StrURL = "";
    public static String StrFirma = "";

    /* Creates a new instance of BitacoraLegalPDF */
    public ImpresionPDF() {
    }

    public ByteArrayOutputStream ImpresionPDF(String RutaImagen, String StoreProcedure, String StoreProcedureCompra) {

        RutaImagenS = RutaImagen;

        ResultSet rsSolicitud = null;

        System.out.println(StoreProcedure);
        rsSolicitud = UtileriasBDF.rsSQLNP(StoreProcedure);

        try {
            if (rsSolicitud.next()) {
                StrEmpresa = rsSolicitud.getString("Empresa");
                StrNITEmpresa = rsSolicitud.getString("NITEmpresa");
                StrRegimen = rsSolicitud.getString("Regimen");
                StrCompra = rsSolicitud.getString("Compra");
                StrFecha = rsSolicitud.getString("Fecha");

                StrProveedor = rsSolicitud.getString("Proveedor");
                StrNITProv = rsSolicitud.getString("NITProv");
                StrDireccionProv = rsSolicitud.getString("DireccionProv");
                StrTelProv = rsSolicitud.getString("TelProv");
                StrContactosProv = rsSolicitud.getString("ContactosProv");
                StrFechaEntrega = rsSolicitud.getString("FechaEntrega");
                StrFormaPago = rsSolicitud.getString("FormaPago");

                StrDescripcion = rsSolicitud.getString("Descripcion");

                StrDireccion = rsSolicitud.getString("Direccion");
                StrURL = rsSolicitud.getString("URL");
                StrFirma = rsSolicitud.getString("Firma");

            }

            rsSolicitud.close();
            rsSolicitud = null;
        } catch (Exception E) {
            System.out.println(E);
        }




        ByteArrayOutputStream baos = new ByteArrayOutputStream();


        try {

            java.awt.Color Style1 = new java.awt.Color(0xFF, 0xFF, 0xFF);
            java.awt.Color Style2 = new java.awt.Color(0x00, 0x00, 0x00);
            java.awt.Color Style3 = new java.awt.Color(0x00, 0x00, 0x00);

            //<<<<<<<<<<<<<<<<< Tipos de Fuentes >>>>>>>>>>>>>>
            Font font1 = new Font(Font.HELVETICA, 8, Font.BOLD, Style1);
            Font font2 = new Font(Font.HELVETICA, 8, Font.NORMAL, Style2);
            Font font3 = new Font(Font.HELVETICA, 8, Font.BOLD, Style3);


            Document document = new Document(PageSize.A4, 50, 60, 264, 40);
            PdfWriter writer = PdfWriter.getInstance(document, baos);

            document.addTitle("SOLICITUD DE COMPRA");
            document.addSubject("IKE ASISTENCIA");
            document.addAuthor("IKE ASISTENCIA");

            writer.setPageEvent(new ImpresionPDF());
            document.open();


            //<<<<<<<<<<<<<<<<<<<< Detalle de la Solicitud >>>>>>>>>>>>>>>>>>>>
            Font font = new Font(Font.HELVETICA, 9);
            font.setColor(new Color(0x00, 0x00, 0x00));
            Chunk fox = new Chunk(StrDescripcion, font);

            ArrayList ListDesc = new ArrayList();
            StringTokenizer stDesc = new StringTokenizer(StrDescripcion, "|");

            while (stDesc.hasMoreTokens()) {
                ListDesc.add(stDesc.nextToken().toString());
            }

            Phrase TextoSalidaDesc = new Phrase();

            TextoSalidaDesc.clear();

            for (int i = 0; i < ListDesc.size(); i++) {
                // System.out.println(ListDesc.get(i));

                int Ind = 0;
                Ind = ListDesc.get(i).toString().indexOf("<BOLD>");

                //System.out.println("Index: "+Ind);

                if (ListDesc.get(i).toString().indexOf("<BOLD>") != -1) {
                    Chunk foxD = new Chunk(ListDesc.get(i).toString().replace("<BOLD>", ""), font3);
                    TextoSalidaDesc.add(foxD);
                }


                if (ListDesc.get(i).toString().indexOf("<NORMAL>") != -1) {
                    Chunk foxD = new Chunk(ListDesc.get(i).toString().replace("<NORMAL>", ""), font2);
                    TextoSalidaDesc.add(foxD);
                }

                if (ListDesc.get(i).toString().indexOf("<n>") != -1) {
                    TextoSalidaDesc.add(new Paragraph("\n"));
                }

            }

            Paragraph paragrapT = new Paragraph(TextoSalidaDesc);
            paragrapT.setLeading(10f);
            paragrapT.setAlignment(Paragraph.ALIGN_JUSTIFIED);

            document.add(paragrapT);
            document.add(new Paragraph("\n"));


            //<<<<<<<<<<<<<<<< Productos de la Compra >>>>>>>>>>>>>>>>
            ResultSet rsProductos = null;

            try {
                System.out.println(StoreProcedureCompra);
                rsProductos = UtileriasBDF.rsSQLNP(StoreProcedureCompra);

                if (rsProductos.next()) {
                    ResultSetMetaData rsMetaDato = rsProductos.getMetaData();

                    int i;
                    int Celdas = rsMetaDato.getColumnCount();

                    PdfPTable table = new PdfPTable(Celdas);
                    table.setWidthPercentage(100);

                    //<<<<<<<<<<<<<<<<<<<<<< Encabezado de Tablas >>>>>>>>>>>>>>>>>>>
                    for (i = 1; i <= Celdas; i++) {
                        PdfPCell cellG = new PdfPCell(new Paragraph(rsMetaDato.getColumnLabel(i).toString(), font1));
                        cellG.setHorizontalAlignment(Element.ALIGN_CENTER);
                        cellG.setBackgroundColor(new Color(0x08, 0x2D, 0x64));
                        cellG.setPadding(3.0f);
                        cellG.setColspan(1);
                        table.addCell(cellG);
                    }

                    //<<<<<<<<<<<<<<<<<< Contenido de la Tabla >>>>>>>>>>>>>>>>>>>>
                    do {
                        for (i = 1; i <= Celdas; i++) {
                            if (rsProductos.getObject(i) != null) {
                                PdfPCell cellG = new PdfPCell(new Paragraph(rsProductos.getObject(i).toString().replaceAll(",|\n|\r\n?", " "), font2));
                                cellG.setHorizontalAlignment(Element.ALIGN_CENTER);
                                cellG.setPadding(3.0f);
                                cellG.setColspan(1);
                                table.addCell(cellG);
                            }
                        }
                    } while (rsProductos.next());


                    document.add(table);
                    table = null;
                }

                rsProductos.close();
                rsProductos = null;


            } catch (Exception rE) {
                System.out.println("Error rsProductos: " + rE);
            }

            document.add(new Paragraph("\n"));

            PdfContentByte cb = writer.getDirectContent();
            document.close();


        } catch (Exception e) {
            System.out.println(e);
        }

        return baos;

    }

    @Override
    public void onStartPage(PdfWriter writer, Document document) {
        try {

            String Imagen = RutaImagenS;
            int SizeFont = 8;

            Image jpg = Image.getInstance(Imagen);
            //jpg.setAlignment(1);
            jpg.setAbsolutePosition(30, 760);
            jpg.scaleAbsolute(230, 60);
            document.add(jpg);

            PdfContentByte cb = writer.getDirectContent();

            //<<<<<<<<<<<<<<<<<< Insertar Texto con Formato >>>>>>>>>>>>>>>>>>
            cb.beginText();
            cb.setFontAndSize(BaseFont.createFont(BaseFont.HELVETICA, BaseFont.WINANSI, BaseFont.EMBEDDED), SizeFont);
            cb.setRGBColorFill(0, 0, 0);
            cb.showTextAligned(Element.ALIGN_LEFT, "SOLICITUD DE COMPRA", 485, 765, 0);
            cb.endText();

            // <<<<<<<<<<<<<<<<< Insertar  una linea en el PDF >>>>>>>>>>>>>>>>>
            cb.setLineWidth(1f);
            cb.moveTo(240, 760);
            cb.lineTo(580, 760);
            cb.stroke();

            //<<<<<<<<<<<<<<<<< Insertar Datos de la Empresa >>>>>>>>>>>>>>>>
            cb.beginText();
            cb.setFontAndSize(BaseFont.createFont(BaseFont.HELVETICA_BOLD, BaseFont.WINANSI, BaseFont.EMBEDDED), SizeFont);
            cb.setRGBColorFill(0, 0, 0);
            cb.showTextAligned(Element.ALIGN_LEFT, StrEmpresa, 45, 735, 0);
            cb.showTextAligned(Element.ALIGN_LEFT, StrNITEmpresa, 45, 722, 0);
            cb.showTextAligned(Element.ALIGN_LEFT, StrRegimen, 45, 709, 0);
            cb.showTextAligned(Element.ALIGN_LEFT, StrCompra, 45, 696, 0);
            cb.showTextAligned(Element.ALIGN_LEFT, StrFecha, 45, 683, 0);
            cb.endText();


            cb.beginText();
            cb.setFontAndSize(BaseFont.createFont(BaseFont.HELVETICA, BaseFont.WINANSI, BaseFont.EMBEDDED), SizeFont);
            cb.setRGBColorFill(0, 0, 0);
            cb.showTextAligned(Element.ALIGN_LEFT, StrFirma, 45, 100, 0);
            cb.showTextAligned(Element.ALIGN_LEFT, StrDireccion, 45, 50, 0);
            cb.showTextAligned(Element.ALIGN_LEFT, StrURL, 45, 35, 0);
            cb.endText();

            // <<<<<<<<<<<<<<<<< Insertar  una linea en el PDF >>>>>>>>>>>>>>>>>
//            cb.setLineWidth(0.8f);
//            cb.moveTo(25, 670);
//            cb.lineTo(580, 670);
//            cb.stroke();

            //<<<<<<<<<<<<<<<<< Insertar Datos del Proveedor  >>>>>>>>>>>>>>>>
            cb.beginText();
            cb.setFontAndSize(BaseFont.createFont(BaseFont.HELVETICA_BOLD, BaseFont.WINANSI, BaseFont.EMBEDDED), SizeFont);
            cb.setRGBColorFill(0, 0, 0);
            cb.showTextAligned(Element.ALIGN_LEFT, StrProveedor, 45, 658, 0);
            cb.showTextAligned(Element.ALIGN_LEFT, StrFechaEntrega, 330, 658, 0);

            cb.showTextAligned(Element.ALIGN_LEFT, StrNITProv, 45, 645, 0);
            cb.showTextAligned(Element.ALIGN_LEFT, StrFormaPago, 330, 645, 0);

            cb.showTextAligned(Element.ALIGN_LEFT, StrDireccionProv, 45, 632, 0);
            cb.showTextAligned(Element.ALIGN_LEFT, StrTelProv, 45, 619, 0);
            cb.showTextAligned(Element.ALIGN_LEFT, StrContactosProv, 45, 606, 0);
            cb.endText();

            cb.beginText();
            cb.setFontAndSize(BaseFont.createFont(BaseFont.HELVETICA_BOLD, BaseFont.WINANSI, BaseFont.EMBEDDED), SizeFont);
            cb.setRGBColorFill(0, 0, 0);
            cb.showTextAligned(Element.ALIGN_LEFT, "DESCRIPCIÓN", 45, 585, 0);
            cb.endText();


        } catch (Exception er) {
            throw new ExceptionConverter(er);
        }
    }

    @Override
    public void onEndPage(PdfWriter writer, Document document) {
        PdfContentByte cb = writer.getDirectContent();
        String text = "" + writer.getPageNumber();
        try {
            cb.beginText();
            cb.setFontAndSize(BaseFont.createFont(BaseFont.HELVETICA, BaseFont.WINANSI, BaseFont.EMBEDDED), 9);
            cb.setRGBColorFill(0, 0, 0);
            cb.showTextAligned(Element.ALIGN_LEFT, text, 550, 40, 0);
            cb.endText();
        } catch (Exception er) {
        }
    }
    /*
    public void onCloseDocument(PdfWriter writer, Document document) {
    //Imagen=null;
    }
     */
}
