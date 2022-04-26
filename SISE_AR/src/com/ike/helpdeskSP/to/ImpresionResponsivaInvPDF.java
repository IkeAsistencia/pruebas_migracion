/*
 * ImpresionResponsivaInvPDF.java
 *
 * Created on 6 de agosto de 2010, 01:45 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package com.ike.helpdeskSP.to;



import com.lowagie.text.pdf.Barcode39;
import com.lowagie.text.pdf.BarcodeCodabar;
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
 * @author bsanchez
 */
public class ImpresionResponsivaInvPDF extends PdfPageEventHelper {
    
    
    public static String RutaImagenS="";
    
    public static String StrEncabezado = "";
    public static String StrInformacion = "";  
    public static String StrFechaAsigna ="";
    public static String StrDescripcion= "";
    

    /* Creates a new instance of ImpresionResponsivaInvPDF */
    public ImpresionResponsivaInvPDF() {
    }
 
    public Phrase TextoSalidaPDF(String StrFrase, Font font1, Font font2, Font font3){
      Phrase TextoSalidaDesc = new Phrase();
         ArrayList ListDesc = new ArrayList();
            StringTokenizer stDesc = new StringTokenizer(StrFrase,"|");
        
            
            while (stDesc.hasMoreTokens()){
                ListDesc.add(stDesc.nextToken().toString());          }
                    
            
            TextoSalidaDesc.clear();
            
            for (int i=0; i< ListDesc.size(); i++){
              //  System.out.println(ListDesc.get(i));
                
                int Ind = 0;
                Ind = ListDesc.get(i).toString().indexOf("<BOLD>");
                
               
                
                if (ListDesc.get(i).toString().indexOf("<BOLD>") != -1){
                    Chunk foxD = new Chunk(ListDesc.get(i).toString().replace("<BOLD>",""), font3);
                    TextoSalidaDesc.add(foxD);
                  //  System.out.println("entra a bold: " + foxD + "Texto de Salida: " + TextoSalidaDesc);
                }
                
                
                if (ListDesc.get(i).toString().indexOf("<NORMAL>") != -1){
                    Chunk foxD = new Chunk(ListDesc.get(i).toString().replace("<NORMAL>",""), font2);
                    TextoSalidaDesc.add(foxD);
                     //      System.out.println("chunk normal: " + foxD);
                   //  System.out.println("entra a normal: " + foxD);
                }
                
                if (ListDesc.get(i).toString().indexOf("<n>") != -1){
                   TextoSalidaDesc.add(new Paragraph("\n"));                 
                   }
                
           
                
            }  
      
      return TextoSalidaDesc;
        
    }
     
