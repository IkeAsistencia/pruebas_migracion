    /*
 *
 *
 * Created on 16 de febrero de 2007, 09:48 PM
 *
 * To change this template, choose Tools | Options and locate the template under
 * the Source Creation and Management node. Right-click the template and choose
 * Open. You can then make changes to the template in the Source Editor.
 */
package com.ike.concierge;
import com.ike.concierge.to.Conciergereferencia;
import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;

/*
 *
 * @author zamoraed
 */
public class DAOConciergeReferencia extends com.ike.model.DAOBASE{
    
    /* Creates a new instance of DAOTelemarketing */
    public DAOConciergeReferencia() {
    }
    
    public Conciergereferencia getCSReferencia(String StrclAsistencia) throws DAOException{
        StringBuffer sb = new StringBuffer();
        Collection col = null;
        
        
        sb.append("st_CSInfoRefereciaxAsistencia ").append(StrclAsistencia);
        System.out.println(sb);
        
        col = this.rsSQLNP(sb.toString(), new conciergeboletoscineFiller());
        
        Iterator it = col.iterator();
        return it.hasNext() ? (Conciergereferencia) it.next() : null;
    }
    
    
    public class conciergeboletoscineFiller implements com.ike.model.LlenaDatos{
        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException{
            Conciergereferencia conciergereferencia = new Conciergereferencia();
            conciergereferencia.setNomAlter(rs.getString("NomAlter"));
            conciergereferencia.setNomEstablec(rs.getString("NomEstablec"));
            conciergereferencia.setContacto(rs.getString("Contacto"));
            conciergereferencia.setDireccion(rs.getString("Direccion"));
            conciergereferencia.setCiudad(rs.getString("Ciudad"));
            return conciergereferencia;
        }
    }
}
