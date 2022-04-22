/*
 * ImpresionMasivaSP.java
 *
 * Created on 2 de agosto de 2011, 05:51 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package com.ike.helpdeskSP;

import Utilerias.UtileriasBDF;
import com.lowagie.text.Document;
import com.lowagie.text.Element;
import com.lowagie.text.ExceptionConverter;
import com.lowagie.text.Font;
import com.lowagie.text.PageSize;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.pdf.PdfContentByte;
import com.lowagie.text.pdf.PdfPageEventHelper;
import com.lowagie.text.pdf.PdfWriter;
import com.lowagie.text.Image;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Phrase;
import com.lowagie.text.Rectangle;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.RadioCheckField;
import java.awt.Color;
import java.io.ByteArrayOutputStream;
import java.sql.ResultSet;

/*
 *
 * @author mramirez
 */
public class ImpresionMasivaSP extends PdfPageEventHelper {
    
    public static String RutaImagenS="";
    public static String StrEncabezado = "";
    public static String StrInformacion = "";
    public static String StrFechaAsigna ="";
    public static String StrDescripcion= "";
    
    /* Creates a new instance of ImpresionMasivaSP */
    public ImpresionMasivaSP() {
    }
    
    public ByteArrayOutputStream ImpresionEvalServicio(String RutaImagen, String StoreProcedure, String StrUsuario){
        
        RutaImagenS = RutaImagen;
        
        ResultSet rsSolicitud = null;
        int SizeFont = 9;
        
        System.out.println(StoreProcedure);
        rsSolicitud = UtileriasBDF.rsSQLNP(StoreProcedure);
        
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        String Imagenes="";
        String StrclArchivoxExp="0";
        String StrclUsrApp="0";
        
        StringBuffer StrSql = new StringBuffer();
        
        StrclUsrApp=StrUsuario;
        
        try {
            java.awt.Color Style1 = new java.awt.Color(0xFF, 0xFF, 0xFF);
            java.awt.Color Style2 = new java.awt.Color(0x00, 0x00, 0x00);
            java.awt.Color Style3 = new java.awt.Color(0x00, 0x00, 0x00);
            java.awt.FlowLayout Style4 = new java.awt.FlowLayout(3);
            
            //<<<<<<<<<<<<<<<<< Tipos de Fuentes >>>>>>>>>>>>>>
            Font font1 = new Font(Font.HELVETICA, 9, Font.BOLD, Style1);
            Font font2 = new Font(Font.HELVETICA, 9, Font.NORMAL, Style2);
            Font font4 = new Font(Font.HELVETICA, 9, Font.NORMAL, Style2);
            Font font3 = new Font(Font.HELVETICA, 8, Font.BOLD, Style3);
            
            //Document document = new Document(PageSize.A4,3,3,84,82);
            Document document = new Document(PageSize.LETTER,3,3,4,82);
            
            PdfWriter writer = PdfWriter.getInstance(document, baos);
            
            writer.setPageEvent(new ImpresionMasivaSP());
            document.open();
            
            int iY = 0;
            int iX = 0;
            
            //document.addTitle("Impresion");
            
            while(rsSolicitud.next()){
                
                PdfContentByte cb = writer.getDirectContent();
                //<<<<<<<<<<<<<<<<<< Insertar Texto con Formato >>>>>>>>>>>>>>>>>>
                cb.beginText();
                // cb.setFontAndSize(BaseFont.createFont( BaseFont.HELVETICA, BaseFont.WINANSI, BaseFont.EMBEDDED),SizeFont);
                
                cb.setRGBColorFill(0,0,0);
                
                cb.setFontAndSize(BaseFont.createFont( BaseFont.HELVETICA_BOLD, BaseFont.WINANSI, BaseFont.EMBEDDED),SizeFont);
                cb.showTextAligned(Element.ALIGN_LEFT, "Folio de Solicitud" , 33, 699, 0);
                cb.setFontAndSize(BaseFont.createFont( BaseFont.HELVETICA, BaseFont.WINANSI, BaseFont.EMBEDDED),SizeFont);
                cb.showTextAligned(Element.ALIGN_LEFT, rsSolicitud.getString("clSolicitud") , 120, 699, 0);
                
                cb.setFontAndSize(BaseFont.createFont( BaseFont.HELVETICA_BOLD, BaseFont.WINANSI, BaseFont.EMBEDDED),SizeFont);
                cb.showTextAligned(Element.ALIGN_LEFT, "Fecha de Solicitud" , 33, 673, 0);
                cb.setFontAndSize(BaseFont.createFont( BaseFont.HELVETICA, BaseFont.WINANSI, BaseFont.EMBEDDED),SizeFont);
                cb.showTextAligned(Element.ALIGN_LEFT, rsSolicitud.getString("FechaRegistro") , 120, 673, 0);
                
                cb.setFontAndSize(BaseFont.createFont( BaseFont.HELVETICA_BOLD, BaseFont.WINANSI, BaseFont.EMBEDDED),SizeFont);
                cb.showTextAligned(Element.ALIGN_LEFT, "Fecha de Conclusión" , 252, 674, 0);
                cb.setFontAndSize(BaseFont.createFont( BaseFont.HELVETICA, BaseFont.WINANSI, BaseFont.EMBEDDED),SizeFont);
                cb.showTextAligned(Element.ALIGN_LEFT, rsSolicitud.getString("FechaTermino") , 349, 674, 0);
                
                cb.setFontAndSize(BaseFont.createFont( BaseFont.HELVETICA_BOLD, BaseFont.WINANSI, BaseFont.EMBEDDED),SizeFont);
                cb.showTextAligned(Element.ALIGN_LEFT, "Usuario que Registra" , 30, 648, 0);
                
                
                cb.setFontAndSize(BaseFont.createFont( BaseFont.HELVETICA_BOLD, BaseFont.WINANSI, BaseFont.EMBEDDED),SizeFont);
                cb.showTextAligned(Element.ALIGN_LEFT, "Nombre:" , 51, 628, 0);
                cb.setFontAndSize(BaseFont.createFont( BaseFont.HELVETICA, BaseFont.WINANSI, BaseFont.EMBEDDED),SizeFont);
                cb.showTextAligned(Element.ALIGN_LEFT, rsSolicitud.getString("Nombre") , 105, 626, 0);
                
                cb.setFontAndSize(BaseFont.createFont( BaseFont.HELVETICA_BOLD, BaseFont.WINANSI, BaseFont.EMBEDDED),SizeFont);
                cb.showTextAligned(Element.ALIGN_LEFT, "Usuario que Solicita" , 30, 603, 0);
                
                cb.setFontAndSize(BaseFont.createFont( BaseFont.HELVETICA_BOLD, BaseFont.WINANSI, BaseFont.EMBEDDED),SizeFont);
                cb.showTextAligned(Element.ALIGN_LEFT, "Nombre:" , 51, 580, 0);
                cb.setFontAndSize(BaseFont.createFont( BaseFont.HELVETICA, BaseFont.WINANSI, BaseFont.EMBEDDED),SizeFont);
                cb.showTextAligned(Element.ALIGN_LEFT, rsSolicitud.getString("NombreUsrSP") , 104, 579, 0);
                
                cb.setFontAndSize(BaseFont.createFont( BaseFont.HELVETICA_BOLD, BaseFont.WINANSI, BaseFont.EMBEDDED),SizeFont);
                cb.showTextAligned(Element.ALIGN_LEFT, "Ext" , 379, 582, 0);
                cb.setFontAndSize(BaseFont.createFont( BaseFont.HELVETICA, BaseFont.WINANSI, BaseFont.EMBEDDED),SizeFont);
                cb.showTextAligned(Element.ALIGN_LEFT, rsSolicitud.getString("Extencion") , 409, 582, 0);
                
                cb.setFontAndSize(BaseFont.createFont( BaseFont.HELVETICA_BOLD, BaseFont.WINANSI, BaseFont.EMBEDDED),SizeFont);
                cb.showTextAligned(Element.ALIGN_LEFT, "Área:" , 65, 558, 0);
                
                cb.setFontAndSize(BaseFont.createFont( BaseFont.HELVETICA, BaseFont.WINANSI, BaseFont.EMBEDDED),SizeFont);
                cb.showTextAligned(Element.ALIGN_LEFT, rsSolicitud.getString("dsAreaOperativa") , 104, 558, 0);
                
                cb.setFontAndSize(BaseFont.createFont( BaseFont.HELVETICA_BOLD, BaseFont.WINANSI, BaseFont.EMBEDDED),SizeFont);
                cb.showTextAligned(Element.ALIGN_LEFT, "Descripción del Servicio" , 253, 532, 0);
                
                cb.setFontAndSize(BaseFont.createFont( BaseFont.HELVETICA_BOLD, BaseFont.WINANSI, BaseFont.EMBEDDED),SizeFont);
                cb.showTextAligned(Element.ALIGN_LEFT, "Seguimiento" , 277, 449, 0);
                
                cb.setFontAndSize(BaseFont.createFont( BaseFont.HELVETICA_BOLD, BaseFont.WINANSI, BaseFont.EMBEDDED),SizeFont);
                cb.showTextAligned(Element.ALIGN_LEFT, "Actividad Realizada" , 264, 283, 0);
                
                cb.setFontAndSize(BaseFont.createFont( BaseFont.HELVETICA_BOLD, BaseFont.WINANSI, BaseFont.EMBEDDED),8);
                cb.showTextAligned(Element.ALIGN_LEFT, "MARQUE CON UNA ''X'' EL RECUADRO QUE CONSIDERE SEA LA EVALUACION DEL SERVICIO DEL INGENIERO ASIGNADO." , 32, 202, 0);
                
                document.add(new Paragraph("\n"));
                document.add(new Paragraph("\n"));
                document.add(new Paragraph("\n"));
                document.add(new Paragraph("\n"));
                document.add(new Paragraph("\n"));
                document.add(new Paragraph("\n"));
                document.add(new Paragraph("\n"));
                document.add(new Paragraph("\n"));
                document.add(new Paragraph("\n"));
                document.add(new Paragraph("\n"));
                document.add(new Paragraph("\n"));
                document.add(new Paragraph("\n"));
                document.add(new Paragraph("\n"));
                document.add(new Paragraph("\n"));
                document.add(new Paragraph("\n"));
                /*
                Paragraph paragrapD = new Paragraph(new Phrase("Descripción del Servicio",font3));
                paragrapD.setAlignment(paragrapD.ALIGN_CENTER);
                document.add(paragrapD);
                 */
                
                
                PdfPTable tableDesc = new PdfPTable(1);
                tableDesc.setWidthPercentage(85);
                PdfPCell cFolio = new PdfPCell(new Phrase(rsSolicitud.getString("DetalleSol"),font2));
                cFolio.setMinimumHeight(45);
                tableDesc.addCell(cFolio);
                document.add(tableDesc);
                
                /*
                Paragraph paragrapT = new Paragraph(new Phrase("Seguimiento",font3));
                paragrapT.setAlignment(paragrapT.ALIGN_CENTER);
                document.add(paragrapT);
                 */
                
                document.add(new Paragraph("\n"));
                document.add(new Paragraph("\n"));
                
                
                PdfPTable tableSeg = new PdfPTable(1);
                tableSeg.setWidthPercentage(85);
                PdfPCell cSeguimiento = new PdfPCell(new Phrase(rsSolicitud.getString("Seguimiento"),font2));
                cSeguimiento.setMinimumHeight(45);
                tableSeg.addCell(cSeguimiento);
                document.add(tableSeg);
                
                document.add(new Paragraph("\n"));
                
                
                PdfPTable tableResp = new PdfPTable(4);
                tableResp.setWidthPercentage(86);
                PdfPCell cFecha = new PdfPCell(new Phrase("FECHA COMPROMISO",font2));
                cFecha.setHorizontalAlignment(Element.ALIGN_CENTER);
                PdfPCell cIng = new PdfPCell(new Phrase("INGENIERO ASIGNADO NOMBRE Y FIRMA",font2));
                cIng.setHorizontalAlignment(Element.ALIGN_CENTER);
                PdfPCell cStatus = new PdfPCell(new Phrase("STATUS DEL REPORTE",font2));
                cStatus.setHorizontalAlignment(Element.ALIGN_CENTER);
                PdfPCell cFechTer = new PdfPCell(new Phrase("FECHA Y HORA DE TERMINO",font2));
                cFechTer.setHorizontalAlignment(Element.ALIGN_CENTER);
                
                PdfPCell cFechaR = new PdfPCell(new Phrase(rsSolicitud.getString("FechaCompromiso"),font2));
                cFechaR.setHorizontalAlignment(Element.ALIGN_CENTER);
                PdfPCell cIngR = new PdfPCell(new Phrase(rsSolicitud.getString("dsColaboradorAsignadoSP"),font2));
                cIngR.setHorizontalAlignment(Element.ALIGN_CENTER);
                PdfPCell cStatusR = new PdfPCell(new Phrase(rsSolicitud.getString("dsEstatus"),font2));
                cStatusR.setHorizontalAlignment(Element.ALIGN_CENTER);
                PdfPCell cFechTerR = new PdfPCell(new Phrase(rsSolicitud.getString("FechaTermino"),font2));
                cFechTerR.setHorizontalAlignment(Element.ALIGN_CENTER);
                
                cFechaR.setMinimumHeight(20);
                
                tableResp.addCell(cFecha);
                tableResp.addCell(cIng);
                tableResp.addCell(cStatus);
                tableResp.addCell(cFechTer);
                
                tableResp.addCell(cFechaR);
                tableResp.addCell(cIngR);
                tableResp.addCell(cStatusR);
                tableResp.addCell(cFechTerR);
                
                document.add(tableResp);
                
                document.add(new Paragraph("\n"));
                document.add(new Paragraph("\n"));
                document.add(new Paragraph("\n"));
                
                
                //    Paragraph paragrapAct = new Paragraph(new Phrase("Actividad Realizada",font3));
                //    paragrapAct.setAlignment(paragrapAct.ALIGN_CENTER);
                //   document.add(paragrapAct);
                //   document.add(new Paragraph("\n"));
                PdfPTable tableAct = new PdfPTable(1);
                PdfPCell cActividad = new PdfPCell(new Phrase(rsSolicitud.getString("ActividadR"),font2));
                cActividad.setMinimumHeight(45);
                tableResp.setWidthPercentage(88);
                tableAct.addCell(cActividad);
                document.add(tableAct);
                
                document.add(new Paragraph("\n"));
                document.add(new Paragraph("\n"));
                
                
                
                PdfPTable tableEval = new PdfPTable(6);
                
                PdfPCell cAten = new PdfPCell(new Phrase("ATENCIÓN",font3));
                cAten.setHorizontalAlignment(Element.ALIGN_CENTER);
                cAten.setVerticalAlignment(Element.ALIGN_MIDDLE);
                
                PdfPCell cDom = new PdfPCell(new Phrase("DOMINIO",font3));
                cDom.setHorizontalAlignment(Element.ALIGN_CENTER);
                cDom.setVerticalAlignment(Element.ALIGN_MIDDLE);
                
                PdfPCell cAct = new PdfPCell(new Phrase("ACTITUD",font3));
                cAct.setHorizontalAlignment(Element.ALIGN_CENTER);
                cAct.setVerticalAlignment(Element.ALIGN_MIDDLE);
                
                PdfPCell cServ = new PdfPCell(new Phrase("SERVICIO",font3));
                cServ.setHorizontalAlignment(Element.ALIGN_CENTER);
                cServ.setVerticalAlignment(Element.ALIGN_MIDDLE);
                
                PdfPCell cTempo = new PdfPCell(new Phrase("TIEMPO DE RESPUESTA",font3));
                cTempo.setHorizontalAlignment(Element.ALIGN_CENTER);
                cTempo.setVerticalAlignment(Element.ALIGN_MIDDLE);
                
                PdfPCell cAtencion = new PdfPCell(new Phrase("X",font3));
                cAtencion.setHorizontalAlignment(Element.ALIGN_CENTER);
                cAtencion.setVerticalAlignment(Element.ALIGN_MIDDLE);
                
                PdfPCell cDominio = new PdfPCell(new Phrase("X",font3));
                cDominio.setHorizontalAlignment(Element.ALIGN_CENTER);
                cDominio.setVerticalAlignment(Element.ALIGN_MIDDLE);
                
                PdfPCell cActitud = new PdfPCell(new Phrase("X",font3));
                cActitud.setHorizontalAlignment(Element.ALIGN_CENTER);
                cActitud.setVerticalAlignment(Element.ALIGN_MIDDLE);
                
                PdfPCell cServicio = new PdfPCell(new Phrase("X",font3));
                cServicio.setHorizontalAlignment(Element.ALIGN_CENTER);
                cServicio.setVerticalAlignment(Element.ALIGN_MIDDLE);
                
                PdfPCell cTiempodeEspera = new PdfPCell(new Phrase("X",font3));
                cTiempodeEspera.setHorizontalAlignment(Element.ALIGN_CENTER);
                cTiempodeEspera.setVerticalAlignment(Element.ALIGN_MIDDLE);
                
                PdfPCell CeldaBlanca = new PdfPCell(new Phrase("",font2));
                CeldaBlanca.setHorizontalAlignment(Element.ALIGN_CENTER);
                CeldaBlanca.setMinimumHeight(25);

                tableEval.addCell(CeldaBlanca);
                tableEval.addCell(cAten);
                tableEval.addCell(cDom);
                tableEval.addCell(cAct);
                tableEval.addCell(cServ);
                tableEval.addCell(cTempo);
                
                PdfPCell cExel = new PdfPCell(new Phrase("EXCELENTE",font2));
                cExel.setHorizontalAlignment(Element.ALIGN_CENTER);
                cExel.setVerticalAlignment(Element.ALIGN_MIDDLE);
                cExel.setMinimumHeight(20);
                
                tableEval.addCell(cExel);
                
                if(rsSolicitud.getString("clAtencion").equalsIgnoreCase("1")){
                    tableEval.addCell(cAtencion);
                }else{
                    tableEval.addCell(new Phrase("",font3));
                }
                
                if(rsSolicitud.getString("clDominio").equalsIgnoreCase("1")){
                    tableEval.addCell(cDominio);
                }else{
                    tableEval.addCell(new Phrase("",font3));
                }
                
                if(rsSolicitud.getString("clActitud").equalsIgnoreCase("1")){
                    tableEval.addCell(cActitud);
                }else{
                    tableEval.addCell(new Phrase("",font3));
                }
                
                if(rsSolicitud.getString("clServicio").equalsIgnoreCase("1")){
                    tableEval.addCell(cServicio);
                }else{
                    tableEval.addCell(new Phrase("",font3));
                }
                
                if(rsSolicitud.getString("clTiempodeEspera").equalsIgnoreCase("1")){
                    tableEval.addCell(cTiempodeEspera);
                }else{
                    tableEval.addCell(new Phrase("",font3));
                }
                
                //<<<<Bueno>>>>>>>
                PdfPCell cBUENO = new PdfPCell(new Phrase("BUENO",font2));
                cBUENO.setHorizontalAlignment(Element.ALIGN_CENTER);
                cBUENO.setVerticalAlignment(Element.ALIGN_MIDDLE);
                cBUENO.setMinimumHeight(20);
                
                tableEval.addCell(cBUENO);
                
                if(rsSolicitud.getString("clAtencion").equalsIgnoreCase("2")){
                    tableEval.addCell(cAtencion);
                }else{
                    tableEval.addCell(new Phrase("",font3));
                }
                
                if(rsSolicitud.getString("clDominio").equalsIgnoreCase("2")){
                    tableEval.addCell(cDominio);
                }else{
                    tableEval.addCell(new Phrase("",font3));
                }
                
                if(rsSolicitud.getString("clActitud").equalsIgnoreCase("2")){
                    tableEval.addCell(cActitud);
                }else{
                    tableEval.addCell(new Phrase("",font3));
                }
                
                if(rsSolicitud.getString("clServicio").equalsIgnoreCase("2")){
                    tableEval.addCell(cServicio);
                }else{
                    tableEval.addCell(new Phrase("",font3));
                }
                
                if(rsSolicitud.getString("clTiempodeEspera").equalsIgnoreCase("2")){
                    tableEval.addCell(cTiempodeEspera);
                }else{
                    tableEval.addCell(new Phrase("",font3));
                }
                
                //<<<<MALO>>>>>>>
                PdfPCell cMALO = new PdfPCell(new Phrase("MALO",font2));
                cMALO.setHorizontalAlignment(Element.ALIGN_CENTER);
                cMALO.setVerticalAlignment(Element.ALIGN_MIDDLE);
                cMALO.setMinimumHeight(20);                
                
                tableEval.addCell(cMALO);
                
                if(rsSolicitud.getString("clAtencion").equalsIgnoreCase("3")){
                    tableEval.addCell(cAtencion);
                }else{
                    tableEval.addCell(new Phrase("",font3));
                }
                
                if(rsSolicitud.getString("clDominio").equalsIgnoreCase("3")){
                    tableEval.addCell(cDominio);
                }else{
                    tableEval.addCell(new Phrase("",font3));
                }
                
                if(rsSolicitud.getString("clActitud").equalsIgnoreCase("3")){
                    tableEval.addCell(cActitud);
                }else{
                    tableEval.addCell(new Phrase("",font3));
                }
                
                if(rsSolicitud.getString("clServicio").equalsIgnoreCase("3")){
                    tableEval.addCell(cServicio);
                }else{
                    tableEval.addCell(new Phrase("",font3));
                }
                
                if(rsSolicitud.getString("clTiempodeEspera").equalsIgnoreCase("3")){
                    tableEval.addCell(cTiempodeEspera);
                }else{
                    tableEval.addCell(new Phrase("",font3));
                }
                
                document.add(tableEval);
                
                if(rsSolicitud.next() ){
                    document.newPage();
                    rsSolicitud.previous();
                }
            }
            
            document.close();
        } catch(Exception e){
            System.out.println(e);
        }
        return baos;
    }
    
