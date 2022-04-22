/*
 * PDF.java
 *
 * Created on 22 de diciembre de 2011, 04:39 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */
package Utilerias;

import com.lowagie.text.FontFactory;
import java.io.ByteArrayOutputStream;
import com.lowagie.text.Chunk;
import com.lowagie.text.Document;
import com.lowagie.text.Element;
import com.lowagie.text.ExceptionConverter;
import com.lowagie.text.PageSize;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Phrase;
import com.lowagie.text.Rectangle;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.pdf.PdfContentByte;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfPageEventHelper;
import com.lowagie.text.pdf.PdfWriter;
import com.lowagie.text.Font;
import com.lowagie.text.Image;
import java.awt.Color;
import java.io.FileOutputStream;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.StringTokenizer;

/*
 *
 * @author vsampablo
 */
public class PDF extends PdfPageEventHelper {

    public static String StrDescripcion = "";
    public static ArrayList lsImgRuta = new ArrayList();
    public static ArrayList lsImgX = new ArrayList();
    public static ArrayList lsImgY = new ArrayList();
    public static ArrayList lsImgW = new ArrayList();
    public static ArrayList lsImgH = new ArrayList();
    public static ArrayList lsText = new ArrayList();
    public static ArrayList lsTextStyleFont = new ArrayList();
    public static ArrayList lsTextSizeFont = new ArrayList();
    public static ArrayList lsTextColorFont = new ArrayList();
    public static ArrayList lsTextX = new ArrayList();
    public static ArrayList lsTextY = new ArrayList();
    public static ArrayList lsTextFont = new ArrayList();
    public static ArrayList lsLineWidth = new ArrayList();
    public static ArrayList lsLineX = new ArrayList();
    public static ArrayList lsLineY = new ArrayList();
    public static ArrayList lsLineToX = new ArrayList();
    //<<<<<<<<<<<<<< Tipo de Letra (Font)  de un archivo ttf >>>>>>>>>>>>>
    public static Font FontTipoLetra = null;
    public static BaseFont bfTipoLetra = null;
    public static String StrNumerarPaginas = "0";

    /* Creates a new instance of PDF */
    public PDF() {
    }

    //<<<<<<<<<<<<<<<<<<<<<< Genera un PDF al vuelo Tipo:VistaPDF >>>>>>>>>>>>>>>>>>>>>>>
    public ByteArrayOutputStream VistaPDF(String StoreProcedure, String StrParametros, String StrParametrosPDF) {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        PDF(StoreProcedure, StrParametros, StrParametrosPDF, "VistaPDF", "", baos);
        return baos;
    }

    //<<<<<<<<<<<<<<<<<<<<<< Genera un PDF en una Ruta Física Tipo:ImprimePDF >>>>>>>>>>>>>>>>>>>>>>>
    public void ImprimePDF(String StoreProcedure, String StrParametros, String StrParametrosPDF, String StrRutaPDF) {
        PDF(StoreProcedure, StrParametros, StrParametrosPDF, "ImprimePDF", StrRutaPDF, null);
    }

    //<<<<<<<<<<<<<<<<<<<< Obtiene el Valor de Una Cadena con un parametro espefifico >>>>>>>>>>>>>>>>>>>>>>
    public String getValorTagPDF(String StrCadena, String StrParametro, String StrToken, String StrValorDefault) {
        int index = 0, indexToken = 0;
        //<<<<<<<<<<<<<< Obtener el index de donde inicia el Parametro de la Cadena >>>>>>>>>>>>>>>
        index = StrCadena.indexOf(StrParametro, 0);

        if (index == -1) {
            return StrValorDefault;
        } else {
            //<<<<<<<<<<<<< Eliminar lo anterior al Parametro >>>>>>>>>>>>>
            StrCadena = StrCadena.substring(index + StrParametro.length());
            indexToken = StrCadena.indexOf(StrToken, 0);

            if (indexToken != -1) {
                StrCadena = StrCadena.substring(0, indexToken + StrToken.length() - 1);
            }

            return StrCadena;
        }
    }

