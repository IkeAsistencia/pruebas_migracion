/*
 * cbInfoResguardada.java
 *
 * Created on 20 de octubre de 2005, 11:35 AM
 *
 * To change this template, choose Tools | Options and locate the template under
 * the Source Creation and Management node. Right-click the template and choose
 * Open. You can then make changes to the template in the Source Editor.
 */

package Combos;

import java.util.HashMap;
import java.sql.ResultSet;
import Utilerias.UtileriasBDF;
import java.util.Iterator;
import java.util.Set;

/*
 *
 * @author perezern
 */

public class cbInfoResguardada {
    private static HashMap comboHash = null;
    private static boolean isConfigured = false;
    
    /* Creates a new instance of ComboSingleton */
    private cbInfoResguardada()
    {
    }
    
    private synchronized static boolean loadComboList()
    {
      if(isConfigured == false)
      {
         comboHash = new HashMap();
         
         try{
             
             ResultSet rs = UtileriasBDF.rsSQLNP("SELECT clTipoInformacionResg clLlave, dsInformacion  dsDesc From cTipoInformacionResg Order by dsInformacion");
             while(rs.next())
             {
                 cbItemParent parentI = new cbItemParent();
                 
                 if(rs.getString("clLlave") == null || rs.getString("clLlave").length()==0)
                     parentI.setStrCod("");
                 else
                     parentI.setStrCod(rs.getString("clLlave"));

                 if(rs.getString("dsDesc") == null || rs.getString("dsDesc").length()==0)
                     parentI.setStrDescripcion("");
                 else
                     parentI.setStrDescripcion(rs.getString("dsDesc"));
                 
                 comboHash.put(parentI.getStrCod(),parentI);
             }
             rs.close();
             isConfigured = true;
             rs = null;
         }
             
         catch(Exception e)
         {
             System.out.print(e.getMessage());
             isConfigured = false;
             return false;
         }
         finally
         {
             System.out.println("Entre a Load de Estatus de Tipo de Información");
         }
      }
         return true;
    }
    
    public static HashMap getComboHash()
    {
        loadComboList();
        return comboHash;
    }
    
    // 
    public static String GeneraHTML(int pSize, String pValue){

        HashMap hshMap=cbInfoResguardada.getComboHash();
        StringBuffer strHTML = new StringBuffer();
        if (hshMap!=null){
        int iLen=0;
        Set set = hshMap.keySet();
        Iterator iT = set.iterator();
        cbItemParent cbParent =null;
        
        while (iT.hasNext()){
            cbParent = (cbItemParent)hshMap.get(iT.next());
            strHTML.append("<option label='").append(cbParent.getStrDescripcion()).append("' value='").append(cbParent.getStrCod()).append("'");            
            iLen = cbParent.getStrDescripcion().length();
            if (iLen>pSize){iLen=pSize ;}
            if (pValue!=null){
                if (pValue.equalsIgnoreCase(cbParent.getStrDescripcion())==true){
                    strHTML.append(" selected ");
                }
            }
            strHTML.append(" >").append(cbParent.getStrDescripcion().substring(0,iLen)).append("</option>");
 
            }
        }
        return strHTML.toString();
    }
    
    public static void main(String args[])
    {
    }
    public static void reLoad(){
        isConfigured=false;
    }
    
}
