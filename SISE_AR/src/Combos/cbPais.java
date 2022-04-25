/*
 * cbPais.java
 *
 * Created on 30 de septiembre de 2005, 02:30 PM
 */
package Combos;

/*
 *
 * @author  cabrerar
 */
import java.util.LinkedHashMap;
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
public class cbPais {

    private static HashMap comboHash = null;
    private static boolean isConfigured = false;

    /* Creates a new instance of ComboSingleton */
    private cbPais() {
    }

    private static boolean loadComboList() {
        comboHash = new LinkedHashMap();

        try {

            ResultSet rs = UtileriasBDF.rsSQLNP("select clPais, dsPais from cPais order by dsPais");

            while (rs.next()) {
                Pais paisI = new Pais();

                if (rs.getString("clPais") == null || rs.getString("clPais").length() == 0) {
                    paisI.setStrclPais("");
                } else {
                    paisI.setStrclPais(rs.getString("clPais"));
                }

                if (rs.getString("dsPais") == null || rs.getString("dsPais").length() == 0) {
                    paisI.setStrdsPais("");
                } else {
                    paisI.setStrdsPais(rs.getString("dsPais"));
                }

                //ResultSet rsCH = UtileriasBDF.rsSQLNP("select clCiudad, dsCiudad from cCiudad where clPais = " + paisI.getStrclPais() + " order by dsCiudad " );
                ResultSet rsCH = UtileriasBDF.rsSQLNP("select c.clCiudad, c.dsCiudad from cCiudad C inner join cPais P on P.clPais = C.clPais where c.clPais = " + paisI.getStrclPais() + " order by c.dsCiudad ");

                List lstChildren = new ArrayList();
                while (rsCH.next()) {
                    Ciudad cbCH = new Ciudad();

                    if (rsCH.getString("clCiudad") == null || rsCH.getString("clCiudad").length() == 0) {
                        cbCH.setStrclCiudad("");
                    } else {
                        cbCH.setStrclCiudad(rsCH.getString("clCiudad"));
                    }

                    if (rsCH.getString("dsCiudad") == null || rsCH.getString("dsCiudad").length() == 0) {
                        cbCH.setStrdsCiudad("");
                    } else {
                        cbCH.setStrdsCiudad(rsCH.getString("dsCiudad"));
                    }

                    lstChildren.add(cbCH);

                }
                rsCH.close();
                rsCH = null;
                paisI.setLstCiudad(lstChildren);
                comboHash.put(paisI.getStrclPais(), paisI);
            }
            rs.close();
            rs = null;
        } catch (Exception e) {
            System.out.print(e.getMessage());
            return false;
        } finally {
            System.out.println("Entre a Load");
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

        HashMap hshMap = cbPais.getComboHash();
        StringBuffer strHTML = new StringBuffer();

        int iLen = 0;
        Set set = hshMap.keySet();
        Iterator iT = set.iterator();
        Pais cbParent = null;

        while (iT.hasNext()) {
            cbParent = (Pais) hshMap.get(iT.next());
            strHTML.append("<option label='").append(cbParent.getStrdsPais()).append("' value='").append(cbParent.getStrclPais()).append("'");
            iLen = cbParent.getStrdsPais().length();
            if (iLen > pSize) {
                iLen = pSize;
            }
            if (pValue != null) {
                if (pValue.equalsIgnoreCase(cbParent.getStrdsPais()) == true) {
                    strHTML.append(" selected ");
                }
            }
            strHTML.append(" >").append(cbParent.getStrdsPais().substring(0, iLen)).append("</option>");

        }
        //System.out.println("qry: " + strHTML.toString());
        return strHTML.toString();
    }

    public static String GeneraHTMLCD(int pSize, String pclPais, String pdsCiudad) {

        Pais hshObj = (Pais) (cbPais.getComboHash().get(pclPais));
        StringBuffer strHTML = new StringBuffer();
        if (hshObj != null) {
            List tempList = hshObj.getLstCiudad();
            if (tempList != null) {

                int x = 0;
                int xR = 1;
                int iLen = 0;
                if (tempList != null) {
                    for (x = 0; x < tempList.size(); x++, xR++) {
                        Ciudad cbCDNode = (Ciudad) tempList.get(x);
                        strHTML.append("<option label='").append(cbCDNode.getStrdsCiudad()).append("' value='").append(cbCDNode.getStrclCiudad()).append("'");
                        iLen = cbCDNode.getStrdsCiudad().length();
                        if (iLen > pSize) {
                            iLen = pSize;
                        }
                        if (pdsCiudad != null) {
                            if (pdsCiudad.equalsIgnoreCase(cbCDNode.getStrdsCiudad()) == true) {
                                strHTML.append(" selected ");
                            }
                        }
                        strHTML.append(" >").append(cbCDNode.getStrdsCiudad().substring(0, iLen)).append("</option>");
                    }
                }
            }
        }
        return strHTML.toString();
    }

    public static void main(String args[]) {
    }
}
