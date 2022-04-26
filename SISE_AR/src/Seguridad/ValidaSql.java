/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Seguridad;

import java.util.ArrayList;

/**
 *
 * @author jesmoreno
 */
public class ValidaSql {
    private static ArrayList matriz=null;
    
    private static void  initMatriz(){
        if(matriz==null){
            matriz=new ArrayList();
            matriz.add("waitfor");
            matriz.add("delay");
            matriz.add("select");
            matriz.add("insert");
            matriz.add("into");
            matriz.add("values");
            matriz.add("delete");
            matriz.add("update");
            matriz.add("drop");
            matriz.add("exec");
            matriz.add("execute");
            matriz.add("procedure");
            matriz.add("truncate");
            matriz.add("create");
            matriz.add("from");
            matriz.add("alter");
            matriz.add("'"); //DEVIDO A QUE SI!, SE RESIVEN PARAMETROS CON COMILLAS POR EJEMPLO 'hola' o '1-2,1-3' que se separa en sql
//            matriz.add("\"");
            matriz.add("<");
            matriz.add(">");
            matriz.add("--");
            matriz.add("openrowset");
            matriz.add("sp_executesql");
            matriz.add("sysadmin");
            matriz.add("xp_cmdshell");
            matriz.add("xp_regread");
            matriz.add("xp_regwrite");
            matriz.add("sp_makewebtask");
            matriz.add("sp_configure");
            matriz.add("xp_sendmail");
            matriz.add("@@version");
            matriz.add(";");
            matriz.add("javascript");
            System.out.println("init");
        }
    }
    public static String limpiaSql(String arg){
        initMatriz();
        String cadena=arg;
        if(arg!=null){
            for (int i = 0; i < matriz.size(); i++) {
                 cadena = cadena.replaceAll("(?i)"+matriz.get(i).toString(),"");
            }
         }
        return cadena;
    }
    public static void main(String arg[]){
        System.out.println(limpiaSql(" aCREatea openrowset 'hola'")); 
          System.out.println(limpiaSql(" aCREatea @@VERSION 'hola'")); 
            System.out.println(limpiaSql(" aCREatea procces 'hola'")); 
    }
}