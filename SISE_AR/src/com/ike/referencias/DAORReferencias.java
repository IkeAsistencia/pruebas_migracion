
package com.ike.referencias;

import com.ike.referencias.to.RReferencias;
import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;

/*
 *
 * @author rurbina
 */
public class DAORReferencias extends com.ike.model.DAOBASE {

    /* Creates a new instance of DAORReferencias */
    public DAORReferencias() {
    }

    public RReferencias getRReferencias(String clRReferencias, String clExpediente) throws DAOException {
        StringBuffer sb = new StringBuffer();
        Collection col = null;

        sb.append("st_RReferencias ").append(clRReferencias).append(",").append(clExpediente);
        System.out.println(sb);
        col = this.rsSQLNP(sb.toString(), new RReferenciasFiller());

        Iterator it = col.iterator();
        return it.hasNext() ? (RReferencias) it.next() : null;

    }

    public class RReferenciasFiller implements com.ike.model.LlenaDatos {

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            RReferencias RR = new RReferencias();

            RR.setClRReferencias(rs.getString("clRReferencias"));
            RR.setFechadeApertura(rs.getString("FechadeApertura"));
            RR.setClCuenta(rs.getString("clCuenta"));
            RR.setDsCuenta(rs.getString("dsCuenta"));
            RR.setNombredelUsuario(rs.getString("NombredelUsuario"));
            RR.setClave(rs.getString("Clave"));
            RR.setCorreo(rs.getString("Correo"));
            RR.setTelefono(rs.getString("Telefono"));
            RR.setCodEnt(rs.getString("CodEnt"));
            RR.setDsEntFed(rs.getString("dsEntFed"));
            RR.setCodMD(rs.getString("CodMD"));
            RR.setDsMunDel(rs.getString("dsMunDel"));
            /*RR.setclRTipodeReferencia(rs.getString("clRTipodeReferencia"));
            RR.setdsRTipodeReferencia(rs.getString("dsRTipodeReferencia"));*/
            RR.setInformacionSol(rs.getString("InformacionSol"));
            RR.setInformacionPro(rs.getString("InformacionPro"));
            RR.setLigaPro(rs.getString("LigaPro"));
            RR.setClRInfo(rs.getString("clRInfo"));
            RR.setDsRinfo(rs.getString("dsRinfo"));
            RR.setClMascotaRef(rs.getString("clMascotaRef"));
            RR.setDsMascotaRef(rs.getString("dsMascotaRef"));
            RR.setClRTipoRecreacion(rs.getString("clRTipoRecreacion"));
            RR.setDsRTipoRecreacion(rs.getString("dsRTipoRecreacion"));
            RR.setClSexo(rs.getString("clSexo"));
            RR.setDsSexo(rs.getString("dsSexo"));
            RR.setPeso(rs.getString("Peso"));
            RR.setEdad(rs.getString("Edad"));
            RR.setClEstatus(rs.getString("clEstatus"));
            RR.setDsEstatus(rs.getString("dsEstatus"));
            RR.setClServicio(rs.getString("clServicio"));
            RR.setDsServicio(rs.getString("dsServicio"));
            RR.setClSubServicio(rs.getString("clSubServicio"));
            RR.setDsSubServicio(rs.getString("dsSubServicio"));
            RR.setClRTipoPersonal(rs.getString("clRTipoPersonal"));
            RR.setDsRTipoPersonal(rs.getString("dsRTipoPersonal"));
            RR.setClRTipoContrato(rs.getString("clRTipoContrato"));
            RR.setDsRTipoContrato(rs.getString("dsRTipoContrato"));
            RR.setClRCampus(rs.getString("clRCampus"));
            RR.setDsRCampus(rs.getString("dsRCampus"));
            RR.setUbicacion(rs.getString("Ubicacion"));
            RR.setClLaboratorios(rs.getString("clLaboratorios"));
            RR.setDsLaboratorios(rs.getString("dsLaboratorios"));
            RR.setSerie(rs.getString("Serie"));
            RR.setFlotilla(rs.getString("Flotilla"));
            RR.setNoVehiculo(rs.getString("NoVehiculo"));
            RR.setConductor(rs.getString("Conductor"));

            return RR;
        }
    }
}
