/*
 * Internacionalizacion.java
 *
 * Created on 5 de enero de 2007, 09:42 AM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package com.ike.util;

import java.util.Locale;
import java.util.ResourceBundle;

/*
 *
 * @author egonzalez
 */
public class I18N
{
    private String idioma;
    private String pais;        

    private static I18N intl = new I18N();
    
    public static I18N getInstance(String idioma, String pais)
    {        
        intl.setIdioma(idioma);
        intl.setPais(pais);
        
        return intl;
    }
    
    public static I18N getInstance(String idioma)
    {
        return getInstance(idioma,"");
    }
    
    public static I18N getInstance()
    {
        return intl;
    }
    /* Creates a new instance of Internacionalizacion */
    private I18N()
    {
        idioma = "";
        pais = "";
    }        
    
    public String getMessage(String key)
    {
        Locale currentLocale;
        ResourceBundle messages;

        currentLocale = new Locale(idioma, pais);

        messages = ResourceBundle.getBundle("resources.ResourceBundle",
                                           currentLocale);

        return messages.getString(key);    
    }

    public String getIdioma()
    {
        return idioma;
    }

    public void setIdioma(String idioma)
    {
        this.idioma = idioma;
    }

    public String getPais()
    {
        return pais;
    }

    public void setPais(String pais)
    {
        this.pais = pais;
    }
    
    public static void main(String []args)
    {
        I18N intl = getInstance("es","co");
        
        System.out.println(intl.getMessage("message.title.entidad"));
    }
    
    private void destroySingleton()
    {
        intl = null;
    }
}
