/*
 * HtmlItem.java
 *
 * Created on 24 de septiembre de 2005, 03:44 PM
 */

package Combos;

/*
 *
 * @author  cabrerar
 * Esta clase se utiliza para guardar en una arrayList los datos comunes
 * en elllenado de un combo, el atributo Code contiene el valor entero del 
 * catálogo, description el valor de la descripción y el codeParent el 
 * valor del catálogo padre referenciado
 */
public class cbItem
    {
    private String code;
    private String description;
    private String codeParent;
    
    public cbItem(){}
    public String getCode(){return this.code;}
    public void setCode(String code){this.code = code;}
    public String getDescription(){return this.description;}
    public void setDescription(String description){this.description = description;}
    public String getCodeParent(){return this.codeParent;}
    public void setCodeParent(String codeParent){this.codeParent = codeParent;}
}