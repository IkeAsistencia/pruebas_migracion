/*
 * cbAMIS.java
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
import java.util.LinkedHashMap;
import java.util.Set;

public class cbAMIS {

    private static LinkedHashMap comboHash = null;
    private static boolean isConfigured = false;

    /* Creates a new instance of ComboSingleton */
    private cbAMIS() {
    }

    private synchronized static boolean loadComboList() {

        if (isConfigured == false) {
            comboHash = new LinkedHashMap();
            try {
                ResultSet rs = UtileriasBDF.rsSQLNP("select CodigoMarca, dsMarcaAuto from cMarcaAuto order by dsMarcaAuto");
                while (rs.next()) {
                    MarcaAuto MarcaAutoI = new MarcaAuto();

                    if (rs.getString("CodigoMarca") == null || rs.getString("CodigoMarca").length() == 0) {
                        MarcaAutoI.setStrCodMarca("");
                    } else {
                        MarcaAutoI.setStrCodMarca(rs.getString("CodigoMarca"));
                    }
                    if (rs.getString("dsMarcaAuto") == null || rs.getString("dsMarcaAuto").length() == 0) {
                        MarcaAutoI.setStrDescripcion("");
                    } else {
                        MarcaAutoI.setStrDescripcion(rs.getString("dsMarcaAuto"));
                    }
                    ResultSet rsTA = UtileriasBDF.rsSQLNP("select clTipoAuto, dsTipoAuto, ClaveAMIS from cTipoAuto where CodigoMarca = '" + MarcaAutoI.getStrCodMarca() + "' order by dsTipoAuto ");

                    List lstTipoAuto = new ArrayList();
                    while (rsTA.next()) {
                        TipoAuto cbTA = new TipoAuto();

                        if (rsTA.getString("clTipoAuto") == null || rsTA.getString("clTipoAuto").length() == 0) {
                            cbTA.setStrclTipoAuto("");
                        } else {
                            cbTA.setStrclTipoAuto(rsTA.getString("clTipoAuto"));
                        }
                        if (rsTA.getString("dsTipoAuto") == null || rsTA.getString("dsTipoAuto").length() == 0) {
                            cbTA.setStrDescripcion("");
                        } else {
                            cbTA.setStrDescripcion(rsTA.getString("dsTipoAuto"));
                        }
                        if (rsTA.getString("ClaveAMIS") == null || rsTA.getString("ClaveAMIS").length() == 0) {
                            cbTA.setStrAMIS("");
                        } else {
                            cbTA.setStrAMIS(rsTA.getString("ClaveAMIS"));
                        }
                        lstTipoAuto.add(cbTA);

                    }
                    rsTA.close();
                    rsTA = null;
                    MarcaAutoI.setLstTipoAuto(lstTipoAuto);
                    comboHash.put(MarcaAutoI.getStrCodMarca(), MarcaAutoI);
                }
                rs.close();
                rs = null;
                isConfigured = true;
            } catch (Exception e) {
                isConfigured = false;
                System.out.print(e.getMessage());
                return false;
            } finally {
                //System.out.println("Entre a Load");
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

        LinkedHashMap hshMap = (LinkedHashMap) cbAMIS.getComboHash();
        StringBuffer strHTML = new StringBuffer();

        if (hshMap != null) {
            int iLen = 0;
            Set set = hshMap.keySet();
            Iterator iT = set.iterator();
            MarcaAuto cbMA = null;

            while (iT.hasNext()) {
                cbMA = (MarcaAuto) hshMap.get(iT.next());
                strHTML.append("<option label='").append(cbMA.getStrDescripcion()).append("' value='").append(cbMA.getStrCodMarca()).append("'");
                iLen = cbMA.getStrDescripcion().length();
                if (iLen > pSize) {
                    iLen = pSize;
                }
                if (pValue != null) {
                    if (pValue.equalsIgnoreCase(cbMA.getStrDescripcion()) == true) {
                        strHTML.append(" selected ");
                    }
                }
                strHTML.append(" >").append(cbMA.getStrDescripcion().substring(0, iLen)).append("</option>");
            }
        }
        return strHTML.toString();
    }

    public static String GeneraHTMLTA(int pSize, String pCodigoMarca, String pdsAMIS) {

        MarcaAuto hshObj = (MarcaAuto) (cbAMIS.getComboHash().get(pCodigoMarca));
        StringBuffer strHTML = new StringBuffer();
        if (hshObj != null) {
            List tempList = hshObj.getLstTipoAuto();
            if (tempList != null) {

                int x = 0;
                int xR = 1;
                int iLen = 0;
                if (tempList != null) {
                    for (x = 0; x < tempList.size(); x++, xR++) {
                        TipoAuto cbTANode = (TipoAuto) tempList.get(x);
                        strHTML.append("<option label='").append(cbTANode.getStrDescripcion()).append("' value='").append(cbTANode.getStrAMIS()).append("'");
                        iLen = cbTANode.getStrDescripcion().length();
                        if (iLen > pSize) {
                            iLen = pSize;
                        }
                        if (pdsAMIS != null) {
                            if (pdsAMIS.equalsIgnoreCase(cbTANode.getStrAMIS()) == true) {
                                strHTML.append(" selected ");
                            }
                        }
                        strHTML.append(" >").append(cbTANode.getStrDescripcion().substring(0, iLen)).append("</option>");
                    }
                }
            }
        }
        return strHTML.toString();
    }

    public static void reLoad() {
        isConfigured = false;
    }

    public static void main(String args[]) {
    }
}
