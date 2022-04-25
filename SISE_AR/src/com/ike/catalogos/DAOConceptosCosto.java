package com.ike.catalogos;

import com.ike.catalogos.to.ConceptosCosto;
import com.ike.model.DAOException;
import java.util.Collection;
import java.util.Iterator;

/*
 *
 * @author mramirez
 */
public class DAOConceptosCosto extends com.ike.model.DAOBASE {

    public DAOConceptosCosto() {
    }

    public ConceptosCosto getConceptosCosto(String clConceptoCosto) throws DAOException {
        StringBuilder sb = new StringBuilder();
        Collection col = null;

        sb.append("st_getDetalleConceptoCosto ").append(clConceptoCosto);
        System.out.println(sb);
        col = this.rsSQLNP(sb.toString(), new ConceptoCostoFiller());

        Iterator it = col.iterator();
        return it.hasNext() ? (ConceptosCosto) it.next() : null;
    }

    public class ConceptoCostoFiller implements com.ike.model.LlenaDatos {

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            ConceptosCosto CC = new ConceptosCosto();

            CC.setClConcepto(rs.getString("clConcepto"));
            CC.setDsConcepto(rs.getString("dsConcepto"));
            CC.setCodigo(rs.getString("Codigo"));
            CC.setClAreaOperativa(rs.getString("clAreaOperativa"));
            CC.setDsAreaOperativa(rs.getString("dsAreaOperativa"));
            CC.setEstatusAct(rs.getString("EstatusAct"));
            CC.setActivo(rs.getString("Activo"));
            CC.setClCategoria(rs.getString("clCategoria"));
            CC.setDsCategoria(rs.getString("dsCategoria"));
            CC.setExcepcion(rs.getString("Excepcion"));
            return CC;
        }
    }
}
