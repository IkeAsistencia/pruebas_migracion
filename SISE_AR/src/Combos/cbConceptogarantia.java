/*
 * cbConceptogarant�a.java
 *
 * Created on 20 de octubre de 2005, 01:31 PM
 *
 */

package Combos;

/*
 *
 * @author escobarm
 */
import java.util.HashMap;
import java.sql.ResultSet;
import Utilerias.UtileriasBDF;
import java.util.Iterator;
import java.util.Set;


public class cbConceptogarantia {
    private static HashMap comboHash = null;
    private static boolean isConfigured = false; 

    /* Creates a new instance of ComboSingleton */
    private cbConceptogarantia()
    {
    }
  
    private synchronized static boolean loadComboList()
    {
         if(isConfigured == false)
         {        
             comboHash = new HashMap();      
             try{
                 ResultSet rs = UtileriasBDF.rsSQLNP("SELECT clConceptoGarantia clLlave ,dsConceptoGarantia dsDesc FROM cConceptoGarantia order by dsConceptoGarantia");
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
                 isConfigured = true;
             }

             catch(Exception e)
             {
                 System.out.print(e.getMessage());
                 isConfigured = false;
                 return false;
             }
             finally
             {
                 System.out.println("Entre a Load de Concepto Garantia");
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

        HashMap hshMap=cbConceptogarantia.getComboHash();
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