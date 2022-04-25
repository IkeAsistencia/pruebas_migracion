
package com.ike.Supervision;
import com.ike.Supervision.to.SCSDeficiencia;
import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;


 public class DAOSCSDeficiencia extends com.ike.model.DAOBASE {

    /* Creates a new instance of DAOCSAutobus */
    public DAOSCSDeficiencia() {
    }

  public SCSDeficiencia getSCSDeficiencia (String getclDeficienciaxAsist ) throws DAOException {
        StringBuffer sb = new StringBuffer(); 
        Collection col = null; 
        sb.append("st_SCSgetDetDeficiencia  ").append(getclDeficienciaxAsist);

        System.out.println("Store: "+sb);

        col = this.rsSQLNP(sb.toString(), new DAOSCSDeficiencia.DAOSCSDeficienciaFiller());
        Iterator it = col.iterator();  
        return it.hasNext() ? (SCSDeficiencia) it.next() : null;
  }

    /* Creates Filler of CSAutobus */
    public class DAOSCSDeficienciaFiller implements com.ike.model.LlenaDatos {
        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            SCSDeficiencia DEF = new SCSDeficiencia();

            DEF.setClDeficienciaxAsist(rs.getString("clDeficienciaxAsistencia"));
            DEF.setClAsistencia(rs.getString("clAsistencia"));
            DEF.setClQuejaxSupervision(rs.getString("clQuejaxSupervision"));
            DEF.setClTipoDeficiencia(rs.getString("clTipoDeficiencia"));
            DEF.setDsTipoDeficiencia(rs.getString("dsTipoDeficiencia"));
            DEF.setClAreaDeficiencia(rs.getString("clAreaDeficiencia"));
            DEF.setDsAreaDefiencia(rs.getString("dsAreaDefiencia"));
            DEF.setClAreaDef(rs.getString("clAreaDef"));
            DEF.setUsrDeficiencia(rs.getString("UsrDeficiencia"));
            DEF.setReferencia(rs.getString("Referencia"));
            DEF.setDsDeficiencia(rs.getString("dsDeficiencia"));
            DEF.setClDeficiencia(rs.getString("clDeficiencia"));
            DEF.setObservacionesSup(rs.getString("ObservacionesSup"));
            DEF.setDsEstatusDef(rs.getString("dsEstatusDef"));
            DEF.setClEstatusDef(rs.getString("clEstatusDef"));
            DEF.setUsrMarca(rs.getString("UsrMarca"));
            DEF.setObservacionesConclu(rs.getString("ObservacionesConclu"));
            DEF.setObservacionesResp(rs.getString("ObservacionesResp"));
            DEF.setAsentada(rs.getString("Asentada"));
            DEF.setAceptada(rs.getString("Aceptada"));
        return DEF;
        }
    }
 }
