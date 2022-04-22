package com.ike.asistencias;

import com.ike.asistencias.to.DetalleClienteVIP;
import com.ike.model.DAOException;
import java.util.Collection;
import java.util.Iterator;

public class DAODetalleClienteVIP extends com.ike.model.DAOBASE {
//------------------------------------------------------------------------------    
    public DAODetalleClienteVIP() {    }
//------------------------------------------------------------------------------
    public DetalleClienteVIP getDetalleClienteVIP(String clClienteVIP) throws DAOException {
        StringBuffer sb = new StringBuffer();
        Collection col = null;
        sb.append("st_DetalleClienteVIP ").append(clClienteVIP);
        col = this.rsSQLNP(sb.toString(), new DetalleClienteVIPFiller());
        Iterator it = col.iterator();
        return it.hasNext() ? (DetalleClienteVIP) it.next() : null;
        }
//------------------------------------------------------------------------------
    public class DetalleClienteVIPFiller implements com.ike.model.LlenaDatos {
        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            DetalleClienteVIP DC = new DetalleClienteVIP();
            DC.setClClienteVIP(rs.getString("clClienteVIP"));
            DC.setClcuentaVIP(rs.getString("clcuentaVIP"));
            DC.setDsCuentaVIP(rs.getString("dsCuentaVIP"));
            DC.setNombreClienteVIP(rs.getString("NombreClienteVIP"));
            DC.setClaveCuentaVIP(rs.getString("ClaveCuentaVIP"));
            DC.setActivo(rs.getString("Activo"));
            DC.setFechaIni(rs.getString("FechaIni"));
            DC.setFechaFin(rs.getString("FechaFin"));
            DC.setFechaAlta(rs.getString("FechaAlta"));
            DC.setFechaBaja(rs.getString("FechaBaja"));
            DC.setNombreCuenta(rs.getString("NombreCuenta"));
            DC.setClResponsableVIP(rs.getString("clResponsableVIP"));
            DC.setDsResponsableVIP(rs.getString("dsResponsableVIP"));
            DC.setTipo(rs.getString("Tipo"));
            DC.setConsecutivo(rs.getString("Consecutivo"));
            DC.setClCuenta(rs.getString("clCuenta"));
            DC.setDsCuenta(rs.getString("dsCuenta"));
            DC.setDNI(rs.getString("DNI"));
            DC.setClCategoriaVIP(rs.getString("clCategoriaVIP"));
            DC.setDsCategoriaVIP(rs.getString("dsCategoriaVIP"));
            DC.setPatente(rs.getString("Patente"));
            return DC;
        }
    }
//------------------------------------------------------------------------------
}