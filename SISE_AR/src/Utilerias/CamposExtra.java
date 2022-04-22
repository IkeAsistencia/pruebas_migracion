package Utilerias;

import java.sql.ResultSet;
import javax.servlet.http.HttpSession;

public class CamposExtra 
{

  private CamposExtra(){}  
  
  public static StringBuffer strGetCamposExtraHTML(UtileriasObj pMyUtil, String strclCuenta, String StrclSubservicio, HttpSession session, int iX, int iY, ResultSet rs)
  {

      ResultSet rsCampos = null;
      StringBuffer strHTMLReturn = new StringBuffer();
      StringBuffer strCmp = new StringBuffer();
      rsCampos = UtileriasBDF.rsSQLNP("sp_GetCamposExtraxCta '" + strclCuenta  + "','" + StrclSubservicio + "'");
      int iPosIni=0;
      int iPosEnd=0;
      int iC=0;
      StringBuffer strParam = new StringBuffer();
      try{
          while (rsCampos.next()){ 
          
          // Obtiene par�metros para secuencia de base de datos en caso de combos
                strCmp.append(rsCampos.getString("Param"));

                iPosIni = 0;
                iPosEnd = 0;
                if (strCmp.toString().equalsIgnoreCase("")==false){
                    iC=0;
                    iPosIni = strCmp.indexOf("$",iPosIni);
                    iPosEnd = strCmp.indexOf(",",iPosIni);
                    
                    //Máximo número de filtros es 10, se hace por protección de que no se vaya a generar
                    //algún problema de variable y resulte que el valor de iPosIni se pierda y se ejecute 
                    //el while infinitamente causando que se pasme el equipo.

                    while (iPosIni>=0 && iC<10){
                        if (iPosEnd<0){
                            iPosEnd = strCmp.length();
                        }
                        
                        if (iPosIni>=0){
                            if (strParam.length()>0){
                                strParam.append("','");
                            }else{
                                strParam.append("'");
                            }
                            if(session.getAttribute(strCmp.substring(iPosIni+1, iPosEnd))!=null){
                                if (session.getAttribute(strCmp.substring(iPosIni+1, iPosEnd)).toString()==null){
                                    strParam.append("0");
                                } else {
                                    strParam.append(session.getAttribute(strCmp.substring(iPosIni+1, iPosEnd)).toString());
                                }
                            }else{
                                strParam.append("0");
                            }
                            if (iPosEnd==strCmp.length()){
                                strCmp.delete(0,strCmp.length());
                            } else {
                                strCmp.delete(0,strCmp.length()).append(strCmp.substring(iPosEnd+1, strCmp.length()));
                            }
                            strParam.append("'");
                        } else {
                            iPosIni=iPosEnd;
                        }
                        iPosIni = strCmp.indexOf("$",iPosIni);
                        iPosEnd = strCmp.indexOf(",",iPosIni);
                        iC++;
                    }
                }
                
          // Genera un objeto tipo por cada campo extra
                if (rs.getRow()>0) {
                     rs.first();
                     switch(rsCampos.getInt("clTipoObjeto")){
                          case 1: // InputText %>
                              strHTMLReturn.append(pMyUtil.ObjInput(rsCampos.getString("Titulo"),rsCampos.getString("Nombre"),rs.getString(rsCampos.getString("ValorRef").trim()),rsCampos.getBoolean("EditAlta"),rsCampos.getBoolean("EditCambio"),iX,iY,"",rsCampos.getBoolean("ReqAlta"),rsCampos.getBoolean("ReqCambio"),rsCampos.getInt("tSize")));
                              break;
                              
                          case 2: // Combo %>
                              strHTMLReturn.append(pMyUtil.ObjComboC(rsCampos.getString("Titulo"),rsCampos.getString("Nombre"),rs.getString(rsCampos.getString("ValorRef")),rsCampos.getBoolean("EditAlta"),rsCampos.getBoolean("EditCambio"),iX,iY,"",rsCampos.getString("SentenciaSQL") + " " + strParam.toString(),"","",rsCampos.getInt("tSize"),rsCampos.getBoolean("ReqAlta"),rsCampos.getBoolean("ReqCambio")));
                              break;
                             
                          default: 
                              break;
                     }
                     iY+=40;
                }
                else{
                     switch(rsCampos.getInt("clTipoObjeto")){
                          case 1: 
                              // InputText %>
                              strHTMLReturn.append(pMyUtil.ObjInput(rsCampos.getString("Titulo"),rsCampos.getString("Nombre"),"",rsCampos.getBoolean("EditAlta"),rsCampos.getBoolean("EditCambio"),iX,iY,"",rsCampos.getBoolean("ReqAlta"),rsCampos.getBoolean("ReqCambio"),rsCampos.getInt("tSize")));
                              break;
                
                          case 2:
                              // Combo %>
                              strHTMLReturn.append(pMyUtil.ObjComboC(rsCampos.getString("Titulo"),rsCampos.getString("Nombre"),"",rsCampos.getBoolean("EditAlta"),rsCampos.getBoolean("EditCambio"),iX,iY,"",rsCampos.getString("SentenciaSQL") + " " + strParam.toString(),"","",rsCampos.getInt("tSize"),rsCampos.getBoolean("ReqAlta"),rsCampos.getBoolean("ReqCambio")));
                
                              break;
                              default: 
                              break;
                     }
                     iY+=40;
                 } 
             strParam.delete(0,strParam.length());
          // Fin: Genera un objeto tipo por cada campo extra
          }
           rsCampos.close();
           rsCampos = null;
      }
      catch(Exception e)
      {
        if (rsCampos!=null)
        {
          try{
            rsCampos.close();
            rsCampos=null;
          }catch(Exception ee)
          {
            ee.printStackTrace();
          }
        }
        e.printStackTrace();
      }
      finally
      {
        if (rsCampos!=null)
        {
          try{
            rsCampos.close();
            rsCampos=null;
          }catch(Exception ee)
          {
            ee.printStackTrace();
          }
        }
      }
      return strHTMLReturn;
  }
}