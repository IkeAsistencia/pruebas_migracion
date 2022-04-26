package Utilerias;

import java.sql.ResultSet;

public class GeneraRpt {

    private static boolean isStarted = false;
    private static ResultSet rs = null;
    private static Utilerias.UtlFiles UtlFilesObj = new Utilerias.UtlFiles();
    private static Correo MailRpt = new Correo();
    private static Utilerias.Zip ZipObj = new Utilerias.Zip();

    private GeneraRpt() {
    }

    public static boolean getEstatus() {
        return isStarted;
    }

    public static synchronized void GeneraReportes() {
        StringBuilder StrSQL = new StringBuilder();
        StringBuilder StrContent = new StringBuilder();

        String StrPath = "";
        String strclMail = "";
        String strHost = "201.116.36.211";
        String StrAsunto = "";

        try {

            StrSQL.delete(0, StrSQL.length());

            StrSQL.append(" st_getHDMailRptmonitor ");
            rs = UtileriasBDF.rsSQLNP(StrSQL.toString());
            StrSQL.delete(0, StrSQL.length());
            StrContent.delete(0, StrContent.length());

            if (rs.next()) {

                System.out.println("--------------------------------------- Entra ENVIO DE REPORTES ARG ---------------------------------------");

                strclMail = rs.getString("clMailRpt");

                StrPath = "File" + strclMail;
                UtileriasBDF.actSQLNP("set dateformat YMD update HDMailRptMonitor set FechaInicio = getdate() where clMailRpt = " + strclMail);
                StringBuffer strSalida = new StringBuffer();

                UtileriasBDF.rsCSVCNP(rs.getString("SentenciaSQL"), strSalida);

                if (rs.getString("Asunto").equalsIgnoreCase("")) {
                    StrAsunto = "Reporte";
                    StrPath = "File" + strclMail;
                } else {
                    StrAsunto = rs.getString("Asunto");
                    StrPath = StrAsunto;
                }
                String StrExt = "";
                if (rs.getString("TipoArchivo").equals("1")) {
                    StrExt = ".txt";
                } else {
                    StrExt = ".csv";
                }
                if (rs.getString("TipoArchivo") == null) {
                    StrExt = ".csv";
                }
                StrContent.append(strSalida);
                strSalida.delete(0, strSalida.length());

                UtileriasBDF.actSQLNP("set dateformat YMD update HDMailRptMonitor set FechaFin = getdate() where clMailRpt = " + strclMail);
                UtlFilesObj.escribeContenido(StrPath + StrExt, StrContent.toString());

                ZipObj.ZipFile(StrPath, StrExt);
                StrContent.delete(0, StrContent.length());

                MailRpt.EnviaMail("rptservices", rs.getString("Correo"), StrAsunto, StrPath + ".zip", strHost);
                UtileriasBDF.actSQLNP("set dateformat mdy update HDMailRptMonitor set FechaEnvio = getdate() where clMailRpt = " + strclMail);

                UtlFilesObj.borraArchivo(StrPath + StrExt);
                UtlFilesObj.borraArchivo(StrPath + ".zip");
            }
            rs.close();
            rs = null;

            StrPath = null;
            strclMail = null;
            strHost = null;
            StrAsunto = null;

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
            } catch (Exception ee) {
            }
        }
    }

    public static void Start() {
        chStatus(true);
        TimerGeneraRpt.Start();
    }

    public static void Stop() {
        chStatus(false);
    }

    private static void chStatus(boolean pEstatus) {
        isStarted = pEstatus;
    }
}
