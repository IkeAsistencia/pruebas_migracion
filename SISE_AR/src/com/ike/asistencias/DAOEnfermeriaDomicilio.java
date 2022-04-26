/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ike.asistencias;

import com.ike.asistencias.to.DetalleEnfermeriaDomicilio;
import com.ike.model.DAOException;
import java.util.Collection;
import java.util.Iterator;

/**
 *
 * @author miperez
 */
public class DAOEnfermeriaDomicilio extends com.ike.model.DAOBASE{
    
    public DAOEnfermeriaDomicilio(){
    }
    public DetalleEnfermeriaDomicilio getDetalleEnfermeriaDomicilio(String clExpediente) throws DAOException{
        StringBuffer sb = new StringBuffer();
        Collection col = null;

        sb.append("st_getEnfermeriaDom ").append(clExpediente);

        col = this.rsSQLNP(sb.toString(), new DAOEnfermeriaDomicilio.DetalleEnfermeriaDomicilioFiller());

        Iterator it = col.iterator();
        return it.hasNext() ? (DetalleEnfermeriaDomicilio) it.next() : null;
    }
    
    public class DetalleEnfermeriaDomicilioFiller implements com.ike.model.LlenaDatos {
    
    public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException{
        DetalleEnfermeriaDomicilio ED = new DetalleEnfermeriaDomicilio();
        ED.setClExpediente(rs.getString("clExpediente"));
        ED.setPaciente(rs.getString("Paciente"));
        ED.setEdad(rs.getString("Edad"));
        ED.setCP(rs.getString("CP"));
        ED.setDsEntFed(rs.getString("dsEntFed"));
        ED.setCodEnt(rs.getString("CodEnt"));
        ED.setDsMunDel(rs.getString("dsMunDel"));
        ED.setCodMD(rs.getString("CodMD"));
        ED.setCalle(rs.getString("Calle"));
        ED.setPadecimiento(rs.getString("Padecimiento"));
        ED.setMedicoAtendio(rs.getString("MedicoAtendio"));
        ED.setDiagnosticoDx(rs.getString("DiagnosticoDx"));
        ED.setTratamientoTx(rs.getString("TratamientoTx"));
        return ED;
        }
    }
}
