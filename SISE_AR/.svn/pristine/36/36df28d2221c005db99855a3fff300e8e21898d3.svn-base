/*
 * Idioma.java
 *
 * Created on 04 de noviembre de 2005, 19:45 PM
 */
package Utilerias;

/*
 *
 * @author
 * cabrerar
 */
import java.util.HashMap;
import java.sql.ResultSet;
import java.sql.Connection;

/*
 *
 * @author
 * cabrerar
 */
public class Idioma {

    private static HashMap comboHash = null;
    private static boolean isConfigured = false;

    private Idioma() {
    }

    private synchronized static boolean loadComboList() {
        if (isConfigured == false) {
            Connection con = null;
            con = UtileriasBDF.getConnection();
            ResultSet rs = null;

            comboHash = new HashMap();
            try {
                rs = UtileriasBDF.rsSQLNP("select Espanol, Portugues from cIdioma order by Espanol");
                while (rs.next()) {
                    Label labelI = new Label();

                    if (rs.getString("Espanol") == null || rs.getString("Espanol").length() == 0) {
                        labelI.setStrLabelSP("");
                    } else {
                        labelI.setStrLabelSP(rs.getString("Espanol"));
                    }

                    if (rs.getString("Portugues") == null || rs.getString("Portugues").length() == 0) {
                        labelI.setStrLabelPO("");
                    } else {
                        labelI.setStrLabelPO(rs.getString("Portugues"));
                    }

                    comboHash.put(labelI.getStrLabelSP(), labelI);
                }
                isConfigured = true;
            } catch (Exception e) {
                System.out.print(e.getMessage());
                isConfigured = false;
                return false;
            } finally {
                try {
                    if (rs != null) {
                        rs.close();
                        rs = null;
                    }
                    if (con != null) {
                        con.close();
                        con = null;
                    }
                } catch (Exception ee) {
                    ee.printStackTrace();
                }
                System.out.println("Entre a Load de Idiomas");
            }
        }
        return true;
    }

    public static String getLabel(String strLabelToFind, byte bytLanguaje) {
        loadComboList();

        Label lblToReturn = null;
        lblToReturn = (Label) comboHash.get(strLabelToFind);
        if (lblToReturn != null) {
            if (bytLanguaje == 1) //Español
            {
                return lblToReturn.getStrLabelSP();
            }
            if (bytLanguaje == 2) //Portugués
            {
                return lblToReturn.getStrLabelPO();
            }
        }
        return strLabelToFind;
    }

    public static void main(String args[]) {
    }

    public static void reLoad() {
        isConfigured = false;
    }
}
