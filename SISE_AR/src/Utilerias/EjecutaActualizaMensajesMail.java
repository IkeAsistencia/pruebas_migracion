package Utilerias;

public class EjecutaActualizaMensajesMail {

    /* Creates a new instance of EjecutaActualizaMensajesMail */
    static void ActualizaEnviado(Integer integer, int i) {

        System.out.println("entra actualizacion mail " + integer.toString() + " " + i);
        try {
            UtileriasBDF.ejecutaSQLNP(" st_ActualizaMensajesMail " + integer + "," + i);
        } catch (Exception ex) {
            System.out.println("Error en EjecutaActualizaMensajesMail");
            ex.printStackTrace();
        }finally{
            System.out.println("Final de EjecutaActualizaMensajesMail");
        }
    }
}