    public ByteArrayOutputStream ImpresionPDF(String RutaImagen, String StoreProcedure, String StoreProcedurePeriferico, String StoreProcedureSoftware){
        
        RutaImagenS = RutaImagen;
        
        ResultSet rsSolicitud = null;
        
        System.out.println(StoreProcedure);
        rsSolicitud = UtileriasBDF.rsSQLNP(StoreProcedure);
        
        try {
            if (rsSolicitud.next()){
                StrEncabezado = rsSolicitud.getString("Encabezado");
                StrInformacion = rsSolicitud.getString("Informacion");
                StrFechaAsigna = rsSolicitud.getString("FechaAsignacion");
                
            }
            
            rsSolicitud.close();
            rsSolicitud = null;
        } catch (Exception E){
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
            
            
          //  Document document = new Document(PageSize.A4,50,60,264,40);
             
              Document document = new Document(PageSize.A4,50,60,84,120);
            
            PdfWriter writer = PdfWriter.getInstance(document, baos);
            
            document.addTitle("RESPONSIVA DE EQUIPO");
            document.addSubject("IKE ASISTENCIA");
            document.addAuthor("IKE ASISTENCIA");           
            writer.setPageEvent(new ImpresionResponsivaInvPDF());
            document.open();
   
            //<<<<<<<<<<<<<<<<<<<< Detalle de la Solicitud >>>>>>>>>>>>>>>>>>>>
            Font font = new Font(Font.HELVETICA, 9);
            font.setColor(new Color(0x00, 0x00, 0x00));
            Chunk fox = new Chunk(StrDescripcion, font);
            
            Phrase TextoSalidaDesc = new Phrase();
            TextoSalidaDesc= TextoSalidaPDF(StrEncabezado,font1,font2, font3);
            
           
       
            //TextoSalidaDesc.add(fox);
            Paragraph paragrapT = new Paragraph(TextoSalidaDesc);
            //paragrapT.setLeading(10f);
            paragrapT.setAlignment(paragrapT.ALIGN_JUSTIFIED);
            document.add(paragrapT);            
            document.add(new Paragraph("\n"));
            
                   
            //<<<<<<<<<<<<<<<< Productos de la Compra >>>>>>>>>>>>>>>>
            ResultSet rsPerifericos = null;
            
            try {
              //  System.out.println(StoreProcedurePeriferico);
                rsPerifericos = UtileriasBDF.rsSQLNP(StoreProcedurePeriferico);
                
                if (rsPerifericos.next()){
                    ResultSetMetaData rsMetaDato = rsPerifericos.getMetaData();

                    int i;
                    int Celdas=rsMetaDato.getColumnCount();

                    PdfPTable table = new PdfPTable(Celdas);
                    table.setWidthPercentage(100);

                    //<<<<<<<<<<<<<<<<<<<<<< Encabezado de Tablas >>>>>>>>>>>>>>>>>>>
                    for ( i=1; i<=Celdas; i++){
                        PdfPCell cellG =new PdfPCell(new Paragraph(rsMetaDato.getColumnLabel(i).toString(),font1));
                        cellG.setHorizontalAlignment(Element.ALIGN_CENTER);
                        cellG.setBackgroundColor(new Color(0x08, 0x2D, 0x64));
                        cellG.setPadding(3.0f);
                        cellG.setColspan(1);
                        table.addCell(cellG);                      
                     
                    }                
                    
                    
                    //<<<<<<<<<<<<<<<<<< Contenido de la Tabla >>>>>>>>>>>>>>>>>>>>
                    do {
                        for ( i=1; i<=Celdas; i++){
                            if (rsPerifericos.getObject(i)!=null){
                             
                                   
                                if(i==Celdas){
                                //Genera  Código de Barras
                                PdfContentByte cb = writer.getDirectContent();
                                Barcode39 code39 = new Barcode39();
                                code39.setCode(rsPerifericos.getObject(i).toString().replaceAll(",|\n|\r\n?"," "));
                                PdfPCell cellG =new PdfPCell(code39.createImageWithBarcode(cb, null, null));
                                
                                   //BarcodeCodabar codabar = new BarcodeCodabar();
                                  // codabar.setCode(rsPerifericos.getObject(i).toString().replaceAll(",|\n|\r\n?"," "));
                                   //codabar.setStartStopText(true);                                 
                                
                                // document.add(code39.createImageWithBarcode(cb, null, null));
                                //PdfPCell cellG =new PdfPCell(codabar.createImageWithBarcode(cb, null, null));
                                cellG.setHorizontalAlignment(Element.ALIGN_CENTER);                                
                                cellG.setPadding(3.0f);
                                cellG.setColspan(3);                               
                                table.addCell(cellG);
                                
                             
                                    
                                } else{
                                    
                                PdfPCell cellG =new PdfPCell(new Paragraph(rsPerifericos.getObject(i).toString().replaceAll(",|\n|\r\n?"," "),font3));
                                cellG.setHorizontalAlignment(Element.ALIGN_CENTER);  
                                cellG.setPadding(3.0f);
                                cellG.setColspan(1);                               
                                table.addCell(cellG);                               
                                    
                                }                
                            }                            
                         }
                    } while(rsPerifericos.next());                      
                                     
                                          
                     PdfContentByte cb = writer.getDirectContent();         
                    document.add(table);
                    table = null;
                }         
               
                
                rsPerifericos.close();
                rsPerifericos = null;                                            
                
            } catch (Exception rE){
                System.out.println("Error rsPerifericos: "+rE);
            }
            
            
                //<<<<<<<<<<<<<<<< Software y Hardware >>>>>>>>>>>>>>>>
            ResultSet rsSoftware = null;
            
            try {
                
                rsSoftware= UtileriasBDF.rsSQLNP(StoreProcedureSoftware);
                
                if (rsSoftware.next()){
                    ResultSetMetaData rsMetaDato = rsSoftware.getMetaData();

                    int i;
                    int Celdas=rsMetaDato.getColumnCount();

                    PdfPTable table = new PdfPTable(Celdas);
                    table.setWidthPercentage(100);

                    //<<<<<<<<<<<<<<<<<<<<<< Encabezado de Tablas >>>>>>>>>>>>>>>>>>>
                    for ( i=1; i<=Celdas; i++){
                        PdfPCell cellG =new PdfPCell(new Paragraph(rsMetaDato.getColumnLabel(i).toString(),font1));
                        cellG.setHorizontalAlignment(Element.ALIGN_CENTER);
                        cellG.setBackgroundColor(new Color(0x08, 0x2D, 0x64));
                        cellG.setPadding(3.0f);
                        cellG.setColspan(1);
                        table.addCell(cellG);                      
                     
                    }                
                    
                    
                    //<<<<<<<<<<<<<<<<<< Contenido de la Tabla >>>>>>>>>>>>>>>>>>>>
                    do {
                        for ( i=1; i<=Celdas; i++){
                            if (rsSoftware.getObject(i)!=null){                                                          
                           
                                    
                                PdfPCell cellG =new PdfPCell(new Paragraph(rsSoftware.getObject(i).toString().replaceAll(",|\n|\r\n?"," "),font3));
                                cellG.setHorizontalAlignment(Element.ALIGN_CENTER);  
                                cellG.setPadding(3.0f);
                                cellG.setColspan(1);                               
                                table.addCell(cellG);                               
                                    
                                                
                            }                            
                         }
                    } while(rsSoftware.next());                      
                                     
                                          
                     PdfContentByte cb = writer.getDirectContent();         
                    document.add(table);
                    table = null;
                }         
               
                
                rsSoftware.close();
                rsSoftware = null;                                            
                
            } catch (Exception rE){
                System.out.println("Error rsPerifericos: "+rE);
            }
            //document.add(new Paragraph("\n"));
            
            document.newPage();  
            PdfContentByte cb = writer.getDirectContent();         
       
            TextoSalidaDesc= TextoSalidaPDF(StrInformacion,font1,font2, font3);         
            paragrapT = new Paragraph(TextoSalidaDesc);      
            paragrapT.setAlignment(paragrapT.ALIGN_JUSTIFIED);
            document.add(paragrapT);            
            document.add(new Paragraph("\n"));
    
                            
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
            cb.showTextAligned(Element.ALIGN_LEFT, "RESPONSIVA DE EQUIPO /  " +  StrFechaAsigna, 425, 765, 0);
            cb.endText();
            
            // <<<<<<<<<<<<<<<<< Insertar  una linea en el PDF >>>>>>>>>>>>>>>>>
            cb.setLineWidth(1f);
            cb.moveTo(240, 760);
            cb.lineTo(580, 760);
            cb.stroke();     
            
             // <<<<<<<<<<<<<<<<< linea despues de tabla >>>>>>>>>>>>>>>>>
           /* cb.setLineWidth(1f);
            cb.moveTo(50, 480);
            cb.lineTo(580, 480);
            cb.stroke();    */
      
            
            
            cb.setLineWidth(1f);
            cb.moveTo(24, 75);
            cb.lineTo(580, 75);
            cb.stroke();
            
            cb.beginText();
            cb.setFontAndSize(BaseFont.createFont( BaseFont.HELVETICA_BOLD, BaseFont.WINANSI, BaseFont.EMBEDDED),7);
            cb.setRGBColorFill(0,0,0);
            cb.showTextAligned(Element.ALIGN_LEFT, "RESPONSIVA DE EQUIPO DE LA GERENCIA", 45, 51, 0);
            cb.showTextAligned(Element.ALIGN_LEFT, "DE SOPORTE Y TELECOMUNICACIONES", 48, 43, 0);           
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
            cb.setFontAndSize(BaseFont.createFont( BaseFont.HELVETICA_BOLD, BaseFont.WINANSI, BaseFont.EMBEDDED),10);
            cb.setRGBColorFill(0,0,0);
            cb.showTextAligned(Element.ALIGN_LEFT, "Clave", 280, 62, 0);
            cb.showTextAligned(Element.ALIGN_LEFT, "SSI08F06", 272, 40, 0);
            cb.showTextAligned(Element.ALIGN_LEFT, "Elaboración", 350, 62, 0);
            cb.showTextAligned(Element.ALIGN_LEFT, "Actualización", 442, 62, 0);
            cb.showTextAligned(Element.ALIGN_LEFT, "Hoja", 540, 62, 0);
            cb.endText();
            
            cb.beginText();
            cb.setFontAndSize(BaseFont.createFont( BaseFont.HELVETICA, BaseFont.WINANSI, BaseFont.EMBEDDED),9);
            cb.showTextAligned(Element.ALIGN_LEFT, "18 / 01 / 2006", 352, 40, 0);
            cb.endText();
            
              
  
            String TDatos[]={"Solicitud:","Fecha de Solicitud:","Fecha Compromiso:","Fecha de Liberación:","Area Solicitante:","Responsable Solicitante:"};
     //       String Datos[]={Solicitud.getAsunto().toUpperCase().toString(),Solicitud.getFechaRegistro().toString(),Solicitud.getFechaCompromiso().toString(),Solicitud.getFechaTermino().toString(),Solicitud.getAreaSolicitante().toUpperCase().toString(),Solicitud.getUsrRegistra().toUpperCase().toString()};
            
            float ptx=0, pty=0, ptyD=0;
            
            String Px[]={"45","45","45","45","45","45"};
            String Py[]={"695","683","671","659","647","635"};
            
            String PyD[]={"715","700","685","670","655","640"};          
        
          
            
            
        } catch(Exception er) {
            throw new ExceptionConverter(er);
        }
    }
    
    public void onEndPage(PdfWriter writer, Document document) {
        PdfContentByte cb = writer.getDirectContent();
        String text = "" + writer.getPageNumber() ;
        try{
          
            cb.beginText();
            cb.setFontAndSize(BaseFont.createFont( BaseFont.HELVETICA, BaseFont.WINANSI, BaseFont.EMBEDDED),9);
            cb.setRGBColorFill(0,0,0);
            cb.showTextAligned(Element.ALIGN_LEFT, text, 550, 40, 0);
            cb.endText();          
                   
        }catch(Exception er){
            
        }
    } 
    
    
}