    public void onStartPage(PdfWriter writer, Document document) {
        try {
            
            String Imagen = RutaImagenS;
            int SizeFont = 10;
            
            /*Image jpg = Image.getInstance(Imagen);
            //jpg.setAlignment(1);
            jpg.setAbsolutePosition(38, 760);
            jpg.scaleAbsolute(238,60);
            document.add(jpg);*/
            
            Image jpg = Image.getInstance(Imagen);
            //jpg.setAlignment(1);
            //jpg.setAbsolutePosition(38, 718);
            //-10,22
            jpg.setAbsolutePosition(27, 726);
            
            jpg.scaleAbsolute(146,40);
            document.add(jpg);
            
            PdfContentByte cb = writer.getDirectContent();
            
            //<<<<<<<<<<<<<<<<<< Insertar Texto con Formato >>>>>>>>>>>>>>>>>>
            cb.beginText();
            cb.setFontAndSize(BaseFont.createFont( BaseFont.HELVETICA, BaseFont.WINANSI, BaseFont.EMBEDDED),SizeFont);
            cb.setRGBColorFill(0,0,0);
            cb.showTextAligned(Element.ALIGN_LEFT, "ATENCIÓN A USUARIOS / HELP DESK SOPORTE TECNICO" , 300, 734, 0);
            cb.endText();
            
            // <<<<<<<<<<<<<<<<< Insertar  una linea en el PDF >>>>>>>>>>>>>>>>>
            cb.setLineWidth(1f);
            cb.moveTo(188, 721);
            cb.lineTo(583, 721);
            cb.stroke();
            
            cb.setLineWidth(0.5f);
            cb.moveTo(426, 51);
            cb.lineTo(560, 51);
            cb.stroke();
            
            //<<<<<<<<<<<<<<<<<<<<<<<< Lineas PDF >>>>>>>>>>>>>>>>>>>>>>>
            cb.beginText();
            cb.setFontAndSize(BaseFont.createFont( BaseFont.HELVETICA, BaseFont.WINANSI, BaseFont.EMBEDDED),10);
            cb.setRGBColorFill(0,0,0);
            cb.showTextAligned(Element.ALIGN_LEFT, "Firma de Conformidad", 445, 38, 0);
            
        } catch(Exception er) {
            throw new ExceptionConverter(er);
        }
    }
}
