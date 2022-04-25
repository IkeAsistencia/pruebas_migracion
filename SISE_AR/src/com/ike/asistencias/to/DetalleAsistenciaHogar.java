package com.ike.asistencias.to;

public class DetalleAsistenciaHogar
{
  private String clExpediente;
  private String Colonia;
  private String Calle;
  private String Referencias;
  private String CodEnt;
  private String dsEntFed;
  private String CodMD;
  private String dsMunDel;
  private String CP;
  private String clTipoSolucion;
  private String dsTipoSolucion;
  private String Verificador;
  private String MotivoServicio;
  private String TiempoCobertura;
  private String ObsInfo;
  private String Cobertura;
  private String Costo;
  private String FueraZona;
  private String VisitasVer;
  private String GestionF;
  private String InformeF;
  private String clUbFallaH;
  private String clTipoFallaH;
  private String dsUbFallaH;
  private String dsTipoFallaH;
  private String clGarantiaHogar;
  private String dsGarantiaHogar;
  private String latLong;
  //Nuevas columnas para HDI CRI
  private String clUbFallaHLugar;
  private String dsUbFallaHLugar;
  private String QuienSeComunica;
  private String NecesitaProvisorio;
  private String clTipoCristalH;
  private String dsTipoCristalH;
  private String clMotivoSiniestroH;
  private String dsMotivoSiniestroH;
  private String fechaSiniestro;
  private String clTipoContactante;
  private String CoberturaFin;
  private String Poliza;
  private String dsTipoContactante;
  private String horaCita;
  private String OtroMotivoSiniestro;
  private String OtroTipoCristal;
  private String OtroTipoContactante;
//------------------------------------------------------------------------------
    public String getClTipoContactante() {        return clTipoContactante;    }
    public void setClTipoContactante(String clTipoContactante) {        this.clTipoContactante = clTipoContactante;    }
//------------------------------------------------------------------------------
    public String getDsTipoContactante() {        return dsTipoContactante;    }
    public void setDsTipoContactante(String dsTipoContactante) {        this.dsTipoContactante = dsTipoContactante;    }
//------------------------------------------------------------------------------
    public String getCP()  {    return this.CP;  }
    public void setCP(String CP)  {    this.CP = CP;  }
//------------------------------------------------------------------------------  
    public String getCalle()  {    return this.Calle;  }
    public void setCalle(String Calle)  {    this.Calle = Calle;  }
//------------------------------------------------------------------------------
    public String getCodEnt() {    return this.CodEnt;  }
    public void setCodEnt(String CodEnt)  {    this.CodEnt = CodEnt;  }
//------------------------------------------------------------------------------  
    public String getCodMD() {    return this.CodMD;  }
    public void setCodMD(String CodMD)  {    this.CodMD = CodMD;  }
//------------------------------------------------------------------------------  
    public String getColonia()    {      return this.Colonia;    }
    public void setColonia(String Colonia)    {      this.Colonia = Colonia;    }
//------------------------------------------------------------------------------
    public String getMotivoServicio()    {      return this.MotivoServicio;    }
    public void setMotivoServicio(String MotivoServicio)    {      this.MotivoServicio = MotivoServicio;    }
//------------------------------------------------------------------------------
    public String getReferencias()    {      return this.Referencias;    }
    public void setReferencias(String Referencias)    {      this.Referencias = Referencias;    }
//------------------------------------------------------------------------------
    public String getTiempoCobertura()    {      return this.TiempoCobertura;    }
    public void setTiempoCobertura(String TiempoCobertura)    {      this.TiempoCobertura = TiempoCobertura;    }
//------------------------------------------------------------------------------
    public String getVerificador()    {      return this.Verificador;    }
    public void setVerificador(String Verificador)    {      this.Verificador = Verificador;    }
//------------------------------------------------------------------------------
    public String getClExpediente()    {      return this.clExpediente;    }
    public void setClExpediente(String clExpediente)    {      this.clExpediente = clExpediente;    }
//------------------------------------------------------------------------------
    public String getClTipoSolucion() {      return this.clTipoSolucion;    }
    public void setClTipoSolucion(String clTipoSolucion)    {      this.clTipoSolucion = clTipoSolucion;    }
//------------------------------------------------------------------------------
    public String getDsEntFed()    {      return this.dsEntFed;    }
    public void setDsEntFed(String dsEntFed)    {      this.dsEntFed = dsEntFed;    }
//------------------------------------------------------------------------------
    public String getDsMunDel()    {      return this.dsMunDel;    }
    public void setDsMunDel(String dsMunDel)    {      this.dsMunDel = dsMunDel;    }
//------------------------------------------------------------------------------
    public String getDsTipoSolucion()   {      return this.dsTipoSolucion;    }
    public void setDsTipoSolucion(String dsTipoSolucion)    {      this.dsTipoSolucion = dsTipoSolucion;    }
//------------------------------------------------------------------------------
    public String getObsInfo()    {      return this.ObsInfo;    }
    public void setObsInfo(String ObsInfo)    {      this.ObsInfo = ObsInfo;    }
//------------------------------------------------------------------------------
    public String getCobertura()    {      return this.Cobertura;    }
    public void setCobertura(String Cobertura)    {      this.Cobertura = Cobertura;    }
//------------------------------------------------------------------------------
    public String getCosto()    {      return this.Costo;    }
    public void setCosto(String Costo)    {      this.Costo = Costo;    }
//------------------------------------------------------------------------------
    public String getFueraZona()    {      return this.FueraZona;    }
    public void setFueraZona(String FueraZona)    {      this.FueraZona = FueraZona;    }
//------------------------------------------------------------------------------
    public String getVisitasVer()    {      return this.VisitasVer;    }
    public void setVisitasVer(String VisitasVer)    {      this.VisitasVer = VisitasVer;    }
//------------------------------------------------------------------------------
    public String getGestionF()    {      return this.GestionF;    }
    public void setGestionF(String GestionF)    {      this.GestionF = GestionF;    }
//------------------------------------------------------------------------------
    public String getInformeF()    {      return this.InformeF;    }
    public void setInformeF(String InformeF)    {      this.InformeF = InformeF;    }
//------------------------------------------------------------------------------
    public String getClUbFallaH()    {      return this.clUbFallaH;    }
    public void setClUbFallaH(String clUbFallaH)    {      this.clUbFallaH = clUbFallaH;    }
//------------------------------------------------------------------------------
    public String getClTipoFallaH()    {      return this.clTipoFallaH;    }
    public void setClTipoFallaH(String clTipoFallaH)    {      this.clTipoFallaH = clTipoFallaH;    }
//------------------------------------------------------------------------------
    public String getDsUbFallaH()    {      return this.dsUbFallaH;    }
    public void setDsUbFallaH(String dsUbFallaH)    {      this.dsUbFallaH = dsUbFallaH;    }
//------------------------------------------------------------------------------
    public String getDsTipoFallaH()    {      return this.dsTipoFallaH;    }
    public void setDsTipoFallaH(String dsTipoFallaH)    {      this.dsTipoFallaH = dsTipoFallaH;    }
//------------------------------------------------------------------------------
    public String getClGarantiaHogar()    {      return this.clGarantiaHogar;    }
    public void setClGarantiaHogar(String clGarantiaHogar)    {      this.clGarantiaHogar = clGarantiaHogar;    }
//------------------------------------------------------------------------------
    public String getDsGarantiaHogar()    {      return this.dsGarantiaHogar;    }
    public void setDsGarantiaHogar(String dsGarantiaHogar)    {      this.dsGarantiaHogar = dsGarantiaHogar;    }
//------------------------------------------------------------------------------  
    public String getLatLong()  {    return this.latLong;  }
    public void setLatLong(String ll) {  this.latLong = ll;  }  
//------------------------------------------------------------------------------  
    public String getClUbFallaHLugar() {        return clUbFallaHLugar;    }
    public void setClUbFallaHLugar(String clUbFallaHLugar) {        this.clUbFallaHLugar = clUbFallaHLugar;    }
//------------------------------------------------------------------------------
    public String getDsUbFallaHLugar() {        return dsUbFallaHLugar;    }
    public void setDsUbFallaHLugar(String dsUbFallaHLugar) {        this.dsUbFallaHLugar = dsUbFallaHLugar;    }
//------------------------------------------------------------------------------
    public String getQuienSeComunica() {        return QuienSeComunica;    }
    public void setQuienSeComunica(String QuienSeComunica) {        this.QuienSeComunica = QuienSeComunica;    }
//------------------------------------------------------------------------------
    public String getNecesitaProvisorio() {        return NecesitaProvisorio;    }
    public void setNecesitaProvisorio(String NecesitaProvisorio) {        this.NecesitaProvisorio = NecesitaProvisorio;    }
//------------------------------------------------------------------------------
    public String getClTipoCristalH() {        return clTipoCristalH;    }
    public void setClTipoCristalH(String clTipoCristalH) {        this.clTipoCristalH = clTipoCristalH;    }
//------------------------------------------------------------------------------
    public String getDsTipoCristalH() {        return dsTipoCristalH;    }
    public void setDsTipoCristalH(String dsTipoCristalH) {        this.dsTipoCristalH = dsTipoCristalH;    }
//------------------------------------------------------------------------------
    public String getClMotivoSiniestroH() {        return clMotivoSiniestroH;    }
    public void setClMotivoSiniestroH(String clMotivoSiniestroH) {        this.clMotivoSiniestroH = clMotivoSiniestroH;    }
//------------------------------------------------------------------------------
    public String getDsMotivoSiniestroH() {        return dsMotivoSiniestroH;    }
    public void setDsMotivoSiniestroH(String dsMotivoSiniestroH) {        this.dsMotivoSiniestroH = dsMotivoSiniestroH;    }
//------------------------------------------------------------------------------
    public String getFechaSiniestro() {        return fechaSiniestro;    }
    public void setFechaSiniestro(String fechaSiniestro) {        this.fechaSiniestro = fechaSiniestro;    }
//------------------------------------------------------------------------------    
    public String getCoberturaFin() {        return CoberturaFin;    }
    public void setCoberturaFin(String CoberturaFin) {        this.CoberturaFin = CoberturaFin;    }
//------------------------------------------------------------------------------
    public String getPoliza() {        return Poliza;    }
    public void setPoliza(String Poliza) {        this.Poliza = Poliza;    }
//------------------------------------------------------------------------------ 
    public String getHoraCita() {     return horaCita;   }
    public void setHoraCita(String horaCita) {      this.horaCita = horaCita;    }
//------------------------------------------------------------------------------
    public String getOtroMotivoSiniestro() {    return OtroMotivoSiniestro;    }
    public void setOtroMotivoSiniestro(String OtroMotivoSiniestro) {    this.OtroMotivoSiniestro = OtroMotivoSiniestro;    }
//------------------------------------------------------------------------------
    public String getOtroTipoCristal() {    return OtroTipoCristal;    }
    public void setOtroTipoCristal(String OtroTipoCristal) {    this.OtroTipoCristal = OtroTipoCristal;    }
//------------------------------------------------------------------------------
    public String getOtroTipoContactante() {    return OtroTipoContactante;    }
    public void setOtroTipoContactante(String OtroTipoContactante) {    this.OtroTipoContactante = OtroTipoContactante;    }
//------------------------------------------------------------------------------    
}