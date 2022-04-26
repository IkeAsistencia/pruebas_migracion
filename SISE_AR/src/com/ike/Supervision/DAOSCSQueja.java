package com.ike.Supervision;

import com.ike.Supervision.to.SCSQueja;
import com.ike.model.DAOBASE;
import com.ike.model.DAOException;
import com.ike.model.LlenaDatos;
import java.io.PrintStream;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import java.util.Iterator;

public class DAOSCSQueja
  extends DAOBASE
{
  public SCSQueja getclQuejaxAsist(String StrclQuejaxSupervision)
    throws DAOException
  {
    StringBuffer sb = new StringBuffer();
    Collection col = null;
    
    sb.append(" st_SCSBuscaQueja '").append(StrclQuejaxSupervision).append("'");
    System.out.println("QRY DAO:" + sb.toString());
    col = rsSQLNP(sb.toString(), new DAOSCSQuejaFiller());
    
    Iterator it = col.iterator();
    return it.hasNext() ? (SCSQueja)it.next() : null;
  }
  
  public class DAOSCSQuejaFiller
    implements LlenaDatos
  {
    public DAOSCSQuejaFiller() {}
    
    public Object llena(ResultSet rs)
      throws SQLException
    {
      System.out.println("entra dao SCSDeficiencia");
      
      SCSQueja Queja = new SCSQueja();
      
      Queja.setClQueja(rs.getString("clQueja"));
      Queja.setDsQueja(rs.getString("dsQueja"));
      Queja.setDsEstatusQueja(rs.getString("dsEstatusQueja"));
      Queja.setEsQueja(rs.getString("EsQueja"));
      Queja.setObservacionesSup(rs.getString("ObservacionesSup"));
      Queja.setObservacionesArea(rs.getString("ObservacionesArea"));
      Queja.setSolucion(rs.getString("Solucion"));
      Queja.setDsTipoSolQueja(rs.getString("dsTipoSolQueja"));
      Queja.setNSComercial(rs.getString("NSComercial"));
      Queja.setNSCliente(rs.getString("NSCliente"));
      Queja.setNSUsuario(rs.getString("NSUsuario"));
      Queja.setNSJefe(rs.getString("NSJefe"));
      Queja.setNSGCP(rs.getString("NSGCP"));
      Queja.setNSProveedor(rs.getString("NSProveedor"));
      Queja.setClDano(rs.getString("clDano"));
      Queja.setDsDano(rs.getString("dsDano"));
      Queja.setClSubDano(rs.getString("clSubDano"));
      Queja.setDsSubDano(rs.getString("dsSubDano"));
      Queja.setClAceptacionDano(rs.getString("clAceptacionDano"));
      Queja.setFechaAceptacionDano(rs.getString("FechaAceptacionDano"));
      Queja.setClResponsabilidadDano(rs.getString("clResponsabilidadDano"));
      Queja.setDsResponsabilidadDano(rs.getString("dsResponsabilidadDano"));
      Queja.setClModoReparacionDano(rs.getString("clModoReparacionDano"));
      Queja.setDsModoReparacionDano(rs.getString("dsModoReparacionDano"));
      Queja.setClTipoPagoDano(rs.getString("clTipoPagoDano"));
      Queja.setDsTipoPagoDano(rs.getString("dsTipoPagoDano"));
      Queja.setFechaRegistroTipoPago(rs.getString("FechaRegistroTipoPago"));
      Queja.setFechaPagoIngreso(rs.getString("FechaPagoIngreso"));
      Queja.setClComprobanteRepDano(rs.getString("clComprobanteRepDano"));
      Queja.setDsComprobanteRepDano(rs.getString("dsComprobanteRepDano"));
      Queja.setFechaRegistroComprob(rs.getString("FechaRegistroComprob"));
      Queja.setMontoPago(rs.getString("MontoPago"));
      Queja.setFechaIngreso(rs.getString("FechaIngreso"));
      Queja.setFechaSolucion(rs.getString("FechaSolucion"));
      
      return Queja;
    }
  }
}
