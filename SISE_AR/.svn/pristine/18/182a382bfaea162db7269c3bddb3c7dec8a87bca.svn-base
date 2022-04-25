/*
 * ViewHelperBase.java
 *
 * Created on 18 de mayo de 2006, 06:22 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */
package com.ike.view;

import Utilerias.UtileriasBDF;
import Utilerias.UtlFiles;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Calendar;
import javax.servlet.http.HttpServletRequest;
import java.util.Hashtable;
import java.util.Enumeration;

/*
 *
 * @author escobarm
 */
public class ViewHelperBase {

    public static Hashtable getUserData(HttpServletRequest request) {

        Hashtable ht = new Hashtable();
        String pname = null;
        String pvalue = null;

        Enumeration myenum = request.getParameterNames();

        while (myenum.hasMoreElements()) {
            pname = (String) myenum.nextElement();
            pvalue = request.getParameter(pname);

            ht.put(pname, pvalue != null ? pvalue.trim() : "");

            //System.out.println(" "+ pname + "--" +  pvalue); //imprime datos recibidos en al ht
        }

        myenum = null;
        pname = null;
        pvalue = null;
        return ht;
    }

    public static void bitacoraHt(Hashtable hash) {

        StringBuffer buff = new StringBuffer();
        String key = null;
        String pvalue = null;
        String clExpediente = null;
        String clPaginaWeb = null;
        String clUsrApp = null;
        String contenido = null;
        String StrQry = null;
        String llave = null;
        String llaveVal = null;

        Enumeration myenum = null;

        try {
            myenum = hash.keys();

            while (myenum.hasMoreElements()) {
                key = (String) myenum.nextElement();
                pvalue = (String) hash.get(key);
                buff.append("[").append(key).append("=").append(pvalue).append("] ");
            }

            try {

                /* if (hash.containsKey("clExpediente")){
                 clExpediente= hash.get("clExpediente").toString();
                 }else{
                 clExpediente="0";
                 }    */
                llave = hash.get("llave").toString();
                llaveVal = hash.get("llaveVal").toString();
                clPaginaWeb = hash.get("clPaginaWeb").toString();
                clUsrApp = hash.get("clUsrApp").toString();

            } catch (Exception e) {
                System.out.println("Trono el llenado de variables");
                e.printStackTrace();
            }

            contenido = buff.toString();
            buff.delete(0, buff.length());
            StrQry = " st_insertaBitacoraOpe " + clPaginaWeb + "," + clUsrApp + ",'" + contenido + "','" + llave + "','" + llaveVal + "'";
            System.out.println("Bitacora : " + StrQry);

            try {
                UtileriasBDF.ejecutaSQLNP(StrQry);
            } catch (Exception sql) {
                System.out.println("Error en ViewHelperBase.bitacoraHt: Fallo el insert a BitacoraGral");
                sql.printStackTrace();
            }

        } catch (Exception ex) {
            System.out.println("Error en ViewHelperBase.bitacoraHt! ");
            ex.printStackTrace();
        }

        key = null;
        pvalue = null;
        myenum = null;
        clExpediente = null;
        clPaginaWeb = null;
        clUsrApp = null;
        contenido = null;
        buff = null;
        StrQry = null;
        llave = null;
        llaveVal = null;
    }

    public static String hash2String(Hashtable hash) {

        StringBuffer buff = new StringBuffer();
        String key = null;
        String pvalue = null;

        Enumeration myenum = hash.keys();
        buff.append("{");
        while (myenum.hasMoreElements()) {
            key = (String) myenum.nextElement();
            pvalue = (String) hash.get(key);
            buff.append("[").append(key).append("=").append(pvalue).append("] ");

        }
        buff.append("}");

        key = null;
        pvalue = null;
        myenum = null;

        return buff.toString();

    }

    public static Hashtable resultset2hashtable(String sqlqry) throws SQLException {

        System.out.println("resultset2hashtable: recibe qry: " + sqlqry);

        Hashtable hasht = new Hashtable();

        try {

            UtileriasBDF.Connect();
            ResultSet rs = UtileriasBDF.rsSQLNP(sqlqry);

            ResultSetMetaData rsmd = rs.getMetaData();

            if (rs.next()) {

                String pname = null;
                String pvalue = null;
                int col = 1;

                // //System.out.println(rsmd.getColumnCount());
                while (col <= rsmd.getColumnCount()) {

                    pname = rsmd.getColumnName(col);
                    pvalue = rs.getString(col);

                    hasht.put(pname, pvalue != null ? pvalue : "");
                    col += 1;
                }
                pname = null;
                pvalue = null;
            }
            rs.close();
            rs = null;
            rsmd = null;

        } catch (SQLException ex) {
            System.out.println("-----> ViewHelperBase.resultset2hashtable: Error ");
            ex.printStackTrace();

        } finally {
            sqlqry = null;
        }

        //System.out.println("sale: ");
        return hasht;

    }

    public static void generaTxt(Hashtable ht, String prefijo) {

        String key = null;
        String pvalue = null;
        PrintWriter out = null;
        String fecha = null;
        String hora = null;
        String dir = null;
        String llave = null;

        try {  //System.out.println("entra generaTxt");

            if (!ht.isEmpty()) {

                //System.out.println("Generat txt:"+prefijo+"  " + hash2String(ht));
                Calendar cal = Calendar.getInstance();
                Timestamp time = new Timestamp(cal.getTimeInMillis());
                fecha = time.toString();
                hora = fecha.substring(11, 19);
                hora = hora.replace(":", "");
                fecha = fecha.toString().substring(0, 10);

                /*2007-07-03 10:22:37.573
                 01234567890123456789*/
                cal.clear();
                cal = null;
                time = null;

                fecha = fecha.replace("-", "//");

                // se arma el directorio del archivo con la informacion de interface
                dir = "LaPeninsularWS//" + ht.get("descripcion").toString() + "//" + ht.get("operacion").toString() + "//" + fecha;

                //llave= ht.get("llave").toString();
                //String sufijo= ht.get(llave).toString();
                String filename = ht.get("repsiniestro").toString();

                UtlFiles writefile = new UtlFiles();
                // dir=writefile.creaDirectorio(dir);

                try {
                    //writefile.abreArchivo( dir+"//"+prefijo+filename+"-"+sufijo+".txt");
                    // writefile.abreArchivo( dir+"//"+prefijo+"_"+filename +"_" +hora +".txt");
                    Enumeration myenum = ht.keys();

                    while (myenum.hasMoreElements()) {
                        key = (String) myenum.nextElement();
                        pvalue = (String) ht.get(key);
                        writefile.appendContenido("[" + key + "=" + pvalue + "]");
                        writefile.appendContenido("\n");
                    }

                    writefile.cierraArchivo(writefile.salida_);
                    myenum = null;
                    writefile = null;
                    dir = null;
                    fecha = null;
                    filename = null;

                } catch (Exception t) {
                    System.out.println("ViewHelperBase.generaTxt: Fallo la escritura a txt");
                    t.printStackTrace();
                }

            } else {
                out.println("<script>alert(\"Faltan datos para la interfase\");</script>");
                System.out.println("\n\n ------------->>  ViewHelperBase.generaTxt: Hashtable esta vacía \n\n");
            }
        } catch (Exception e) {
            System.out.println("\n\n ------------->> ViewHelperBase.generaTxt: Error escritura de archivo \n\n");
            e.printStackTrace();

        } finally {

            ht.clear();
            ht = null;
            key = null;
            pvalue = null;
            llave = null;
        }
    }
}
