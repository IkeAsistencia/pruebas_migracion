/*
 * Zip.java
 *
 * Created on 9 de enero de 2006, 05:51 PM
 *
 */
package Utilerias;

/*
 * @author colinj
 */
import java.io.File;
import java.io.*;


import java.util.zip.ZipOutputStream;
import java.util.zip.Deflater;
import java.util.zip.ZipEntry;

public class Zip {

    public static File ZipFile(String strFileToZip, String Ext) {
        int BUFFER = 2048;
        String zipTofilename = strFileToZip + ".zip";
        String[] filesToZip = {strFileToZip + Ext};
        try {
            BufferedInputStream origin = null;
            FileOutputStream dest = new FileOutputStream(zipTofilename);
            ZipOutputStream out = new ZipOutputStream(new BufferedOutputStream(dest));
            out.setMethod(ZipOutputStream.DEFLATED);
            out.setLevel(Deflater.DEFAULT_COMPRESSION); //use default level
            byte data[] = new byte[BUFFER];
            for (int i = 0; i < filesToZip.length; i++) {
                FileInputStream fi = new FileInputStream(filesToZip[i]);

                origin = new BufferedInputStream(fi, BUFFER);
                ZipEntry entry = new ZipEntry(filesToZip[i]);
                out.putNextEntry(entry);
                int count;
                while ((count = origin.read(data, 0, BUFFER)) != -1) {
                    out.write(data, 0, count);
                }
                origin.close();
            }
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return new File(zipTofilename);
    }
}