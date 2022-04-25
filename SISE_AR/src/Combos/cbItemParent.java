/*
 * cbItemParent.java
 *
 * Created on 30 de septiembre de 2005, 02:24 PM
 */

package Combos;
import java.util.List;

/*
 *
 * @author  cabrerar
 */
public class cbItemParent {
    private String strCod;
    private String strDescripcion;
    private List lstChildren = null;
    
    /* Creates a new instance of Entidad */
    public  cbItemParent() {
    }
    
    public String getStrCod(){return this.strCod;}
    public void setStrCod(String strCod){this.strCod= strCod;}
    public String getStrDescripcion(){return this.strDescripcion;}
    public void setStrDescripcion(String strDescripcion){this.strDescripcion = strDescripcion;}
    public List getLstChildren(){return this.lstChildren;}
    public void setLstChildren(List lstChildren){this.lstChildren = lstChildren;}
}
