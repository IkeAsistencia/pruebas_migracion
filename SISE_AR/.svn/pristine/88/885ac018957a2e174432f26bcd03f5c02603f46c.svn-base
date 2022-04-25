/*
 * ImpresionRespEquipoSalidaPDF.java
 *
 * Created on 25 de abril de 2011, 12:24 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package com.ike.helpdeskSP.to;

import Utilerias.UtileriasBDF;
import com.lowagie.text.Chunk;
import com.lowagie.text.Document;
import com.lowagie.text.Element;
import com.lowagie.text.ExceptionConverter;
import com.lowagie.text.Font;
import com.lowagie.text.Image;
import com.lowagie.text.PageSize;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Phrase;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.pdf.PdfContentByte;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfPageEventHelper;
import com.lowagie.text.pdf.PdfWriter;
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
public class ImpresionRespEquipoSalidaPDF extends PdfPageEventHelper {
    
    public static String RutaImagenS="";
    public static String StrEncabezado = "";
    public static String StrInformacion = "";
    public static String StrFechaAsigna ="";
    public static String StrDescripcion= "";
    public static String StrNota="";
    
    /*
     * Creates a new instance of ImpresionRespEquipoSalidaPDF
     */
    public ImpresionRespEquipoSalidaPDF() {
    }
    
    public Phrase TextoSalidaPDF(String StrFrase, Font font1, Font font2, Font font3){
        Phrase TextoSalidaDesc = new Phrase();
        ArrayList ListDesc = new ArrayList();
        StringTokenizer stDesc = new StringTokenizer(StrFrase,"|");
        
        while (stDesc.hasMoreTokens()){
            ListDesc.add(stDesc.nextToken().toString());
        }
        
        TextoSalidaDesc.clear();
        
        for (int i=0; i< ListDesc.size(); i++){
            
            
            int Ind = 0;
            Ind = ListDesc.get(i).toString().indexOf("<BOLD>");
            
            
            if (ListDesc.get(i).toString().indexOf("<BOLD>") != -1){
                Chunk foxD = new Chunk(ListDesc.get(i).toString().replace("<BOLD>",""), font3);
                TextoSalidaDesc.add(foxD);
            }
            
            if (ListDesc.get(i).toString().indexOf("<NORMAL>") != -1){
                Chunk foxD = new Chunk(ListDesc.get(i).toString().replace("<NORMAL>",""), font2);
                TextoSalidaDesc.add(foxD);
            }
            
            if (ListDesc.get(i).toString().indexOf("<n>") != -1){
                TextoSalidaDesc.add(new Paragraph("\n"));
            }
        }
        return TextoSalidaDesc;
    }
    
    public ByteArrayOutputStream ImpresionResponsivaPDF(String RutaImagen, String StoreProcedureInfoFolio, String StoreProcedurePeriferico){
        
        String StrTitular="";
        String StrJefeServicios="";
        RutaImagenS = RutaImagen;
        String StoreProcedure="";
        String StrSPInfoFolio="";
        ResultSet rsInfoFolio=null;
        ResultSet rsSolicitud = null;
        
        StoreProcedure="sp_InfoHojaSalida";
        rsSolicitud = UtileriasBDF.rsSQLNP(StoreProcedure);
        
        //************************ Información General para Hoja de Salida ***********************
        try {
            if (rsSolicitud.next()){
                
                StrInformacion = rsSolicitud.getString("Informacion");
                StrNota=rsSolicitud.getString("Nota");
                StrTitular=rsSolicitud.getString("Titular");
                StrJefeServicios=rsSolicitud.getString("JefeServicios");
            }
            rsSolicitud.close();
            rsSolicitud = null;
        } catch (Exception E){
            System.out.println(E);
        }
        
        //************************ Información de Folio ***********************
        rsInfoFolio = UtileriasBDF.rsSQLNP(StoreProcedureInfoFolio);
        
        String StrFolio="";
        String ResponsableEntrega="";
        String ResponsableSalida="";
        String FechaEntrega="";
        String FechaSalida="";
        String StrComentarios="";
        String dsMotivoSalida="";
        String StrclEstatus="0";
        
        try {
            if (rsInfoFolio.next()){
                StrFolio = rsInfoFolio.getString("clEquipoSalidaSP");
                ResponsableEntrega=rsInfoFolio.getString("ResponsableEntrega");
                ResponsableSalida=rsInfoFolio.getString("ResponsableSalida");
                FechaEntrega=rsInfoFolio.getString("FechaEntrega");
                FechaSalida=rsInfoFolio.getString("FechaSalida");
                StrComentarios=rsInfoFolio.getString("Comentarios");
                StrclEstatus=rsInfoFolio.getString("clEstatus");
                dsMotivoSalida=rsInfoFolio.getString("dsMotivoSalida");
            }
            rsInfoFolio.close();
            rsInfoFolio = null;
        } catch (Exception ex){
            ex.printStackTrace();
            System.out.println("Error al obtener Datos de Folio. "+ ex.toString());
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
            
            Document document = new Document(PageSize.A4,40,20,84,120);
            
            PdfWriter writer = PdfWriter.getInstance(document, baos);
            
            document.addTitle("RESPONSIVA HOJA DE SALIDA");
            document.addSubject("IKE ASISTENCIA");
            document.addAuthor("IKE ASISTENCIA");
            writer.setPageEvent(new ImpresionRespEquipoSalidaPDF());
            document.open();
            
            
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
            
            
            //<<<<<<<<<<<<<<<< Periferico x Usuario>>>>>>>>>>>>>>>>
            ResultSet rsPerifericos = null;
            
            try {
                System.out.println(StoreProcedurePeriferico);
                rsPerifericos = UtileriasBDF.rsSQLNP(StoreProcedurePeriferico);
                
                if (rsPerifericos.next()){
                    
                    //***************Tabla de Fechas**********************************************
                    PdfPTable tableFecha = new PdfPTable(4);
                    tableFecha.setWidthPercentage(100);
                    
                    PdfPCell c2 = new PdfPCell(new Phrase("MOTIVO DE SALIDA",font3));
                    c2.setHorizontalAlignment(Element.ALIGN_CENTER);
                    tableFecha.addCell(c2);
                    
                    c2 = new PdfPCell(new Phrase("FECHA SALIDA",font3));
                    c2.setHorizontalAlignment(Element.ALIGN_CENTER);
                    tableFecha.addCell(c2);
                    
                    c2 = new PdfPCell(new Phrase("FECHA REGRESO",font3));
                    c2.setHorizontalAlignment(Element.ALIGN_CENTER);
                    tableFecha.addCell(c2);
                    
                    c2 = new PdfPCell(new Phrase("FOLIO",font3));
                    c2.setHorizontalAlignment(Element.ALIGN_CENTER);
                    tableFecha.addCell(c2);
                    // tableFecha.setHeaderRows(1);
                    PdfPCell cMotivo = new PdfPCell(new Phrase(dsMotivoSalida,font3));
                    cMotivo.setHorizontalAlignment(Element.ALIGN_CENTER);
                    
                    PdfPCell cFechSalida = new PdfPCell(new Phrase(FechaSalida,font3));
                    cFechSalida.setHorizontalAlignment(Element.ALIGN_CENTER);
                    
                    PdfPCell cFechRegreso = new PdfPCell(new Phrase(FechaEntrega,font3));
                    cFechRegreso.setHorizontalAlignment(Element.ALIGN_CENTER);
                    
                    PdfPCell cFolio = new PdfPCell(new Phrase(StrFolio,font3));
                    cFolio.setHorizontalAlignment(Element.ALIGN_CENTER);
                    
                    tableFecha.addCell(cMotivo);
                    tableFecha.addCell(cFechSalida);
                    tableFecha.addCell(cFechRegreso);
                    tableFecha.addCell(cFolio);
                    document.add(tableFecha);
                    tableFecha=null;
                    
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
                    
                    //<<<<<<<<<<<<<<<<<< Contenido de la Tabla(Perifericos x Hoja de Salida) >>>>>>>>>>>>>>>>>>>>
                    do {
                        for ( i=1; i<=Celdas; i++){
                            if (rsPerifericos.getObject(i)!=null){
                                
                                PdfPCell cellG =new PdfPCell(new Paragraph(rsPerifericos.getObject(i).toString().replaceAll(",|\n|\r\n?"," "),font3));
                                cellG.setHorizontalAlignment(Element.ALIGN_CENTER);
                                cellG.setPadding(3.0f);
                                cellG.setColspan(1);
                                table.addCell(cellG);
                            }
                        }
                    } while(rsPerifericos.next());
                    
                    PdfContentByte cb = writer.getDirectContent();
                    document.add(table);
                    table = null;
                    // Tabla para responsables y nota
                    
                    PdfPTable tableResp = new PdfPTable(2);
                    tableResp.setWidthPercentage(100);
                    
                    //<<<<<<<<<<< Tabla Nombre y Firma Responsable Entrega>>>>>>>>>>>>>>>>>>
                    PdfPTable tableEntrega = new PdfPTable(1);
                    tableEntrega.setWidthPercentage(100);
                    //Columnas Entrega y Recibe
                    
                    PdfPCell cellNomFir =new PdfPCell(new Paragraph("NOMBRE Y FIRMA DEL:",font3));
                    cellNomFir.setHorizontalAlignment(Element.ALIGN_CENTER);
                    tableEntrega.addCell(cellNomFir);
                    
                    PdfPCell cellNom =new PdfPCell(new Paragraph(ResponsableEntrega,font3));
                    cellNom.setHorizontalAlignment(Element.ALIGN_CENTER);
                    cellNom.setPadding(25);
                    tableEntrega.addCell(cellNom);
                    
                    PdfPCell cellEnt =new PdfPCell(new Paragraph("RESPONSABLE DE LA ENTREGA",font3));
                    cellEnt.setHorizontalAlignment(Element.ALIGN_CENTER);
                    tableEntrega.addCell(cellEnt);
                    
                    PdfPCell cell2 =new PdfPCell(tableEntrega);
                    cell2.setHorizontalAlignment(Element.ALIGN_CENTER);
                    cell2.setPadding(0);
                    
                    //<<<<<<<<<<< Tabla Nombre y Firma Responsable Recibe >>>>>>>>>>>>>>>>>>
                    
                    PdfPTable tableRecibe = new PdfPTable(1);
                    tableRecibe.setWidthPercentage(100);
                    //Columnas Entrega y Recibe
                    
                    PdfPCell cellNomFirRec =new PdfPCell(new Paragraph("NOMBRE Y FIRMA DEL:",font3));
                    cellNomFirRec.setHorizontalAlignment(Element.ALIGN_CENTER);
                    tableRecibe.addCell(cellNomFirRec);
                    
                    PdfPCell cellFirRec =new PdfPCell(new Paragraph(ResponsableSalida,font3));
                    cellFirRec.setHorizontalAlignment(Element.ALIGN_CENTER);
                    cellFirRec.setPadding(25);
                    tableRecibe.addCell(cellFirRec);
                    
                    PdfPCell cellRec =new PdfPCell(new Paragraph("RESPONSABLE DE RECIBIR",font3));
                    cellRec.setHorizontalAlignment(Element.ALIGN_CENTER);
                    tableRecibe.addCell(cellRec);
                    
                    Phrase TextoNota = new Phrase();
                    TextoNota= TextoSalidaPDF(StrNota,font1,font2, font3);
                    PdfPCell cell3 =new PdfPCell(tableRecibe);
                    cell3.setHorizontalAlignment(Element.ALIGN_CENTER);
                    cell3.setPadding(0);
                    tableResp.addCell(cell2);
                    tableResp.addCell(cell3);
                    
                    PdfPCell cellNota =new PdfPCell(TextoNota);
                    cellNota.setHorizontalAlignment(Element.ALIGN_JUSTIFIED);
                    
                    
                    PdfPCell cell1 =new PdfPCell(tableResp);
                    cell1.setHorizontalAlignment(Element.ALIGN_CENTER);
                    cell1.setPadding(0);
                    
                    PdfPCell cellCom =new PdfPCell(new Paragraph("COMENTARIOS: ",font3));
                    cellCom.setHorizontalAlignment(Element.ALIGN_LEFT);
                    
                    
                    PdfPCell cellComentario =new PdfPCell(new Paragraph(StrComentarios,font3));
                    cellComentario.setHorizontalAlignment(Element.ALIGN_JUSTIFIED);
                    
                    //Tabla General Reponsables y texto
                    PdfPTable table1 = new PdfPTable(1);
                    table1.setWidthPercentage(100);
                    
                    table1.addCell(cellCom);
                    table1.addCell(cellComentario);
                    table1.addCell(cellNota);
                    
                    table1.addCell(cell1);
                    
                    Phrase Textoinfo = new Phrase();
                    Textoinfo= TextoSalidaPDF(StrInformacion,font1,font2, font3);
                    
                    PdfPCell cellInfo =new PdfPCell(Textoinfo);
                    cellInfo.setHorizontalAlignment(Element.ALIGN_JUSTIFIED);
                    table1.addCell(cellInfo);
                    
                    //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< FIRMAS >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                    
                    if(StrclEstatus.equalsIgnoreCase("6")){}else{
                        
                        //<<<<<<<<<<< Tabla Nombre y Firma Titular del AREA >>>>>>>>>>>>>>>>>>
                        PdfPTable tableFirmaTit = new PdfPTable(1);
                        tableFirmaTit.setWidthPercentage(100);
                        //Columnas Entrega y Recibe
                        tableFirmaTit.addCell(cellNomFir);
                        
                        PdfPCell cellFirTit =new PdfPCell(new Paragraph(StrTitular,font3));
                        cellFirTit.setHorizontalAlignment(Element.ALIGN_CENTER);
                        cellFirTit.setPadding(33);
                        tableFirmaTit.addCell(cellFirTit);
                        
                        PdfPCell cellTit =new PdfPCell(new Paragraph("TITULAR DE ÁREA QUE AUTORIZA",font3));
                        cellTit.setHorizontalAlignment(Element.ALIGN_CENTER);
                        tableFirmaTit.addCell(cellTit);
                        
                        PdfPCell cellTitArea =new PdfPCell(tableFirmaTit);
                        cellTitArea.setHorizontalAlignment(Element.ALIGN_CENTER);
                        cellTitArea.setPadding(0);
                        
                        //<<<<<<<<<<< Tabla Nombre y Firma Jefe de Servicios >>>>>>>>>>>>>>>>>>
                        PdfPTable tableFirmaJefeSer = new PdfPTable(1);
                        tableFirmaJefeSer.setWidthPercentage(100);
                        
                        PdfPCell cellFirJefeSer =new PdfPCell(new Paragraph(StrJefeServicios,font3));
                        cellFirJefeSer.setHorizontalAlignment(Element.ALIGN_CENTER);
                        cellFirJefeSer.setPadding(33);
                        
                        PdfPCell cellJefeSer =new PdfPCell(new Paragraph("JEFE DE SERVICIOS GENERALES",font3));
                        cellJefeSer.setHorizontalAlignment(Element.ALIGN_CENTER);
                        
                        
                        tableFirmaJefeSer.addCell(cellNomFir);
                        tableFirmaJefeSer.addCell(cellFirJefeSer);
                        tableFirmaJefeSer.addCell(cellJefeSer);
                        
                        PdfPCell cellJefeSerGen =new PdfPCell(tableFirmaJefeSer);
                        cellJefeSerGen.setHorizontalAlignment(Element.ALIGN_CENTER);
                        cellJefeSerGen.setPadding(0);
                        
                        
                        //<<<<<<<<<<< Tabla Nombre y Firma Personal de Vigilancia >>>>>>>>>>>>>>>>>>
                        
                        PdfPTable tableFirmaPerVig = new PdfPTable(1);
                        tableFirmaPerVig.setWidthPercentage(100);
                        
                        
                        PdfPCell cellFirPerVig =new PdfPCell(new Paragraph(" ",font3));
                        cellFirPerVig.setHorizontalAlignment(Element.ALIGN_CENTER);
                        cellFirPerVig.setPadding(37);
                        
                        PdfPCell cellPerVig =new PdfPCell(new Paragraph("PERSONAL DE VIGILANCIA",font3));
                        cellPerVig.setHorizontalAlignment(Element.ALIGN_CENTER);
                        
                        
                        tableFirmaPerVig.addCell(cellNomFir);
                        tableFirmaPerVig.addCell(cellFirPerVig);
                        tableFirmaPerVig.addCell(cellPerVig);
                        
                        PdfPCell cellPerVigilancia =new PdfPCell(tableFirmaPerVig);
                        cellPerVigilancia.setHorizontalAlignment(Element.ALIGN_CENTER);
                        cellPerVigilancia.setPadding(0);
                        
                        //<<<<<<<<<<< Tabla Firmas General >>>>>>>>>>>>>>>>>>
                        
                        PdfPTable tableFirmas = new PdfPTable(3);
                        tableFirmas.setWidthPercentage(100);
                        
                        tableFirmas.addCell(cellTitArea);
                        tableFirmas.addCell(cellJefeSerGen);
                        tableFirmas.addCell(cellPerVigilancia);
                        
                        PdfPCell cellTitAreaGen =new PdfPCell(tableFirmas);
                        cellTitAreaGen.setHorizontalAlignment(Element.ALIGN_CENTER);
                        cellTitAreaGen.setPadding(0);
                        
                        table1.addCell(cellTitAreaGen);                        
                        
                        tableFirmas = null;
                        tableFirmaTit = null;
                        tableFirmaJefeSer = null;
                        tableFirmaPerVig = null;
                    }
                    document.add(table1);
                    table1 = null;
                    tableResp = null;
                    tableRecibe = null;
                    tableEntrega = null;
                    table = null;
                    
                }else{
                    paragrapT = new Paragraph("NO EXISTEN EQUIPOS ASIGNADOS A ESTE FOLIO");
                    paragrapT.setAlignment(paragrapT.ALIGN_CENTER);
                    document.add(paragrapT);
                }
                
                rsPerifericos.close();
                rsPerifericos = null;
                
            } catch (Exception rE){
                System.out.println("Error rsPerifericos: "+rE);
            }
            
            
            PdfContentByte cb = writer.getDirectContent();
            
            String Imagen = RutaImagenS;
            int SizeFont = 8;
            
            Image jpg = Image.getInstance(Imagen);
            //jpg.setAlignment(1);
            jpg.setAbsolutePosition(30, 760);
            jpg.scaleAbsolute(230,60);
            document.add(jpg);
            document.close();
            
        } catch(Exception e){
            System.out.println(e);
        }
        //Limpiar Variables
        StrNota=null;
        StrFolio=null;
        ResponsableEntrega=null;
        ResponsableSalida=null;
        FechaEntrega=null;
        FechaSalida=null;
        StrComentarios=null;
        dsMotivoSalida=null;
        
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
            cb.showTextAligned(Element.ALIGN_RIGHT, "AUTORIZACIÓN PARA LA SALIDA DE", 580, 775, 0);
            cb.showTextAligned(Element.ALIGN_RIGHT, "EQUIPOS, MOBILIARIOS Y DOCUMENTOS", 580, 765, 0);
            cb.endText();
            
            // <<<<<<<<<<<<<<<<< Insertar  una linea en el PDF >>>>>>>>>>>>>>>>>
            cb.setLineWidth(1f);
            cb.moveTo(240, 760);
            cb.lineTo(580, 760);
            cb.stroke();
            
            // <<<<<<<<<<<<<<<<< linea despues de tabla >>>>>>>>>>>>>>>>>
            
            cb.beginText();
            cb.setFontAndSize(BaseFont.createFont( BaseFont.HELVETICA_BOLD, BaseFont.WINANSI, BaseFont.EMBEDDED),7);
            cb.setRGBColorFill(0,0,0);
            cb.showTextAligned(Element.ALIGN_LEFT, "GERENCIA DE RECURSOS HUMANOS                                  GRH09F11 Rev. No. 00                              AUTOSALBIENES", 45, 51, 0);
            cb.showTextAligned(Element.ALIGN_LEFT, "(DISTRIBUCIÓN: ORIGINAL= ÁREA SOLICITANTE; COPIA 1 = GERENCIA DE RECURSOS HUMANOS; COPIA 2 = PERSONA QUE RECIBE EL BIEN)", 48, 43, 0);
            cb.endText();
            
            cb.setLineWidth(1f);
            cb.moveTo(25, 60);
            cb.lineTo(580, 60);
            cb.stroke();
            
            //<<<<<<<<<<<<<<<<<<<<<<<< Lineas PDF >>>>>>>>>>>>>>>>>>>>>>>
            cb.beginText();
            cb.setFontAndSize(BaseFont.createFont( BaseFont.HELVETICA_BOLD, BaseFont.WINANSI, BaseFont.EMBEDDED),10);
            cb.setRGBColorFill(0,0,0);
            cb.endText();
            
            cb.beginText();
            cb.setFontAndSize(BaseFont.createFont( BaseFont.HELVETICA, BaseFont.WINANSI, BaseFont.EMBEDDED),9);
            cb.endText();
            
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
