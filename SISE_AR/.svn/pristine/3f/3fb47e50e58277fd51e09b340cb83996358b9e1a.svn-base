package Utilerias;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

public class EscribeRPT {

    public EscribeRPT() {
    }

    public int EscribeRPT(String clUsrApp, String FechaIni, String FechaFin) throws IOException {

        String NombreFile = "";
        String RutaFile = "";
        String RutaFull = "";
        BufferedWriter bw;

        /*RS Para obtener el nombre y ruta del archivo*/
        ResultList rsNFile = new ResultList();
        rsNFile.rsSQL("st_getLISOLRutaFile");
        if (rsNFile.next()) {
            RutaFile = rsNFile.getString("RutaFile");
            NombreFile = rsNFile.getString("NombreFile");
        }
        rsNFile.close();
        rsNFile = null;

        RutaFull = RutaFile + NombreFile;
        //System.out.println(RutaFull);

        File archivo = new File(RutaFull);
        System.out.println("Se crea archivo: " + RutaFull);
        bw = new BufferedWriter(new FileWriter(archivo));

        ResultList rsLISOL = new ResultList();
        System.out.println("st_Lisol_Reporte " + clUsrApp + ",'" + FechaIni + "','" + FechaFin + "'," + "0");
        rsLISOL.rsSQL("st_Lisol_Reporte " + clUsrApp + ",'" + FechaIni + "','" + FechaFin + "'," + "0");
        while (rsLISOL.next()) {

            bw.write(rsLISOL.getString("L-ISOL"));
            bw.write("\r\n");
        }

        System.out.println("Se termina de escribir archivo: " + RutaFull);
        bw.close();
        rsLISOL.close();
        rsLISOL = null;

        //Se programa envio de RPT
        ResultList rsEnviaRPT = new ResultList();
        
        System.out.println("st_LISOLEnviaRPT " + clUsrApp + ",'" + RutaFull + "'");
                
        rsEnviaRPT.rsSQL("st_LISOLEnviaRPT " + clUsrApp + ",'" + RutaFull + "'");
        
        if(rsEnviaRPT.next()){
            System.out.println("Mensaje: " + rsEnviaRPT.getString("Mensaje"));
        }
        rsEnviaRPT.close();
        rsEnviaRPT = null;
        
        return 0;
    }
}

/*
 public static void main(String[] args) throws IOException {
 String ruta = "C:\\Repositorio\\SISE_AR\\branches\\build\\web\\archivo.txt";
 File archivo = new File(ruta);
 BufferedWriter bw;
 if (archivo.exists()) {
 bw = new BufferedWriter(new FileWriter(archivo));
 bw.write("El fichero de texto ya estaba creado 1.");
 bw.write("\r\n");
 bw.write("El fichero de texto ya estaba creado 2.");
 } else {
 bw = new BufferedWriter(new FileWriter(archivo));
 bw.write("Acabo de crear el fichero de texto.");
 }
 bw.close();
 }
 */
