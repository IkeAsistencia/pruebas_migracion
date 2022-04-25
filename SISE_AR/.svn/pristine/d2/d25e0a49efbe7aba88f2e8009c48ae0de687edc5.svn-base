package com.ike.pdf;

import com.lowagie.text.pdf.AcroFields;
import com.lowagie.text.pdf.PdfReader;
import com.lowagie.text.pdf.PdfStamper;
import java.io.FileOutputStream;

/*
 * @author mescobar
 */
public class PDFCartaBienvenida {

    public static void generaPDF(String monto, String PDFOrigen, String PDFDestino) {

        try {
            System.out.println("Entra generacion de PDF");
            PdfReader reader = new PdfReader(PDFOrigen);
            PdfStamper stamper = new PdfStamper(reader, new FileOutputStream(PDFDestino));
            AcroFields form = stamper.getAcroFields();

            form.setField("Precio", " $" + monto);

            stamper.setFormFlattening(true);
            stamper.close();
            //reader.close();
            form = null;
            stamper = null;
            reader = null;

        } catch (Exception ex) {
            System.err.println("Generacion de PDF");
            ex.printStackTrace();
        }

        PDFOrigen = null;
        PDFDestino = null;
    }
}
