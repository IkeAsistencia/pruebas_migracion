/*
 * cbCSReferencia.java
 *
 * Created on 7 de septiembre de 2006, 06:53 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */
package Combos;

/*
 *
 * @author cabrerar
 */
import java.util.List;
import java.util.HashMap;
import java.util.ArrayList;
import java.sql.ResultSet;
import Utilerias.UtileriasBDF;
import java.util.Iterator;
import java.util.Set;

public class cbCSReferencia {

    private static HashMap comboHash = null;
    private static boolean isConfigured = false;

    /* Creates a new instance of cbCSReferencia */
    public cbCSReferencia() {
    }

    private synchronized static boolean loadComboList() {
        if (isConfigured == false) {
            comboHash = new HashMap();
            try {
                ResultSet rs = UtileriasBDF.rsSQLNP("select clCategoria, dsCategoria from CScCategoria order by dsCategoria ");
                while (rs.next()) {
                    CSCategoria CSCategoriaI = new CSCategoria();

                    if (rs.getString("clCategoria") == null || rs.getString("clCategoria").length() == 0) {
                        CSCategoriaI.setClCategoria("");
                    } else {
                        CSCategoriaI.setClCategoria(rs.getString("clCategoria"));
                    }

                    if (rs.getString("dsCategoria") == null || rs.getString("dsCategoria").length() == 0) {
                        CSCategoriaI.setDescripcion("");
                    } else {
                        CSCategoriaI.setDescripcion(rs.getString("dsCategoria"));
                    }

                    ResultSet rsSUB = UtileriasBDF.rsSQLNP("select clSubCategoria, substring(dsSubCategoria,1,30) dsSubCategoria from CScSubCategoria where clCategoria = '" + CSCategoriaI.getClCategoria() + "' order by dsSubCategoria");

                    List lstSubCategoria = new ArrayList();
                    while (rsSUB.next()) {
                        CSSubCategoria CSSubCategoriaI = new CSSubCategoria();

                        if (rsSUB.getString("clSubCategoria") == null || rsSUB.getString("clSubCategoria").length() == 0) {
                            CSSubCategoriaI.setClSubCategoria("");
                        } else {
                            CSSubCategoriaI.setClSubCategoria(rsSUB.getString("clSubCategoria"));
                        }

                        if (rsSUB.getString("dsSubCategoria") == null || rsSUB.getString("dsSubCategoria").length() == 0) {
                            CSSubCategoriaI.setDescripcion("");
                        } else {
                            CSSubCategoriaI.setDescripcion(rsSUB.getString("dsSubCategoria"));
                        }

                        lstSubCategoria.add(CSSubCategoriaI);

                    }
                    rsSUB.close();
                    rsSUB = null;
                    CSCategoriaI.setLstSubCategoria(lstSubCategoria);
                    comboHash.put(CSCategoriaI.getClCategoria(), CSCategoriaI);
                }
                rs.close();
                rs = null;
                isConfigured = true;
            } catch (Exception e) {
                System.out.print(e.getMessage());
                isConfigured = false;
                return false;
            } finally {
                System.out.println("Entre a Load de Categorías");
            }
        }
        return true;
    }

    public static HashMap getComboHash() {
        loadComboList();
        return comboHash;
    }

    // 
    public static String GeneraHTML(int pSize, String pValue) {

        HashMap hshMap = cbCSReferencia.getComboHash();
        StringBuffer strHTML = new StringBuffer();
        if (hshMap != null) {
            int iLen = 0;
            Set set = hshMap.keySet();
            Iterator iT = set.iterator();
            CSCategoria cbNode = null;

            while (iT.hasNext()) {
                cbNode = (CSCategoria) hshMap.get(iT.next());
                strHTML.append("<option label='").append(cbNode.getDescripcion()).append("' value='").append(cbNode.getClCategoria()).append("'");
                iLen = cbNode.getDescripcion().length();
                if (iLen > pSize) {
                    iLen = pSize;
                }
                if (pValue != null) {
                    if (pValue.equalsIgnoreCase(cbNode.getDescripcion()) == true) {
                        strHTML.append(" selected ");
                    }
                }
                strHTML.append(" >").append(cbNode.getDescripcion().substring(0, iLen)).append("</option>");

            }
        }
        return strHTML.toString();
    }

    public static String GeneraHTMLMD(int pSize, String pclCategoria, String pdsSubCategoria) {

        CSCategoria hshObj = (CSCategoria) (cbCSReferencia.getComboHash().get(pclCategoria));
        StringBuffer strHTML = new StringBuffer();
        if (hshObj != null) {
            List tempList = hshObj.getLstSubCategoria();
            if (tempList != null) {

                int x = 0;
                int xR = 1;
                int iLen = 0;
                if (tempList != null) {
                    for (x = 0; x < tempList.size(); x++, xR++) {
                        CSSubCategoria cbCSSubCategoria = (CSSubCategoria) tempList.get(x);
                        strHTML.append("<option label='").append(cbCSSubCategoria.getDescripcion()).append("' value='").append(cbCSSubCategoria.getClSubCategoria()).append("'");
                        iLen = cbCSSubCategoria.getDescripcion().length();
                        if (iLen > pSize) {
                            iLen = pSize;
                        }
                        if (pdsSubCategoria != null) {
                            if (pdsSubCategoria.equalsIgnoreCase(cbCSSubCategoria.getDescripcion()) == true) {
                                strHTML.append(" selected ");
                            }
                        }
                        strHTML.append(" >").append(cbCSSubCategoria.getDescripcion().substring(0, iLen)).append("</option>");
                    }
                }
            }
        }
        return strHTML.toString();
    }

    public static void main(String args[]) {
    }

    public static void reLoad() {
        isConfigured = false;
    }
}
