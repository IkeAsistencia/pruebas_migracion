/*
 * DAOBASE.java
 *
 * Created on 22 de marzo de 2006, 05:31 PM
 *
 * To change this template, choose Tools | Options and locate the template under
 * the Source Creation and Management node. Right-click the template and choose
 * Open. You can then make changes to the template in the Source Editor.
 */
package com.ike.model;

import Utilerias.*;
import java.sql.Connection;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.ResultSetMetaData;
import java.util.Collection;
import java.util.ArrayList;
import snaq.db.ConnectionPool;

/*
 *
 * @author cabrerar
 */
public class DAOBASE {

    static ConnectionPool pool = null;
    static long timeout = 10000;  // 30 second expire timeout  
    private static boolean isConnected = false;
    private static byte bytLanguaje = 2;

    public static Connection getConnection() {
        Connection con = null;
        try {
            Connect();
            con = pool.getConnection(timeout);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return con;
    }

    public synchronized static void Connect() {

        if (isConnected == false) {
            try {
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            } catch (Exception e) {
                //Fallo carga driver JDBC/ODBC.;
                e.printStackTrace();
            }

            pool = new ConnectionPool("local",
                    200,
                    1000,
                    10000, // milliseconds                  

                    /* PROD */
                    /*"jdbc:sqlserver://172.21.170.7:21577;DatabaseName=SISE_AR;useLOBs=false",
                    "dessiaikeAR",
                    "d2ssi1ik3AR.2011");*/
                    
                    /* PROD KIO*/
                    /*"jdbc:sqlserver://172.17.17.131:1433;DatabaseName=SISE_AR;useLOBs=false",
                    "dessiaikeAR",
                    "d2ssi1ik3AR.2011");*/

                    /* TEST */
                    /*"jdbc:sqlserver://172.21.10.185;DatabaseName=SISE_AR_PROD;useLOBs=false",
                    "dessiaikeAR",
                    "C@ch@lot3.2016_Arg3nt1n");*/
            
                    /* TEST */
                    /*"jdbc:sqlserver://172.21.10.88:1533;DatabaseName=SISE_AR_DEV;useLOBs=false",
                    "dessiaikeAR",
                    "C@ch@lot3.2016_Arg3nt1n");*/
            
                    /* DEV */
                    "jdbc:sqlserver://172.21.10.88:1533;DatabaseName=SISE_AR_DEV;useLOBs=false",
                    "WSdessiaikeAR_dev",
                    "1QDF5t6a6pO6");

            pool.init(20);
            isConnected = true;
            System.out.println(">>>>>>>>>>>>>>>     Conectado SISE ARG      <<<<<<<<<<<<<<<");
        }
    }

    protected Collection rsSQLNP(final String SQL, LlenaDatos Lld) throws DAOException {
        /*Metodo que regresa un record set
         Nota: Una vez ejecutada la sentencia no se cierra la conexion*/
        Connection con = null;
        Statement stmt = null;
        ResultSet rsObt = null;
        Collection col = new ArrayList();

        try {
            con = DAOBASE.getConnection();
            stmt = con.createStatement();
            stmt.execute("set dateformat YMD");
            stmt.execute("SET NOCOUNT ON");
            //System.out.println("DAOBASE SISE ARG: " + SQL);
            rsObt = stmt.executeQuery(SQL);
            while (rsObt.next()) {
                col.add(Lld.llena(rsObt));
            }

        } catch (SQLException e) {
            throw new DAOException(e.getMessage(), e);
        } finally {
            try {
                //Cierro Resultset
                if (rsObt != null) {
                    rsObt.close();
                }
                //Cierro Statement
                if (stmt != null) {
                    stmt.close();
                }
                // Cierro Conexion
                if (con != null) {
                    con.close();
                }
            } catch (SQLException ee) {
                ee.printStackTrace();
            }
        }

        return col;
    }
    /* FALTANTES ---------------------------------------------------- */
    private static boolean logStatus = false;

    public synchronized static void StartLog() {
        logStatus = true;
    }

    public synchronized static void StopLog() {
        logStatus = false;
    }

    public static boolean getStatusLog() {
        return logStatus;
    }

    public static void ejecutaSQLNP(final String args) {
        /* Metodo que no regresa nada despues de ejecutar una sentencia SQL
         Nota: obtiene conexion y la cierra una vez ejecutada la sentencia */

        Statement stmt = null;
        Connection con = null;

        try {
            con = UtileriasBDF.getConnection();
            if (con != null) {
                stmt = con.createStatement();
                try {
                    if (logStatus == true) {
                        long longTimeI = System.currentTimeMillis();
                        long longTimeF = 0;
                        StringBuffer strBuff = new StringBuffer();

                        stmt.execute("set dateformat YMD");
                        stmt.execute("SET NOCOUNT ON");
                        stmt.execute(args);

                        longTimeF = System.currentTimeMillis();

                        strBuff.append(" set quoted_identifier off Insert into LogDB(Tiempo,Sentencia) values(");
                        strBuff.append((longTimeF - longTimeI) / 1000);
                        strBuff.append(",\"Con Con: ");
                        strBuff.append(args);
                        strBuff.append("\")");
                        stmt.execute(strBuff.toString());
                        strBuff.delete(0, strBuff.length());
                        strBuff = null;

                    } else {
                        stmt.execute("set dateformat YMD");
                        stmt.execute("SET NOCOUNT ON");
                        stmt.execute(args);
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            } else {
                System.out.println(">>>>>>>>>>>>>>>     No me pude conectar SISE ARG - ejecutaSQLNP      <<<<<<<<<<<<<<<");
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException ee) {
                ee.printStackTrace();
            }
        }
    }

    public static int actSQLNP(final String args) {
        /* Metodo que regresa el numero de registros afectados
         Nota: obtiene conexi�n y la cierra una vez ejecutada la sentencia */

        Statement stmt = null;
        int iResponse = 0;
        Connection con = null;

        try {
            con = UtileriasBDF.getConnection();

            if (con != null) {
                stmt = con.createStatement();
                try {
                    if (logStatus == true) {
                        long longTimeI = System.currentTimeMillis();
                        long longTimeF = 0;
                        StringBuffer strBuff = new StringBuffer();

                        stmt.execute("set dateformat YMD");
                        stmt.execute("SET NOCOUNT ON");
                        iResponse = stmt.executeUpdate(args);

                        longTimeF = System.currentTimeMillis();

                        strBuff.append(" set quoted_identifier off  Insert into LogDB(Tiempo,Sentencia) values(");
                        strBuff.append((longTimeF - longTimeI) / 1000);
                        strBuff.append(",\"Con Con: ");
                        strBuff.append(args);
                        strBuff.append("\")");
                        stmt.execute(strBuff.toString());
                        strBuff.delete(0, strBuff.length());
                        strBuff = null;

                    } else {
                        stmt.execute("set dateformat YMD");
                        stmt.execute("SET NOCOUNT ON");
                        iResponse = stmt.executeUpdate(args);
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            } else {
                System.out.println(">>>>>>>>>>>>>>>     No me pude conectar SISE ARG - actSQLNP      <<<<<<<<<<<<<<<");
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
            iResponse = -1;
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }
                if (con != null) {
                    con.close();
                }

            } catch (SQLException ee) {
                ee.printStackTrace();
            }
        }
        return iResponse;
    }

    public static ResultSet rsSQLP(Connection con, final String SQL) {
        /*Metodo que regresa un record set
         Nota: Una vez ejecutada la sentencia no se cierra la conexion*/
        Statement stmt = null;
        Statement stmtLog = null;
        ResultSet rsObt = null;
        try {
            if (con != null) {
                stmt = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
                stmtLog = con.createStatement();

                try {
                    if (logStatus == true) {
                        long longTimeI = System.currentTimeMillis();
                        long longTimeF = 0;
                        StringBuffer strBuff = new StringBuffer();
                        stmt.execute("set dateformat YMD");
                        stmt.execute("SET NOCOUNT ON");
                        rsObt = stmt.executeQuery(SQL);

                        longTimeF = System.currentTimeMillis();
                        strBuff.append(" set quoted_identifier off  Insert into LogDB(Tiempo,Sentencia) values(");
                        strBuff.append((longTimeF - longTimeI) / 1000);
                        strBuff.append(",\"Con Con: ");
                        strBuff.append(SQL);
                        strBuff.append("\")");
                        stmtLog.execute(strBuff.toString());
                        strBuff.delete(0, strBuff.length());
                        strBuff = null;

                    } else {
                        stmt.execute("set dateformat YMD");
                        stmt.execute("SET NOCOUNT ON");
                        rsObt = stmt.executeQuery(SQL);
                    }
                } catch (SQLException e) {
                    //e.printStackTrace();
                }
            } else {
                System.out.println(">>>>>>>>>>>>>>>     No me pude conectar SISE ARG - rsSQLP      <<<<<<<<<<<<<<<");
            }
        } catch (SQLException sqle) {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (SQLException ee) {
                ee.printStackTrace();
            }
            sqle.printStackTrace();
        } finally {
        }
        return rsObt;
    }

    public static void rsTableNP(final String pStrSQL, final StringBuffer StrSalida) {
        /* genera codigo HTM de una tabla con los registros de la base de datos
         * Nota: Se cierra la conexion una vez extraidos los datos*/
        String strValue = null;

        ResultSet rs = null;
        boolean blnRegistro = true;
        Connection con = null;

        try {
            con = UtileriasBDF.getConnection();

            rs = rsSQLP(con, pStrSQL);
            if (rs.next()) {
                rs.last();
                StrSalida.append("<th class='cssTitDet'>Registros Encontrados:").append(rs.getRow()).append("</th>");
                rs.first();

                ResultSetMetaData rsMetaDato = rs.getMetaData();
                int i;
                StrSalida.append("<table id='ObjTable' class='Table' border='0' cellpadding='0'>");
                StrSalida.append("<tr class = 'TTable'>");
                for (i = 1; i <= rsMetaDato.getColumnCount(); i++) {
                    StrSalida.append("<th onClick='fnOrder(this.parentElement.parentElement,").append(String.valueOf(i - 1)).append(")'>").append(rsMetaDato.getColumnLabel(i)).append("</th>");
                }
                StrSalida.append("</tr>");
                do {
                    // Checa que si el registro es par o non
                    if (blnRegistro) {
                        StrSalida.append("<tr class='R1Table'>");
                        blnRegistro = false;
                    } else {
                        StrSalida.append("<tr class='R2Table'>");
                        blnRegistro = true;
                    }
                    for (i = 1; i <= rsMetaDato.getColumnCount(); i++) {
                        strValue = rs.getString(i);
                        StrSalida.append("<td>").append(strValue).append("</td>");
                        strValue = null;
                    }
                    StrSalida.append("</tr>");
                } while (rs.next());
            }
            //System.out.println("pStrSQL____rsTableNP SISE ARG: " + pStrSQL);
        } catch (SQLException e) {
            StrSalida.delete(0, StrSalida.length());
            e.printStackTrace();
        } finally {
            strValue = null;
            try {
                if (rs != null) {
                    rs.close();
                    rs = null;
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException ee) {
                ee.printStackTrace();
            }
        }
        strValue = null;
        StrSalida.append("</table>");
    }

    public static void rsTablePlasmaNP(final String pStrSQL, int NumRows, String strTitulo, final StringBuffer StrSalida) {
        /* genera codigo HTM de una tabla con los registros de la base de datos
         Nota: Se cierra la conexi�n una vez extraidos los datos*/
        ResultSet rs = null;
        boolean blnRegistro = true;

        Connection con = null;

        try {
            con = UtileriasBDF.getConnection();

            rs = rsSQLP(con, pStrSQL);
            if (rs.next()) {
                rs.last();
                StrSalida.append("<p class='cssTitDetPlasma'>").append(strTitulo).append("        Total:").append(rs.getRow()).append("</p>");
                rs.first();

                ResultSetMetaData rsMetaDato = rs.getMetaData();
                int i;
                int iR;
                StrSalida.append("<table id='ObjTable' class='TablePlasma' border='0' cellpadding='0'>");
                StrSalida.append("<tr class = 'TTablePlasma'>");
                for (i = 1; i <= rsMetaDato.getColumnCount(); i++) {
                    StrSalida.append("<th onClick='fnOrder(this.parentElement.parentElement,").append(String.valueOf(i - 1)).append(")'>").append(rsMetaDato.getColumnLabel(i)).append("</th>");
                }
                StrSalida.append("</tr>");
                iR = 0;
                do {
                    // Checa que si el registro es par o non
                    if (blnRegistro) {
                        StrSalida.append("<tr class='R1TablePlasma'>");
                        blnRegistro = false;
                    } else {
                        StrSalida.append("<tr class='R2TablePlasma'>");
                        blnRegistro = true;
                    }
                    for (i = 1; i <= rsMetaDato.getColumnCount(); i++) {
                        StrSalida.append("<td>").append(rs.getObject(i)).append("</td>");
                    }
                    StrSalida.append("</tr>");
                    iR++;
                } while (rs.next() && iR < NumRows);
            }
            //System.out.println("pStrSQL____rsTablePlasmaNP SISE ARG: " + pStrSQL);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
                if (rs != null) {
                    rs.close();
                    rs = null;
                }

            } catch (SQLException ee) {
                ee.printStackTrace();
            }
        }
    }

    public static void rsCSVCNP(final String pStrSQL, final StringBuffer StrSalida) {
        /* genera una cadena con los informacion separada por comas
         Nota: Se cierra la conexion una vez extraidos los datos*/
        ResultSet rs = null;
        boolean blnRegistro = true;

        Connection con = null;
        try {
            con = UtileriasBDF.getConnection();
            rs = rsSQLP(con, pStrSQL);
            if (rs.next()) {
                ResultSetMetaData rsMetaDato = rs.getMetaData();
                int i;
                int iCol = rsMetaDato.getColumnCount();

                for (i = 1; i <= iCol; i++) {
                    StrSalida.append(rsMetaDato.getColumnLabel(i)).append(",");
                }
                StrSalida.append("\n\r");
                do {
                    for (i = 1; i <= iCol; i++) {
                        if (rs.getObject(i) != null) {
                            StrSalida.append(rs.getObject(i).toString().replaceAll(",|\n|\r\n?", " ")).append(",");
                        } else {
                            StrSalida.append(",");
                        }
                    }
                    StrSalida.append("\n");
                } while (rs.next());
            }
            //System.out.println("pStrSQL____rsCSVCNP SISE ARG: " + pStrSQL);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
                if (rs != null) {
                    rs.close();
                    rs = null;
                }

            } catch (SQLException ee) {
                ee.printStackTrace();
            }
        }
    }

    public static void rsTableGRNP(String pStrSQL, final StringBuffer StrSalida) {

        ResultSet rs = null;
        boolean blnRegistro = true;

        Connection con = null;
        try {
            con = UtileriasBDF.getConnection();
            rs = rsSQLP(con, pStrSQL);
            //System.out.println("pStrSQL____rsTableGRNP SISE ARG: " + pStrSQL);
            ResultSetMetaData rsMetaDato = rs.getMetaData();
            int i;
            if (rs.next()) {
                rs.last();
                StrSalida.append("<th class='cssTitDet'>Registros Encontrados:").append(rs.getRow()).append("</th>");
                rs.first();
            }
            StrSalida.append("<table class='Table' border='1' cellpadding='0'>");
            StrSalida.append("<tr class = 'TTable'>");
            for (i = 1; i <= rsMetaDato.getColumnCount() - 1; i++) {
                StrSalida.append("<th>").append(rsMetaDato.getColumnLabel(i)).append("</th>");
            }
            StrSalida.append("</tr>");
            while (rs.next()) {
                // Checa el color del registro
                if (rs.getObject(rsMetaDato.getColumnCount()).equals("ROJO")) {
                    StrSalida.append("<tr class='Rojo'>");
                } else if (rs.getObject(rsMetaDato.getColumnCount()).equals("AMARILLO")) {
                    StrSalida.append("<tr class='Amarillo'>");
                } else if (rs.getObject(rsMetaDato.getColumnCount()).equals("BLANCO")) {
                    StrSalida.append("<tr class='Blanco'>");
                } else if (rs.getObject(rsMetaDato.getColumnCount()).equals("VERDE")) {
                    StrSalida.append("<tr class='Verde'>");
                }
                for (i = 1; i <= rsMetaDato.getColumnCount() - 1; i++) {
                    StrSalida.append("<td>").append(rs.getObject(i)).append("</td>");
                }
                StrSalida.append("</tr>");
            }
        } catch (SQLException e) {
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                    rs = null;
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException ee) {
                ee.printStackTrace();
            }
        }
    }
}
