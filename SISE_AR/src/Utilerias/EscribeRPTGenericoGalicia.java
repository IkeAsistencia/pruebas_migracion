package Utilerias;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

public class EscribeRPTGenericoGalicia {

    public EscribeRPTGenericoGalicia() {
    }

    public int EscribeRPTGenericoGaliciaBG(String clUsrApp, String FechaIni, String FechaFin, String tipoArchivo, String clPaginaWeb, String Documento) throws IOException {
        System.out.println("EscribeRPTGenericoGalicia");
        String SentenciaSQL = "";
        SentenciaSQL = "'st_ReporteGralGalicia ''" + FechaIni + "'',''" + FechaFin + "'','" + "''" + Documento + "''''";

        //Se programa envio de RPT
        ResultList rsEnviaRPT = new ResultList();

        System.out.println("=s st_EnviaRPTGenrico " + SentenciaSQL + ",'" + clUsrApp + "'," + clPaginaWeb + "," + tipoArchivo);
        rsEnviaRPT.rsSQL("st_EnviaRPTGenrico " + SentenciaSQL + ",'" + clUsrApp + "'," + clPaginaWeb + "," + tipoArchivo);

        if (rsEnviaRPT.next()) {
            System.out.println("Mensaje: " + rsEnviaRPT.getString("Mensaje"));
        }
        rsEnviaRPT.close();
        rsEnviaRPT = null;
        return 0;
    }
}
