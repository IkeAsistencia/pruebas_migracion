/*
 * DAONutricional.java
 *
 * Created on 8 de noviembre de 2007, 11:15 AM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */
package com.ike.referencias;

import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;
import com.ike.referencias.to.Nutricional; //Debe ser la clase de los getters y setters

/*
 *
 * @author rurbina
 */
public class DAONutricional extends com.ike.model.DAOBASE {

    /* Creates a new instance of DAONutricional */
    public DAONutricional() {
    }

   // public Nutricional getReferencia(String clNutricional, String clCuenta, String Clave) throws DAOException {
     public Nutricional getReferencia(String clRReferencias) throws DAOException {
        StringBuffer sb = new StringBuffer();
        Collection col = null;

        sb.append("st_Nutricional ").append(clRReferencias);    
        
//        sb.append("st_Nutricional ").append(clNutricional).append(",");
//        sb.append(clCuenta).append(",");
//        sb.append("'").append(Clave).append("'");

        col = this.rsSQLNP(sb.toString(), new NutricionalFiller());

        Iterator it = col.iterator();
        return it.hasNext() ? (Nutricional) it.next() : null;
    }

    public class NutricionalFiller implements com.ike.model.LlenaDatos {

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            Nutricional ObjNutricional = new Nutricional();
            //ObjNutricional.setClReferenciaLlamada(rs.getString("clReferenciaLlamada"));
            ObjNutricional.setClCuenta(rs.getString("clCuenta"));
            ObjNutricional.setClave(rs.getString("Clave"));
            ObjNutricional.setEdad(rs.getString("Edad"));
            ObjNutricional.setSexo(rs.getString("Sexo"));
            ObjNutricional.setTalla(rs.getString("Talla"));
            ObjNutricional.setPeso(rs.getString("Peso"));
            ObjNutricional.setIMC(rs.getString("IMC"));
            ObjNutricional.setPesoIdeal(rs.getString("PesoIdeal"));
            ObjNutricional.setPesoBajo(rs.getString("PesoBajo"));
            ObjNutricional.setSobrepeso(rs.getString("Sobrepeso"));
            ObjNutricional.setDesnutricion(rs.getString("Desnutricion"));
            ObjNutricional.setObesidad1(rs.getString("Obesidad1"));
            ObjNutricional.setObesidad2(rs.getString("Obesidad2"));
            ObjNutricional.setClAsesoria(rs.getString("clAsesoria"));
            ObjNutricional.setDsAsesoria(rs.getString("dsAsesoria"));
            ObjNutricional.setClNutricional(rs.getString("clNutricional"));
            return ObjNutricional;
        }
    }
}
