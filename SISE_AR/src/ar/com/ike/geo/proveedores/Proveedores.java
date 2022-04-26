/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ar.com.ike.geo.proveedores;

import Utilerias.UtileriasBDF;
import ar.com.ike.geo.ws.tns.Application;
import ar.com.ike.geo.ws.tns.Application_Service;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 * @author ddiez
 */

public class Proveedores {
    private List<Proveedor> pvds = null;
    
    private List<Proveedor> getListaCLProveedores() {
        List<Proveedor> ret = new ArrayList();
        try {
            String strSql = "st_GEOListaCLPrestadores";
            ResultSet rs = UtileriasBDF.rsSQLNP(strSql);
            while( rs.next() ) {
                Proveedor pvd = new Proveedor();
                pvd.setClProveedor(String.valueOf(rs.getInt("clProveedor")));
                pvd.setNombreOpe(rs.getString("NombreOpe"));
                pvd.setClPais(rs.getString("clPais"));
                pvd.setCodEnt(rs.getString("codEnt"));
                pvd.setDsEntFed(rs.getString("dsEntFed"));
                pvd.setCodMD(rs.getString("codMd"));
                pvd.setDsMunDel(rs.getString("dsMunDel"));
                pvd.setHorario(rs.getString("horario"));
                pvd.setActivo(rs.getBoolean("activo"));
                pvd.setDireccion(rs.getString("calle"));
                pvd.setLatLong( rs.getString("Lat_Long"));
                pvd.setAlias( rs.getString("alias"));
                pvd.setActivoAA( rs.getBoolean("ActivoAA") );
                pvd.setAreaOperativa( rs.getString("dsAreaOperativa"));
                ret.add(pvd);
            }
            rs.close();
            rs = null;
        } catch (Exception e) {
            System.out.println("Proveedores.java.getListaCLProveedores.Error:" + e.toString());
        }
        return ret;
    }

    public List<Proveedor> getProveedores( ) {
        List<Proveedor> proveedores = getListaCLProveedores();
        String strSql = "st_GEODetallePrestador ? ";
        try {
            Connection cnx = UtileriasBDF.getConnection();
            PreparedStatement ps = cnx.prepareStatement( strSql );
            for (Proveedor proveedor : proveedores) {
                ps.setString(1, proveedor.getClProveedor());
                ResultSet rs = ps.executeQuery();
                completarProveedor(proveedor, rs);
                rs.close();
                rs = null;
            }
        } catch (Exception e) {
            System.out.println("Proveedores.java.getProveedores.Error:" + e.toString() );
        }
        this.pvds = proveedores;
        return proveedores;
    }
    
    private Proveedor completarProveedor(Proveedor pvd, ResultSet rs ) {
        boolean bFirst=true;
        try {
            int i=0;
            while (rs.next()) {
                if (bFirst) {
                    pvd.setClServicio(String.valueOf(rs.getString("clServicio")));
                    pvd.setDsServicio(rs.getString("dsServicio"));
                    //pvd.setClSubServicio(String.valueOf(rs.getString("clSubServicio")));
                    bFirst=false;
                }
                i++;
                pvd.addCobCodEnt(rs.getString("CobCodEnt"));
                pvd.addCobDsEntFed(rs.getString("CobDSEntFed"));
                pvd.addCobPrioridad(String.valueOf(rs.getString("prioridad")));
                //pvd.addCodMD(rs.getString("CobCodMD"));
                pvd.addCodMD(rs.getString("IdGeoLoc"));
                pvd.addDsMunDel(rs.getString("CobDSMunDel"));
                pvd.addSubServicio(rs.getString("dsSubServicio"));
            }
            //System.out.println("Cargado:" + pvd.getClProveedor() + ":: Coberturas:" + String.valueOf(i) );
            return pvd;
        } catch (Exception ex) {
            System.out.println("Proveedores.completarProveedor.Error:" + ex.toString() );
        }
        return null;
    }
    
    private String replaceForXMLChars(String tmp) {
        return  "<![CDATA[" + tmp + "]]>";
    }
    
    public boolean send() {
        try {
            Application_Service sis = new Application_Service();
            Application app = sis.getApplication();
            if ( this.pvds != null ) {
                for (Proveedor pvd : pvds) {
                    try {
                            String ikePrestador = app.ikePrestador( pvd.getClProveedor(), replaceForXMLChars(pvd.getNombreOpe()), replaceForXMLChars(pvd.getRazonSocial()),
                                    pvd.getTitular(), pvd.getCuit(), (pvd.getActivo()?"1":"0"), pvd.getClPais(), pvd.getDsEntFed(), pvd.getDsMunDel(),
                                    replaceForXMLChars(pvd.getDireccion()), pvd.getLatLong(),  pvd.getHorario(), pvd.getEmail(), pvd.getTelefono(), "", pvd.getAreaOperativa(),
                                    pvd.getAlias(), (pvd.getActivoAA()?"1":"0"),
                                    pvd.getCobDsEntFed(), pvd.getCobSubServicio(), pvd.getCobCodMD(), pvd.getCobPrioridad() );
                            System.out.println( pvd.getClProveedor() + "Alta Prestador: " + ikePrestador);
                    }
                    catch (Exception e) {
                        System.out.println("Proveedores.send.Error:" + e.toString() );
                    }
                }
            }
            app.ikePrestadorProcess();
        }
        catch (Exception e) {
            System.out.println("Proveedores.send.Error2:" + e.toString() );
            return false;
        }
        return true;
    }
}
