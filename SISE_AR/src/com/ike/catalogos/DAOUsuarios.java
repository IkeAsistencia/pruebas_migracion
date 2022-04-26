package com.ike.catalogos;

import com.ike.catalogos.to.Usuarios;
import com.ike.model.DAOException;
import java.util.Collection;
import java.util.Iterator;

public class DAOUsuarios extends com.ike.model.DAOBASE {
//------------------------------------------------------------------------------    
    public DAOUsuarios() {    }
//------------------------------------------------------------------------------
    public Usuarios getUsuarios(String clUsrApp) throws DAOException {
        StringBuffer sb = new StringBuffer();
        Collection col = null;
        sb.append("sp_MuestraUsuario ").append(clUsrApp);
        col = this.rsSQLNP(sb.toString(), new UsuariosFiller());
        Iterator it = col.iterator();
        return it.hasNext() ? (Usuarios) it.next() : null;
    }
//------------------------------------------------------------------------------
    public class UsuariosFiller implements com.ike.model.LlenaDatos {
        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            Usuarios usuarios = new Usuarios();
            usuarios.setClUsrApp(rs.getString("clUsrApp"));
            usuarios.setUsuario(rs.getString("Usuario"));
            usuarios.setNombre(rs.getString("Nombre"));
            usuarios.setActivo(rs.getString("Activo"));
            usuarios.setFechaAlta(rs.getString("FechaAlta"));
            usuarios.setFechaUltAcceso(rs.getString("FechaUltAcceso"));
            usuarios.setFechaCambioPwd(rs.getString("FechaCambioPwd"));
            usuarios.setTipoHorario(rs.getString("TipoHorario"));
            usuarios.setClTipoHorario(rs.getString("clTipoHorario"));
            usuarios.setRestringeProv(rs.getString("RestringeProv"));
            usuarios.setRestringeClie(rs.getString("RestringeClie"));
            usuarios.setAgente(rs.getString("Agente"));
            usuarios.setNumEmpleado(rs.getString("NumEmpleado"));
            usuarios.setClArea(rs.getString("clArea"));
            usuarios.setDsAreaUsuario(rs.getString("dsAreaUsuario"));
            usuarios.setClCentroCosto(rs.getString("clCentroCosto"));
            usuarios.setDsCentroCosto(rs.getString("dsCentroCosto"));
            usuarios.setFechaBaja(rs.getString("FechaBaja"));
            usuarios.setClPerfilOperativo(rs.getString("clPerfilOperativo"));
            usuarios.setDsPerfilOperativo(rs.getString("dsPerfilOperativo"));
            usuarios.setValidaDobleFactor(rs.getString("ValidaDobleFactor"));
            usuarios.setCorreo(rs.getString("Correo"));
            return usuarios;
        }
    }
//------------------------------------------------------------------------------    
}