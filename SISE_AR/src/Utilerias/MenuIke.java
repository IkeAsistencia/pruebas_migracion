package Utilerias;

import java.sql.ResultSet;
import java.sql.Connection;

/*
 *
 * @author  mramirez
 * @version
 */
public class MenuIke {

    private MenuIke() {
    }

    public static void doMenuIke(String pclUsrApp, final StringBuffer strMenu) {

        int i;
        int j;
        int k;
        int l;

        Connection con = null;
        con = UtileriasBDF.getConnection();

        TreeView tv = new TreeView();

        ResultSet rsMenu = null;
        ResultSet rsSubMenu1 = null;
        ResultSet rsSubMenu2 = null;
        ResultSet rsSubMenu3 = null;

        tv.target = "Contenido";
        tv.setImagesUrl("Imagenes");

        // Obtiene Menu Principal
        StringBuffer strSql = new StringBuffer();
        strSql.append("sp_GetMenues ").append(pclUsrApp).append(",1");
        rsMenu = UtileriasBDF.rsSQLNP(strSql.toString());
        strSql.delete(0, strSql.length());

        try {
            i = 0;
            while (rsMenu.next()) {
                // Agrega el elemento del Menu Principal
                tv.add(tv.createNode(rsMenu.getString("dsMenu")));

                // Busca dentro de la Tabla si tiene Subemenu 1
                strSql.append("sp_GetMenues ").append(pclUsrApp).append(",2,").append("'").append(rsMenu.getString("dsMenu")).append("'");
                rsSubMenu1 = UtileriasBDF.rsSQLNP(strSql.toString());
                strSql.delete(0, strSql.length());

                j = 0;
                while (rsSubMenu1.next()) {
                    //verifica si el registro es un submenu o hace referencia a una Pagina
                    if (rsSubMenu1.getString("NombrePaginaWeb") == null) {
                        tv.nodes.item(i).add(tv.createNode(rsSubMenu1.getString("dsMenu")));
                        // genera el submenu 2
                        strSql.append("sp_GetMenues ").append(pclUsrApp).append(",2,").append("'").append(rsSubMenu1.getString("dsMenu")).append("'");
                        rsSubMenu2 = UtileriasBDF.rsSQLNP(strSql.toString());
                        strSql.delete(0, strSql.length());

                        k = 0;
                        while (rsSubMenu2.next()) {
                            if (rsSubMenu2.getString("NombrePaginaWeb") == null) {
                                tv.nodes.item(i).childNodes.item(j).add(tv.createNode(rsSubMenu2.getString("dsMenu"), rsSubMenu2.getString("NombrePaginaWeb"), rsSubMenu2.getString("dsMenu")));
                                // genera el submenu 3
                                strSql.append("sp_GetMenues ").append(pclUsrApp).append(",2,").append("'").append(rsSubMenu2.getString("dsMenu")).append("'");
                                rsSubMenu3 = UtileriasBDF.rsSQLNP(strSql.toString());
                                strSql.delete(0, strSql.length());
                                l = 0;
                                while (rsSubMenu3.next()) {
                                    tv.nodes.item(i).childNodes.item(j).childNodes.item(k).add(tv.createNode(rsSubMenu3.getString("dsMenu"), rsSubMenu3.getString("NombrePaginaWeb"), rsSubMenu3.getString("dsMenu")));
                                    l++;
                                }
                                rsSubMenu3.close();
                                rsSubMenu3 = null;
                            } else {
                                tv.nodes.item(i).childNodes.item(j).add(tv.createNode(rsSubMenu2.getString("dsMenu"), rsSubMenu2.getString("NombrePaginaWeb"), rsSubMenu2.getString("dsMenu")));
                                k++;
                            }
                        }
                        rsSubMenu2.close();
                        rsSubMenu2 = null;
                    } else {
                        tv.nodes.item(i).add(tv.createNode(rsSubMenu1.getString("dsMenu"), rsSubMenu1.getString("NombrePaginaWeb"), rsSubMenu1.getString("dsMenu")));
                    }
                    j++;
                }
                rsSubMenu1.close();
                rsSubMenu1 = null;
                i++;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            strSql.delete(0, strSql.length());
            strSql = null;

            try {
                if (rsMenu != null) {
                    rsMenu.close();
                    rsMenu = null;
                }
                if (rsSubMenu1 != null) {
                    rsSubMenu1.close();
                    rsSubMenu1 = null;
                }
                if (rsSubMenu2 != null) {
                    rsSubMenu2.close();
                    rsSubMenu2 = null;
                }
                if (rsSubMenu3 != null) {
                    rsSubMenu3.close();
                    rsSubMenu3 = null;
                }
                if (con != null) {
                    con.close();
                }
            } catch (Exception ee) {
                ee.printStackTrace();
            }
        }
        strMenu.append(tv.getTree());
        tv = null;
    }
}
