package com.ike.operacion;


import com.ike.operacion.to.AltaNU;
import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;

        /*
         *
         * @author escobarm
         */
        
        public class DAOAltaNU extends com.ike.model.DAOBASE {
    
    /* Creates a new instance of DAODatosPaciente */
    
    public DAOAltaNU() {
    }
    
    public AltaNU getAltaNU(String clLlamadaAlta) throws DAOException {
        StringBuffer sb = new StringBuffer();
        Collection col = null;
        
        
        sb.append("sp_getLlamadaAltaNU ").append(clLlamadaAlta);
        
        
        col = this.rsSQLNP(sb.toString(), new AltaNUFiller());
        
        Iterator it = col.iterator();
        return it.hasNext() ? (AltaNU) it.next() : null;
        
    }
    
    public class AltaNUFiller implements com.ike.model.LlenaDatos
            
    {
        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
                        
            AltaNU alta = new AltaNU();
                        
            alta.setClAfiliado(rs.getString("ClAfiliado"));
            alta.setAnio(rs.getString("modelo"));
            alta.setCP(rs.getString("cp"));
            alta.setCalle(rs.getString("Calle"));
            alta.setClave(rs.getString("clave"));
            alta.setCodEnt(rs.getString("CodEnt"));
            alta.setCodMD(rs.getString("CodMD"));
            alta.setColonia(rs.getString("Colonia"));
            alta.setDescAuto(rs.getString("DescAuto"));
            alta.setDsEntFed(rs.getString("dsEntFed"));
            alta.setDsMunDel(rs.getString("dsMunDel"));
            alta.setEmpresa(rs.getString("Empresa"));
            alta.setFechaNac(rs.getString("FechaNac"));
            alta.setFolio(rs.getString("clLlamaAltaNU"));
            alta.setIdCliente(rs.getString("id_Cliente"));
            alta.setNombre(rs.getString("Nombre"));
            alta.setNombrecta(rs.getString("NombreC"));
            alta.setTelefono(rs.getString("Telefono"));    
            alta.setClCuenta(rs.getString("clCuenta"));
            alta.setClLlamada(rs.getString("clLlamaAltaNU"));
            
            return alta;
        }
    }
}