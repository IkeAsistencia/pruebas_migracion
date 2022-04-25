/*
 * DAORCCliente.java
 *
 * Created on 06 de Octubre de 2006
 */
package com.ike.ReuComer;

import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;
import com.ike.ReuComer.to.RCCliente;

/*
 * @author Rodrigus
 */
public class DAORCCliente extends com.ike.model.DAOBASE {
    /* Creates a new instance of DAOHelpdesk */

    public DAORCCliente() {
    }

    public RCCliente getCliente(String strclCliente) throws DAOException {
        StringBuffer sb = new StringBuffer();
        Collection col = null;

        sb.append("st_RCObtenCliente ").append(strclCliente);

        col = this.rsSQLNP(sb.toString(), new ClienteFiller());

        Iterator it = col.iterator();
        return it.hasNext() ? (RCCliente) it.next() : null;

    }

    public class ClienteFiller implements com.ike.model.LlenaDatos {

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            RCCliente Cliente = new RCCliente();

            Cliente.setclCliente(rs.getString("clCliente"));
            Cliente.setNombreCliente(rs.getString("NombreCliente"));
            Cliente.setDireccion(rs.getString("Direccion"));
            Cliente.setNotas(rs.getString("Notas"));
            Cliente.setNombreContacto1(rs.getString("NombreContacto1"));
            Cliente.setPuestoContacto1(rs.getString("PuestoContacto1"));
            Cliente.setTelefonoContacto1(rs.getString("TelefonoContacto1"));
            Cliente.setNombreContacto2(rs.getString("NombreContacto2"));
            Cliente.setPuestoContacto2(rs.getString("PuestoContacto2"));
            Cliente.setTelefonoContacto2(rs.getString("TelefonoContacto2"));
            Cliente.setNombreContacto3(rs.getString("NombreContacto3"));
            Cliente.setPuestoContacto3(rs.getString("PuestoContacto3"));
            Cliente.setTelefonoContacto3(rs.getString("TelefonoContacto3"));
            Cliente.setNombreContacto4(rs.getString("NombreContacto4"));
            Cliente.setPuestoContacto4(rs.getString("PuestoContacto4"));
            Cliente.setTelefonoContacto4(rs.getString("TelefonoContacto4"));
            Cliente.setNombreContactoD1(rs.getString("NombreContactoD1"));
            Cliente.setPuestoContactoD1(rs.getString("PuestoContactoD1"));
            Cliente.setTelefonoContactoD1(rs.getString("TelefonoContactoD1"));
            Cliente.setNombreContactoD2(rs.getString("NombreContactoD2"));
            Cliente.setPuestoContactoD2(rs.getString("PuestoContactoD2"));
            Cliente.setTelefonoContactoD2(rs.getString("TelefonoContactoD2"));
            Cliente.setNombreContactoD3(rs.getString("NombreContactoD3"));
            Cliente.setPuestoContactoD3(rs.getString("PuestoContactoD3"));
            Cliente.setTelefonoContactoD3(rs.getString("TelefonoContactoD3"));
            Cliente.setNombreContactoD4(rs.getString("NombreContactoD4"));
            Cliente.setPuestoContactoD4(rs.getString("PuestoContactoD4"));
            Cliente.setTelefonoContactoD4(rs.getString("TelefonoContactoD4"));

            return Cliente;
        }
    }
    /**
     * **************************************************************************************************************
     */
}
