/*
 * DAOPerifericosSP.java
 * 
 * Created 2010-08-05
 * 
 */
package com.ike.helpdeskSP;

import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;

/*
 *
 * @author bsanchez
 */
public class DAOPerifericosSP extends com.ike.model.DAOBASE {

    /* Creates a new instance of DAOPerifericosSP */
    public DAOPerifericosSP() {
    }

    public PerifericosSP getPerifericoSP(String clPeriferico) throws DAOException {
        StringBuffer sb = new StringBuffer();
        Collection col = null;

        sb.append("st_perifericosSP ").append(clPeriferico);

        col = this.rsSQLNP(sb.toString(), new PerifericosSPFiller());

        Iterator it = col.iterator();
        return it.hasNext() ? (PerifericosSP) it.next() : null;
    }

    public class PerifericosSPFiller implements com.ike.model.LlenaDatos {

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            PerifericosSP PSP = new PerifericosSP();

            PSP.setclPeriferico(rs.getString("clPeriferico"));
            PSP.setclInventarioSP(rs.getString("clInventarioSP"));
            PSP.setclTipoPeriferico(rs.getString("clTipoPeriferico"));
            PSP.setdsTipoPeriferico(rs.getString("dsTipoPeriferico"));
            PSP.setclMarca(rs.getString("clMarca"));
            PSP.setdsMarca(rs.getString("dsMarca"));
            PSP.setModelo(rs.getString("Modelo"));
            PSP.setNoSerie(rs.getString("NoSerie"));
            PSP.setProcesador(rs.getString("Procesador"));
            PSP.setclDiscoDuro(rs.getString("clDiscoDuro"));
            PSP.setdsDiscoDuro(rs.getString("dsDiscoDuro"));
            PSP.setclMemoriaRam(rs.getString("clMemoriaRam"));
            PSP.setdsMemoriaRam(rs.getString("dsMemoriaRam"));
            PSP.setclPropiedad(rs.getString("clPropiedad"));
            PSP.setdsPropiedad(rs.getString("dsPropiedad"));
            PSP.setObservaciones(rs.getString("Observaciones"));
            PSP.setClEstatus(rs.getString("clEstatus"));
            PSP.setDsEstatus(rs.getString("dsEstatus"));
            PSP.setFactura(rs.getString("Factura"));
            PSP.setAnexo(rs.getString("Anexo"));
            PSP.setClArrendadora(rs.getString("clArrendadora"));
            PSP.setDsArrendadora(rs.getString("dsArrendadora"));
            PSP.setEtiquetaActivo(rs.getString("EtiquetaActivo"));
            PSP.setFechaFactura(rs.getString("FechaFactura"));
            PSP.setClEmpresa(rs.getString("clEmpresa"));
            PSP.setDsEmpresa(rs.getString("dsEmpresa"));
            PSP.setMouse(rs.getString("Mouse"));
            PSP.setTeclado(rs.getString("Teclado"));
            return PSP;
        }
    }
}
