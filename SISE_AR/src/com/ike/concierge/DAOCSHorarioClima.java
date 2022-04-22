/*
 * DAOCSHorarioClima.java
 * 
 * Created 2010-11-23
 * 
 */ 
 
package com.ike.concierge;
import com.ike.concierge.to.CSHorarioClima;
import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;
  
/*
 *
 * @autor rfernandez
 */
 public class DAOCSHorarioClima extends com.ike.model.DAOBASE { 
  
    /* Creates a new instance of DAOCSHorarioClima */ 
    public DAOCSHorarioClima() { 
    } 
  
    public CSHorarioClima getCSHorarioClima ( String StrclAsistencia ) throws DAOException {
        StringBuffer sb = new StringBuffer(); 
        Collection col = null; 
        sb.append("st_CSHorarioClima ").append(StrclAsistencia);
        col = this.rsSQLNP(sb.toString(), new CSHorarioClimaFiller());  
        Iterator it = col.iterator();  
        return it.hasNext() ? (CSHorarioClima) it.next() : null;
    } 
  
    /* Creates Filler of CSHorarioClima */ 
    public class CSHorarioClimaFiller implements com.ike.model.LlenaDatos { 
        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException { 
            CSHorarioClima HC = new CSHorarioClima();
 
            HC.setclHorarioClima(rs.getString("clHorarioClima")); 
            HC.setclAsistencia(rs.getString("clAsistencia")); 
        
            HC.setclPais(rs.getString("clPais"));
            HC.setdsPais(rs.getString("dsPais"));

            HC.setCiudad(rs.getString("Ciudad"));

            HC.setHoraActual(rs.getString("HoraActual")); 
            HC.setDifHorario(rs.getString("DifHorario")); 
            HC.setZonaHoraria(rs.getString("ZonaHoraria")); 
            HC.setHorarioVerano(rs.getString("HorarioVerano"));

            HC.setclPaisC(rs.getString("clPaisC"));
            HC.setdsPaisC(rs.getString("dsPaisC"));

            HC.setCiudadC(rs.getString("CiudadC"));

            HC.setMinima(rs.getString("Minima"));
            HC.setMaxima(rs.getString("Maxima")); 
            HC.setProbabilidad(rs.getString("Probabilidad"));

            HC.setFechaTemp(rs.getString("FechaTemp"));
            HC.setFechaTemp1(rs.getString("FechaTemp1"));
            HC.setFechaTemp2(rs.getString("FechaTemp2"));
            HC.setFechaTemp3(rs.getString("FechaTemp3"));
            HC.setFechaTemp4(rs.getString("FechaTemp4"));
            HC.setFechaTemp5(rs.getString("FechaTemp5"));
            HC.setFechaTemp6(rs.getString("FechaTemp6"));
            HC.setMinimaTemp(rs.getString("MinimaTemp"));
            HC.setMinimaTemp1(rs.getString("MinimaTemp1"));
            HC.setMinimaTemp2(rs.getString("MinimaTemp2"));
            HC.setMinimaTemp3(rs.getString("MinimaTemp3"));
            HC.setMinimaTemp4(rs.getString("MinimaTemp4"));
            HC.setMinimaTemp5(rs.getString("MinimaTemp5")); 
            HC.setMinimaTemp6(rs.getString("MinimaTemp6"));
            HC.setMaximaTemp(rs.getString("MaximaTemp"));
            HC.setMaximaTemp1(rs.getString("MaximaTemp1")); 
            HC.setMaximaTemp2(rs.getString("MaximaTemp2"));
            HC.setMaximaTemp3(rs.getString("MaximaTemp3"));
            HC.setMaximaTemp4(rs.getString("MaximaTemp4"));
            HC.setMaximaTemp5(rs.getString("MaximaTemp5"));
            HC.setMaximaTemp6(rs.getString("MaximaTemp6"));
            HC.setProbTemp(rs.getString("ProbTemp"));
            HC.setProbTemp1(rs.getString("ProbTemp1"));
            HC.setProbTemp2(rs.getString("ProbTemp2"));
            HC.setProbTemp3(rs.getString("ProbTemp3")); 
            HC.setProbTemp4(rs.getString("ProbTemp4"));
            HC.setProbTemp5(rs.getString("ProbTemp5")); 
            HC.setProbTemp6(rs.getString("ProbTemp6"));
  
            HC.setComentarios(rs.getString("Comentarios"));
            HC.setEstatus(rs.getString("Estatus"));
            HC.setdsEstatus(rs.getString("dsEstatus"));
            HC.setFechaRegistro(rs.getString("FechaRegistro"));
 
            return HC;
        } 
    } 
  
 } 
