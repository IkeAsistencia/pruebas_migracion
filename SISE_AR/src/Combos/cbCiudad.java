/*
 * cbCiudad.java
 *
 * Created on 4 de octubre de 2006, 01:05 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package Combos;

import java.util.List;
import java.util.HashMap;
import java.util.ArrayList;
import java.sql.ResultSet;
import Utilerias.UtileriasBDF;
import java.util.Iterator;
import java.util.Set;

/*
 *
 * @author cabrerar
 */

public class cbCiudad {
    private static HashMap comboHash = null;
    private static boolean isConfigured = false;
    
    /* Creates a new instance of ComboSingleton */
    private cbCiudad()
    {
    }
    
    private static boolean loadComboList()
    {
         comboHash = new HashMap();
         
         try{
             
             ResultSet rs = UtileriasBDF.rsSQLNP("select clCiudad, dsCiudad from cCiudad order by dsCiudad");
             while(rs.next())
             {
                 Ciudad CiudadI = new Ciudad();
                 
                 if(rs.getString("clCiudad") == null || rs.getString("clCiudad").length()==0)
                     CiudadI.setStrclCiudad("");
                 else
                     CiudadI.setStrclCiudad(rs.getString("clCiudad"));

                 if(rs.getString("dsCiudad") == null || rs.getString("dsCiudad").length()==0)
                     CiudadI.setStrdsCiudad("");
                 else
                     CiudadI.setStrdsCiudad(rs.getString("dsCiudad"));
                 
                 ResultSet rsZ = UtileriasBDF.rsSQLNP("select clZona, dsZona from CScZona where clCiudad = " + CiudadI.getStrclCiudad() + " order by dsZona " );
                   
                 List lstZonasConcierge = new ArrayList();
                 while(rsZ.next())
                   {
                      CScZona cbZ = new CScZona();                  
                      
                      if(rsZ.getString("clZona") == null || rsZ.getString("dsZona").length()==0)
                           cbZ.setClZona(0);
                      else
                           cbZ.setClZona(rsZ.getInt("clZona"));
  
                      if(rsZ.getString("dsZona") == null || rsZ.getString("dsZona").length()==0)
                           cbZ.setDsZona("");
                      else
                           cbZ.setDsZona(rsZ.getString("dsZona"));
                      
                      lstZonasConcierge.add(cbZ);
  
                   }
                 rsZ.close();
                 rsZ = null;
                 
                 CiudadI.setLstZonasConcierge(lstZonasConcierge);
                 comboHash.put(CiudadI.getStrclCiudad(),CiudadI);
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

        HashMap hshMap=cbCiudad.getComboHash();
        StringBuffer strHTML = new StringBuffer();

        int iLen=0;
        Set set = hshMap.keySet();
        Iterator iT = set.iterator();
        Ciudad cbCiudad =null;
        
        while (iT.hasNext()){
            cbCiudad = (Ciudad)hshMap.get(iT.next());
            strHTML.append("<option label='").append(cbCiudad.getStrdsCiudad()).append("' value='").append(cbCiudad.getStrclCiudad()).append("'");            
            iLen = cbCiudad.getStrdsCiudad().length();
            if (iLen>pSize){iLen=pSize ;}
            if (pValue!=null){
                if (pValue.equalsIgnoreCase(cbCiudad.getStrdsCiudad())==true){
                    strHTML.append(" selected ");
                }
            }
            strHTML.append(" >").append(cbCiudad.getStrdsCiudad().substring(0,iLen)).append("</option>");
 
        }
        return strHTML.toString();
    }
    
    public static String GeneraHTMLZ(int pSize, String pclCiudad, String pdsZona){

        Ciudad hshObj = (Ciudad)(cbCiudad.getComboHash().get(pclCiudad));        
        StringBuffer strHTML = new StringBuffer();        
        if (hshObj != null){
          List tempList=hshObj.getLstZonasConcierge();
          if (tempList !=null){
    
            int x=0;
            int xR = 1;
            int iLen = 0;
            if (tempList!=null){
                for(x=0; x<tempList.size(); x++, xR++)
                {
                    CScZona cbZonaNode = (CScZona)tempList.get(x);
                    strHTML.append("<option label='").append(cbZonaNode.getDsZona()).append("' value='").append(cbZonaNode.getClZona()).append("'");            
                    iLen = cbZonaNode.getDsZona().length();
                    if (iLen>pSize){iLen=pSize ;}
                    if (pdsZona!=null){
                        if (pdsZona.equalsIgnoreCase(cbZonaNode.getDsZona())==true){
                            strHTML.append(" selected ");
                        }
                    }
                    strHTML.append(" >").append(cbZonaNode.getDsZona().substring(0,iLen)).append("</option>");
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
