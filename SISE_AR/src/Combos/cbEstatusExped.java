package Combos;

import java.util.HashMap;
import java.sql.ResultSet;
import Utilerias.UtileriasBDF;
import java.util.Iterator;
import java.util.Set;

/*
 *
 * @author  cabrerar
 */

public class cbEstatusExped {
    private static HashMap comboHash = null;
    private static boolean isConfigured = false;
    
    /* Creates a new instance of ComboSingleton */
    private cbEstatusExped()
    {
    }
    
    private static boolean loadComboList()
    {
         comboHash = new HashMap();
         
         try{
             ResultSet rs = UtileriasBDF.rsSQLNP("SELECT clEstatus clLlave ,dsEstatus dsDesc FROM cEstatus where TipoEstatus in(1,2,4,6) ORDER BY dsEstatus");
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
             rs = null;
         }
             
         catch(Exception e)
         {
             System.out.print(e.getMessage());
             return false;
         }
         finally
         {
             System.out.println("Entre a Load de Estatus de Expediente para Filtro");
         }
         return true;
    }
    
    public static HashMap getComboHash()
    {
        if(isConfigured == false)
        {
            if(loadComboList())
            isConfigured = true;
            else
            isConfigured = false;    
        }
        return comboHash;
    }
    
    // 
    public static String GeneraHTML(int pSize, String pValue){

        HashMap hshMap=cbEstatusExped.getComboHash();
        StringBuffer strHTML = new StringBuffer();

        if (hshMap !=null){
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
    
    
}
