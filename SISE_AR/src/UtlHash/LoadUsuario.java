package UtlHash;

/*
 * LoadUsuario.java
 *
 * Created on 17 de febrero de 2006, 11:53 PM
 */
/*
 *
 * @author  cabrerar
 */
import java.util.HashMap;
import java.sql.ResultSet;
import Utilerias.UtileriasBDF;
import Utilerias.MenuIke;

/*
 *
 * @author  cabrerar
 */
public class LoadUsuario {
// A diferencia del load de Páginas y combos singleton, esta clase solo carga 
// a petición el usuario que accesa

    private static HashMap comboHash = new HashMap();
    private static Usuario UsuarioI = null;

    /* Creates a new instance of ComboSingleton */
    private LoadUsuario() {
    }

    public static Usuario getUsuario(final String strclUsrApp) {
        UsuarioI = LoadUsuario(strclUsrApp);
        return UsuarioI;
    }

    private synchronized static Usuario LoadUsuario(final String strclUsrApp) {
        StringBuilder strSql = new StringBuilder();
        Usuario UsuarioI = (Usuario) comboHash.get(strclUsrApp);

        if (UsuarioI == null) {
            ResultSet rs = null;
            try {
                strSql.append("select U.clUsrApp, U.Nombre from cUsrApp U where U.clUsrApp= ").append(strclUsrApp);
                rs = UtileriasBDF.rsSQLNP(strSql.toString());

                if (rs.next()) {
                    UsuarioI = new Usuario();
                    UsuarioI.setStrclUsrApp(rs.getString("clUsrApp"));
                    UsuarioI.setStrNombre(rs.getString("Nombre"));
                    StringBuffer strMenus = new StringBuffer();
                    MenuIke.doMenuIke(strclUsrApp, strMenus);
                    UsuarioI.setstrMenus(strMenus);
                    comboHash.put(UsuarioI.getStrclUsrApp(), UsuarioI);
                }
            } catch (Exception e) {
                System.out.print(e.getMessage());
                return null;
            } finally {
                try {
                    if (rs != null) {
                        rs.close();
                        rs = null;
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }

                System.out.println("Entre a Load de Usuario");
            }

        }
        return UsuarioI;
    }

    /*    public static List getFiltros(String strclPagina)
     {
     HashMap hshMap=LoadPagina.getComboHash();
     Pagina PaginaI = (Pagina) hshMap.get(strclPagina);
     return PaginaI.getLstFiltros();
     }

     public static Pagina getPagina(String strclPagina)
     {
     HashMap hshMap=LoadPagina.getComboHash();
     Pagina PaginaI = (Pagina) hshMap.get(strclPagina);
     return PaginaI;
     }*/
    public static void main(String args[]) {
    }

    public static StringBuffer getstrMenus(String strclUsrApp) {
        StringBuffer strSql = new StringBuffer();

        ResultSet rs = null;
        strSql.append("Select MenuConfig, coalesce(Menus,'') Menus from cUsrApp where clUsrApp=").append(strclUsrApp);
        rs = UtileriasBDF.rsSQLNP(strSql.toString());
        strSql.delete(0, strSql.length());

        StringBuffer strMenus = new StringBuffer();
        try {
            if (rs.next()) {
                if (rs.getString("MenuConfig").compareToIgnoreCase("0") == 0) {
                    MenuIke.doMenuIke(strclUsrApp, strMenus);
                    strSql.append("set quoted_identifier off Update cUsrApp set MenuConfig=1, Menus = \"").append(strMenus).append("\" where clUsrApp=").append(strclUsrApp);
                    UtileriasBDF.actSQLNP(strSql.toString());
                    strSql.delete(0, strSql.length());
                } else {
                    strMenus.append(rs.getString("Menus"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                    rs = null;
                }
            } catch (Exception e) {
            }
        }
        return strMenus;
    }

    public static void reLoad() {
    }
}
