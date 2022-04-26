package com.ike.model;

import com.ike.model.to.Usuario;
import java.util.Collection;
import java.util.Iterator;

public class DAOSeguridad extends DAOBASE {
//------------------------------------------------------------------------------    
    public Usuario getUsuario(String user, String password, String ip) throws DAOException {
        StringBuffer sb = new StringBuffer();
        Collection col = null;
        sb.append("dbo.sp_EncriptDesEncriptPassword '").append(user).append("',1,'','").append(password).append("','").append(ip).append("'");
        col = this.rsSQLNP(sb.toString(), new UsuarioFiller());
        Iterator it = col.iterator();
        return it.hasNext() ? (Usuario) it.next() : null;
        }
//------------------------------------------------------------------------------    
    public class UsuarioFiller implements LlenaDatos {
        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            Usuario usuario = new Usuario();
            usuario.setActivo(rs.getString("Activo"));
            usuario.setMess(rs.getString("strMess"));
            usuario.setClUsrApp(rs.getString("clUsrApp"));
            usuario.setPassword(rs.getString("password"));
            usuario.setNombre(rs.getString("Nombre"));
            usuario.setFechaAlta(rs.getString("FechaAlta"));
            usuario.setFechaInicio(rs.getString("FechaInicio"));
            usuario.setCorreo(rs.getString("Correo"));
            usuario.setAgente(rs.getString("Agente"));
            usuario.setCambioPwd(rs.getString("CambioPwd"));
            usuario.setWebPhone(rs.getString("WebPhone"));
            usuario.setPhoneClass(rs.getString("PhoneClass"));
            usuario.setAccesoID(rs.getString("AccesoId"));
            usuario.setPermisoDesbloqueo(rs.getString("PermiteDesbWeb"));
            usuario.setAlertaApp(rs.getString("alertaApp"));
            usuario.setValidaDobleFactor(rs.getString("ValidaDobleFactor"));
            return usuario;
        }
    }
}