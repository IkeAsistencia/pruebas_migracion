/*
 * DAOSoftwareSP.java
 *
 * Created on 5 de agosto de 2010, 01:44 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package com.ike.helpdeskSP;

import com.ike.helpdeskSP.SoftwareSP;
import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;

/*
 *
 * @author bsanchez
 */
public class DAOSoftwareSP extends com.ike.model.DAOBASE {
    
    /* Creates a new instance of DAOSoftwareSP */
    public DAOSoftwareSP() {
    }
    
    public SoftwareSP  getCalificacionSP (String clSoftwareSP ) throws DAOException
    {
        StringBuffer sb = new StringBuffer();
        Collection col = null;
        
        sb.append("st_SoftwareSP ").append(clSoftwareSP);
        
        col = this.rsSQLNP(sb.toString(), new SoftwareSPFiller());
        
        Iterator it = col.iterator();
        return it.hasNext() ? (SoftwareSP) it.next() : null;        
    }
    
    public class SoftwareSPFiller implements com.ike.model.LlenaDatos
    
    {
        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException
        {
             SoftwareSP SSP = new SoftwareSP();      
             
             SSP.setClSoftwareSP(rs.getString("clSoftwareSP"));
             SSP.setClSO(rs.getString("clSO"));
             SSP.setDsSO(rs.getString("dsSO"));
             SSP.setClOffice(rs.getString("clOffice"));
             SSP.setDsOffice(rs.getString("dsOffice"));
             SSP.setClAntivirus(rs.getString("clAntivirus"));
             SSP.setDsAntivirus(rs.getString("dsAntivirus"));
             SSP.setClIE(rs.getString("clIE"));
             SSP.setDsIE(rs.getString("dsIE"));             
             SSP.setClVisio(rs.getString("clVisio"));
             SSP.setDsVisio(rs.getString("dsVisio"));             
             SSP.setClProject(rs.getString("clProject"));
             SSP.setDsProject(rs.getString("dsProject"));
             SSP.setClAdobe(rs.getString("clAdobe"));
             SSP.setDsAdobe(rs.getString("dsAdobe"));
             SSP.setLicenciaWin(rs.getString("LicenciaWin"));
             SSP.setOtros(rs.getString("Otros"));
            return SSP;
        }
        
    }
    
}
