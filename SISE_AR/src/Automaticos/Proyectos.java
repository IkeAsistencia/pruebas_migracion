/*
 * Proyectos.java
 *
 * Created on 10 de enero de 2005, 05:35 PM
 */

/*
 *
 * @author  colinj
 */

package Automaticos;

import java.sql.ResultSet;
import Utilerias.UtileriasBDF;

public class Proyectos {
    
    /* Creates a new instance of Proyectos */
    
    static   ResultSet rs = null;    
    static   String strDatos = null;
    Proceso[]  pr = null; 
    int j = 1;
    
    public ResultSet ObtieneProyecto(){
            return  UtileriasBDF.rsSQLNP("select * from T_ProyectoMail where EsProcesoAutomatico = 1");
    }
    
    public void ProcesaProyecto(){
       rs = this.ObtieneProyecto(); 
       try{
           while (rs.next()){
               pr[j] = new Proceso();
               if (rs.getInt("LlevaParametros") == 1){
                      strDatos = this.ArmaQuery(rs.getInt("clProyecto"));
               }else{
                   strDatos = rs.getString("StoreProc");
               }
               pr[j].setNumproceso(rs.getInt("clProyecto"));
               pr[j].setNombre(rs.getString("Subject"));
               pr[j].setStatus("Sin Procesar");
               pr[j].setHorario(rs.getString("horario"));
               pr[j].setStoreProcedure(strDatos);
               j += 1;
           }
       }catch(Exception e){
           e.getMessage();
       }
    }    
   
    public String ArmaQuery(int numProyecto){
        String sp = "";
        ResultSet rsParam = null;
        ResultSet rsTem  = null;
        try{
            sp = rs.getString("StoreProc");
            int clUltimo = 0;
            int i = 0;

            rsParam = UtileriasBDF.rsSQLNP("Select * from Parametros where clProyecto = " + numProyecto );
            rsTem = rsParam;
            rsTem.last();
            clUltimo = rsTem.getInt("clParametro");

            while (rsParam.next()){
               if (rsParam.getString("tipo").equalsIgnoreCase("Fecha")){

                   sp = sp + "'" + UtileriasBDF.rsSQLNP(" select getdate() + (" + rsParam.getString("Valor") + ") fecha").getString("fecha").substring(1,rsParam.getInt("Longitud")) + "'";
               }else {
                   if (rsParam.getString("tipo").equalsIgnoreCase("Cadena")){
                       sp = sp + "'" + rsParam.getString("Valor") +  "'";
                   }else{
                       sp = sp + " getdate() + (" + rsParam.getString("Valor") + ")";
                   }    
               }

               if (i > 0) { 
                  if ( clUltimo != rsParam.getInt("clParametro")) {
                      sp = sp + ",";
                  }
               }
               i += 1;
            }
        }catch(Exception e){
            e.getMessage();
        }
        return sp;
    }
}