/*
 * TieneAsistenciaExp.java
 *
 * Created on 11 de Agosto de 2006, 16:35 PM
 *
 * To change this template, choose Tools | Options and locate the template under
 * the Source Creation and Management node. Right-click the template and choose
 * Open. You can then make changes to the template in the Source Editor.
 */

package com.ike.model.to;

/*
 *
 * @author rodrigus
 */

public class TieneAsistenciaExp
{                  
    private String strclExpediente;
    private String strclTieneAsistencia;
    private String strCodEnt;
    private String strdsEntFed;
    private String strCodMD;
    private String strdsMunDel;
   
    /* Creates a new instance of RGMMExpediente */
    public TieneAsistenciaExp()
    {
    }
    
    public String getclExpediente()
    {
        return strclExpediente;
    }

    public void setclExpediente(String strclExpediente)
    {
        this.strclExpediente = strclExpediente;
    }

    public String getTieneAsistencia()
    {
        return strclTieneAsistencia;
    }

    public void setTieneAsistencia(String strclTieneAsistencia)
    {
        this.strclTieneAsistencia = strclTieneAsistencia;
    }
    
    public String getCodEnt()
    {
        return strCodEnt;
    }

    public void setCodEnt(String strCodEnt)
    {
        this.strCodEnt = strCodEnt;
    }
    
    public String getdsEntFed()
    {
        return strdsEntFed;
    }

    public void setdsEntFed(String strdsEntFed)
    {
        this.strdsEntFed = strdsEntFed;
    }

    public String getCodMD()
    {
        return strCodMD;
    }

    public void setCodMD(String strCodMD)
    {
        this.strCodMD = strCodMD;
    }

    public String getdsMunDel()
    {
        return strdsMunDel;
    }

    public void setdsMunDel(String strdsMunDel)
    {
        this.strdsMunDel = strdsMunDel;
    }

    
}