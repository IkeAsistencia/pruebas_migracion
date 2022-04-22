/*
 * cbServicio.java
 *
 * Created on 30 de septiembre de 2005, 12:10 PM
 */

/*
 * cbServicio.java
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

public class cbServicio {
    private static HashMap comboHash = null;
    private static boolean isConfigured = false;
    
    /* Creates a new instance of ComboSingleton */
    private cbServicio()
    {
    }
    
    private static boolean loadComboList()
    {
         comboHash = new HashMap();
         
         try{
             
             ResultSet rs = UtileriasBDF.rsSQLNP("select clServicio, dsServicio from cServicio order by dsServicio");
             while(rs.next())
             {
                 Servicio ServicioI = new Servicio();
                 
                 if(rs.getString("clServicio") == null || rs.getString("clServicio").length()==0)
                     ServicioI.setStrclServicio("");
                 else
                     ServicioI.setStrclServicio(rs.getString("clServicio"));

                 if(rs.getString("dsServicio") == null || rs.getString("dsServicio").length()==0)
                     ServicioI.setStrdsServicio("");
                 else
                     ServicioI.setStrdsServicio(rs.getString("dsServicio"));
                 
                 ResultSet rsSub = UtileriasBDF.rsSQLNP("select clSubServicio, dsSubServicio from cSubServicio where clServicio= '" + ServicioI.getStrclServicio() + "' order by dsSubServicio " );
                 
                 List lstSubServicios = new ArrayList();
                 while(rsSub.next())
                 {
                    SubServicio cbSub = new SubServicio();                  
                    
                    if(rsSub.getString("clSubServicio") == null || rsSub.getString("clSubServicio").length()==0)
                         cbSub.setStrclSubServicio("");
                    else
                         cbSub.setStrclSubServicio(rsSub.getString("clSubServicio"));

                    if(rsSub.getString("dsSubServicio") == null || rsSub.getString("dsSubServicio").length()==0)
                         cbSub.setStrdsSubServicio("");
                    else
                         cbSub.setStrdsSubServicio(rsSub.getString("dsSubServicio"));
                    
                    lstSubServicios.add(cbSub);

                 }
                 rsSub.close();
                 rsSub = null;
                 ServicioI.setLstSubServicio(lstSubServicios);
                 comboHash.put(ServicioI.getStrclServicio(),ServicioI);
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

        HashMap hshMap=cbServicio.getComboHash();
        StringBuffer strHTML = new StringBuffer();

        int iLen=0;
        Set set = hshMap.keySet();
        Iterator iT = set.iterator();
        Servicio cbServ =null;
        
        while (iT.hasNext()){
            cbServ = (Servicio)hshMap.get(iT.next());
            strHTML.append("<option label='").append(cbServ.getStrdsServicio()).append("' value='").append(cbServ.getStrclServicio()).append("'");            
            iLen = cbServ.getStrdsServicio().length();
            if (iLen>pSize){iLen=pSize ;}
            if (pValue!=null){
                if (pValue.equalsIgnoreCase(cbServ.getStrdsServicio())==true){
                    strHTML.append(" selected ");
                }
            }
            strHTML.append(" >").append(cbServ.getStrdsServicio().substring(0,iLen)).append("</option>");
 
        }
        return strHTML.toString();
    }
    
    public static String GeneraHTMLSub(int pSize, String pCodServ, String pdsSubServ){

        Servicio hshObj = (Servicio)(cbServicio.getComboHash().get(pCodServ));        
        StringBuffer strHTML = new StringBuffer();        
        if (hshObj != null){
          List tempList=hshObj.getLstSubServicio();
          if (tempList !=null){
    
            int x=0;
            int xR = 1;
            int iLen = 0;
            if (tempList!=null){
                for(x=0; x<tempList.size(); x++, xR++)
                {
                    SubServicio cbSubServicioNode = (SubServicio)tempList.get(x);
                    strHTML.append("<option label='").append(cbSubServicioNode.getStrdsSubServicio()).append("' value='").append(cbSubServicioNode.getStrclSubServicio()).append("'");            
                    iLen = cbSubServicioNode.getStrdsSubServicio().length();
                    if (iLen>pSize){iLen=pSize ;}
                    if (pdsSubServ!=null){
                        if (pdsSubServ.equalsIgnoreCase(cbSubServicioNode.getStrdsSubServicio())==true){
                            strHTML.append(" selected ");
                        }
                    }
                    strHTML.append(" >").append(cbSubServicioNode.getStrdsSubServicio().substring(0,iLen)).append("</option>");
                }
            }
          }
        }
        return strHTML.toString();
    }

    public static void main(String args[])
    {
    }
    
    
}
