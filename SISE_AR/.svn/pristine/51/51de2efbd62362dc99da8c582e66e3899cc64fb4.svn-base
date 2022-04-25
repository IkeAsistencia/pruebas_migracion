/*
 * DeleteFile.java
 *
 * Created on 2 de septiembre de 2008, 15:08
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */
package Utilerias;

import java.io.File;

/*
 *
 * @author vsampablo
 */
public class DeleteFile {

    /* Creates a new instance of DeleteFile */
    public DeleteFile() {
    }

    public void DeleteFile(String file) {

        /* timer = new Timer (  ) ;
         timer.schedule ( new ToDoTask (  ) , seconds*1000 ) ;*/
        File f1 = new File(file);

        boolean success = f1.delete();

        //<<<<<<<<<<<<<<<< No se pudo Borrar el Archivo >>>>>>>>>>>
        if (!success) {
            System.out.println("No se pudo Borrar el Archivo.");
            System.exit(0);
        } else {
            System.out.println("Archivo Borrado " + file);
        }

    }

}
