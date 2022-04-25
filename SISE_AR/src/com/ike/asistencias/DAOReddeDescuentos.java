/*
 * DAOReddeDescuentos.java
 *
 * Created on 13 de MAYO de 2008, 10:00 AM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor
 */
package com.ike.asistencias;

import com.ike.asistencias.to.ReddeDescuentos;
import com.ike.model.DAOException;
import java.util.Collection;
import java.util.Iterator;


public class DAOReddeDescuentos extends com.ike.model.DAOBASE {

    /*
     * Creates a new instance of DAOReddeDescuentos
     */
    public DAOReddeDescuentos() {
    }

    public ReddeDescuentos getReddeDescuentos(String clExpediente) throws DAOException {
        StringBuffer sb = new StringBuffer();
        Collection col = null;
              
        sb.append("st_ReddeDescuentos ").append(clExpediente);

        col = this.rsSQLNP(sb.toString(), new ReddeDescuentosFiller());
        
        System.out.println(sb);

        Iterator it = col.iterator();
        return it.hasNext() ? (ReddeDescuentos) it.next() : null;

    }

    public class ReddeDescuentosFiller implements com.ike.model.LlenaDatos {

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            ReddeDescuentos RED = new ReddeDescuentos();
            
            RED.setClReddeDescuentos(rs.getString("clReddeDescuentos"));
            RED.setFechadeCaptura(rs.getString("FechadeCaptura"));
            RED.setContacto(rs.getString("Contacto"));
            RED.setNombreComercial(rs.getString("NombreComercial"));
            RED.setRazonSocial(rs.getString("RazonSocial"));
            RED.setClTipoDescuento(rs.getString("clTipoDescuento"));
            RED.setDsTipoDescuento(rs.getString("dsTipoDescuento"));
            RED.setClGiroRed(rs.getString("clGiroRed"));
            RED.setDsGiroRed(rs.getString("dsGiroRed"));
            RED.setCodEnt(rs.getString("CodEnt"));
            RED.setDsEntFed(rs.getString("dsEntFed"));
            RED.setCodMD(rs.getString("CodMD"));
            RED.setDsMunDel(rs.getString("dsMunDel"));
            RED.setBeneficios(rs.getString("Beneficios"));
            RED.setCorreo(rs.getString("Correo"));
            RED.setTelefono1(rs.getString("Telefono1"));
            RED.setTelefono2(rs.getString("Telefono2"));
            RED.setClExpediente(rs.getString("clExpediente"));
            return RED;
        }
    }
}