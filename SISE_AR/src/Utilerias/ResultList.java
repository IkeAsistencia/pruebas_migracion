package Utilerias;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

public class ResultList {
//------------------------------------------------------------------------------
    private List rslt = null;
//------------------------------------------------------------------------------
    private int columns = 0;
//------------------------------------------------------------------------------
    private int columnIndex = -1;
//------------------------------------------------------------------------------
    private HashMap colsHM = null;
//------------------------------------------------------------------------------
    public ResultList() {    }
//------------------------------------------------------------------------------
    public void rsSQL(final String SQL) {
        Connection con = null;
        Statement stmt = null;
        ResultSet rs = null;
        ResultSetMetaData md = null;
        rslt = new ArrayList();
        Date Ahora = new Date();
        try {
            con = UtileriasBDF.getConnection();
            if (con != null) {
                stmt = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
                stmt.execute("SET DATEFORMAT MDY SET NOCOUNT ON");
                rs = stmt.executeQuery(SQL);
                md = rs.getMetaData();
                int columns = md.getColumnCount();
                this.columns = columns;
                colsHM = new HashMap(columns);
                while (rs.next()) {
                    HashMap row = new HashMap(columns);
                    for (int i = 1; i <= columns; ++i) {
                        if (rs.getString(i) == null) {
                            row.put(md.getColumnName(i).toUpperCase(), "");
                        } else {
                            row.put(md.getColumnName(i).toUpperCase(), rs.getString(i));
                        }
                        colsHM.put(i, md.getColumnName(i).toUpperCase());
                    }
                    rslt.add(row);
                    row = null;
                }
            } else {
                System.out.println("SISE AR ResultList=" + Ahora.toString() + " void rsSQL - Error de Conexion a la BD");
            }
        } catch (SQLException ex) {
            try {
                if (!ex.getMessage().equalsIgnoreCase("La instruccion no devolvio un result set.")
                        && !ex.getMessage().equalsIgnoreCase("La instruccion no devolio un conjunto de resultados.")) {
                    System.out.println("SISE AR ResultList = " + Ahora.toString() + " void rsSQL - " + SQL.toString());
                    ex.printStackTrace();
                    stmt.execute("SET DATEFORMAT YMD SET QUOTED_IDENTIFIER OFF  INSERT LogError (Sentencia,ErrorCode,Error,Fecha) VALUES (\"" + SQL + "\",\"" + ex.getErrorCode() + "\",\"" + ex.getMessage() + "\",GETDATE())");
                }
            } catch (Exception er) {
                er.printStackTrace();
            }
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (con != null) {
                    con.close();
                    con = null;
                }
                if (md != null) {
                    md = null;
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
//------------------------------------------------------------------------------
    public String getTable() {
        StringBuffer StrSalida = new StringBuffer();
        String StrTH = "", StrCSSRow = "", StrToolTip = "", StrCSSRowCol = "", StrToolTipCol = "", iTDToolTip = "1";
        int iColumnas = 0, iCSSRow = 0, iToolTip = 0;
        boolean blnCSSRow = false, blnToolTip = false;
        StrSalida.append("<table id=\"PW_LST\" class=\"Lista\" cellspacing='0' cellpadding='0'>");
        if (this.getRow() > 0) {
            for (int col = 1; col <= colsHM.size(); col++) {
                if (colsHM.get(col).toString().equalsIgnoreCase("CSSRow")) {
                    blnCSSRow = true;
                    iCSSRow = col;
                    StrCSSRowCol = colsHM.get(col).toString();
                } else {
                    if (colsHM.get(col).toString().equalsIgnoreCase("ToolTip")) {
                        blnToolTip = true;
                        iToolTip = col;
                        StrToolTipCol = colsHM.get(col).toString();
                    } else {
                        StrTH = StrTH + "<th onClick='fnOrder(" + String.valueOf(col - 1) + ");'>" + colsHM.get(col) + "</th>";
                    }
                }
            }
            StrSalida.append("<tr class=\"Registros\"><th colspan=\"" + this.getColumnCount() + "\">Registros: ").append(this.getRow()).append("</th></tr>");
            StrSalida.append("<tr class=\"Columnas\">").append(StrTH).append("</tr>");
            for (int lt = 0; lt < rslt.size(); lt++) {
                iColumnas = iColumnas + 1;
                HashMap rsHM = (HashMap) rslt.get(lt);
                if (blnCSSRow) {
                    StrCSSRow = rsHM.get(StrCSSRowCol).toString();
                }
                if (blnToolTip) {
                    StrToolTip = rsHM.get(StrToolTipCol).toString();
                    if (StrToolTip.indexOf("|") != -1) {
                        iTDToolTip = StrToolTip.substring(0, StrToolTip.indexOf("|"));
                    }
                }
                if (StrCSSRow.equalsIgnoreCase("")) {
                    StrSalida.append("<tr class=\"Contenido\" onMouseOut=\"this.className='Contenido'\" onMouseOver=\"this.className='ratonEncima'\">");
                } else {
                    StrSalida.append("<tr class=\"" + StrCSSRow + "\" onMouseOut=\"this.className='" + StrCSSRow + "'\" onMouseOver=\"this.className='ratonEncima'\">");
                }
                for (int col = 1; col <= colsHM.size(); col++) {
                    if (iCSSRow != col && iToolTip != col) {
                        if (StrToolTip.equalsIgnoreCase("")) {
                            StrSalida.append("<td>").append(rsHM.get(colsHM.get(col))).append("</td>");
                        } else {
                            if (col == Integer.parseInt(iTDToolTip)) {
                                StrSalida.append("<td onMouseOut=\"fn_HTT();\" onMouseOver=\"fn_STT(event," + StrToolTip + ");return false\">").append(rsHM.get(colsHM.get(col))).append("</td>");
                            } else {
                                StrSalida.append("<td>").append(rsHM.get(colsHM.get(col))).append("</td>");
                            }
                        }
                    }
                }
                StrSalida.append("</tr>");
            }
        } else {
            StrSalida.append("<tr class=\"Registros\"><th> ").append("</th></tr>");
            StrSalida.append("<tr class=\"Columnas\"><th>Mensaje</th></tr>");
            StrSalida.append("<tr class=\"Contenido\"><td>No se encontraron registros.</td></tr>");
        }
        StrSalida.append("</table>");
        return StrSalida.toString();
    }
//------------------------------------------------------------------------------
    public String rsTable(final String SQL) {
        StringBuffer StrSalida = new StringBuffer();
        String StrTH = "",
                StrCSSRow = "",
                StrToolTip = "",
                StrCSSRowCol = "",
                StrToolTipCol = "",
                iTDToolTip = "1";
        int iColumnas = 0,
                iCSSRow = 0,
                iToolTip = 0;
        boolean blnCSSRow = false,
                blnToolTip = false,
                blnRegistro = true;
        this.rsSQL(SQL);
        StrSalida.append("<table id=\"PW_LST\" class=\"Lista\" cellspacing='0'>");
        if (this.getRow() > 0) {
            for (int col = 1; col <= colsHM.size(); col++) {
                if (colsHM.get(col).toString().equalsIgnoreCase("CSSRow")) {
                    blnCSSRow = true;
                    iCSSRow = col;
                    StrCSSRowCol = colsHM.get(col).toString();
                } else {
                    if (colsHM.get(col).toString().equalsIgnoreCase("ToolTip")) {
                        blnToolTip = true;
                        iToolTip = col;
                        StrToolTipCol = colsHM.get(col).toString();
                    } else {
                        StrTH = StrTH + "<th onClick='fnOrder(" + String.valueOf(col - 1) + ");'>" + colsHM.get(col) + "</th>";
                    }
                }
            }
            StrSalida.append("<tr class=\"Registros\"><th colspan=\"" + this.getColumnCount() + "\">Registos Encontrados: ").append(this.getRow()).append("</th></tr>");
            StrSalida.append("<tr class=\"Columnas\">").append(StrTH).append("</tr>");
            for (int lt = 0; lt < rslt.size(); lt++) {
                iColumnas = iColumnas + 1;
                HashMap rsHM = (HashMap) rslt.get(lt);
                if (blnCSSRow) {
                    StrCSSRow = rsHM.get(StrCSSRowCol).toString();
                }
                if (blnToolTip) {
                    StrToolTip = rsHM.get(StrToolTipCol).toString();
                    if (StrToolTip.indexOf("|") != -1) {
                        iTDToolTip = StrToolTip.substring(0, StrToolTip.indexOf("|"));
                    }
                }
                if (StrCSSRow.equalsIgnoreCase("") && !blnCSSRow) {
                    if (blnRegistro) {
                        StrSalida.append("<tr class=\"Contenido1\" onMouseOut=\"this.className='Contenido1'\" onMouseOver=\"this.className='ratonEncima'\">");
                        blnRegistro = false;
                    } else {
                        StrSalida.append("<tr class=\"Contenido2\" onMouseOut=\"this.className='Contenido2'\" onMouseOver=\"this.className='ratonEncima'\">");
                        blnRegistro = true;
                    }
                } else {
                    StrSalida.append("<tr class=\"" + StrCSSRow + "\" onMouseOut=\"this.className='" + StrCSSRow + "'\" onMouseOver=\"this.className='ratonEncima'\">");
                }
                for (int col = 1; col <= colsHM.size(); col++) {
                    if (iCSSRow != col && iToolTip != col) {
                        if (StrToolTip.equalsIgnoreCase("")) {
                            StrSalida.append("<td>").append(rsHM.get(colsHM.get(col))).append("</td>");
                        } else {
                            if (col == Integer.parseInt(iTDToolTip)) {
                                StrSalida.append("<td onMouseOut=\"fn_HTT();\" onMouseOver=\"fn_STT(event," + StrToolTip + ");return false\">").append(rsHM.get(colsHM.get(col))).append("</td>");
                            } else {
                                StrSalida.append("<td>").append(rsHM.get(colsHM.get(col))).append("</td>");
                            }
                        }
                    }
                }
                StrSalida.append("</tr>");
            }
        } else {
            StrSalida.append("<tr class=\"Registros\"><th> ").append("</th></tr>");
            StrSalida.append("<tr class=\"Columnas\"><th>Mensaje</th></tr>");
            StrSalida.append("<tr class=\"Contenido\"><td>No se encontraron registros.</td></tr>");
        }
        StrSalida.append("</table>");
        return StrSalida.toString();
    }
//------------------------------------------------------------------------------
    public String rsTable(final String clPaginaWeb, final String NombrePaginaWeb, final String NombreLogicoWeb, final String Llave, final String Titulo, final String Alta, final String Busqueda, final String SQL, final String Link, final String TituloD) {
        StringBuffer StrSalida = new StringBuffer();
        String StrTH = "", StrCSSRow = "", StrToolTip = "", StrCSSRowCol = "", StrToolTipCol = "", iTDToolTip = "1";
        int iColumnas = 0, iCSSRow = 0, iToolTip = 0;
        boolean blnCSSRow = false, blnToolTip = false;
        this.rsSQL(SQL);
        StrSalida.append("<div id='LstBtn' class='ltT'>");
        if (!TituloD.equalsIgnoreCase("1")) {
            StrSalida.append("<center><FONT FACE=\"arial\" SIZE=2 COLOR=#004B85><B>").append(Titulo).append("</B></FONT></center>");
        }
        StrSalida.append("</div>");
        StrSalida.append("<table id=\"PW_LST\" class=\"Lista\" cellspacing='0'>");
        if (this.getRow() > 0) {
            for (int col = 1; col <= colsHM.size(); col++) {
                if (colsHM.get(col).toString().equalsIgnoreCase("CSSRow")) {
                    blnCSSRow = true;
                    iCSSRow = col;
                    StrCSSRowCol = colsHM.get(col).toString();
                } else {
                    if (colsHM.get(col).toString().equalsIgnoreCase("ToolTip")) {
                        blnToolTip = true;
                        iToolTip = col;
                        StrToolTipCol = colsHM.get(col).toString();
                    } else {
                        StrTH = StrTH + "<th onClick='fnOrder(" + String.valueOf(col - 1) + ");'>" + colsHM.get(col) + "</th>";
                    }
                }
            }
            StrSalida.append("<tr class=\"Registros\"><th colspan=\"" + this.getColumnCount() + "\">Registros: ").append(this.getRow()).append("</th></tr>");
            StrSalida.append("<tr class=\"Columnas\">").append(StrTH).append("</tr>");
            for (int lt = 0; lt < rslt.size(); lt++) {
                iColumnas = iColumnas + 1;
                HashMap rsHM = (HashMap) rslt.get(lt);
                if (blnCSSRow) {
                    StrCSSRow = rsHM.get(StrCSSRowCol).toString();
                }
                if (blnToolTip) {
                    StrToolTip = rsHM.get(StrToolTipCol).toString();
                    if (StrToolTip.indexOf("|") != -1) {
                        iTDToolTip = StrToolTip.substring(0, StrToolTip.indexOf("|"));
                    }
                }
                if (StrCSSRow.equalsIgnoreCase("")) {
                    StrSalida.append("<tr class=\"Contenido\" onMouseOut=\"this.className='Contenido'\" onMouseOver=\"this.className='ratonEncima'\">");
                } else {
                    StrSalida.append("<tr class=\"" + StrCSSRow + "\" onMouseOut=\"this.className='" + StrCSSRow + "'\" onMouseOver=\"this.className='ratonEncima'\">");
                }
                for (int col = 1; col <= colsHM.size(); col++) {
                    if (iCSSRow != col) {
                        if (col == 1 && Link.equalsIgnoreCase("1")) {
                            if (iCSSRow != col && iToolTip != col) {
                                //StrSalida.append("<th>").append("<a href=\"javascript:fn_DPW('"+clPaginaWeb+"','"+NombrePaginaWeb+"','"+Llave+"="+rsHM.get(colsHM.get(col))+"','');\">"+rsHM.get(colsHM.get(col))+"").append("</a></th>");
                                StrSalida.append("<td>").append(rsHM.get(colsHM.get(col))).append("</a></td>");
                            }
                        } else {
                            if (iCSSRow != col && iToolTip != col) {
                                if (StrToolTip.equalsIgnoreCase("")) {
                                    StrSalida.append("<td>").append(rsHM.get(colsHM.get(col))).append("</td>");
                                } else {
                                    if (col == Integer.parseInt(iTDToolTip)) {
                                        StrSalida.append("<td onMouseOut=\"fn_HTT();\" onMouseOver=\"fn_STT(event," + StrToolTip + ");return false\">").append(rsHM.get(colsHM.get(col))).append("</td>");
                                    } else {
                                        StrSalida.append("<td>").append(rsHM.get(colsHM.get(col))).append("</td>");
                                    }
                                }

                            }
                        }
                    }
                }
                StrSalida.append("</tr>");
            }
        } else {
            StrSalida.append("<tr class=\"Registros\"><th> ").append("</th></tr>");
            StrSalida.append("<tr class=\"Columnas\"><th>Mensaje</th></tr>");
            StrSalida.append("<tr class=\"Contenido\"><td>No se encontraron registros.</td></tr>");
        }
        StrSalida.append("</table>");
        return StrSalida.toString();
    }
//------------------------------------------------------------------------------
    public String rsTableAC(final String clPaginaWeb, final String NombrePaginaWeb, final String NombreLogicoWeb, final String k, final String Titulo, final String Alta, final String Busqueda, final String SQL, final String Link, final String TituloD) {
        StringBuffer StrSalida = new StringBuffer();
        String StrTH = "", StrCSSRow = "", StrToolTip = "", StrCSSRowCol = "", StrToolTipCol = "", iTDToolTip = "1";
        int iColumnas = 0, iCSSRow = 0, iToolTip = 0;
        boolean blnCSSRow = false, blnToolTip = false;
        this.rsSQL(SQL);
        StrSalida.append("<div id='LstBtn' class='ltT'>");
        if (!TituloD.equalsIgnoreCase("1")) {
            //StrSalida.append("<center><FONT FACE=\"arial\" SIZE=2 COLOR=#004B85><B>").append(Titulo).append("</B></FONT></center>");
        }
        StrSalida.append("</div>");
        StrSalida.append("<table id=\"PW_LST\" class=\"Lista\" cellspacing='0'>");
        StrSalida.append("<input type='hidden' id='HPW_" + clPaginaWeb + "' name='HPW_" + clPaginaWeb + "' value='" + this.getRow() + "'>");
        if (this.getRow() > 0) {
            for (int col = 1; col <= colsHM.size(); col++) {
                if (colsHM.get(col).toString().equalsIgnoreCase("CSSRow")) {
                    blnCSSRow = true;
                    iCSSRow = col;
                    StrCSSRowCol = colsHM.get(col).toString();
                } else {
                    if (colsHM.get(col).toString().equalsIgnoreCase("ToolTip")) {
                        blnToolTip = true;
                        iToolTip = col;
                        StrToolTipCol = colsHM.get(col).toString();
                    } else {
                        StrTH = StrTH + "<th onClick='fnOrder(" + String.valueOf(col - 1) + ");'>" + colsHM.get(col) + "</th>";
                    }
                }
            }
            StrSalida.append("<tr class=\"Registros\"><th colspan=\"" + this.getColumnCount() + "\">Registos Encontrados: ").append(this.getRow()).append("</th></tr>");
            StrSalida.append("<tr class=\"Columnas\">").append(StrTH).append("</tr>");
            for (int lt = 0; lt < rslt.size(); lt++) {
                iColumnas = iColumnas + 1;
                HashMap rsHM = (HashMap) rslt.get(lt);
                if (blnCSSRow) {
                    StrCSSRow = rsHM.get(StrCSSRowCol).toString();
                }
                if (blnToolTip) {
                    StrToolTip = rsHM.get(StrToolTipCol).toString();
                    if (StrToolTip.indexOf("|") != -1) {
                        iTDToolTip = StrToolTip.substring(0, StrToolTip.indexOf("|"));
                    }
                }
                if (StrCSSRow.equalsIgnoreCase("")) {
                    StrSalida.append("<tr class=\"Contenido\" onMouseOut=\"this.className='Contenido'\" onMouseOver=\"this.className='ratonEncima'\">");
                } else {
                    StrSalida.append("<tr class=\"" + StrCSSRow + "\" onMouseOut=\"this.className='" + StrCSSRow + "'\" onMouseOver=\"this.className='ratonEncima'\">");
                }
                for (int col = 1; col <= colsHM.size(); col++) {
                    if (iCSSRow != col) {
                        if (col == 1 && Link.equalsIgnoreCase("1")) {
                            if (iCSSRow != col && iToolTip != col) {
                                StrSalida.append("<td>").append(rsHM.get(colsHM.get(col))).append("</a></td>");
                            }
                        } else {
                            if (iCSSRow != col && iToolTip != col) {
                                if (StrToolTip.equalsIgnoreCase("")) {
                                    StrSalida.append("<td>").append(rsHM.get(colsHM.get(col))).append("</td>");
                                } else {
                                    if (col == Integer.parseInt(iTDToolTip)) {
                                        StrSalida.append("<td onMouseOut=\"fn_HTT();\" onMouseOver=\"fn_STT(event," + StrToolTip + ");return false\">").append(rsHM.get(colsHM.get(col))).append("</td>");
                                    } else {
                                        StrSalida.append("<td>").append(rsHM.get(colsHM.get(col))).append("</td>");
                                    }
                                }

                            }
                        }
                    }
                }
                StrSalida.append("</tr>");
            }
        } else {
            StrSalida.append("<tr class=\"Registros\"><th> ").append("</th></tr>");
            StrSalida.append("<tr class=\"Columnas\"><th>Mensaje</th></tr>");
            StrSalida.append("<tr class=\"Contenido\"><td>No se encontraron registros.</td></tr>");
        }
        StrSalida.append("</table>");
        return StrSalida.toString();
    }
//------------------------------------------------------------------------------
    public int getRow() {
        return rslt.size();
    }
//------------------------------------------------------------------------------
    public int getColumnCount() {
        return this.columns;
    }
//------------------------------------------------------------------------------
    public boolean next() {
        if (rslt.size() > 0 && rslt.size() - 1 > columnIndex) {
            columnIndex = columnIndex + 1;
            return true;
        } else {
            return false;
        }
    }
//------------------------------------------------------------------------------
    public String getString(String columnName) {
        Date Ahora = new Date();
        String valorColumn = "";
        columnName = columnName.toUpperCase();
        HashMap rsHM = (HashMap) rslt.get(this.columnIndex);
        if (rsHM.get(columnName) != null) {
            valorColumn = rsHM.get(columnName).toString();
        } else {
            System.out.println("SISE AR ResultList=" + Ahora.toString() + " getString - La Columna " + columnName + " no existe");
        }
        Ahora = null;
        return valorColumn;
    }
//------------------------------------------------------------------------------
    public String getString(int columnIndex) {
        Date Ahora = new Date();
        String valorColumn = "";
        String columnName = "";
        if (colsHM.get(columnIndex) != null) {
            columnName = colsHM.get(columnIndex).toString();
        } else {
            System.out.println("SISE AR ResultList=" + Ahora.toString() + " getString - El id " + columnIndex + " no existe");
        }
        if (!columnName.equalsIgnoreCase("")) {
            HashMap rsHM = (HashMap) rslt.get(this.columnIndex);
            valorColumn = rsHM.get(columnName).toString();
        }
        Ahora = null;
        return valorColumn;
    }
//------------------------------------------------------------------------------
    public int getInt(String columnName) {
        columnName = columnName.toUpperCase();
        Date Ahora = new Date();
        String valorColumn = "";
        HashMap rsHM = (HashMap) rslt.get(this.columnIndex);
        if (rsHM.get(columnName) != null) {
            valorColumn = rsHM.get(columnName).toString();
        } else {
            System.out.println("SISE AR ResultList=" + Ahora.toString() + " getString - La Columna " + columnName + " no existe");
        }
        Ahora = null;
        return Integer.parseInt(valorColumn);
    }
//------------------------------------------------------------------------------
    public String getObject(int columnIndex) {
        String valorColumn = "";
        String columnName = "";
        Date Ahora = new Date();
        if (colsHM.get(columnIndex) != null) {
            columnName = colsHM.get(columnIndex).toString();
        } else {
            System.out.println("SISE AR ResultList=" + Ahora.toString() + " getString - La id " + columnIndex + " no existe");
        }
        if (!columnName.equalsIgnoreCase("")) {
            HashMap rsHM = (HashMap) rslt.get(this.columnIndex);
            valorColumn = rsHM.get(columnName).toString();
        }
        Ahora = null;
        return valorColumn;
    }
//------------------------------------------------------------------------------
    public boolean getBoolean(String columnName) {
        boolean valorColumn = false;
        columnName = columnName.toUpperCase();
        Date Ahora = new Date();
        HashMap rsHM = (HashMap) rslt.get(this.columnIndex);
        if (rsHM.get(columnName) != null) {
            valorColumn = rsHM.get(columnName).toString().equalsIgnoreCase("0") ? false : true;
        } else {
            System.out.println("SISE AR ResultList=" + Ahora.toString() + " getString - La Columna " + columnName + " no existe");
        }
        Ahora = null;
        return valorColumn;
    }
//------------------------------------------------------------------------------
    public boolean getBoolean(int columnIndex) {
        boolean valorColumn = false;
        String columnName = "";
        Date Ahora = new Date();
        if (colsHM.get(columnIndex) != null) {
            columnName = colsHM.get(columnIndex).toString();
        } else {
            System.out.println("SISE AR ResultList=" + Ahora.toString() + " getString - La id " + columnName + " no existe");
        }
        if (!columnName.equalsIgnoreCase("")) {
            HashMap rsHM = (HashMap) rslt.get(this.columnIndex);
            valorColumn = rsHM.get(columnName).toString().equalsIgnoreCase("0") ? false : true;
        }
        Ahora = null;
        return valorColumn;
    }
//------------------------------------------------------------------------------
    public void close() {
        this.rslt = null;
        this.colsHM = null;
        this.columnIndex = -1;
    }
//------------------------------------------------------------------------------
    public void afterLast() {
        this.columnIndex = rslt.size() - 1;
    }
//------------------------------------------------------------------------------
    public void beforeFirst() {
        this.columnIndex = 0;
    }
//------------------------------------------------------------------------------
    public void first() {
        this.columnIndex = 1;
    }
//------------------------------------------------------------------------------
}
