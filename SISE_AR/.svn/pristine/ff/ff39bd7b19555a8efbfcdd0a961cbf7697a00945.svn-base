/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ike.asistencias;

import com.ike.asistencias.to.RentaAuto;
import com.ike.model.DAOException;
import java.util.Collection;
import java.util.Iterator;

public class DAORentaAuto extends com.ike.model.DAOBASE {

    public DAORentaAuto() {
    }

    public RentaAuto getRentaAuto(String clExpediente) throws DAOException {
        StringBuffer sb = new StringBuffer();
        Collection col = null;

        sb.append("st_getRentaAuto ").append(clExpediente);
        System.out.println("get Renta: " + sb.toString());

        col = this.rsSQLNP(sb.toString(), new RentAut());

        Iterator it = col.iterator();
        return it.hasNext() ? (RentaAuto) it.next() : null;

    }

    public class RentAut implements com.ike.model.LlenaDatos {

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            RentaAuto RA = new RentaAuto();

            RA.setExpediente(rs.getString("expediente"));
            RA.setFechaApertura(rs.getString("fechaApertura"));
            RA.setFechaRegistro(rs.getString("fechaRegistro"));
            RA.setClCausaAsistencia(rs.getString("clCausaAsistencia"));
            RA.setDsCausaAsistencia(rs.getString("dsCausaAsistencia"));
            RA.setTiempoReparacion(rs.getString("tiempoReparacion"));
            RA.setClPaisVieaje(rs.getString("clPaisVieaje"));
            RA.setDsPaisVieje(rs.getString("dsPaisVieje"));
            RA.setCodEntViaje(rs.getString("CodEntViaje"));
            RA.setDsEntFedVieaje(rs.getString("dsEntFedVieaje"));
            RA.setCodMDVieaje(rs.getString("CodMDVieaje"));
            RA.setDsMunDelVieaje(rs.getString("dsMunDelVieaje"));
            RA.setDireccionVieaje(rs.getString("direccionVieaje"));
            RA.setCodigoMarca(rs.getString("CodigoMarca"));
            RA.setDsMarcaAuto(rs.getString("dsMarcaAuto"));
            RA.setClaveAMIS(rs.getString("ClaveAMIS"));
            RA.setDsTipoAuto(rs.getString("dsTipoAuto"));
            RA.setReservacionA(rs.getString("ReservacionA"));
            RA.setHorasReservacion(rs.getString("HorasReservacion"));
            RA.setNumTarjCredito(rs.getString("NumTarjCredito"));
            RA.setCodigoSeguridad(rs.getString("CodigoSeguridad"));
            RA.setBanco(rs.getString("Banco"));
            RA.setMesVmtoTarj(rs.getString("MesVmtoTarj"));
            RA.setAnioVmtoTarj(rs.getString("AnioVmtoTarj"));
            RA.setNumPersonasViajan(rs.getString("NumPersonasViajan"));
            RA.setNroLiConducir(rs.getString("NroLiConducir"));
            RA.setClPaisResid(rs.getString("clPaisResid"));
            RA.setDsPaisResid(rs.getString("dsPaisResid"));
            RA.setCodEntResid(rs.getString("CodEntResid"));
            RA.setDsEntFedResid(rs.getString("dsEntFedResid"));
            RA.setCodMDResid(rs.getString("CodMDResid"));
            RA.setDsMunDelResid(rs.getString("dsMunDelResid"));
            RA.setDireccionResid(rs.getString("direccionResid"));
            RA.setCostoCotizacion(rs.getString("CostoCotizacion"));
            RA.setCostoFinal(rs.getString("CostoFinal"));
            RA.setClTipoPago(rs.getString("clTipoPago"));
            RA.setDsTipoPago(rs.getString("dsTipoPago"));
            RA.setClTipoMoneda(rs.getString("clTipoMoneda"));
            RA.setDsTipoMoneda(rs.getString("dsTipoMoneda"));
            RA.setVmtoTarj(rs.getString("VmtoTarj"));
            RA.setVmtoTarjVTR(rs.getString("VmtoTarjVTR"));
            RA.setDesencripTarj(rs.getString("desencripTarj"));
            RA.setNumTC(rs.getString("NumTC"));
            return RA;
        }
    }
}
