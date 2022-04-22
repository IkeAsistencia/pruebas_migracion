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
import com.ike.concierge.to.ConciergeBoletosCine;
import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;

/*
 *
 * @author zamoraed
 */
public class DAOBoletosCine extends com.ike.model.DAOBASE{
    
    /* Creates a new instance of DAOTelemarketing */
    public DAOBoletosCine() {
    }
    
    public ConciergeBoletosCine getCSBoletosCine(String StrclAsistencia) throws DAOException{
        StringBuffer sb = new StringBuffer();
        Collection col = null;
        
        
        sb.append("st_CScBoletoCine ").append(StrclAsistencia);
        System.out.println(sb);
        
        col = this.rsSQLNP(sb.toString(), new conciergeboletoscineFiller());
        
        Iterator it = col.iterator();
        return it.hasNext() ? (ConciergeBoletosCine) it.next() : null;
    }
    
    
    public class conciergeboletoscineFiller implements com.ike.model.LlenaDatos{
        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException{
            ConciergeBoletosCine conciergeboletoscine = new ConciergeBoletosCine();
            conciergeboletoscine.setclBoletoCine(rs.getString("clBoletoCine"));
            conciergeboletoscine.setclAsistencia(rs.getString("clAsistencia"));
            conciergeboletoscine.setNumAdultos(rs.getString("NumAdultos"));
            conciergeboletoscine.setNumNinos(rs.getString("NumNinos"));
            conciergeboletoscine.setEdades(rs.getString("Edades"));
            conciergeboletoscine.setPelicula(rs.getString("Pelicula"));
            conciergeboletoscine.setFechaIni(rs.getString("FechaIni"));
            conciergeboletoscine.setdsComplejo(rs.getString("dsComplejo"));
            conciergeboletoscine.setdsSala(rs.getString("dsSala"));
            conciergeboletoscine.setclReservaCompra(rs.getString("clReservaCompra"));
            conciergeboletoscine.setdsReservaCompra(rs.getString("dsReservaCompra"));
            conciergeboletoscine.setclTipoPago(rs.getString("clTipoPago"));
            conciergeboletoscine.setdsTipoPago(rs.getString("dsTipoPago"));
            conciergeboletoscine.setNomBanco(rs.getString("NomBanco"));
            conciergeboletoscine.setNombreTC(rs.getString("NombreTC"));
            conciergeboletoscine.setCargo(rs.getString("Cargo"));
            conciergeboletoscine.setNumTarjeta(rs.getString("NumTarjeta"));
            conciergeboletoscine.setExpiraTarjeta2(rs.getString("ExpiraTarjeta2"));
            conciergeboletoscine.setExpiraTarjeta(rs.getString("ExpiraTarjeta"));
            conciergeboletoscine.setClaveTarjeta(rs.getString("ClaveTarjeta"));
            conciergeboletoscine.setCalleNum(rs.getString("CalleNum"));
            conciergeboletoscine.setCP(rs.getString("CP"));
            conciergeboletoscine.setColonia(rs.getString("Colonia"));
            conciergeboletoscine.setclCiudad(rs.getString("clCiudad"));
            conciergeboletoscine.setdsEntFed(rs.getString("dsEntFed"));
            conciergeboletoscine.setCodEnt(rs.getString("CodEnt"));
            conciergeboletoscine.setCodMD(rs.getString("CodMD"));
            conciergeboletoscine.setdsMunDel(rs.getString("dsMunDel"));
            conciergeboletoscine.setConfirmo(rs.getString("Confirmo"));
            conciergeboletoscine.setNumConfimacion(rs.getString("NumConfimacion"));
            conciergeboletoscine.setCancelacion(rs.getString("Cancelacion"));
            conciergeboletoscine.setNUInfoK(rs.getString("NUInfoK"));
            conciergeboletoscine.setComentarios(rs.getString("Comentarios"));
            conciergeboletoscine.setclEstatus(rs.getString("clEstatus"));
            conciergeboletoscine.setdsEstatus(rs.getString("dsEstatus"));
            conciergeboletoscine.setFechaRegistro(rs.getString("FechaRegistro"));

            return conciergeboletoscine;
        }
    }
}
