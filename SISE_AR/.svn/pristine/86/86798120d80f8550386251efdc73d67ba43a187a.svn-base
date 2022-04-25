/*
 * cbConcepto.java
 *
 * Created on 26 de septiembre de 2005, 01:04 PM
 */
package Combos;

/*
 *
 * @author  cabrerar
 */
import java.util.List;
import java.util.HashMap;
import java.util.ArrayList;
import java.sql.ResultSet;
import Utilerias.UtileriasBDF;
import java.util.Iterator;
import java.util.Set;

/*
 *
 * @author  cabrerar
 */
public class cbConcepto {

    private static HashMap comboHash = null;
    private static boolean isConfigured = false;

    /* Creates a new instance of ComboSingleton */
    private cbConcepto() {
    }

    private static boolean loadComboList() {
        comboHash = new HashMap();

        try {
            ResultSet rs = UtileriasBDF.rsSQLNP("SELECT clAreaOperativa, dsAreaOperativa from cAreaOperativa order by clAreaOperativa ");
            while (rs.next()) {
                cbItemParent parentI = new cbItemParent();

                if (rs.getString("clAreaOperativa") == null || rs.getString("clAreaOperativa").length() == 0) {
                    parentI.setStrCod("");
                } else {
                    parentI.setStrCod(rs.getString("clAreaOperativa"));
                }

                if (rs.getString("dsAreaOperativa") == null || rs.getString("dsAreaOperativa").length() == 0) {
                    parentI.setStrDescripcion("");
                } else {
                    parentI.setStrDescripcion(rs.getString("dsAreaOperativa"));
                }

//                 ResultSet rsCH = UtileriasBDF.rsSQLNP("SELECT clConcepto,dsConcepto FROM cConceptoCosto Where clAreaOperativa= 1 Order by dsConcepto" );
//                 ResultSet rsCH = UtileriasBDF.rsSQLNP("select clConcepto, dsConcepto from cConceptoCosto order by dsConcepto " );
                ResultSet rsCH = UtileriasBDF.rsSQLNP("Select clConcepto, dsConcepto from cConceptoCosto where clAreaOperativa= " + parentI.getStrCod() + " order by dsConcepto ");


                List lstChildren = new ArrayList();
                while (rsCH.next()) {
                    cbItemChildren cbCH = new cbItemChildren();

                    if (rsCH.getString("clConcepto") == null || rsCH.getString("clConcepto").length() == 0) {
                        cbCH.setStrCod("");
                    } else {
                        cbCH.setStrCod(rsCH.getString("clConcepto"));
                    }

                    if (rsCH.getString("dsConcepto") == null || rsCH.getString("dsConcepto").length() == 0) {
                        cbCH.setStrDescripcion("");
                    } else {
                        cbCH.setStrDescripcion(rsCH.getString("dsConcepto"));
                    }

                    lstChildren.add(cbCH);

                }
                rsCH.close();
                rsCH = null;
                parentI.setLstChildren(lstChildren);
                comboHash.put(parentI.getStrCod(), parentI);
            }
            rs.close();
            rs = null;
        } catch (Exception e) {
            //System.out.print(e.getMessage());
            return false;
        } finally {
            //System.out.println("Entre a Load");
        }
        return true;
    }

    public static HashMap getComboHash() {
        if (isConfigured == false) {
            if (loadComboList()) {
                isConfigured = true;
            } else {
                isConfigured = false;
            }
        }
        return comboHash;
    }

    // 
    public static String GeneraHTML(int pSize, String pValue) {

        HashMap hshMap = cbConcepto.getComboHash();
        StringBuilder strHTML = new StringBuilder();

        int iLen = 0;
        Set set = hshMap.keySet();
        Iterator iT = set.iterator();
        cbItemParent cbParent = null;

        while (iT.hasNext()) {
            cbParent = (cbItemParent) hshMap.get(iT.next());
            strHTML.append("<option label='").append(cbParent.getStrDescripcion()).append("' value='").append(cbParent.getStrCod()).append("'");
            iLen = cbParent.getStrDescripcion().length();
            if (iLen > pSize) {
                iLen = pSize;
            }
            if (pValue != null) {
                if (pValue.equalsIgnoreCase(cbParent.getStrDescripcion()) == true) {
                    strHTML.append(" selected ");
                }
            }
            strHTML.append(" >").append(cbParent.getStrDescripcion().substring(0, iLen)).append("</option>");

        }
        return strHTML.toString();
    }

    public static void main(String args[]) {
    }
}
