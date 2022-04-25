/*
 * cbItemRef.java
 *
 * Created on 27 de septiembre de 2005, 08:52 AM
 */

package Combos;

/*
 *
 * @author  cabrerar
 * Esta clase se utiliza para mejorar el performance en la búsqueda de combos
 * guarda las posiciones iniciales de cada cambio de Code Parent para obtener
 * una sublista del vombo cargado en memoria
 */
public class cbItemRef {
    
    /* Creates a new instance of cbItemRef */
    private String codeParent;
    private int indexStart;
    private int indexEnd;

    public cbItemRef() {}
    public int getindexStart(){return this.indexStart;}
    public void setindexStart(int indexStart){this.indexStart = indexStart;}
    public int getindexEnd(){return this.indexEnd;}
    public void setindexEnd(int indexEnd){this.indexEnd = indexEnd;}
    public String getCodeParent(){return this.codeParent;}
    public void setCodeParent(String codeParent){this.codeParent = codeParent;}
}
