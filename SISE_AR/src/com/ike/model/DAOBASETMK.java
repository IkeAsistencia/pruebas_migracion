/*
 * DAOBASETMK.java
 *
 * Created on 30 de marzo de 2006, 05:03 PM
 *
 * To change this template, choose Tools | Options and locate the template under
 * the Source Creation and Management node. Right-click the template and choose
 * Open. You can then make changes to the template in the Source Editor.
 */
package com.ike.model;

import java.sql.Connection;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.DatabaseMetaData;
import java.sql.ResultSetMetaData;

/********************************/
import javax.naming.Context;
import javax.naming.NamingException;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import Utilerias.*;
import java.util.Collection;
import java.util.ArrayList;

/*
 *
 * @author cabrerar
 */
public class DAOBASETMK {

    public static Connection getConnection() throws DAOException {
        Context ctx = null;
        DataSource ds = null;
        Connection con = null;

        try {
            ctx = new InitialContext();
            // java:comp/env siempre para indicar que se busque en el contexto de jndi
            ds = (DataSource) ctx.lookup("java:comp/env/jdbc/IkeTMK");
            con = ds.getConnection();

        } catch (NamingException NE) {
            throw new DAOException(NE.getMessage(), NE);
        } catch (SQLException SE) {
            throw new DAOException(SE.getMessage(), SE);
        } finally {
            try {
                if (ctx != null) {
                    ctx.close();
                }
            } catch (NamingException NEb) {
                NEb.printStackTrace();
            }
        }
        return con;
    }

    protected Collection rsSQLNP(final String SQL, LlenaDatos Lld) throws DAOException {
        /*
         *      Método que regresa un record set
         *      Nota: Una vez ejecutada la sentencia no se cierra la conexión
         */
        Connection con = null;
        Statement stmt = null;
        ResultSet rsObt = null;
        Collection col = new ArrayList();


        try {
            con = DAOBASE.getConnection();
            stmt = con.createStatement();
            stmt.execute("set dateformat mdy");
            rsObt = stmt.executeQuery(SQL);

            while (rsObt.next()) {
                col.add(Lld.llena(rsObt));
            }

        } catch (Throwable t) {
            throw new DAOException(t.getMessage(), t);
        } finally {
            try {
                //Cierro Resultset
                if (rsObt != null) {
                    con.close();
                }
                //Cierro Statement
                if (stmt != null) {
                    stmt.close();
                }
                // Cierro Conexion
                if (con != null) {
                    con.close();
                }
            } catch (Exception ee) {
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
        /* Método que no regresa nada después de ejecutar una sentencia SQL
        Nota: obtiene conexión y la cierra una vez ejecutada la sentencia */

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

                        stmt.execute("set dateformat mdy");
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
                        stmt.execute("set dateformat mdy");
                        stmt.execute(args);
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            } else {
                System.out.println("No me pude conectar");
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
            } catch (Exception ee) {
                ee.printStackTrace();
            }
        }
    }

    public static int actSQLNP(final String args) {

        /*
        Metodo que regresa el numero de registros afectados
        Nota: obtiene conexión y la cierra una vez ejecutada la sentencia */

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

                        stmt.execute("set dateformat mdy");
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
                        stmt.execute("set dateformat mdy");
                        iResponse = stmt.executeUpdate(args);
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            } else {
                System.out.println("No me pude conectar");
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

            } catch (Exception ee) {
                ee.printStackTrace();
            }
        }
        return iResponse;
    }

    public static ResultSet rsSQLP(Connection con, final String SQL) {
        /*
         *      Método que regresa un record set
         *      Nota: Una vez ejecutada la sentencia no se cierra la conexión
         */
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
                        stmt.execute("set dateformat mdy");
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
                        stmt.execute("set dateformat mdy");
                        rsObt = stmt.executeQuery(SQL);
                    }

                // Pendiente : Verificar que tan eficiente es CONCUR....
                } catch (Exception e) {
                    //e.printStackTrace();
                }
            } else {
                System.out.println("No me pude conectar");
            }
        } catch (SQLException sqle) {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (Exception ee) {
                ee.printStackTrace();
            }
            sqle.printStackTrace();
        } finally {
        }

        return rsObt;
    }

    public static void rsTableNP(final String pStrSQL, final StringBuffer StrSalida) {
        /* genera código HTM de una tabla con los registros de la base de datos
         * Nota: Se cierra la conexión una vez extraídos los datos
         */
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
        } catch (Exception e) {
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
            } catch (Exception ee) {
                ee.printStackTrace();
            }
        }
        strValue = null;
        StrSalida.append("</table>");
    }

    public static void rsTablePlasmaNP(final String pStrSQL, int NumRows, String strTitulo, final StringBuffer StrSalida) {
        /* genera código HTM de una tabla con los registros de la base de datos
         * Nota: Se cierra la conexión una vez extraídos los datos
         */
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
        } catch (Exception e) {
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

            } catch (Exception ee) {
                ee.printStackTrace();
            }
        }
    }

    public static void rsCSVCNP(final String pStrSQL, final StringBuffer StrSalida) {
        /* genera una cadena con los información separada por comas 
         * Nota: Se cierra la conexión una vez extraídos los datos
         */
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
        } catch (Exception e) {
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

            } catch (Exception ee) {
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
                } else {
                    if (rs.getObject(rsMetaDato.getColumnCount()).equals("AMARILLO")) {
                        StrSalida.append("<tr class='Amarillo'>");
                    } else {
                        if (rs.getObject(rsMetaDato.getColumnCount()).equals("BLANCO")) {
                            StrSalida.append("<tr class='Blanco'>");
                        } else {
                            if (rs.getObject(rsMetaDato.getColumnCount()).equals("VERDE")) {
                                StrSalida.append("<tr class='Verde'>");
                            }
                        }
                    }
                }
                for (i = 1; i <= rsMetaDato.getColumnCount() - 1; i++) {
                    StrSalida.append("<td>").append(rs.getObject(i)).append("</td>");
                }
                StrSalida.append("</tr>");
            }
        } catch (Exception e) {
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                    rs = null;
                }
                if (con != null) {
                    con.close();
                }
            } catch (Exception ee) {
                ee.printStackTrace();
            }
        }
    }
}
