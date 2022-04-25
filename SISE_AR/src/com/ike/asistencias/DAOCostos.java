package com.ike.asistencias;

import com.ike.asistencias.to.Costos;
import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;

public class DAOCostos extends com.ike.model.DAOBASE {
    public DAOCostos() {  }
//------------------------------------------------------------------------------
    public Costos getCostos(String clCosto) throws DAOException {
        StringBuffer sb = new StringBuffer();
        Collection col = null;
        sb.append("sp_DetalleCostos ").append(clCosto);
        col = this.rsSQLNP(sb.toString(), new CostosFiller());
        Iterator it = col.iterator();
        return it.hasNext() ? (Costos) it.next() : null;
        }
//------------------------------------------------------------------------------    
    public class CostosFiller implements com.ike.model.LlenaDatos {
        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            Costos Costo = new Costos();
            Costo.setClCosto(rs.getString("clCosto"));
            Costo.setClUsrAppAut(rs.getString("clUsrAppAut"));
            Costo.setMotivoAut(rs.getString("MotivoAut"));
            Costo.setDsProveedor(rs.getString("dsProveedor"));
            Costo.setDsConcepto(rs.getString("dsConcepto"));
            Costo.setConcepto(rs.getString("Concepto"));
            Costo.setCostoConv(rs.getString("CostoConv"));
            Costo.setCostoSEA(rs.getString("CostoSEA"));
            Costo.setCostoNU(rs.getString("CostoNU"));
            Costo.setCostoExced(rs.getString("CostoExced"));
            Costo.setPorcentajeDesc(rs.getString("PorcentajeDesc"));
            Costo.setCostoRealSEA(rs.getString("CostoRealSEA"));
            Costo.setClProveedor(rs.getString("clProveedor"));
            Costo.setClConcepto(rs.getString("clConcepto"));
            Costo.setClMedioPago(rs.getString("clMedioPago"));
            Costo.setDsMedioPago(rs.getString("dsMedioPago"));
            Costo.setCostoTotal(rs.getString("CostoTotal"));
            Costo.setComprobante(rs.getString("comprobante"));
            Costo.setKMExcedente(rs.getString("KMExcedente"));
            Costo.setClCategoria(rs.getString("clCategoria"));
            Costo.setExcepcion(rs.getString("Excepcion"));
            Costo.setCostoCIA(rs.getString("CostoCIA"));
            Costo.setNombre(rs.getString("Nombre"));
            Costo.setDomicilio(rs.getString("Domicilio"));
            Costo.setDniCuil(rs.getString("DniCuil"));
            Costo.setMail(rs.getString("Mail"));
            Costo.setProvincia(rs.getString("Provincia"));
            Costo.setLocalidad(rs.getString("Localidad"));
            Costo.setCostoMP(rs.getString("CostoMP"));
            Costo.setDsTipoFactura(rs.getString("dsTipoFactura"));
            Costo.setChckOpcPago(rs.getString("ChckOpcPago"));
            Costo.setEstatus(rs.getString("Estatus") );
            Costo.setDsEstatus(rs.getString("dsEstatus"));
            Costo.setObservaciones(rs.getString("Observaciones"));
            Costo.setFechaRegistro(rs.getString("FechaRegistro"));
            return Costo;
            }
        }
    }