    //<<<<<<<<<<<<<<<<<<<<<<< Contruye  el PDF >>>>>>>>>>>>>>>>>>>>>>>>
    public void PDF(String StoreProcedure, String StrParametros, String StrParametrosPDF, String Tipo, String StrRutaPDF, ByteArrayOutputStream BAOS) {
        ResultSet rsTipoDato = null;

        //System.out.println(StoreProcedure + " " + StrParametros);

        Phrase TextoSalidaTablaTitulo = new Phrase();
        Phrase TextoSalidaTabla = new Phrase();

        String StrTitulo = "", StrAutor = "", StrMargenLeft = "", StrMargenRight = "", StrMargenTop = "", StrMargenBottom = "", StrAsunto = "";

        StrTitulo = getValorTagPDF(StrParametrosPDF, "Titulo=", ",", "IKE");
        StrAutor = getValorTagPDF(StrParametrosPDF, "Autor=", ",", "IKE");
        StrMargenLeft = getValorTagPDF(StrParametrosPDF, "MargenLeft=", ",", "30");
        StrMargenRight = getValorTagPDF(StrParametrosPDF, "MargenRight=", ",", "30");
        StrMargenTop = getValorTagPDF(StrParametrosPDF, "MargenTop=", ",", "90");
        StrMargenBottom = getValorTagPDF(StrParametrosPDF, "MargenBottom=", ",", "30");
        StrAsunto = getValorTagPDF(StrParametrosPDF, "Asunto=", ",", " ");
        StrNumerarPaginas = getValorTagPDF(StrParametrosPDF, "NumerarPaginas=", ",", "0");

        try {

            java.awt.Color Style1 = new java.awt.Color(0xFF, 0xFF, 0xFF);
            java.awt.Color Style2 = new java.awt.Color(0x00, 0x00, 0x00);
            java.awt.Color Style3 = new java.awt.Color(0x00, 0x00, 0x00);

            //<<<<<<<<<<<<<<<<< Tipos de Fuentes >>>>>>>>>>>>>>
            Font font1 = new Font(Font.HELVETICA, 8, Font.BOLD, Style1);
            Font font2 = new Font(Font.HELVETICA, 8, Font.NORMAL, Style2);
            Font font3 = new Font(Font.HELVETICA, 8, Font.BOLD, Style3);



            PdfWriter writer = null;
            Document document = new Document(PageSize.A4, Float.parseFloat(StrMargenLeft), Float.parseFloat(StrMargenRight), Float.parseFloat(StrMargenTop), Float.parseFloat(StrMargenBottom));

            if (Tipo.equalsIgnoreCase("VistaPDF")) {
                //System.out.println("<<<<<<<<<<<<<<< Vista PDF >>>>>>>>>>>>>>>");
                writer = PdfWriter.getInstance(document, BAOS);
                writer.setEncryption(PdfWriter.STRENGTH128BITS, "", "", 0);
                /*writer.setViewerPreferences(PdfCopy.HideMenubar  | PdfCopy.CenterWindow);
                 writer.setViewerPreferences(PdfCopy.HideToolbar  | PdfCopy.CenterWindow);
                 writer.setViewerPreferences(PdfCopy.HideWindowUI | PdfCopy.CenterWindow);*/

                rsTipoDato = UtileriasBDF.rsSQLNP(StoreProcedure + " '" + StrParametros + "',0");
            }

            if (Tipo.equalsIgnoreCase("ImprimePDF")) {
                //System.out.println("<<<<<<<<<<<<<<< Imprime PDF >>>>>>>>>>>>>>>");
                writer = PdfWriter.getInstance(document, new FileOutputStream(StrRutaPDF.replace(".pdf", "") + ".pdf"));
                //writer.setEncryption(PdfWriter.STRENGTH128BITS ,"","",0);
                //<<<<<<<< Se agrega un Parametro para la Impresion >>>>>>>>
                rsTipoDato = UtileriasBDF.rsSQLNP(StoreProcedure + " '" + StrParametros + "',1");
            }

            document.addTitle(StrTitulo);
            document.addSubject(StrAsunto);
            document.addAuthor(StrAutor);

            document.open();
            writer.setPageEvent(new PDF());

            PdfContentByte cb = writer.getDirectContent();

            String StrTipoDato = "", StrX = "", StrY = "", StrEncabezado = "",
                    StrPiePagina = "", StrAlign = "", StrStyleFont = "",
                    StrFont = "", StrSizeFont = "", StrColorFont = "", StrTexto = "",
                    StrWidth = "", StrHeight = "", StrRuta = "";
            int iHoja = 1;
            int iHojaEnUso = 1;

            String StrColorTabTitulo = "", StrColorFontTabTitulo = "", StrBorderTab = "0", StrColsTab = "", StrBoderTab = "0";

            try {
                while (rsTipoDato.next()) {
                    StrTipoDato = rsTipoDato.getString("Tipo");
                    StrX = rsTipoDato.getString("X");
                    StrY = rsTipoDato.getString("Y");
                    StrEncabezado = rsTipoDato.getString("Encabezado");
                    iHoja = Integer.parseInt(rsTipoDato.getString("Hoja"));
                    StrAlign = rsTipoDato.getString("Align");
                    StrColorTabTitulo = rsTipoDato.getString("ColorTabTitulo");
                    StrColorFontTabTitulo = rsTipoDato.getString("ColorFontTabTitulo");
                    StrBorderTab = rsTipoDato.getString("BorderTab");
                    StrColsTab = rsTipoDato.getString("ColsTab");
                    StrStyleFont = rsTipoDato.getString("StyleFont");
                    StrSizeFont = rsTipoDato.getString("SizeFont");
                    StrColorFont = rsTipoDato.getString("ColorFont");
                    StrTexto = rsTipoDato.getString("Texto");
                    StrBoderTab = rsTipoDato.getString("BorderTab");
                    StrWidth = rsTipoDato.getString("width");
                    StrHeight = rsTipoDato.getString("height");
                    StrRuta = rsTipoDato.getString("Ruta");
                    StrFont = rsTipoDato.getString("Font");

                    if (!StrFont.equalsIgnoreCase("")) {
                        FontFactory.register(getValorTagPDF(StrFont, "Ruta=", ",", ""));
                    }

                    if (StrTipoDato.equalsIgnoreCase("Img")) {
                        if (StrEncabezado.equalsIgnoreCase("1")) {
                            lsImgRuta.add(StrRuta);
                            lsImgX.add(StrX);
                            lsImgY.add(StrY);
                            lsImgW.add(StrWidth);
                            lsImgH.add(StrHeight);

                        } else {
                            if (iHoja != iHojaEnUso) {
                                //System.out.println("--- Hoja Nueva"+String.valueOf(iHoja));
                                iHojaEnUso = iHoja;
                                document.newPage();
                            }


                            //File fileImg = new File(StrRuta);

                            Image jpg = Image.getInstance(StrRuta);
                            jpg.setAbsolutePosition(Integer.parseInt(StrX), Integer.parseInt(StrY));
                            if (!StrWidth.equalsIgnoreCase("0") && !StrHeight.equalsIgnoreCase("0")) {
                                jpg.scaleAbsolute(Integer.parseInt(StrWidth), Integer.parseInt(StrHeight));
                            }
                            document.add(jpg);
                            jpg = null;
                        }
                    }

                    if (StrTipoDato.equalsIgnoreCase("Line")) {

                        if (StrEncabezado.equalsIgnoreCase("1")) {
                            lsLineWidth.add(rsTipoDato.getString("LineWidth"));
                            lsLineX.add(StrX);
                            lsLineY.add(StrY);
                            lsLineToX.add(rsTipoDato.getString("LineToX"));
                        } else {
                            if (iHoja != iHojaEnUso) {
                                //System.out.println("--- Hoja Nueva"+String.valueOf(iHoja));
                                iHojaEnUso = iHoja;
                                document.newPage();
                            }

                            // <<<<<<<<<<<<<<<<< Insertar  una linea en el PDF >>>>>>>>>>>>>>>>>
                            cb.setLineWidth(Float.parseFloat(rsTipoDato.getString("LineWidth")));
                            cb.moveTo(Integer.parseInt(StrX), Integer.parseInt(StrY));
                            cb.lineTo(Integer.parseInt(rsTipoDato.getString("LineToX")), Integer.parseInt(StrY));
                            cb.stroke();
                        }
                    }

                    if (StrTipoDato.equalsIgnoreCase("Table")) {

                        java.awt.Color StyleTabTitulo = null;
                        java.awt.Color StyleTabText = null;

                        if (!StrColorFontTabTitulo.equalsIgnoreCase("") && !StrColorFont.equalsIgnoreCase("")) {
                            StyleTabTitulo = new java.awt.Color(Integer.parseInt(StrColorFontTabTitulo));
                            StyleTabText = new java.awt.Color(Integer.parseInt(StrColorFont));
                        }

                        //System.out.println("Table");
                        PdfPTable table = new PdfPTable(Integer.parseInt(StrColsTab));
                        table.setWidthPercentage(100);

                        ArrayList ListTextTable = new ArrayList();
                        StringTokenizer stTextTable = new StringTokenizer(StrTexto, "|");

                        while (stTextTable.hasMoreTokens()) {
                            ListTextTable.add(stTextTable.nextToken().toString());
                        }

                        PdfPCell cellG = null;



                        for (int lt = 0; lt < ListTextTable.size(); lt++) {
                            TextoSalidaTabla.clear();

                            //<<<<<<<<<<<<<<<<<<<<<<< Verificar si es Imagen >>>>>>>>>>>>>>>>>>>>>
                            if (ListTextTable.get(lt).toString().indexOf("Img=") != -1) {

                                String ImgTable = "", ImgTableWidth = "", ImgTableHeight = "", ImgTableAlignH = "", ImgTableAlignV = "", ImgTableColspan = "1";

                                //<<<<<<<<<<<<<<< Ruta Img >>>>>>>>>>>>>>
                                ImgTable = getValorTagPDF(ListTextTable.get(lt).toString(), "Img=", ",", "");
                                //<<<<<<<<<<<<<<< Width Img >>>>>>>>>>>>>>
                                ImgTableWidth = getValorTagPDF(ListTextTable.get(lt).toString(), "Width=", ",", "10");
                                //<<<<<<<<<<<<<<< Height Img >>>>>>>>>>>>>>
                                ImgTableHeight = getValorTagPDF(ListTextTable.get(lt).toString(), "Height=", ",", "10");
                                //<<<<<<<<<<<<<<< Align Horizontal Img >>>>>>>>>>>>>>
                                ImgTableAlignH = getValorTagPDF(ListTextTable.get(lt).toString(), "AlignH=", ",", "Center");
                                //<<<<<<<<<<<<<<< Align Vertical Img >>>>>>>>>>>>>>
                                ImgTableAlignV = getValorTagPDF(ListTextTable.get(lt).toString(), "AlignV=", ",", "Middle");
                                //<<<<<<<<<<<<<< Colspan Img >>>>>>>>>>>>>>>
                                ImgTableColspan = getValorTagPDF(ListTextTable.get(lt).toString(), "Colspan=", ",", "1");

                                Image jpg = Image.getInstance(ImgTable);
                                jpg.scaleAbsolute(Integer.parseInt(ImgTableWidth), Integer.parseInt(ImgTableHeight));

                                cellG = new PdfPCell(jpg);
                                cellG.setColspan(Integer.parseInt(ImgTableColspan));

                                if (StrBoderTab.equalsIgnoreCase("0")) {
                                    cellG.setBorder(PdfPCell.NO_BORDER);
                                }

                                //<<<<<<<<< Alineacion de Img Horizontal >>>>>>>>>>
                                if (ImgTableAlignH.equalsIgnoreCase("Center")) {
                                    cellG.setHorizontalAlignment(Element.ALIGN_CENTER);
                                }

                                if (ImgTableAlignH.equalsIgnoreCase("Left")) {
                                    cellG.setHorizontalAlignment(Element.ALIGN_LEFT);
                                }

                                if (ImgTableAlignH.equalsIgnoreCase("Right")) {
                                    cellG.setHorizontalAlignment(Element.ALIGN_RIGHT);
                                }

                                //<<<<<<<<< Alineacion de Img Vertical  >>>>>>>>>>
                                if (ImgTableAlignV.equalsIgnoreCase("Top")) {
                                    cellG.setVerticalAlignment(Element.ALIGN_TOP);
                                }

                                if (ImgTableAlignV.equalsIgnoreCase("Middle")) {
                                    cellG.setVerticalAlignment(Element.ALIGN_MIDDLE);
                                }

                                if (ImgTableAlignV.equalsIgnoreCase("Bottom")) {
                                    cellG.setVerticalAlignment(Element.ALIGN_BOTTOM);
                                }

                                table.addCell(cellG);

                                ImgTable = null;
                                ImgTableWidth = null;
                                ImgTableHeight = null;
                                ImgTableAlignH = null;
                                ImgTableAlignV = null;

                            } //<<<<<<<<<<<<<<<<<<<<<< Insertar Texto en la Tabla >>>>>>>>>>>>>>>
                            else {
                                //<<<<<<<<<<<<<<<<<<<<<<< Verificar si el hay una Tabla Anidada>>>>>>>>>>>>>>>>>>>>>
                                if (ListTextTable.get(lt).toString().indexOf("Table=") != -1) {
                                    String TxtTableNested = "", TableNestedCols = "", AlignTableNested = "", TxtColspanTableNested = "";

                                    TxtTableNested = getValorTagPDF(ListTextTable.get(lt).toString(), "Table=", "^", "");
                                    TableNestedCols = getValorTagPDF(ListTextTable.get(lt).toString(), "Cols=", "^", "0");
                                    TxtColspanTableNested = getValorTagPDF(ListTextTable.get(lt).toString(), "Colspan=", "^", "1");



                                    ArrayList ListTextTableNested = new ArrayList();
                                    StringTokenizer stTextTableNested = new StringTokenizer(TxtTableNested, "¦"); //Alt + 179 = ?

                                    while (stTextTableNested.hasMoreTokens()) {
                                        ListTextTableNested.add(stTextTableNested.nextToken().toString());
                                    }

                                    PdfPTable tableNested = new PdfPTable(Integer.parseInt(TableNestedCols));
                                    tableNested.setWidthPercentage(100);

                                    PdfPCell cellGNested = null;


                                    for (int ltn = 0; ltn < ListTextTableNested.size(); ltn++) {
                                        String TxtTable = "", TxtFontTable = "", TxtSizeTable = "", TxtStyleTable = "Normal", TxtColorTable = "", TxtAlignTable = "", TxtColspanTable = "1";
                                        String TxtTipoTable = "", TxtRutaTable = "";

                                        TxtTable = getValorTagPDF(ListTextTableNested.get(ltn).toString(), "Txt=", "~", "");  // Alt + 126 = ~
                                        //<<<<<<<<<<<<<<< Txt Size Tabla con Formato >>>>>>>>>>>>>>
                                        TxtSizeTable = getValorTagPDF(ListTextTableNested.get(ltn).toString(), "Size=", "~", "10");
                                        //<<<<<<<<<<<<<<< Txt Style Tabla con Formato >>>>>>>>>>>>>>
                                        TxtStyleTable = getValorTagPDF(ListTextTableNested.get(ltn).toString(), "Style=", "~", "Normal");
                                        //<<<<<<<<<<<<<<< Txt Color Tabla con Formato >>>>>>>>>>>>>>
                                        TxtColorTable = getValorTagPDF(ListTextTableNested.get(ltn).toString(), "Color=", "~", StrColorFont);
                                        //<<<<<<<<<<<<<<< Txt Align Tabla con Formato >>>>>>>>>>>>>>
                                        TxtAlignTable = getValorTagPDF(ListTextTableNested.get(ltn).toString(), "Align=", "~", "Center");
                                        //<<<<<<<<<<<<<<< Txt ColsPan Tabla con Formato >>>>>>>>>>>>>>
                                        TxtColspanTable = getValorTagPDF(ListTextTableNested.get(ltn).toString(), "Span=", "~", "1");

                                        //<<<<<<<<<<<<<< Tipo de Fuente de un Archivo TTF >>>>>>>>>>>>>>>
                                        TxtTipoTable = getValorTagPDF(ListTextTableNested.get(ltn).toString(), "Tipo=", "~", "");
                                        TxtRutaTable = getValorTagPDF(ListTextTableNested.get(ltn).toString(), "Ruta=", "~", "");

                                        Font fontTab = null;

                                        java.awt.Color StyleTabTxtTable = new java.awt.Color(Integer.parseInt(TxtColorTable));


                                        if (!TxtTipoTable.equalsIgnoreCase("") && !TxtRutaTable.equalsIgnoreCase("")) {
                                            FontFactory.register(TxtRutaTable);
                                            if (TxtStyleTable.equalsIgnoreCase("Normal")) {
                                                FontTipoLetra = FontFactory.getFont(TxtTipoTable, BaseFont.WINANSI, BaseFont.EMBEDDED, Float.parseFloat(TxtSizeTable), Font.NORMAL, StyleTabTxtTable);
                                            }

                                            if (TxtStyleTable.equalsIgnoreCase("Bold")) {
                                                FontTipoLetra = FontFactory.getFont(TxtTipoTable, BaseFont.WINANSI, BaseFont.EMBEDDED, Float.parseFloat(TxtSizeTable), Font.BOLD, StyleTabTxtTable);
                                            }

                                            if (TxtStyleTable.equalsIgnoreCase("Italic")) {
                                                FontTipoLetra = FontFactory.getFont(TxtTipoTable, BaseFont.WINANSI, BaseFont.EMBEDDED, Float.parseFloat(TxtSizeTable), Font.ITALIC, StyleTabTxtTable);
                                            }

                                            if (TxtStyleTable.equalsIgnoreCase("BoldItalic")) {
                                                FontTipoLetra = FontFactory.getFont(TxtTipoTable, BaseFont.WINANSI, BaseFont.EMBEDDED, Float.parseFloat(TxtSizeTable), Font.BOLDITALIC, StyleTabTxtTable);
                                            }
                                        } else {
                                            if (TxtStyleTable.equalsIgnoreCase("Normal")) {
                                                fontTab = new Font(Font.HELVETICA, Float.parseFloat(TxtSizeTable), Font.NORMAL, StyleTabTxtTable);
                                            }

                                            if (TxtStyleTable.equalsIgnoreCase("Bold")) {
                                                fontTab = new Font(Font.HELVETICA, Float.parseFloat(TxtSizeTable), Font.BOLD, StyleTabTxtTable);
                                            }

                                            if (TxtStyleTable.equalsIgnoreCase("Italic")) {
                                                fontTab = new Font(Font.HELVETICA, Float.parseFloat(TxtSizeTable), Font.ITALIC, StyleTabTxtTable);
                                            }

                                            if (TxtStyleTable.equalsIgnoreCase("BoldItalic")) {
                                                fontTab = new Font(Font.HELVETICA, Float.parseFloat(TxtSizeTable), Font.BOLDITALIC, StyleTabTxtTable);
                                            }
                                        }


                                        Chunk foxTab = null;

                                        if (!TxtTipoTable.equalsIgnoreCase("") && !TxtRutaTable.equalsIgnoreCase("")) {
                                            foxTab = new Chunk(TxtTable, FontTipoLetra);
                                        } else {
                                            foxTab = new Chunk(TxtTable, fontTab);
                                        }

                                        cellGNested = new PdfPCell(new Paragraph(foxTab));

                                        cellGNested.setColspan(Integer.parseInt(TxtColspanTable));

                                        if (StrBoderTab.equalsIgnoreCase("0")) {
                                            cellGNested.setBorder(PdfPCell.NO_BORDER);
                                        }

                                        //<<<<<<<<< Alineacion de Txt Horizontal >>>>>>>>>>
                                        if (TxtAlignTable.equalsIgnoreCase("Center")) {
                                            cellGNested.setHorizontalAlignment(Element.ALIGN_CENTER);
                                        }

                                        if (TxtAlignTable.equalsIgnoreCase("Left")) {
                                            cellGNested.setHorizontalAlignment(Element.ALIGN_LEFT);
                                        }

                                        if (TxtAlignTable.equalsIgnoreCase("Right")) {
                                            cellGNested.setHorizontalAlignment(Element.ALIGN_RIGHT);
                                        }

                                        //<<<<<<<<< Alineacion de Txt Vertical  >>>>>>>>>>
                                        if (TxtAlignTable.equalsIgnoreCase("Top")) {
                                            cellGNested.setVerticalAlignment(Element.ALIGN_TOP);
                                        }

                                        if (TxtAlignTable.equalsIgnoreCase("Middle")) {
                                            cellGNested.setVerticalAlignment(Element.ALIGN_MIDDLE);
                                        }

                                        if (TxtAlignTable.equalsIgnoreCase("Bottom")) {
                                            cellGNested.setVerticalAlignment(Element.ALIGN_BOTTOM);
                                        }

                                        tableNested.addCell(cellGNested);

                                    }

                                    cellG = new PdfPCell();
                                    cellG.setColspan(Integer.parseInt(TxtColspanTableNested));
                                    if (StrBoderTab.equalsIgnoreCase("0")) {
                                        cellG.setBorder(PdfPCell.NO_BORDER);
                                    }

                                    cellG.addElement(tableNested);


                                    table.addCell(cellG);
                                    continue;
                                }//<<<<<<<<<<<<<<<<<<<<<<< Verificar si el hay una Tabla Anidada>>>>>>>>>>>>>>>>>>>>>

                                //<<<<<<<<<<<<<<<<<<<<<<< Verificar si el Texto Tiene Formato >>>>>>>>>>>>>>>>>>>>>
                                if (ListTextTable.get(lt).toString().indexOf("Txt=") != -1) {

                                    String TxtTable = "", TxtFontTable = "", TxtSizeTable = "", TxtStyleTable = "Normal", TxtColorTable = "", TxtAlignTable = "", TxtColspanTable = "1";
                                    String TxtTipoTable = "", TxtRutaTable = "";

                                    //<<<<<<<<<<<<<<< Txt Tabla con Formato >>>>>>>>>>>>>>
                                    TxtTable = getValorTagPDF(ListTextTable.get(lt).toString(), "Txt=", "^", "");
                                    //<<<<<<<<<<<<<<< Txt Size Tabla con Formato >>>>>>>>>>>>>>
                                    TxtSizeTable = getValorTagPDF(ListTextTable.get(lt).toString(), "Size=", "^", "10");
                                    //<<<<<<<<<<<<<<< Txt Style Tabla con Formato >>>>>>>>>>>>>>
                                    TxtStyleTable = getValorTagPDF(ListTextTable.get(lt).toString(), "Style=", "^", "Normal");
                                    //<<<<<<<<<<<<<<< Txt Color Tabla con Formato >>>>>>>>>>>>>>
                                    TxtColorTable = getValorTagPDF(ListTextTable.get(lt).toString(), "Color=", "^", StrColorFont);
                                    //<<<<<<<<<<<<<<< Txt Align Tabla con Formato >>>>>>>>>>>>>>
                                    TxtAlignTable = getValorTagPDF(ListTextTable.get(lt).toString(), "Align=", "^", "Center");
                                    //<<<<<<<<<<<<<<< Txt ColsPan Tabla con Formato >>>>>>>>>>>>>>
                                    TxtColspanTable = getValorTagPDF(ListTextTable.get(lt).toString(), "Colspan=", "^", "1");

                                    //<<<<<<<<<<<<<< Tipo de Fuente de un Archivo TTF >>>>>>>>>>>>>>>
                                    TxtTipoTable = getValorTagPDF(ListTextTable.get(lt).toString(), "Tipo=", "^", "");
                                    TxtRutaTable = getValorTagPDF(ListTextTable.get(lt).toString(), "Ruta=", "^", "");

                                    Font fontTab = null;

                                    java.awt.Color StyleTabTxtTable = new java.awt.Color(Integer.parseInt(TxtColorTable));


                                    if (!TxtTipoTable.equalsIgnoreCase("") && !TxtRutaTable.equalsIgnoreCase("")) {
                                        FontFactory.register(TxtRutaTable);
                                        // FontTipoLetra =  FontFactory.getFont(TxtTipoTable,BaseFont.WINANSI,BaseFont.EMBEDDED, Float.parseFloat(TxtSizeTable));
                                        if (TxtStyleTable.equalsIgnoreCase("Normal")) {
                                            FontTipoLetra = FontFactory.getFont(TxtTipoTable, BaseFont.WINANSI, BaseFont.EMBEDDED, Float.parseFloat(TxtSizeTable), Font.NORMAL, StyleTabTxtTable);
                                        }

                                        if (TxtStyleTable.equalsIgnoreCase("Bold")) {
                                            FontTipoLetra = FontFactory.getFont(TxtTipoTable, BaseFont.WINANSI, BaseFont.EMBEDDED, Float.parseFloat(TxtSizeTable), Font.BOLD, StyleTabTxtTable);
                                        }

                                        if (TxtStyleTable.equalsIgnoreCase("Italic")) {
                                            FontTipoLetra = FontFactory.getFont(TxtTipoTable, BaseFont.WINANSI, BaseFont.EMBEDDED, Float.parseFloat(TxtSizeTable), Font.ITALIC, StyleTabTxtTable);
                                        }

                                        if (TxtStyleTable.equalsIgnoreCase("BoldItalic")) {
                                            FontTipoLetra = FontFactory.getFont(TxtTipoTable, BaseFont.WINANSI, BaseFont.EMBEDDED, Float.parseFloat(TxtSizeTable), Font.BOLDITALIC, StyleTabTxtTable);
                                        }
                                    } else {
                                        if (TxtStyleTable.equalsIgnoreCase("Normal")) {
                                            fontTab = new Font(Font.HELVETICA, Float.parseFloat(TxtSizeTable), Font.NORMAL, StyleTabTxtTable);
                                        }

                                        if (TxtStyleTable.equalsIgnoreCase("Bold")) {
                                            fontTab = new Font(Font.HELVETICA, Float.parseFloat(TxtSizeTable), Font.BOLD, StyleTabTxtTable);
                                        }

                                        if (TxtStyleTable.equalsIgnoreCase("Italic")) {
                                            fontTab = new Font(Font.HELVETICA, Float.parseFloat(TxtSizeTable), Font.ITALIC, StyleTabTxtTable);
                                        }

                                        if (TxtStyleTable.equalsIgnoreCase("BoldItalic")) {
                                            fontTab = new Font(Font.HELVETICA, Float.parseFloat(TxtSizeTable), Font.BOLDITALIC, StyleTabTxtTable);
                                        }
                                    }


                                    Chunk foxTab = null;

                                    if (!TxtTipoTable.equalsIgnoreCase("") && !TxtRutaTable.equalsIgnoreCase("")) {
                                        foxTab = new Chunk(TxtTable, FontTipoLetra);
                                    } else {
                                        foxTab = new Chunk(TxtTable, fontTab);
                                    }

                                    cellG = new PdfPCell(new Paragraph(foxTab));

                                    cellG.setColspan(Integer.parseInt(TxtColspanTable));

                                    if (StrBoderTab.equalsIgnoreCase("0")) {
                                        cellG.setBorder(PdfPCell.NO_BORDER);
                                    }

                                    //<<<<<<<<< Alineacion de Txt Horizontal >>>>>>>>>>
                                    if (TxtAlignTable.equalsIgnoreCase("Center")) {
                                        cellG.setHorizontalAlignment(Element.ALIGN_CENTER);
                                    }

                                    if (TxtAlignTable.equalsIgnoreCase("Left")) {
                                        cellG.setHorizontalAlignment(Element.ALIGN_LEFT);
                                    }

                                    if (TxtAlignTable.equalsIgnoreCase("Right")) {
                                        cellG.setHorizontalAlignment(Element.ALIGN_RIGHT);
                                    }

                                    //<<<<<<<<< Alineacion de Txt Vertical  >>>>>>>>>>
                                    if (TxtAlignTable.equalsIgnoreCase("Top")) {
                                        cellG.setVerticalAlignment(Element.ALIGN_TOP);
                                    }

                                    if (TxtAlignTable.equalsIgnoreCase("Middle")) {
                                        cellG.setVerticalAlignment(Element.ALIGN_MIDDLE);
                                    }

                                    if (TxtAlignTable.equalsIgnoreCase("Bottom")) {
                                        cellG.setVerticalAlignment(Element.ALIGN_BOTTOM);
                                    }

                                    table.addCell(cellG);
                                } else {
                                    if (StrStyleFont.equalsIgnoreCase("Normal") || StrStyleFont.equalsIgnoreCase("")) {
                                        Font fontTabTitulo = new Font(Font.HELVETICA, Float.parseFloat(StrSizeFont), Font.NORMAL, StyleTabTitulo);
                                        Font fontTab = new Font(Font.HELVETICA, Float.parseFloat(StrSizeFont), Font.NORMAL, StyleTabText);

                                        //<<<<<<<<<<<<<<<<<< Titulo (s) Tabla >>>>>>>>>>>>>>>>>>>
                                        if (lt < Integer.parseInt(StrColsTab) && !StrColorTabTitulo.equalsIgnoreCase("") && !StrColorFont.equalsIgnoreCase("")) {
                                            Chunk foxTabTitulo = new Chunk(ListTextTable.get(lt).toString(), fontTabTitulo);
                                            cellG = new PdfPCell(new Paragraph(foxTabTitulo));
                                            //<<<<<<<<<<<<<<<<<<< Quitar Border de la Tabla >>>>>>>>>>>>>>>>>>
                                            if (StrBoderTab.equalsIgnoreCase("0")) {
                                                cellG.setBorder(PdfPCell.NO_BORDER);
                                            }
                                            cellG.setColspan(1);
                                            cellG.setHorizontalAlignment(Element.ALIGN_CENTER);
                                            cellG.setBackgroundColor(new Color(Integer.parseInt(StrColorTabTitulo)));
                                            cellG.setPadding(3.0f);
                                            table.addCell(cellG);
                                        } else {
                                            Chunk foxTab = new Chunk(ListTextTable.get(lt).toString(), fontTab);
                                            cellG = new PdfPCell(new Paragraph(foxTab));
                                            //<<<<<<<<<<<<<<<<<<< Quitar Border de la Tabla >>>>>>>>>>>>>>>>>>
                                            if (StrBoderTab.equalsIgnoreCase("0")) {
                                                cellG.setBorder(PdfPCell.NO_BORDER);
                                            }
                                            cellG.setColspan(1);
                                            cellG.setHorizontalAlignment(Element.ALIGN_LEFT);
                                            table.addCell(cellG);
                                        }

                                    }

                                    if (StrStyleFont.equalsIgnoreCase("Bold")) {
                                        Font fontTabTitulo = new Font(Font.HELVETICA, Float.parseFloat(StrSizeFont), Font.BOLD, StyleTabTitulo);
                                        Font fontTab = new Font(Font.HELVETICA, Float.parseFloat(StrSizeFont), Font.BOLD, StyleTabText);

                                        //<<<<<<<<<<<<<<<<<< Titulo (s) Tabla >>>>>>>>>>>>>>>>>>>
                                        if (lt < Integer.parseInt(StrColsTab) && !StrColorTabTitulo.equalsIgnoreCase("") && !StrColorFont.equalsIgnoreCase("")) {
                                            Chunk foxTabTitulo = new Chunk(ListTextTable.get(lt).toString(), fontTabTitulo);
                                            cellG = new PdfPCell(new Paragraph(foxTabTitulo));
                                            //<<<<<<<<<<<<<<<<<<< Quitar Border de la Tabla >>>>>>>>>>>>>>>>>>
                                            if (StrBoderTab.equalsIgnoreCase("0")) {
                                                cellG.setBorder(PdfPCell.NO_BORDER);
                                            }
                                            cellG.setColspan(1);
                                            cellG.setHorizontalAlignment(Element.ALIGN_CENTER);
                                            cellG.setBackgroundColor(new Color(Integer.parseInt(StrColorTabTitulo)));
                                            cellG.setPadding(3.0f);
                                            table.addCell(cellG);
                                        } else {
                                            Chunk foxTab = new Chunk(ListTextTable.get(lt).toString(), fontTab);
                                            cellG = new PdfPCell(new Paragraph(foxTab));
                                            //<<<<<<<<<<<<<<<<<<< Quitar Border de la Tabla >>>>>>>>>>>>>>>>>>
                                            if (StrBoderTab.equalsIgnoreCase("0")) {
                                                cellG.setBorder(PdfPCell.NO_BORDER);
                                            }
                                            cellG.setColspan(1);
                                            cellG.setHorizontalAlignment(Element.ALIGN_LEFT);
                                            table.addCell(cellG);
                                        }
                                    }
                                }//Fin else Txt
                            }// Fin else Img
                        }

                        document.add(table);

                        StyleTabText = null;
                        StyleTabTitulo = null;
                        ListTextTable.clear();
                        stTextTable = null;
                        ListTextTable = null;

                    }

                    if (StrTipoDato.equalsIgnoreCase("Text") && !StrX.equalsIgnoreCase("0") && !StrY.equalsIgnoreCase("0")) {


                        if (!StrFont.equalsIgnoreCase("")) {
                            bfTipoLetra = FontFactory.getFont(getValorTagPDF(StrFont, "Tipo=", ",", ""), BaseFont.WINANSI, BaseFont.EMBEDDED).getCalculatedBaseFont(false);
                        }

                        if (StrEncabezado.equalsIgnoreCase("1")) {
                            //System.out.println("Txt Encabezado: " + StrTexto);
                            lsText.add(StrTexto);
                            lsTextX.add(StrX);
                            lsTextY.add(StrY);
                            lsTextStyleFont.add(StrStyleFont);
                            lsTextColorFont.add(StrColorFont);
                            lsTextSizeFont.add(rsTipoDato.getString("SizeFont"));
                            lsTextFont.add(StrFont);
                        } else {
                            if (iHoja != iHojaEnUso) {
                                iHojaEnUso = iHoja;
                                document.newPage();
                            }

                            cb.beginText();
                            if (StrStyleFont.equalsIgnoreCase("Normal") || StrStyleFont.equalsIgnoreCase("")) {
                                if (!StrFont.equalsIgnoreCase("")) {
                                    cb.setFontAndSize(bfTipoLetra, Float.parseFloat(StrSizeFont));
                                } else {
                                    cb.setFontAndSize(BaseFont.createFont(BaseFont.HELVETICA, BaseFont.WINANSI, BaseFont.EMBEDDED), Float.parseFloat(StrSizeFont));
                                }
                            }

                            if (StrStyleFont.equalsIgnoreCase("Bold")) {
                                if (!StrFont.equalsIgnoreCase("")) {
                                    cb.setFontAndSize(bfTipoLetra, Float.parseFloat(StrSizeFont));
                                } else {
                                    cb.setFontAndSize(BaseFont.createFont(BaseFont.HELVETICA_BOLD, BaseFont.WINANSI, BaseFont.EMBEDDED), Float.parseFloat(StrSizeFont));
                                }
                            }

                            java.awt.Color StyleT = new java.awt.Color(Integer.parseInt(StrColorFont));
                            cb.setColorFill(StyleT);
                            cb.showTextAligned(Element.ALIGN_LEFT, StrTexto, Integer.parseInt(StrX), Integer.parseInt(StrY), 0);
                            cb.endText();
                        }
                    }

                    if (StrTipoDato.equalsIgnoreCase("Text") && StrX.equalsIgnoreCase("0") && StrY.equalsIgnoreCase("0")) {

                        //System.out.println(StrTexto+" "+StrSizeFont);

                        StrDescripcion = StrTexto;

                        java.awt.Color StyleG = new java.awt.Color(Integer.parseInt(StrColorFont));

                        //<<<<<<<<<<<<<<<<< Tipos de Fuentes >>>>>>>>>>>>>>
                        Font fontB = new Font(Font.HELVETICA, Float.parseFloat(StrSizeFont), Font.BOLD, StyleG);
                        Font fontN = new Font(Font.HELVETICA, Float.parseFloat(StrSizeFont), Font.NORMAL, StyleG);
                        Font fontU = new Font(Font.HELVETICA, Float.parseFloat(StrSizeFont), Font.UNDERLINE, StyleG);
                        Font fontBI = new Font(Font.HELVETICA, Float.parseFloat(StrSizeFont), Font.BOLDITALIC, StyleG);
                        Font fontI = new Font(Font.HELVETICA, Float.parseFloat(StrSizeFont), Font.ITALIC, StyleG);

                        ArrayList ListDesc = new ArrayList();
                        StringTokenizer stDesc = new StringTokenizer(StrDescripcion, "|");

                        while (stDesc.hasMoreTokens()) {
                            ListDesc.add(stDesc.nextToken().toString());
                        }

                        Phrase TextoSalidaDesc = new Phrase();
                        TextoSalidaDesc.clear();
                        String StrTextoSalidaFont = "";

                        for (int i = 0; i < ListDesc.size(); i++) {
                            //System.out.println(ListDesc.get(i));


                            if (ListDesc.get(i).toString().indexOf("<BOLD>") != -1) {
                                Chunk foxD = new Chunk(ListDesc.get(i).toString().replace("<BOLD>", ""), fontB);
                                TextoSalidaDesc.add(foxD);
                            }


                            if (ListDesc.get(i).toString().indexOf("<NORMAL>") != -1) {
                                Chunk foxD = new Chunk(ListDesc.get(i).toString().replace("<NORMAL>", ""), fontN);
                                TextoSalidaDesc.add(foxD);
                            }

                            if (ListDesc.get(i).toString().indexOf("<UNDERLINE>") != -1) {
                                Chunk foxD = new Chunk(ListDesc.get(i).toString().replace("<UNDERLINE>", ""), fontU);
                                TextoSalidaDesc.add(foxD);
                            }

                            if (ListDesc.get(i).toString().indexOf("<BOLDITALIC>") != -1) {
                                Chunk foxD = new Chunk(ListDesc.get(i).toString().replace("<BOLDITALIC>", ""), fontBI);
                                TextoSalidaDesc.add(foxD);
                            }

                            if (ListDesc.get(i).toString().indexOf("<ITALIC>") != -1) {
                                Chunk foxD = new Chunk(ListDesc.get(i).toString().replace("<ITALIC>", ""), fontI);
                                TextoSalidaDesc.add(foxD);
                            }

                            // <<<<<<<<<<<<<<<<< Tomar una Fuente de un archivo TTF >>>>>>>>>>>>>>>>>
                            if (ListDesc.get(i).toString().indexOf("<FONT ") != -1) {
                                StrTextoSalidaFont = ListDesc.get(i).toString().substring(ListDesc.get(i).toString().indexOf("<FONT "), ListDesc.get(i).toString().length());
                                StrTextoSalidaFont = StrTextoSalidaFont.replace(">", "");
                                String StrTextoColor = getValorTagPDF(StrTextoSalidaFont, "Color=", ",", "0");
                                String StrStyle = getValorTagPDF(StrTextoSalidaFont, "Style=", ",", "Normal");
                                String StrSize = getValorTagPDF(StrTextoSalidaFont, "Size=", ",", StrSizeFont);
                                java.awt.Color StyleTxt = new java.awt.Color(Integer.parseInt(StrTextoColor));

                                FontFactory.register(getValorTagPDF(StrTextoSalidaFont, "Ruta=", ",", ""));

                                if (StrStyle.equalsIgnoreCase("Normal")) {
                                    FontTipoLetra = FontFactory.getFont(getValorTagPDF(StrTextoSalidaFont, "Tipo=", ",", ""), BaseFont.WINANSI, BaseFont.EMBEDDED, Float.parseFloat(StrSize), Font.NORMAL, StyleTxt);
                                }
                                if (StrStyle.equalsIgnoreCase("Bold")) {
                                    FontTipoLetra = FontFactory.getFont(getValorTagPDF(StrTextoSalidaFont, "Tipo=", ",", ""), BaseFont.WINANSI, BaseFont.EMBEDDED, Float.parseFloat(StrSize), Font.BOLD, StyleTxt);
                                }
                                if (StrStyle.equalsIgnoreCase("Italic")) {
                                    FontTipoLetra = FontFactory.getFont(getValorTagPDF(StrTextoSalidaFont, "Tipo=", ",", ""), BaseFont.WINANSI, BaseFont.EMBEDDED, Float.parseFloat(StrSize), Font.ITALIC, StyleTxt);
                                }

                                Chunk foxD = new Chunk(ListDesc.get(i).toString().substring(0, ListDesc.get(i).toString().indexOf("<FONT ")), FontTipoLetra);
                                TextoSalidaDesc.add(foxD);
                            }


                            if (ListDesc.get(i).toString().indexOf("<n>") != -1) {

                                if (ListDesc.get(i).toString().length() > 3) {
                                    int n = 0;
                                    n = Integer.parseInt(ListDesc.get(i).toString().substring(3, ListDesc.get(i).toString().length()));
                                    for (int ent = 0; ent < n; ent++) {
                                        TextoSalidaDesc.add(new Paragraph("\n"));
                                    }

                                } else {
                                    TextoSalidaDesc.add(new Paragraph("\n"));
                                }
                            }

                        }

                        Paragraph paragrapT = new Paragraph(TextoSalidaDesc);
                        paragrapT.setLeading(14f);

                        if (StrAlign.equalsIgnoreCase("") || StrAlign.equalsIgnoreCase("JUSTIFIED")) {
                            paragrapT.setAlignment(Paragraph.ALIGN_JUSTIFIED);
                        }

                        if (StrAlign.equalsIgnoreCase("CENTER")) {
                            paragrapT.setAlignment(Paragraph.ALIGN_CENTER);
                        }

                        if (StrAlign.equalsIgnoreCase("RIGHT")) {
                            paragrapT.setAlignment(Paragraph.ALIGN_RIGHT);
                        }

                        if (StrAlign.equalsIgnoreCase("LEFT")) {
                            paragrapT.setAlignment(Paragraph.ALIGN_LEFT);
                        }


                        document.add(paragrapT);
                        //document.add(new Paragraph("\n"));

                        fontB = null;
                        fontN = null;
                        fontU = null;
                        fontI = null;
                        fontBI = null;
                        StyleG = null;
                        ListDesc.clear();
                        ListDesc = null;
                        stDesc = null;
                    }
                }

                rsTipoDato.close();
                rsTipoDato = null;
            } catch (Exception E) {
                System.out.println(E);
            }


            document.add(new Paragraph("\n"));
            document.close();


        } catch (Exception e) {
            System.out.println(e);
        } finally {
            try {
                lsImgRuta.clear();
                lsImgH.clear();
                lsImgW.clear();
                lsImgX.clear();
                lsImgY.clear();


                lsText.clear();
                lsTextColorFont.clear();
                lsTextSizeFont.clear();
                lsTextX.clear();
                lsTextY.clear();
                lsTextFont.clear();

                lsLineToX.clear();
                lsLineWidth.clear();
                lsLineX.clear();
                lsLineY.clear();
            } catch (Exception e) {
                System.out.println(e);
            }
        }

    }

