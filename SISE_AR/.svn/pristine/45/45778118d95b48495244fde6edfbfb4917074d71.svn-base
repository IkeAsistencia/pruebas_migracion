/*
 * LoadPagina.java
 *
 * Created on 15 de febrero de 2006, 12:35 PM
 */
package UtlHash;

/*
 *
 * @author  cabrerar
 */
import java.util.List;
import java.util.HashMap;
import java.util.ArrayList;
import java.sql.ResultSet;
import Utilerias.UtileriasBDF;

/*
 *
 * @author  cabrerar
 */
public class LoadPagina {

    private static HashMap comboHash = new HashMap();

    /* Creates a new instance of ComboSingleton */
    private LoadPagina() {
    }

    private synchronized static Pagina LoadPagina(String strclPagina) {
        Pagina PaginaI = null;

        PaginaI = (Pagina) comboHash.get(strclPagina);

        if (PaginaI == null) {
            StringBuffer strSql = new StringBuffer();

            try {
                ResultSet rs = UtileriasBDF.rsSQLNP("st_getInfoPagina " + strclPagina);
                while (rs.next()) {
                    PaginaI = new Pagina();

                    PaginaI.setStrclPagina(rs.getString("clPaginaWeb"));
                    PaginaI.setStrTablaBitacora(rs.getString("TablaBitacora"));
                    PaginaI.setStrTituloRPT(rs.getString("TituloRPT"));
                    PaginaI.setStrSentenciaRPT(rs.getString("SentenciaRPT"));
                    PaginaI.setStrPaginaDetalle(rs.getString("PaginaDetalle"));
                    PaginaI.setStrTarget(rs.getString("Target"));
                    PaginaI.setStrNombrePaginaWeb(rs.getString("NombrePaginaWeb"));
                    PaginaI.setStrNombrePaginaWebCSV(rs.getString("NombrePaginaWebCSV"));
                    PaginaI.setStrNombrePaginaWebMail(rs.getString("NombrePaginaWebMail"));

                    strSql.append("st_getFiltrosxPag ").append(PaginaI.getStrclPagina());
                    ResultSet rsFiltros = UtileriasBDF.rsSQLNP(strSql.toString());
                    strSql.delete(0, strSql.length());
                    List lstFiltros = new ArrayList();

                    while (rsFiltros.next()) {
                        Filtro FiltroI = new Filtro();

                        FiltroI.setStrclFiltroWeb(rsFiltros.getString("clFiltroWeb"));
                        FiltroI.setStrSecuencia(rsFiltros.getString("Secuencia"));
                        FiltroI.setStrTipoGet(rsFiltros.getString("TipoGet"));
                        FiltroI.setStrTipoFiltro(rsFiltros.getString("TipoFiltro"));
                        FiltroI.setStrVarVal(rsFiltros.getString("VarVal"));
                        FiltroI.setStrTipoDato(rsFiltros.getString("TipoDato"));
                        FiltroI.setStrParametros(rsFiltros.getString("Parametros"));
                        FiltroI.setStrValorDefault(rsFiltros.getString("ValorDefault"));
                        FiltroI.setStrMask(rsFiltros.getString("Mask"));
                        FiltroI.setStrdsFiltroWeb(rsFiltros.getString("dsFiltroWeb"));
                        FiltroI.setStrSentencia(rsFiltros.getString("Sentencia"));
                        FiltroI.setStrfnOnChange(rsFiltros.getString("fnOnChange"));
                        FiltroI.setStrBusquedaRef(rsFiltros.getString("BusquedaRef"));
                        FiltroI.setStrClass(rsFiltros.getString("Class"));
                        FiltroI.setStrDivID(rsFiltros.getString("NombreDiv"));

                        lstFiltros.add(FiltroI);

                    }
                    rsFiltros.close();
                    rsFiltros = null;
                    PaginaI.setLstFiltros(lstFiltros);
                    comboHash.put(PaginaI.getStrclPagina(), PaginaI);
                }
                rs.close();
                rs = null;
            } catch (Exception e) {
                System.out.print(e.getMessage());
            }
        }
        return PaginaI;
    }

    public static List getFiltros(final String strclPagina) {
        Pagina PaginaI = getPagina(strclPagina);
        return PaginaI.getLstFiltros();
    }

    public static Pagina getPagina(final String strclPagina) {
        Pagina PaginaI = null;
        PaginaI = (Pagina) comboHash.get(strclPagina);
        if (PaginaI == null) {
            PaginaI = LoadPagina(strclPagina);
        }
        return PaginaI;
    }

    public static void main(String args[]) {
    }

    public static void reLoad() {
    }

    public static void reLoadP(String strclPagina) {
        //System.out.println("Entra reloadP");
        comboHash.remove(strclPagina);
        //System.out.println("Sale reloadP");
    }
}
