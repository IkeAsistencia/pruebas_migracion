/*
 * ImpresionAtencionUsrSP.java
 *
 * Created on 2 de agosto de 2011, 05:51 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package com.ike.helpdeskSP.to;

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
 * @author bsanchez
 */
public class ImpresionAtencionUsrSP extends PdfPageEventHelper {
    
    public static String RutaImagenS="";
    public static String StrEncabezado = "";
    public static String StrInformacion = "";
    public static String StrFechaAsigna ="";
    public static String StrDescripcion= "";
    
    
    /* Creates a new instance of ImpresionAtencionUsrSP */
    public ImpresionAtencionUsrSP() {
    }
    
    
    
    public ByteArrayOutputStream ImpresionEvalServicio(String RutaImagen, String StoreProcedure, String StrUsuario){
        
        RutaImagenS = RutaImagen;
        
        ResultSet rsSolicitud = null;
        int SizeFont = 8;
        
        
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
            
            //<<<<<<<<<<<<<<<<< Tipos de Fuentes >>>>>>>>>>>>>>
            Font font1 = new Font(Font.HELVETICA, 8, Font.BOLD, Style1);
            Font font2 = new Font(Font.HELVETICA, 8, Font.NORMAL, Style2);
            Font font3 = new Font(Font.HELVETICA, 8, Font.BOLD, Style3);
            
            //Document document = new Document(PageSize.A4,50,60,84,120);
            Document document = new Document(PageSize.A4,5,5,84,82);
            
            PdfWriter writer = PdfWriter.getInstance(document, baos);
            
            
            
            
            writer.setPageEvent(new ImpresionAtencionUsrSP());
            document.open();
            
            int iY =0;
            
            
            while(rsSolicitud.next()){
                

                PdfContentByte cb = writer.getDirectContent();
                //<<<<<<<<<<<<<<<<<< Insertar Texto con Formato >>>>>>>>>>>>>>>>>>
                cb.beginText();
                cb.setFontAndSize(BaseFont.createFont( BaseFont.HELVETICA_BOLD, BaseFont.WINANSI, BaseFont.EMBEDDED),SizeFont);
                cb.setRGBColorFill(0,0,0);
                
                cb.showTextAligned(Element.ALIGN_LEFT, "Folio de Solicitud" , 30, 730, 0);
                cb.showTextAligned(Element.ALIGN_LEFT, rsSolicitud.getString("clSolicitud") , 120, 730, 0);
                
                cb.showTextAligned(Element.ALIGN_LEFT, "Fecha de Solicitud" , 30, 700+iY, 0);
                cb.showTextAligned(Element.ALIGN_LEFT, rsSolicitud.getString("FechaRegistro") , 120, 700+iY, 0);
                
                cb.showTextAligned(Element.ALIGN_LEFT, "Fecha de Conclusión" , 300, 700+iY, 0);
                cb.showTextAligned(Element.ALIGN_LEFT, rsSolicitud.getString("FechaTermino") , 420, 700+iY, 0);
                
                cb.showTextAligned(Element.ALIGN_LEFT, "Usuario que Registra" , 30, 670+iY, 0);
                cb.showTextAligned(Element.ALIGN_LEFT, "Nombre:" , 50, 640+iY, 0);
                cb.showTextAligned(Element.ALIGN_LEFT, rsSolicitud.getString("Nombre") , 120, 640+iY, 0);
                
                cb.showTextAligned(Element.ALIGN_LEFT, "Usuario que Solicita" , 30, 610+iY, 0);
                cb.showTextAligned(Element.ALIGN_LEFT, "Nombre:" , 50, 580+iY, 0);
                cb.showTextAligned(Element.ALIGN_LEFT, rsSolicitud.getString("NombreUsrSP") , 120, 580+iY, 0);
                
                cb.showTextAligned(Element.ALIGN_LEFT, "Ext" , 300, 580+iY, 0);
                cb.showTextAligned(Element.ALIGN_LEFT, rsSolicitud.getString("Extencion") , 420, 580+iY, 0);
                
                cb.showTextAligned(Element.ALIGN_LEFT, "Area" , 50, 550+iY, 0);
                cb.showTextAligned(Element.ALIGN_LEFT, rsSolicitud.getString("dsAreaOperativa") , 120, 550+iY, 0);
                
                
                
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
                
                Paragraph paragrapD = new Paragraph(new Phrase("Descripción del Servicio",font3));
                paragrapD.setAlignment(paragrapD.ALIGN_CENTER);
                document.add(paragrapD);
                
                document.add(new Paragraph("\n"));
                PdfPTable tableDesc = new PdfPTable(1);
                PdfPCell cFolio = new PdfPCell(new Phrase(rsSolicitud.getString("DetalleSol"),font3));
                // cFolio.setHorizontalAlignment(Element.ALIGN_CENTER);
                cFolio.setMinimumHeight(55);
                tableDesc.addCell(cFolio);
                document.add(tableDesc);
                document.add(new Paragraph("\n"));
                
                Paragraph paragrapT = new Paragraph(new Phrase("Seguimiento",font3));
                paragrapT.setAlignment(paragrapT.ALIGN_CENTER);
                document.add(paragrapT);
                
                document.add(new Paragraph("\n"));
                PdfPTable tableSeg = new PdfPTable(1);
                PdfPCell cSeguimiento = new PdfPCell(new Phrase(rsSolicitud.getString("Seguimiento"),font3));
                cSeguimiento.setMinimumHeight(55);
                tableSeg.addCell(cSeguimiento);
                document.add(tableSeg);
                document.add(new Paragraph("\n"));
                
                PdfPTable tableResp = new PdfPTable(4);
                PdfPCell cFecha = new PdfPCell(new Phrase("FECHA COMPROMISO",font3));
                PdfPCell cIng = new PdfPCell(new Phrase("INGENIERO ASIGNADO NOMBRE Y FIRMA",font3));
                PdfPCell cStatus = new PdfPCell(new Phrase("STATUS DEL REPORTE",font3));
                PdfPCell cFechTer = new PdfPCell(new Phrase("FECHA Y HORA DE TERMINO",font3));
                tableResp.addCell(cFecha);
                tableResp.addCell(cIng);
                tableResp.addCell(cStatus);
                tableResp.addCell(cFechTer);
                tableResp.addCell(new Phrase(rsSolicitud.getString("FechaCompromiso"),font3));
                tableResp.addCell(new Phrase(rsSolicitud.getString("dsColaboradorAsignadoSP"),font3));
                tableResp.addCell(new Phrase(rsSolicitud.getString("dsEstatus"),font3));
                tableResp.addCell(new Phrase(rsSolicitud.getString("FechaTermino"),font3));
                document.add(tableResp);
                
                document.add(new Paragraph("\n"));
                
                Paragraph paragrapAct = new Paragraph(new Phrase("Actividad Realizada",font3));
                paragrapAct.setAlignment(paragrapAct.ALIGN_CENTER);
                document.add(paragrapAct);
                document.add(new Paragraph("\n"));
                PdfPTable tableAct = new PdfPTable(1);
                PdfPCell cActividad = new PdfPCell(new Phrase(rsSolicitud.getString("ActividadR"),font3));
                cActividad.setMinimumHeight(55);
                tableAct.addCell(cActividad);
                document.add(tableAct);
                document.add(new Paragraph("\n"));
                
                PdfPTable tableEval = new PdfPTable(6);
                tableEval.addCell("");
                tableEval.addCell(new Phrase("ATENCIÓN",font3));
                tableEval.addCell(new Phrase("DOMINIO",font3));
                tableEval.addCell(new Phrase("ACTITUD",font3));
                tableEval.addCell(new Phrase("SERVICIO",font3));
                tableEval.addCell(new Phrase("TIEMPO DE RESPUESTA",font3));
                
                PdfPCell cAtencion = new PdfPCell(new Phrase("X",font3));
                cAtencion.setHorizontalAlignment(Element.ALIGN_CENTER);
                
                PdfPCell cDominio = new PdfPCell(new Phrase("X",font3));
                cDominio.setHorizontalAlignment(Element.ALIGN_CENTER);
                
                PdfPCell cActitud = new PdfPCell(new Phrase("X",font3));
                cActitud.setHorizontalAlignment(Element.ALIGN_CENTER);
                
                PdfPCell cServicio = new PdfPCell(new Phrase("X",font3));
                cServicio.setHorizontalAlignment(Element.ALIGN_CENTER);
                
                PdfPCell cTiempodeEspera = new PdfPCell(new Phrase("X",font3));
                cTiempodeEspera.setHorizontalAlignment(Element.ALIGN_CENTER);
                
                
                tableEval.addCell(new Phrase("EXCELENTE",font3));
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
                tableEval.addCell(new Phrase("BUENO",font3));
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
                tableEval.addCell(new Phrase("MALO",font3));
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
            int SizeFont = 8;
            
            Image jpg = Image.getInstance(Imagen);
            //jpg.setAlignment(1);
            jpg.setAbsolutePosition(30, 760);
            jpg.scaleAbsolute(230,60);
            document.add(jpg);
            
            PdfContentByte cb = writer.getDirectContent();
            
            
            
            //<<<<<<<<<<<<<<<<<< Insertar Texto con Formato >>>>>>>>>>>>>>>>>>
            cb.beginText();
            cb.setFontAndSize(BaseFont.createFont( BaseFont.HELVETICA, BaseFont.WINANSI, BaseFont.EMBEDDED),SizeFont);
            cb.setRGBColorFill(0,0,0);
            cb.showTextAligned(Element.ALIGN_LEFT, "ATENCIÓN A USUARIOS / HELP DESK SOPORTE TECNICO" , 350, 765, 0);
            cb.endText();
            
            // <<<<<<<<<<<<<<<<< Insertar  una linea en el PDF >>>>>>>>>>>>>>>>>
            cb.setLineWidth(1f);
            cb.moveTo(240, 760);
            cb.lineTo(580, 760);
            cb.stroke();
			
			cb.setLineWidth(0.5f);
            cb.moveTo(440, 57);
            cb.lineTo(540, 57);
            cb.stroke();
            
            //<<<<<<<<<<<<<<<<<<<<<<<< Lineas PDF >>>>>>>>>>>>>>>>>>>>>>>
            cb.beginText();
            cb.setFontAndSize(BaseFont.createFont( BaseFont.HELVETICA_BOLD, BaseFont.WINANSI, BaseFont.EMBEDDED),8);
            cb.setRGBColorFill(0,0,0);
            cb.showTextAligned(Element.ALIGN_LEFT, "Firma de Conformidad", 450, 47, 0);
            
            
            
        } catch(Exception er) {
            throw new ExceptionConverter(er);
        }
    }
    
   
}
