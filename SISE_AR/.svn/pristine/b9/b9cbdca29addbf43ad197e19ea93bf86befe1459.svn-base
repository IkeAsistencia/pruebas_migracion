/*
 * CertificadoASATEJ.java
 *
 * Created on 30 de diciembre de 2009, 18:02
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */
package com.ike.pdf;

import com.lowagie.text.pdf.AcroFields;
import com.lowagie.text.pdf.PdfReader;
import com.lowagie.text.pdf.PdfStamper;
import java.io.FileOutputStream;
import com.ike.operacion.to.AltaNUAsatej;
import com.ike.operacion.DAOAltaNUAsatej;

/*
 *
 * @author vsampablo
 */
public class CertificadoASATEJ {

    private static DAOAltaNUAsatej dao = null;
    private static AltaNUAsatej alta = null;

    /*
     * Creates a new instance of CertificadoASATEJ
     */
    public CertificadoASATEJ() {
    }

    public static void buildPDF(String clAfiliado, String path) {

        int clUsrReg = 0;

        try {
            String StrISIC = "";

            dao = new DAOAltaNUAsatej();
            alta = dao.getAltaNUAsatej(clAfiliado);

            if (alta.getISIC().equalsIgnoreCase("1")) {
                StrISIC = "SI";
            } else {
                StrISIC = "NO";
            }

            PdfReader reader = new PdfReader(path);
            PdfStamper stamper = new PdfStamper(reader, new FileOutputStream(path.replace(".pdf", "") + "_" + clAfiliado.toString() + ".pdf"));
            AcroFields form = stamper.getAcroFields();

            form.setField("Nombres", alta.getNombre());
            form.setField("Apellido", alta.getApellido());
            form.setField("DocTipo", alta.getDsTipoDocumento());
            form.setField("DNI", alta.getClave());
            form.setField("Email", alta.getMail());
            form.setField("FechaNac", alta.getFechaNac());
            form.setField("clAfiliado", alta.getClAfiliado());
            form.setField("NombreContacto", alta.getNombreContacto());
            form.setField("Telefono2", alta.getTelefono2());
            form.setField("Producto", alta.getDsTipoProducto());
            form.setField("ISIC", StrISIC);
            form.setField("FechaIni", alta.getFechaIni());
            form.setField("FechaFin", alta.getFechaFin());
            form.setField("Provincia", alta.getDsEntFed());
            form.setField("Localidad", alta.getDsMunDel());
            //form.setField("Telefono",alta.getTelefono1());

            stamper.setFormFlattening(true);
            stamper.close();
//            reader.close();
            reader = null;
            form = null;

            path = null;
            clAfiliado = null;

            dao = null;
            alta = null;

        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("CertificadoASATEJ.buildPDF Error: " + e);
        }
    }
}

