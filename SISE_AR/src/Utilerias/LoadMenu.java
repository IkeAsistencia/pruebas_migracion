/*
 * LoadMenus.java
 *
 * Created on 13 de febrero de 2006, 01:36 PM
 */

/*
 *
 * @author  cabrerar
 */
package Utilerias;

import java.util.HashMap;
import java.sql.ResultSet;
import java.sql.Connection;

public class LoadMenu {

    private static HashMap comboHashParents = null;
    private static HashMap comboHashMenu = null;
    private static boolean isConfigured = false;

    /* Creates a new instance of ComboSingleton */
    private LoadMenu() {
    }

    private synchronized static boolean loadComboList() {
        if (isConfigured == false) {
            Connection con = null;
            con = UtileriasBDF.getConnection();
            ResultSet rsP = null;
            ResultSet rsM = null;
            comboHashParents = new HashMap();
            try {
                rsP = UtileriasBDF.rsSQLNP("sp_GetMenuesAll 1");
                while (rsP.next()) {
                    MenuItem MenuItemI = new MenuItem();

                    MenuItemI.setIntclUsrApp(rsP.getInt("clUsrApp"));
                    MenuItemI.setIntclMenu(rsP.getInt("clMenu"));
                    MenuItemI.setStrdsMenu(rsP.getString("dsMenu"));
                    MenuItemI.setStrdsPagina("");
                    comboHashParents.put(Integer.toString(MenuItemI.getIntclUsrApp()), MenuItemI);
                }

                rsM = UtileriasBDF.rsSQLNP("sp_GetMenuesAll 2");
                while (rsM.next()) {
                    MenuItem MenuItemI = new MenuItem();

                    MenuItemI.setIntclUsrApp(rsM.getInt("clUsrApp"));
                    MenuItemI.setIntclMenu(rsM.getInt("clMenuParent"));
                    MenuItemI.setStrdsMenu(rsM.getString("dsMenu"));
                    MenuItemI.setIntclMenu(rsM.getInt("clMenu"));
                    MenuItemI.setStrdsPagina(rsM.getString("NombrePaginaWeb"));
                    comboHashMenu.put(Integer.toString(MenuItemI.getIntclUsrApp()) + '-' + Integer.toString(MenuItemI.getIntclMenuParent()), MenuItemI);
                }
                isConfigured = true;
            } catch (Exception e) {
                System.out.print(e.getMessage());
                isConfigured = false;
                return false;
            } finally {
                try {
                    if (rsP != null) {
                        rsP.close();
                        rsP = null;
                    }
                    if (rsM != null) {
                        rsM.close();
                        rsM = null;
                    }
                    if (con != null) {
                        con.close();
                        con = null;

                    }

                } catch (Exception ee) {
                    ee.printStackTrace();
                }
                System.out.println("Entre a Load de Menues");
            }
        }
        return true;
    }

    public static HashMap getComboHashParents() {
        loadComboList();
        return comboHashParents;
    }

    public static void main(String args[]) {
    }

    public static void reLoad() {
        isConfigured = false;
    }
}
