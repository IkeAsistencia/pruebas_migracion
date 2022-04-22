package com.ike.model;

import Seguridad.ValidaSql;
import Utilerias.ResultList;
import com.ike.model.to.AutenticacionError;
import com.ike.model.to.Usuario;
import com.ike.model.to.UsuarioAutenticacion;
import java.util.Random;

public class DAOUsuarioAutenticacion extends DAOBASE {
//----------------------------------------------------------------	
    public DAOUsuarioAutenticacion() { }
//----------------------------------------------------------------	
    public String insertUsuarioAutenticaion(Usuario usuario) {
        String sesionID = null;
        UsuarioAutenticacion usuarioAutenticacion = new UsuarioAutenticacion();
        usuarioAutenticacion.setUsrApp(usuario.getClUsrApp());
        usuarioAutenticacion.setNombre(usuario.getNombre());
        usuarioAutenticacion.setCorreo(usuario.getCorreo());
        Random random = new Random();
        int numero = random.nextInt(999999);
        usuarioAutenticacion.setCodigoValidacion(String.format("%06d", numero));
        ResultList rs = new ResultList();
        rs.rsSQL(createQuery(usuarioAutenticacion));
        if (rs.next()) {    sesionID = rs.getString("sesionID");      }
        rs.close();
        return sesionID;
		}
//----------------------------------------------------------------
    public AutenticacionError verificaCodigo(String id, String codigo) {
        AutenticacionError error = new AutenticacionError();
        ResultList rs = new ResultList();
        rs.rsSQL("dbo.st_VerificaAutenticacion '"+id+"','"+codigo+"'");
        if (rs.next()) {
            if (rs.getInt("error") != 0) {
               error.setMensaje(rs.getString("mensaje"));
               error.setCodigo(Integer.toString(rs.getInt("error")));
                }                       
            }
        rs.close();        
        return error;
	}
//----------------------------------------------------------------
    private String createQuery(UsuarioAutenticacion usuario) {
        String query;
        query = (new StringBuilder("dbo.st_InsertUsuarioAutenticacion '")
                .append(ValidaSql.limpiaSql(usuario.getUsrApp())).append("','")
                .append(ValidaSql.limpiaSql(usuario.getNombre())).append("','")
                .append(ValidaSql.limpiaSql(usuario.getCorreo())).append("','")
                .append(ValidaSql.limpiaSql(usuario.getCodigoValidacion())).append("'").toString());
        return query;
		}
//----------------------------------------------------------------
}