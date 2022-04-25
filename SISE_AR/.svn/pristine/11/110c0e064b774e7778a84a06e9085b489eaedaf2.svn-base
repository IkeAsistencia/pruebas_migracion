/*
 * cbAfianzadora.java
 *
 * Created on 30 de septiembre de 2005, 05:29 PM
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

public class cbProveedor {
    private static HashMap comboHash = null;
    private static boolean isConfigured = false;
    
    /* Creates a new instance of ComboSingleton */
    private cbProveedor()
    {
    }
    
    private static boolean loadComboList()
    {
         comboHash = new HashMap();
         
         try{
             
             ResultSet rs = UtileriasBDF.rsSQLNP("select clProveedor, NombreOpe from cProveedor where clTipoProveedor in (1,2,3,11) order by NombreOpe");
             while(rs.next())
             {
                 cbItemParent proveedorI = new cbItemParent();
                 
                 if(rs.getString("clProveedor") == null || rs.getString("clProveedor").length()==0)
                     proveedorI.setStrCod("");
                 else
                     proveedorI.setStrCod(rs.getString("clProveedor"));

                 if(rs.getString("NombreOpe") == null || rs.getString("NombreOpe").length()==0)
                     proveedorI.setStrDescripcion("");
                 else
                     proveedorI.setStrDescripcion(rs.getString("NombreOpe"));
                 
                 ResultSet rsCH = UtileriasBDF.rsSQLNP("select P.clPersonalxProv, P.Nombre from PersonalxProv P where clProveedor= " + proveedorI.getStrCod() + " order by P.Nombre " );
                 
                 List lstChildren = new ArrayList();
                 while(rsCH.next())
                 {
                    cbItemChildren cbCH = new cbItemChildren();                  
                    
                    if(rsCH.getString("clPersonalxProv") == null || rsCH.getString("clPersonalxProv").length()==0)
                         cbCH.setStrCod("");
                    else
                         cbCH.setStrCod(rsCH.getString("clPersonalxProv"));

                    if(rsCH.getString("Nombre") == null || rsCH.getString("Nombre").length()==0)
                         cbCH.setStrDescripcion("");
                    else
                         cbCH.setStrDescripcion(rsCH.getString("Nombre"));
                    
                    lstChildren.add(cbCH);

                 }
                 rsCH.close();
                 rsCH = null;
                 proveedorI.setLstChildren(lstChildren);
                 comboHash.put(proveedorI.getStrCod(),proveedorI);
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
             System.out.println("Entre a Load");
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

        HashMap hshMap=cbProveedor.getComboHash();
        StringBuffer strHTML = new StringBuffer();

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
        return strHTML.toString();
    }
    
    public static void main(String args[])
    {
    }
    
    
}
