package com.ike.operacion;

import com.ike.operacion.to.CircuitoReclamos;
import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;

/*
 *
 * @author fcerqueda
 */
public class DAOCircuitoReclamos extends com.ike.model.DAOBASE {

    public DAOCircuitoReclamos() {
    }

    public CircuitoReclamos getReclamo(int clReclamo) throws DAOException {
        StringBuilder sb = new StringBuilder();
        Collection col = null;

        sb.append("st_RecuperaReclamo ").append(clReclamo);

        col = this.rsSQLNP(sb.toString(), new ReclamoFiller());

        Iterator it = col.iterator();
        return it.hasNext() ? (CircuitoReclamos) it.next() : null;

    }

    public class ReclamoFiller implements com.ike.model.LlenaDatos {

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {

            CircuitoReclamos cr = new CircuitoReclamos();

            cr.setClReclamo(rs.getString("clReclamo"));
            cr.setClCuenta(rs.getString("clCuenta"));
            cr.setClEstatusReclamo(rs.getString("clEstatusReclamo"));
            cr.setDsEstatusReclamo(rs.getString("dsEstatusReclamo"));
            cr.setFechaReclamo(rs.getString("FechaReclamo"));
            cr.setFechaCierre(rs.getString("FechaCierre"));
            cr.setAfiliado(rs.getString("Afiliado"));
            cr.setDNI(rs.getString("DNI"));
            cr.setFechaValida(rs.getString("FechaValida"));
            cr.setFechaBaja(rs.getString("FechaBaja"));
            cr.setDsGrupoCuenta(rs.getString("dsGpoCuenta"));
            cr.setClave(rs.getString("Clave"));
            cr.setDsSector(rs.getString("dsSector"));
            cr.setDstipoReclamo(rs.getString("dsTipoReclamo"));
            cr.setReintegro(rs.getString("Reintegro"));
            cr.setMonto(rs.getString("Monto"));
            cr.setOpeVenta(rs.getString("Operador"));
            cr.setValidador(rs.getString("Validador"));
            cr.setObservaciones(rs.getString("Observaciones"));
            cr.setAplicaReclamo(rs.getString("AplicaReclamo"));
            cr.setCanalVenta(rs.getString("CanalVenta"));
            cr.setTipoTarjeta(rs.getString("tipoTarjeta"));
            cr.setNoTarjeta(rs.getString("noTarjeta"));
            cr.setBanco(rs.getString("banco"));
            cr.setNoCuenta(rs.getString("noCuenta"));
            cr.setNoCBU(rs.getString("CBU"));
            cr.setCategoriaReclamo(rs.getString("CategoriaReclamo"));
            cr.setClAfiliado(rs.getString("clAfiliado"));
            cr.setAutorizaReintegro(rs.getString("AutorizaReintegro"));

            return cr;
        }
    }
}