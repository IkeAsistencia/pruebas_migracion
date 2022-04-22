/*
 * CSReferencia.java
 *
 * Created on 7 de septiembre de 2006, 03:38 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */   

package com.ike.concierge.to;

/*
 *
 * @author cabrerar
 */
public class CSReferencia {

    private int clReferencia;
    private String NomEstablec;
    private String NomAlter;
    private int clCategoria;
    private String dsCategoria;
    private int clSubCategoria;
    private String dsSubCategoria;
    private String CalleNum;
    private String EntreCalles;
    private int clPais;
    private String dsPais;
    private int clCiudad;
    private String dsCiudad;
    private int clZona;
    private String dsZona;
    private String CodEnt;
    private String dsEntFed;
    private String CodMD;
    private String dsMunDel;
    private String Colonia;
    private String CP;
    private String Horario;
    private String Notas;
    private String VISA;
    private String MasterCard;
    private String AMEX;
    private String Dinners;
    private String TDebito;
    private String Efectivo;
    private String Contacto;
    private String FechaAlta;
    private String Activo;

    private String Entidad;
    private String Ciudad;
    private String RutaLogo;
    private String RutaURL;
    
    /* Creates a new instance of CSReferencia */
    public CSReferencia() {
    }

    public int getClReferencia() {
        return clReferencia;
    }

    public void setClReferencia(int clReferencia) {
        this.clReferencia = clReferencia;
    }

    public String getNomEstablec() {
        return NomEstablec;
    }

    public void setNomEstablec(String NomEstablec) {
        this.NomEstablec = NomEstablec;
    }

    public String getNomAlter() {
        return NomAlter;
    }

    public void setNomAlter(String NomAlter) {
        this.NomAlter = NomAlter;
    }

    public int getClCategoria() {
        return clCategoria;
    }

    public void setClCategoria(int clCategoria) {
        this.clCategoria = clCategoria;
    }

    public int getClSubCategoria() {
        return clSubCategoria;
    }

    public void setClSubCategoria(int clSubCategoria) {
        this.clSubCategoria = clSubCategoria;
    }

    public String getCalleNum() {
        return CalleNum;
    }

    public void setCalleNum(String CalleNum) {
        this.CalleNum = CalleNum;
    }

    public String getEntreCalles() {
        return EntreCalles;
    }

    public void setEntreCalles(String EntreCalles) {
        this.EntreCalles = EntreCalles;
    }

    public int getClPais() {
        return clPais;
    }

    public void setClPais(int clPais) {
        this.clPais = clPais;
    }

    public String getCodEnt() {
        return CodEnt;
    }

    public void setCodEnt(String CodEnt) {
        this.CodEnt = CodEnt;
    }

    public String getCodMD() {
        return CodMD;
    }

    public void setCodMD(String CodMD) {
        this.CodMD = CodMD;
    }

    public String getColonia() {
        return Colonia;
    }

    public void setColonia(String Colonia) {
        this.Colonia = Colonia;
    }

    public String getCP() {
        return CP;
    }

    public void setCP(String CP) {
        this.CP = CP;
    }

    /////    CAMPOS NUEVOS
      public String getEntidad() {
        return Entidad;
    }

    public void setEntidad(String Entidad) {
        this.Entidad = Entidad;
    }
    
     public String getCiudad() {
        return Ciudad;
    }

    public void setCiudad(String Ciudad) {
        this.Ciudad = Ciudad;
    }
    
    
    public String getHorario() {
        return Horario;
    }

    public void setHorario(String Horario) {
        this.Horario = Horario;
    }

    public String getNotas() {
        return Notas;
    }

    public void setNotas(String Notas) {
        this.Notas = Notas;
    }
//---------------------------------------------------------
    
    public String getVISA()
    {
        return VISA;
    }

    public void setVISA(String VISA)
    {
        this.VISA = VISA;
    }

    public String getMasterCard()
    {
        return MasterCard;
    }

    public void setMasterCard(String MasterCard)
    {
        this.MasterCard = MasterCard;
    }
    
    public String getAMEX()
    {
        return AMEX;
    }

    public void setAMEX(String AMEX)
    {
        this.AMEX = AMEX;
    }
    
        public String getDinners()
    {
        return Dinners;
    }

    public void setDinners(String Dinners)
    {
        this.Dinners = Dinners;
    }

//---------------------------------------------------------    
    public String getTDebito() {
        return TDebito;
    }

    public void setTDebito(String TDebito) {
        this.TDebito = TDebito;
    }

    public String getEfectivo() {
        return Efectivo;
    }

    public void setEfectivo(String Efectivo) {
        this.Efectivo = Efectivo;
    }
    
    public String getContacto() {
        return Contacto;
    }

    public void setContacto(String Contacto) {
        this.Contacto = Contacto;
    }

    public String getFechaAlta() {
        return FechaAlta;
    }

    public void setFechaAlta(String FechaAlta) {
        this.FechaAlta = FechaAlta;
    }

    public String getActivo() {
        return Activo;
    }

    public void setActivo(String  Activo) {
        this.Activo = Activo;
    }

    public String getDsCategoria() {
        return dsCategoria;
    }

    public void setDsCategoria(String dsCategoria) {
        this.dsCategoria = dsCategoria;
    }

    public String getDsSubCategoria() {
        return dsSubCategoria;
    }

    public void setDsSubCategoria(String dsSubCategoria) {
        this.dsSubCategoria = dsSubCategoria;
    }

    public String getDsPais() {
        return dsPais;
    }

    public void setDsPais(String dsPais) {
        this.dsPais = dsPais;
    }

    public String getDsEntFed() {
        return dsEntFed;
    }

    public void setDsEntFed(String dsEntFed) {
        this.dsEntFed = dsEntFed;
    }

    public String getDsMunDel() {
        return dsMunDel;
    }

    public void setDsMunDel(String dsMunDel) {
        this.dsMunDel = dsMunDel;
    }

    public int getClCiudad() {
        return clCiudad;
    }

    public void setClCiudad(int clCiudad) {
        this.clCiudad = clCiudad;
    }

    public String getDsCiudad() {
        return dsCiudad;
    }

    public void setDsCiudad(String dsCiudad) {
        this.dsCiudad = dsCiudad;
    }

    public int getClZona() {
        return clZona;
    }

    public void setClZona(int clZona) {
        this.clZona = clZona;
    }

    public String getDsZona() {
        return dsZona;
    }

    public void setDsZona(String dsZona) {
        this.dsZona = dsZona;
    }

    public String getRutaLogo() {
        return RutaLogo;
    }

    public void setRutaLogo(String RutaLogo) {
        this.RutaLogo = RutaLogo;
    }

    public String getRutaURL() {
        return RutaURL;
    }

    public void setRutaURL(String RutaURL) {
        this.RutaURL = RutaURL;
    }

    /*
     * Holds value of property telefono.
     */
    private String telefono;

    /*
     * Getter for property telefono.
     * @return Value of property telefono.
     */
    public String getTelefono() {
        return this.telefono;
    }

    /*
     * Setter for property telefono.
     * @param telefono New value of property telefono.
     */
    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

 
       
}