    @Override
    public void onStartPage(PdfWriter writer, Document document) {
        try {
        } catch (Exception er) {
            throw new ExceptionConverter(er);
        }
    }

    @Override
    public void onEndPage(PdfWriter writer, Document document) {
        PdfContentByte cb = writer.getDirectContent();
        Rectangle rect = writer.getBoxSize("Footer/header");

        String text = "" + writer.getPageNumber();


        try {
            for (int l = 0; l < lsLineX.size(); l++) {
                // <<<<<<<<<<<<<<<<< Insertar  una linea en el Encabezado >>>>>>>>>>>>>>>>>
                cb.setLineWidth(Float.parseFloat(lsLineWidth.get(l).toString()));
                cb.moveTo(Integer.parseInt(lsLineX.get(l).toString()), Integer.parseInt(lsLineY.get(l).toString()));
                cb.lineTo(Integer.parseInt(lsLineToX.get(l).toString()), Integer.parseInt(lsLineY.get(l).toString()));
                cb.stroke();
            }

            for (int i = 0; i < lsImgRuta.size(); i++) {
                //System.out.println("Imagen de Encabezado/PiePagina: " + lsImgRuta.get(i).toString());
                Image jpgE = Image.getInstance(lsImgRuta.get(i).toString());
                jpgE.setAbsolutePosition(Integer.parseInt(lsImgX.get(i).toString()), Integer.parseInt(lsImgY.get(i).toString()));

                if (!lsImgW.get(i).toString().equalsIgnoreCase("0") && !lsImgH.get(i).toString().equalsIgnoreCase("0")) {
                    jpgE.scaleAbsolute(Integer.parseInt(lsImgW.get(i).toString()), Integer.parseInt(lsImgH.get(i).toString()));
                }
                document.add(jpgE);
                jpgE = null;
            }


            for (int t = 0; t < lsText.size(); t++) {
                //System.out.println("Texto de Encabezado/PiePagina: " + lsText.get(t).toString());


                if (!lsTextFont.get(t).toString().equalsIgnoreCase("")) {
                    FontFactory.register(getValorTagPDF(lsTextFont.get(t).toString(), "Ruta=", ",", ""));
                    bfTipoLetra = FontFactory.getFont(getValorTagPDF(lsTextFont.get(t).toString(), "Tipo=", ",", ""), BaseFont.WINANSI, BaseFont.EMBEDDED).getCalculatedBaseFont(false);
                }

                cb.beginText();

                if (lsTextStyleFont.get(t).toString().equalsIgnoreCase("Normal") || lsTextStyleFont.get(t).toString().equalsIgnoreCase("")) {
                    if (!lsTextFont.get(t).toString().equalsIgnoreCase("")) {
                        cb.setFontAndSize(bfTipoLetra, Float.parseFloat(lsTextSizeFont.get(t).toString()));
                    } else {
                        cb.setFontAndSize(BaseFont.createFont(BaseFont.HELVETICA, BaseFont.WINANSI, BaseFont.EMBEDDED), Float.parseFloat(lsTextSizeFont.get(t).toString()));
                    }
                }

                if (lsTextStyleFont.get(t).toString().equalsIgnoreCase("Bold")) {
                    if (!lsTextFont.get(t).toString().equalsIgnoreCase("")) {
                        cb.setFontAndSize(bfTipoLetra, Float.parseFloat(lsTextSizeFont.get(t).toString()));
                    } else {
                        cb.setFontAndSize(BaseFont.createFont(BaseFont.HELVETICA_BOLD, BaseFont.WINANSI, BaseFont.EMBEDDED), Float.parseFloat(lsTextSizeFont.get(t).toString()));
                    }
                }

                java.awt.Color StyleE = new java.awt.Color(Integer.parseInt(lsTextColorFont.get(t).toString()));
                cb.setColorFill(StyleE);
                //cb.showTextAligned(Element.ALIGN_LEFT, lsText.get(t).toString(), Integer.parseInt(lsTextX.get(t).toString()), Integer.parseInt(lsTextY.get(t).toString()), 0);
                cb.showTextAligned(Element.ALIGN_LEFT, lsText.get(t).toString(), Integer.parseInt(lsTextX.get(t).toString()), Integer.parseInt(lsTextY.get(t).toString()), 0);



                cb.endText();
            }

            if (StrNumerarPaginas.equalsIgnoreCase("1")) {
                cb.beginText();
                cb.setFontAndSize(BaseFont.createFont(BaseFont.HELVETICA, BaseFont.WINANSI, BaseFont.EMBEDDED), 9);
                cb.setRGBColorFill(0, 0, 0);
                cb.showTextAligned(Element.ALIGN_LEFT, text, 580, 20, 0);
                cb.endText();
            }

        } catch (Exception er) {
        }
    }
}
