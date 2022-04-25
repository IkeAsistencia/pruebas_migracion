/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ar.com.ike.geo.proveedores;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author ddiez
 */
public class Proveedor {
    private String   clProveedor   = null;
    private String   nombreOpe     = null;
    private String   razonSocial   = null;
    private String   titular       = null; 
    private String   cuit          = null;
    private String   clPais        = null;  
    private String   codEnt        = null;
    private String   dsEntFed      = null;
    private String   codMD         = null;
    private String   dsMunDel      = null;
    private String   direccion     = null;
    private String   email         = null;
    private String   telefono      = null; 
    private String   areaOperativa = null;
    private String   clServicio    = null;
    private String   dsServicio    = null;
    private String   clSubServicio = null;
    private String   dsSubServicio = null;
    private String   horario       = null;
    private boolean  activo        = false;
    private boolean  activoAA      = false;
    private String   LatLong       = null;
    private String   alias         = null;
    
    private List<String> cobCodEnt     = null;
    private List<String> cobDsEntFed   = null;
    private List<String> cobCodMD      = null;
    private List<String> cobDsMunDel   = null;
    private List<String> cobPrioridad  = null;
    private List<String> cobServicios  = null;
    private List<String> cobSubServicios = null;
    

     public Proveedor() {
        cobCodEnt    = new ArrayList();
        cobDsEntFed  = new ArrayList();
        cobCodMD     = new ArrayList();
        cobDsMunDel  = new ArrayList();
        cobPrioridad = new ArrayList();
        cobServicios = new ArrayList();
        cobSubServicios = new ArrayList();
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public String getRazonSocial() {
        return razonSocial;
    }

    public void setRazonSocial(String razonSocial) {
        this.razonSocial = razonSocial;
    }

    public String getTitular() {
        return titular;
    }

    public void setTitular(String titular) {
        this.titular = titular;
    }

    public String getCuit() {
        return cuit;
    }

    public void setCuit(String cuit) {
        this.cuit = cuit;
    }
    public void addServicio( String s) {
        this.cobServicios.add(s);
    }
    public void addSubServicio( String s ){
        this.cobSubServicios.add(s);
    }
    public void addCobCodEnt(String codEnt ){
        this.cobCodEnt.add(codEnt);
    }
    public void addCobDsEntFed(String dsEntFed) {
        this.cobDsEntFed.add(dsEntFed);
    }
    public void addCodMD(String codMD){
        this.cobCodMD.add(codMD);
    }
    public void addDsMunDel(String dsMunDel){
        this.cobDsMunDel.add(dsMunDel);
    }
    public void addCobPrioridad(String prioridad){
        this.cobPrioridad.add(prioridad);
    }
    
    public List<String> getCobServicio() {
        return this.cobServicios;
    }
    public List<String> getCobSubServicio(){
        return this.cobSubServicios;
    }
    
    public List<String> getCobCodEnt() {
        return cobCodEnt;
    }

    public List<String> getCobDsEntFed() {
        return cobDsEntFed;
    }

    public List<String> getCobCodMD() {
        return cobCodMD;
    }

    public List<String> getCobDsMunDel() {
        return cobDsMunDel;
    }

    public List<String> getCobPrioridad() {
        return cobPrioridad;
    }


    public String getClProveedor() {
        return clProveedor;
    }

    public void setClProveedor(String clProveedor) {
        this.clProveedor = clProveedor;
    }

    public String getNombreOpe() {
        return nombreOpe;
    }

    public void setNombreOpe(String nombreOpe) {
        this.nombreOpe = nombreOpe;
    }

    public String getClPais() {
        return clPais;
    }

    public void setClPais(String clPais) {
        this.clPais = clPais;
    }

    public String getCodEnt() {
        return codEnt;
    }

    public void setCodEnt(String codEnt) {
        this.codEnt = codEnt;
    }

    public String getDsEntFed() {
        return dsEntFed;
    }

    public void setDsEntFed(String dsEntFed) {
        this.dsEntFed = dsEntFed;
    }

    public String getCodMD() {
        return codMD;
    }

    public void setCodMD(String codMD) {
        this.codMD = codMD;
    }

    public String getDsMunDel() {
        return dsMunDel;
    }

    public void setDsMunDel(String dsMunDel) {
        this.dsMunDel = dsMunDel;
    }

    public String getClServicio() {
        return clServicio;
    }

    public void setClServicio(String clServicio) {
        this.clServicio = clServicio;
    }

    public String getDsServicio() {
        return dsServicio;
    }

    public void setDsServicio(String dsServicio) {
        this.dsServicio = dsServicio;
    }

    public String getClSubServicio() {
        return clSubServicio;
    }

    public void setClSubServicio(String clSubServicio) {
        this.clSubServicio = clSubServicio;
    }

    public String getDsSubServicio() {
        return dsSubServicio;
    }

    public void setDsSubServicio(String dsSubServicio) {
        this.dsSubServicio = dsSubServicio;
    }

    public String getHorario() {
        return horario;
    }

    public void setHorario(String horario) {
        this.horario = horario;
    }

    public String getEmail() {
        return this.email;
    }
    
    public void setEmail(String e) {
        this.email = e;
    }
    
    public String getTelefono() {
        return this.telefono;
    }
    public void setTelefono(String t) {
        this.telefono = t;
    }

    public String getAreaOperativa() {
        return this.areaOperativa;
    }
    
    public void setAreaOperativa(String a) {
        this.areaOperativa = a;
    }

    public boolean getActivo() {
        return this.activo;
    }
    
    public void setActivo(boolean a) {
        this.activo = a;
    }
    
    public boolean getActivoAA() {
        return this.activoAA;
    }
    
    public void setActivoAA(boolean a) {
        this.activoAA = a;
    }

    public void setLatLong(String t) {
        this.LatLong = t;
    }

    public String getLatLong() {
        return this.LatLong;
    }

    public void setAlias(String t) {
        this.alias= t;
    }

    public String getAlias() {
        return this.alias;
    }
}
