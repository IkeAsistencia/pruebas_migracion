/*
 * DAORGMM.java
 *
 * Created on 11 de Agosto de 2006, 12:00 PM
 *
 * To change this template, choose Tools | Options and locate the template under
 * the Source Creation and Management node. Right-click the template and choose
 * Open. You can then make changes to the template in the Source Editor.
 */

package com.ike.asistencias;

import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;
import com.ike.asistencias.to.RGMMExpediente;
/*
 *
 * @author rodrigus
 */
public class DAORGMM extends com.ike.model.DAOBASE
{
        /* Creates a new instance of DAOHelpdesk */
    public DAORGMM()
    {
    }
    
    public RGMMExpediente getExpediente(String strclExpediente) throws DAOException
    {
        
        StringBuffer sb = new StringBuffer();
        Collection col = null;

        sb.append(" select"); 
        sb.append(" RG.clExpediente 'clExpediente',"); 
        sb.append(" RG.Poliza 'Poliza',"); 
        sb.append(" RG.Siniestro 'Siniestro',"); 
        sb.append(" RG.Paciente 'Paciente',"); 
        sb.append(" RG.Medico 'Medico',"); 
        sb.append(" RG.Telefono 'Telefono',"); 
        sb.append(" RG.Celular 'Celular',"); 
        sb.append(" RG.Movil 'Movil',"); 
        sb.append(" RG.Hospital 'Hospital',"); 
        sb.append(" EFH.CodEnt 'CodEntH',");        
        sb.append(" EFH.dsEntFed 'dsEntFedH', "); 
        sb.append(" MDH.CodMD 'CodMDH',"); 
        sb.append(" MDH.dsMunDel 'dsMunDelH',"); 
        sb.append(" RG.ColoniaH 'ColoniaH',"); 
        sb.append(" RG.CalleNumH 'CalleH',"); 
        sb.append(" RG.CPH 'CPH',"); 
        sb.append(" RG.PersonaContacto 'Persona',"); 
        sb.append(" RG.TelefonoP 'TelefonoP',"); 
        sb.append(" RG.MovilP 'MovilP',"); 
        sb.append(" RG.Padecimiento 'Padecimiento',"); 
        sb.append(" RG.Titular 'Titular',"); 
        sb.append(" EFP.CodEnt 'CodEntP',"); 
        sb.append(" EFP.dsEntFed 'dsEntFedP',"); 
        sb.append(" MDP.CodMD 'CodMDP',");
        sb.append(" MDP.dsMunDel 'dsMunDelP',");
        sb.append(" RG.ColoniaP 'ColoniaP',"); 
        sb.append(" RG.CalleNumP 'CalleP',"); 
        sb.append(" RG.CPP 'CPP'"); 
        sb.append(" from AsistRecupGMM RG"); 
        sb.append(" inner join Expediente Ex on (Ex.clExpediente=RG.clExpediente)"); 
        sb.append(" inner join cEntFed EFH on (EFH.CodEnt=RG.CodEntH)"); 
        sb.append(" inner join cMunDel MDH on(MDH.CodEnt=RG.CodEntH and MDH.CodMD=RG.codMDH)"); 
        sb.append(" inner join cEntFed EFP on (EFP.CodEnt=RG.CodEntP)"); 
        sb.append(" inner join cMunDel MDP on(MDP.CodEnt=RG.CodEntP and MDP.CodMD=RG.codMDP)"); 
        sb.append(" where RG.clExpediente = ").append(strclExpediente);
        System.out.println(sb);
        col = this.rsSQLNP(sb.toString(), new ExpedienteFiller());

        Iterator it = col.iterator();
        return it.hasNext() ? (RGMMExpediente) it.next() : null;

    }
    
    public class ExpedienteFiller implements com.ike.model.LlenaDatos
    {
        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException
        {
            
            RGMMExpediente Expediente = new RGMMExpediente();
            
            Expediente.setclExpediente(rs.getString("clExpediente"));
            Expediente.setPoliza(rs.getString("Poliza"));
            Expediente.setSiniestro(rs.getString("Siniestro"));
            Expediente.setPaciente(rs.getString("Paciente"));
            Expediente.setMedico(rs.getString("Medico"));
            Expediente.setTelefono(rs.getString("Telefono"));
            Expediente.setCelular(rs.getString("Celular"));
            Expediente.setMovil(rs.getString("Movil"));
            Expediente.setHospital(rs.getString("Hospital"));
            Expediente.setCodEntH(rs.getString("CodEntH"));
            Expediente.setdsEntFedH(rs.getString("dsEntFedH"));
            Expediente.setCodMDH(rs.getString("CodMDH"));
            Expediente.setdsMunDelH(rs.getString("dsMunDelH"));
            Expediente.setColoniaH(rs.getString("ColoniaH"));
            Expediente.setCalleH(rs.getString("CalleH"));
            Expediente.setCPH(rs.getString("CPH"));
            Expediente.setPersona(rs.getString("Persona"));
            Expediente.setTelefonoP(rs.getString("TelefonoP"));
            Expediente.setMovilP(rs.getString("MovilP"));
            Expediente.setPadecimiento(rs.getString("Padecimiento"));
            Expediente.setTitular(rs.getString("Titular"));
            Expediente.setCodEntP(rs.getString("CodEntP"));
            Expediente.setdsEntFedP(rs.getString("dsEntFedP"));            
            Expediente.setCodMDP(rs.getString("CodMDP"));
            Expediente.setdsMunDelP(rs.getString("dsMunDelP"));            
            Expediente.setColoniaP(rs.getString("ColoniaP"));            
            Expediente.setCalleP(rs.getString("CalleP"));
            Expediente.setCPP(rs.getString("CPP"));
            return Expediente;
        }
    }
    
}
    