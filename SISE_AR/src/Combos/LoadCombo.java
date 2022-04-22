/*
 * LoadCombo.java
 *
 * Created on 3 de agosto de 2012, 11:09 AM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */
package Combos;

import java.util.HashMap;

/*
 *
 * @author vsampablo
 */
public class LoadCombo {

    /* Creates a new instance of LoadCombo */
    public LoadCombo() {
    }
    private static HashMap ComboHM = new HashMap();

    public static void reloadComboHM(String StrCombo) {
        System.out.println("Reload  Combo.." + StrCombo);
        ComboHM.remove(StrCombo);
    }
}
