/*
 * Label.java
 *
 * Created on 04 de Noviembre de 2005, 19:38 PM
 */

package Utilerias;

/*
 *
 * @author  cabrerar
 */
public class Label {
    private String strLabelSP; //Label en español
    private String strLabelPO; //Label en Portugués
    
    /* Creates a new instance of Entidad */
    public  Label() {
    }
    
    public String getStrLabelSP(){return this.strLabelSP;}
    public void setStrLabelSP(String strLabelSP){this.strLabelSP= strLabelSP;}
    public String getStrLabelPO(){return this.strLabelPO;}
    public void setStrLabelPO(String strLabelPO){this.strLabelPO= strLabelPO;}

}
