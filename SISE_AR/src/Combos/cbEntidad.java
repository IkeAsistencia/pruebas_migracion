/*
 * cbEntidad.java
 *
 * Created on 26 de septiembre de 2005, 01:04 PM
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
public class cbEntidad {

    private static LinkedHashMap comboHash = null;
    private static boolean isConfigured = false;

    /* Creates a new instance of ComboSingleton */
    private cbEntidad() {
    }

    private synchronized static boolean loadComboList() {
        if (isConfigured == false) {
            comboHash = new LinkedHashMap();
            try {
                //ResultSet rs = UtileriasBDF.rsSQLNP("select CodEnt, dsEntFed from cEntFed order by dsEntfed");
                ResultSet rs = UtileriasBDF.rsSQLNP("select CodEnt, dsEntFed, coalesce(clPais,0) as clPais from cEntFed order by clPais,dsEntfed");

                while (rs.next()) {
                    Entidad entidadI = new Entidad();

                    if (rs.getString("CodEnt") == null || rs.getString("CodEnt").length() == 0) {
                        entidadI.setStrCodEnt("");
                    } else {
                        entidadI.setStrCodEnt(rs.getString("CodEnt"));
                    }

                    if (rs.getString("dsEntFed") == null || rs.getString("dsEntFed").length() == 0) {
                        entidadI.setStrDescription("");
                    } else {
                        entidadI.setStrDescription(rs.getString("dsEntFed"));
                    }

                    if (rs.getString("clPais") == null || rs.getString("clPais").length() == 0) {
                        entidadI.setClPais(0);
                    } else {
                        entidadI.setClPais(rs.getInt("clPais"));
                    }

                    ResultSet rsMD = UtileriasBDF.rsSQLNP("select CodMD, dsMunDel from cMunDel where CodEnt = '" + entidadI.getStrCodEnt() + "' order by dsMunDel");

                    List lstMunicipios = new ArrayList();
                    while (rsMD.next()) {
                        Municipio cbMD = new Municipio();

                        if (rsMD.getString("CodMD") == null || rsMD.getString("CodMD").length() == 0) {
                            cbMD.setStrCodMD("");
                        } else {
                            cbMD.setStrCodMD(rsMD.getString("CodMD"));
                        }

                        if (rsMD.getString("dsMunDel") == null || rsMD.getString("dsMunDel").length() == 0) {
                            cbMD.setStrDescripcion("");
                        } else {
                            cbMD.setStrDescripcion(rsMD.getString("dsMunDel"));
                        }

                        lstMunicipios.add(cbMD);

                    }
                    rsMD.close();
                    rsMD = null;

                    entidadI.setLstMunicipio(lstMunicipios);
                    comboHash.put(entidadI.getStrCodEnt(), entidadI);
                }
                rs.close();
                rs = null;
                isConfigured = true;
            } catch (Exception e) {
                System.out.print(e.getMessage());
                isConfigured = false;
                return false;
            } finally {
                System.out.println("Entre a Load");
            }
        }
        return true;
    }

  public static synchronized boolean altaLocalidadEnCache(String codEnt, String codMD, String dsMunDel){
    Entidad provincia = (Entidad)comboHash.get(codEnt);
    if (provincia == null)
    {
      System.out.println("cbEntidad.java.WARNING: Provincia No encontrada" + codEnt);
      return false;
    }
    System.out.println("cbEntidad.java: Provincia encontrada" + codEnt);
    

    Municipio localidad = new Municipio();
    localidad.setStrCodMD(codMD);
    localidad.setStrDescripcion(dsMunDel);
    
    System.out.println("Cantidad localidades:" + provincia.getLstMunicipio().size());
    provincia.getLstMunicipio().add(localidad);
    
    return true;
    }
    
    public static HashMap getComboHash() {
        loadComboList();
        return comboHash;
    }

    // 
    public static String GeneraHTML(int pSize, String pValue, int pPais) {

        HashMap hshMap = cbEntidad.getComboHash();
        StringBuffer strHTML = new StringBuffer();

        if (hshMap != null) {
            int iLen = 0;
            Set set = hshMap.keySet();
            Iterator iT = set.iterator();
            Entidad cbEntNode = null;

            while (iT.hasNext()) {
                cbEntNode = (Entidad) hshMap.get(iT.next());

                if (cbEntNode.getClPais() == (pPais)) {

                    strHTML.append("<option label='").append(cbEntNode.getStrDescription()).append("' value='").append(cbEntNode.getStrCodEnt()).append("'");
                    iLen = cbEntNode.getStrDescription().length();
                    if (iLen > pSize) {
                        iLen = pSize;
                    }
                    if (pValue != null) {
                        if (pValue.equalsIgnoreCase(cbEntNode.getStrDescription()) == true) {
                            strHTML.append(" selected ");
                        }
                    }
                    strHTML.append(" >").append(cbEntNode.getStrDescription().substring(0, iLen)).append("</option>");

                }// falta codificar combo vacio
            }

            if (strHTML.length() == 0) {
                //*Se llena el combo el datos predeterminado CodEnt = 25 para paises que no tienen entidades cargadas //
                System.out.println("pValue:" + pValue + " pPais:" + pPais);
                strHTML.append("<option value='25'");
                if (pValue.equalsIgnoreCase("EXTERIOR")) {
                    strHTML.append(" selected ");
                }
                strHTML.append(" >EXTERIOR </option>");
            }
        }
        return strHTML.toString();
    }

    public static String GeneraHTML(int pSize, String pValue) {

        HashMap hshMap = cbEntidad.getComboHash();
        StringBuffer strHTML = new StringBuffer();

        if (hshMap != null) {
            int iLen = 0;
            Set set = hshMap.keySet();
            Iterator iT = set.iterator();
            Entidad cbEntNode = null;

            while (iT.hasNext()) {
                cbEntNode = (Entidad) hshMap.get(iT.next());

                //if(cbEntNode.getClPais()==(10)){
                strHTML.append("<option label='").append(cbEntNode.getStrDescription()).append("' value='").append(cbEntNode.getStrCodEnt()).append("'");
                iLen = cbEntNode.getStrDescription().length();
                if (iLen > pSize) {
                    iLen = pSize;
                }
                if (pValue != null) {
                    if (pValue.equalsIgnoreCase(cbEntNode.getStrDescription()) == true) {
                        strHTML.append(" selected ");
                    }
                }
                strHTML.append(" >").append(cbEntNode.getStrDescription().substring(0, iLen)).append("</option>");

                //}// falta codificar combo vacio
            }

            if (strHTML.length() == 0) {
                //*Se llena el combo el datos predeterminado CodEnt = 25 para paises que no tienen entidades cargadas //
                strHTML.append("<option value='25' >EXTERIOR</option>");
            }
        }
        return strHTML.toString();
    }

    public static String GeneraHTMLMD(int pSize, String pCodEnt, String pdsMunDel) {

        Entidad hshObj = (Entidad) (cbEntidad.getComboHash().get(pCodEnt));
        StringBuffer strHTML = new StringBuffer();
        if (hshObj != null) {
            List tempList = hshObj.getLstMunicipio();
            if (tempList != null) {

                int x = 0;
                int xR = 1;
                int iLen = 0;
                if (tempList != null) {
                    for (x = 0; x < tempList.size(); x++, xR++) {
                        Municipio cbMunNode = (Municipio) tempList.get(x);
                        strHTML.append("<option label='").append(cbMunNode.getStrDescripcion()).append("' value='").append(cbMunNode.getStrCodMD()).append("'");
                        iLen = cbMunNode.getStrDescripcion().length();
                        if (iLen > pSize) {
                            iLen = pSize;
                        }
                        if (pdsMunDel != null) {
                            if (pdsMunDel.equalsIgnoreCase(cbMunNode.getStrDescripcion()) == true) {
                                strHTML.append(" selected ");
                            }
                        }
                        strHTML.append(" >").append(cbMunNode.getStrDescripcion().substring(0, iLen)).append("</option>");
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
