<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="Combos.cbEntidad,java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<html>
    <head>
        <title></title>
    </head>
    <body class="cssBody">
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj"/>
        <script src='../../Utilerias/Util.js'></script>
        <script src='../../Utilerias/UtilMask.js'></script>
        <script src='../../Utilerias/UtilDireccion.js' ></script>
        <%  
        com.ike.util.I18N i18n = com.ike.util.I18N.getInstance("es","AR");
        String strclUsr = "0";
        
        
        if (session.getAttribute("clUsrApp")!= null)
        {
            strclUsr = session.getAttribute("clUsrApp").toString();
        }
        if (SeguridadC.verificaHorarioC(Integer.parseInt(strclUsr)) != true)
            
        {%>
        Fuera de Horario
        <%
        strclUsr=null;
        return;
        }
        String StrclExpediente = "0";
        
        if (session.getAttribute("clExpediente")!= null)
        {
            StrclExpediente = session.getAttribute("clExpediente").toString();
        }
        
        // checar si ya existe asistencia para el expediente, si existe, ya no procede la alta
        StringBuffer StrSql = new StringBuffer();
        
        StrSql.append(" select E.TieneAsistencia, E.Contacto,E.clTipoContactante, TC.dsTipoContactante,E.Telefono1,E.Telefono2,E.NuestroUsuario, ");
        StrSql.append(" E.clave " );
        StrSql.append(" From Expediente E");
        StrSql.append(" inner join ctipocontactante TC on (E.clTipoContactante=TC.clTipoContactante) ");
        StrSql.append(" Where clExpediente=").append(StrclExpediente);
        
        ResultSet rs2 = UtileriasBDF.rsSQLNP(StrSql.toString());
        StrSql.delete(0,StrSql.length());
        
        if (rs2.next())
        {
            
            StrSql.append(" select A.CodEntUbicacion, EF.dsEntFed as dsEntFedUb, A.CodMDUbicacion, MU.dsmundel as dsmundelUb, ");
            StrSql.append(" A.ColoniaUbicacion,A.CalleNumUbicacion,A.ReferenciasUbicacion,A.clCausaMuerte,CM.dsCausaMuerte, ");
            StrSql.append(" A.clLugarFallecimiento,LF.dsLugarFallecimiento,A.CodEntFallecimiento,EF2.dsEntFed as dsEntFedFalle,A.CodMDFallecimiento,MU2.dsmundel as dsmundelFalle, ");
            StrSql.append(" coalesce(convert(varchar(16),A.FechaMuerte,120),'')FechaMuerte,coalesce(A.NombreACargo,'')NombreACargo, ");
            StrSql.append(" coalesce(TelContacto1,'')TelContacto1,coalesce(TelContacto2,'')TelContacto2,coalesce(A.DireccionLevantamiento,'')DireccionLevantamiento, ");
            StrSql.append(" coalesce(A.DireccionServicio,'')DireccionServicio,A.clUbicacionServicio,US.dsUbicacionServicio,A.LugarSepulcro, ");
            StrSql.append(" A.clServFunerario,SF.dsServFunerario,A.Fosa,A.CirugiaEstetica,A.CertificadoMedico,A.Reconstruccion,A.CertificadoDefuncion, ");
            StrSql.append(" A.Embalsamamiento,A.Maquillaje,A.PreparacionCuerpo,Carroza,A.clTipoCarroza,TCA.dsTipoCarroza,convert(varchar(5),HorarioCortejo,108)HorarioCortejo, ");
            StrSql.append(" A.Transporte,A.clTransporteFunerario,TF.dsTransporteFunerario ");
            
            StrSql.append(" from AFuneraria A ");
            StrSql.append(" inner join Expediente E on (A.clexpediente=E.clexpediente) ");
            StrSql.append(" inner join cEntFed EF on (A.CodEntUbicacion=EF.CodEnt) ");
            StrSql.append(" left  join cMunDel MU on (A.CodMDUbicacion=MU.CodMD and MU.CodEnt=A.CodEntUbicacion) ");
            StrSql.append(" left  join cCausaMuerte CM on (A.clCausaMuerte=CM.clCausaMuerte) ");
            StrSql.append(" left  join cLugarFallecimiento LF on (A.clLugarFallecimiento=LF.clLugarFallecimiento) ");
            StrSql.append(" left  join cEntFed EF2 on (A.CodEntFallecimiento=EF2.CodEnt) ");
            StrSql.append(" left  join cMunDel MU2 on (A.CodMDFallecimiento=MU2.CodMD and MU2.CodEnt=A.CodEntFallecimiento) ");
            StrSql.append(" left  join cUbicacionServicio US on (A.clUbicacionServicio=US.clUbicacionServicio) ");
            StrSql.append(" left  join cServFunerario SF on (A.clServFunerario=SF.clServFunerario) ");
            StrSql.append(" left  join cTipoCarroza TCA on (A.clTipoCarroza=TCA.clTipoCarroza) ");
            StrSql.append(" left  join cTransporteFunerario TF on (A.clTransporteFunerario=TF.clTransporteFunerario) ");
            
            StrSql.append(" Where A.clExpediente= ").append(StrclExpediente);
            
        }
        else
        {
        %>
        El expediente no existe
        <%
        rs2.close();
        rs2=null;
        StrclExpediente = null;
        StrSql =null;
        strclUsr=null;
        return;
        }
        
        String StrclPaginaWeb = "563";
        session.setAttribute("clPaginaWebP",StrclPaginaWeb);
        %>
        <script>fnOpenLinks()</script>
        <%
        MyUtil.InicializaParametrosC(563,Integer.parseInt(strclUsr)); 
        %>
        <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist","")%>
        <%
        if(rs2.getString("TieneAsistencia").compareToIgnoreCase("1")==0)
        {%>
        <script>document.all.btnAlta.disabled=true;</script>
        <%
        }
        else
        {%>
        <script>document.all.btnCambio.disabled=true;</script>
        <%
        }
        
        ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
        StrSql.delete(0,StrSql.length());
        %>
        <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="Funerarios.jsp?'>"%>
        <%
        
        String StrdsEntFedUb = "";
        String StrdsMunDelUb = "";
        String StrdsEntFedFa = "";
        String StrdsMunDelFa = "";
        
        
        if (rs.next())
        {
            
            StrdsEntFedUb = rs.getString("dsEntFedUb");
            if (StrdsEntFedUb ==null)
            {
                StrdsEntFedUb = "";
            }
            
            StrdsMunDelUb = rs.getString("dsmundelUb");
            if (StrdsMunDelUb ==null)
            {
                StrdsMunDelUb = "";
            }
            
            StrdsEntFedFa = rs.getString("dsEntFedFalle");
            if (StrdsEntFedFa ==null)
            {
                StrdsEntFedFa = "";
            }
            
            StrdsMunDelFa = rs.getString("dsmundelFalle");
            if (StrdsMunDelFa ==null)
            {
                StrdsMunDelFa = "";
            }               
        
        
        %>
        
        <script>   document.all.btnAlta.disabled=true;  </script>
        <script>   document.all.btnCambio.disabled=false;  </script>
        
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
        
        <%=MyUtil.ObjInput("Quien Reporta","Contacto",rs2.getString("Contacto"),false,false,30,80,rs2.getString("Contacto"),false,false,40)%>
        <%=MyUtil.ObjComboC("Parentesco","clTipoContactante",rs2.getString("dsTipoContactante"),false,false,270,80,rs2.getString("clTipoContactante"),"select * from cTipoContactante order by dsTipoContactante","","",15,false,false)%>
        <%=MyUtil.ObjInput("Tel Contacto","Telefono1",rs2.getString("Telefono1"),false,false,445,80,rs2.getString("Telefono1"),false,false,20)%>
        <%=MyUtil.ObjInput("Tel Movil","Telefono2",rs2.getString("Telefono2"),false,false,575,80,rs2.getString("Telefono2"),false,false,20)%>
        <%=MyUtil.ObjInput("Nombre Usuario","NuestroUsuario",rs2.getString("NuestroUsuario"),false,false,30,120,rs2.getString("NuestroUsuario"),false,false,40)%>
        <%=MyUtil.ObjInput("Poliza","Clave",rs2.getString("Clave"),false,false,270,120,rs2.getString("Clave"),false,false,40)%>        
        <%=MyUtil.DoBlock("Datos Generales")%>  
        
        <%=MyUtil.ObjComboC(i18n.getMessage("message.title.entidad"),"CodEntUbicacion",StrdsEntFedUb,true,true,30,210,"","Select CodEnt, dsEntFed from cEntFed order by dsEntFed ","fnLlenaMunFunerarioUbic()","",40,true,true)%>
        <%=MyUtil.ObjComboC(i18n.getMessage("message.title.municipio"),"CodMDUbicacion",StrdsMunDelUb,true,true,270,210,"","Select CodMD, dsMunDel from cMunDel where CodMD='" + rs.getString("CodMDUbicacion") + "' and CodEnt='"+ rs.getString("CodEntUbicacion") +"' order by dsMunDel ","","",40,true,true)%>                                                                  
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.colonia"),"ColoniaUbicacion",rs.getString("ColoniaUbicacion"),true,true,30,250,"",true,true,40)%>
        <%=MyUtil.ObjInput("Calle y Número","CalleNumUbicacion",rs.getString("CalleNumUbicacion"),true,true,270,250,"",true,true,50)%>
        <%=MyUtil.ObjTextArea("Referencias","ReferenciasUbicacion",rs.getString("ReferenciasUbicacion"),"100","4",true,true,30,290,"",false,false)%>
        <%=MyUtil.DoBlock("Ubicacion del Cuerpo",150,35)%>
        
        <%=MyUtil.ObjComboC("Causa de la Muerte","clCausaMuerte",rs.getString("dsCausaMuerte"),true,true,30,415,"","Select * from cCausaMuerte order by dsCausaMuerte","","",25,true,true)%>
        <%=MyUtil.ObjComboC("Lugar del Fallecimiento","clLugarFallecimiento",rs.getString("dsLugarFallecimiento"),true,true,270,415,"","Select * from cLugarFallecimiento order by dsLugarFallecimiento","","",25,true,true)%>        
        <%=MyUtil.ObjComboC(i18n.getMessage("message.title.entidad"),"CodEntFallecimiento",StrdsEntFedFa,true,true,30,465,"","Select CodEnt, dsEntFed from cEntFed order by dsEntFed ","fnLlenaMunFunerarioFallec()","",40,true,true)%>
        <%=MyUtil.ObjComboC(i18n.getMessage("message.title.municipio"),"CodMDFallecimiento",StrdsMunDelFa,true,true,270,465,"","Select CodMD, dsMunDel from cMunDel where CodMD='" + rs.getString("CodMDFallecimiento") + "' and CodEnt='"+ rs.getString("CodEntFallecimiento") +"' order by dsMunDel ","","",40,true,true)%>                                                                  
        <%=MyUtil.ObjInput("Fecha y Hora <br>(aaaa/mm/dd hh:mm)","FechaMuerte",rs.getString("FechaMuerte"),true,true,595,450,"",true,true,20,"if(this.readOnly==false){fnValMask(this,document.all.FechaMuerteMsk.value,this.name)}")%>        
        <%=MyUtil.DoBlock("Información del Fallecimiento",5,0)%>                 
        
        <%=MyUtil.ObjInput("Persona a Cargo","NombreACargo",rs.getString("NombreACargo"),true,true,30,555,"",true,true,40)%>       
        <%=MyUtil.ObjInput("Tel Contacto","TelContacto1",rs.getString("TelContacto1"),true,true,270,555,"",true,true,20)%>       
        <%=MyUtil.ObjInput("Tel Movil","TelContacto2",rs.getString("TelContacto2"),true,true,400,555,"",false,false,20)%>       
        <%=MyUtil.ObjInput("Direccion Levantamiento","DireccionLevantamiento",rs.getString("DireccionLevantamiento"),true,true,30,595,"",true,true,40)%>       
        <%=MyUtil.ObjInput("Direccion Servicio","DireccionServicio",rs.getString("DireccionServicio"),true,true,270,595,"",true,true,45)%>       
        <%=MyUtil.ObjComboC("Ubicación","clUbicacionServicio",rs.getString("dsUbicacionServicio"),true,true,530,595,"","Select * from cUbicacionServicio order by dsUbicacionServicio","","",15,true,true)%>
        <%=MyUtil.ObjInput("Lugar Sepulcro","LugarSepulcro",rs.getString("LugarSepulcro"),true,true,30,635,"",false,false,40)%>               
        <%=MyUtil.ObjComboC("Servicio Funerario","clServFunerario",rs.getString("dsServFunerario"),true,true,270,635,"","Select * from cServFunerario order by dsServFunerario","","",15,true,true)%>                      
        <%=MyUtil.ObjChkBox("Cuenta con fosa/Osario","Fosa",rs.getString("Fosa"), true,true,30,675,"0","")%>    
        <%=MyUtil.ObjChkBox("Cirugía Estética","CirugiaEstetica",rs.getString("CirugiaEstetica"), true,true,270,675,"0","")%>
        <%=MyUtil.ObjChkBox("Certificado Médico","CertificadoMedico",rs.getString("CertificadoMedico"), true,true,30,705,"0","")%>    
        <%=MyUtil.ObjChkBox("Reconstrucción","Reconstruccion",rs.getString("Reconstruccion"), true,true,270,705,"0","")%>
        <%=MyUtil.ObjChkBox("Certificado de Defunción","CertificadoDefuncion",rs.getString("CertificadoDefuncion"), true,true,30,735,"0","")%>
        <%=MyUtil.ObjChkBox("Embalsamamiento","Embalsamamiento",rs.getString("Embalsamamiento"), true,true,270,735,"0","")%>
        <%=MyUtil.ObjChkBox("Maquillaje","Maquillaje",rs.getString("Maquillaje"), true,true,30,765,"0","")%>  
        <%=MyUtil.ObjChkBox("Preparación del Cuerpo","PreparacionCuerpo",rs.getString("PreparacionCuerpo"), true,true,270,765,"0","")%>
        <%=MyUtil.DoBlock("Información del Servicio",0,0)%> 
        
        <%=MyUtil.ObjChkBox("Requiere Carroza","Carroza",rs.getString("Carroza"), true,true,30,855,"0","fnComboCarroza()")%>  
        <%=MyUtil.ObjComboC("Tipo Carroza","clTipoCarroza",rs.getString("dsTipoCarroza"),false,false,270,855,"","Select * from cTipoCarroza order by dsTipoCarroza","","",50,false,false)%>
        <%=MyUtil.ObjInput("Partida del Cortejo <br>(hh:mm)","HorarioCortejo",rs.getString("HorarioCortejo"),true,true,530,855,"",true,true,7,"if(this.readOnly==false){fnValMask(this,document.all.HoraMuerteMsk.value,this.name)}")%>
        <%=MyUtil.ObjChkBox("Requiere Transporte","Transporte",rs.getString("Transporte"), true,true,30,895,"0","fnComboTransporte()")%>
        <%=MyUtil.ObjComboC("Tipo Transporte","clTransporteFunerario",rs.getString("dsTransporteFunerario"),false,false,270,895,"","Select * from cTransporteFunerario order by dsTransporteFunerario","","",50,false,false)%>
        
        <%=MyUtil.DoBlock("Información del Servicio",0,0)%> 
        <%
        }
        else
        {
        
        
        %>
        
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
        
        <%=MyUtil.ObjInput("Quien Reporta","Contacto",rs2.getString("Contacto"),false,false,30,80,rs2.getString("Contacto"),false,false,40)%>
        <%=MyUtil.ObjComboC("Parentesco","clTipoContactante",rs2.getString("dsTipoContactante"),false,false,270,80,rs2.getString("clTipoContactante"),"select * from cTipoContactante order by dsTipoContactante","","",15,false,false)%>
        <%=MyUtil.ObjInput("Tel Contacto","Telefono1",rs2.getString("Telefono1"),false,false,445,80,rs2.getString("Telefono1"),false,false,20)%>
        <%=MyUtil.ObjInput("Tel Movil","Telefono2",rs2.getString("Telefono2"),false,false,575,80,rs2.getString("Telefono2"),false,false,20)%>
        <%=MyUtil.ObjInput("Nombre Usuario","NuestroUsuario",rs2.getString("NuestroUsuario"),false,false,30,120,rs2.getString("NuestroUsuario"),false,false,40)%>
        <%=MyUtil.ObjInput("Poliza","Clave",rs2.getString("Clave"),false,false,270,120,rs2.getString("Clave"),false,false,40)%>
        <%=MyUtil.DoBlock("Datos Generales")%>                              
        
        
        <%=MyUtil.ObjComboC(i18n.getMessage("message.title.entidad"),"CodEntUbicacion","",true,true,30,210,"","Select CodEnt, dsEntFed from cEntFed order by dsEntFed ","fnLlenaMunFunerarioUbic()","",40,true,true)%>
        <%=MyUtil.ObjComboC(i18n.getMessage("message.title.municipio"),"CodMDUbicacion","",true,true,270,210,"","Select CodMD, dsMunDel from cMunDel where CodMD='' and CodEnt='' order by dsMunDel ","","",40,true,true)%>                                                                  
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.colonia"),"ColoniaUbicacion","",true,true,30,250,"",true,true,40)%>
        <%=MyUtil.ObjInput("Calle y Número","CalleNumUbicacion","",true,true,270,250,"",true,true,50)%>
        <%=MyUtil.ObjTextArea("Referencias","ReferenciasUbicacion","","100","4",true,true,30,290,"",false,false)%>
        <%=MyUtil.DoBlock("Ubicacion del Cuerpo",150,35)%>
        
        <%=MyUtil.ObjComboC("Causa de la Muerte","clCausaMuerte","",true,true,30,415,"","Select * from cCausaMuerte order by dsCausaMuerte","","",25,true,true)%>
        <%=MyUtil.ObjComboC("Lugar del Fallecimiento","clLugarFallecimiento","",true,true,270,415,"","Select * from cLugarFallecimiento order by dsLugarFallecimiento","","",25,true,true)%>                
        <%=MyUtil.ObjComboC(i18n.getMessage("message.title.entidad"),"CodEntFallecimiento","",true,true,30,465,"","Select CodEnt, dsEntFed from cEntFed order by dsEntFed ","fnLlenaMunFunerarioFallec()","",40,true,true)%>
        <%=MyUtil.ObjComboC(i18n.getMessage("message.title.municipio"),"CodMDFallecimiento","",true,true,270,465,"","Select CodMD, dsMunDel from cMunDel where CodMD='' and CodEnt='' order by dsMunDel ","","",40,true,true)%>                                                                  
        <%=MyUtil.ObjInput("Fecha y Hora <br>(aaaa/mm/dd hh:mm)","FechaMuerte","",true,true,595,450,"",true,true,20,"if(this.readOnly==false){fnValMask(this,document.all.FechaMuerteMsk.value,this.name)}")%>
        <%=MyUtil.DoBlock("Información del Fallecimiento",5,0)%> 
        
        <%=MyUtil.ObjInput("Persona a Cargo","NombreACargo","",true,true,30,555,"",true,true,40)%>       
        <%=MyUtil.ObjInput("Tel Contacto","TelContacto1","",true,true,270,555,"",true,true,20)%>       
        <%=MyUtil.ObjInput("Tel Movil","TelContacto2","",true,true,400,555,"",false,false,20)%>       
        <%=MyUtil.ObjInput("Direccion Levantamiento","DireccionLevantamiento","",true,true,30,595,"",true,true,40)%>       
        <%=MyUtil.ObjInput("Direccion Servicio","DireccionServicio","",true,true,270,595,"",true,true,45)%>       
        <%=MyUtil.ObjComboC("Ubicación","clUbicacionServicio","",true,true,530,595,"","Select * from cUbicacionServicio order by dsUbicacionServicio","","",15,true,true)%>
        <%=MyUtil.ObjInput("Lugar Sepulcro","LugarSepulcro","",true,true,30,635,"",false,false,40)%>               
        <%=MyUtil.ObjComboC("Servicio Funerario","clServFunerario","",true,true,270,635,"","Select * from cServFunerario order by dsServFunerario","","",15,true,true)%>                      
        <%=MyUtil.ObjChkBox("Cuenta con fosa/Osario","Fosa","", true,true,30,675,"0","")%>    
        <%=MyUtil.ObjChkBox("Cirugía Estética","CirugiaEstetica","", true,true,270,675,"0","")%>
        <%=MyUtil.ObjChkBox("Certificado Médico","CertificadoMedico","", true,true,30,705,"0","")%>    
        <%=MyUtil.ObjChkBox("Reconstrucción","Reconstruccion","", true,true,270,705,"0","")%>
        <%=MyUtil.ObjChkBox("Certificado de Defunción","CertificadoDefuncion","", true,true,30,735,"0","")%>
        <%=MyUtil.ObjChkBox("Embalsamamiento","Embalsamamiento","", true,true,270,735,"0","")%>
        <%=MyUtil.ObjChkBox("Maquillaje","Maquillaje","", true,true,30,765,"0","")%>  
        <%=MyUtil.ObjChkBox("Preparación del Cuerpo","PreparacionCuerpo","", true,true,270,765,"0","")%>
        <%=MyUtil.DoBlock("Información del Servicio",0,0)%> 
        
        <%=MyUtil.ObjChkBox("Requiere Carroza","Carroza","", true,true,30,855,"0","fnComboCarroza()")%>  
        <%=MyUtil.ObjComboC("Tipo Carroza","clTipoCarroza","",false,false,270,855,"","Select * from cTipoCarroza order by dsTipoCarroza","","",50,false,false)%>
        <%=MyUtil.ObjInput("Partida del Cortejo <br>(hh:mm)","HorarioCortejo","",true,true,530,855,"",true,true,7,"if(this.readOnly==false){fnValMask(this,document.all.HoraMuerteMsk.value,this.name)}")%>
        <%=MyUtil.ObjChkBox("Requiere Transporte","Transporte","", true,true,30,895,"0","fnComboTransporte()")%>
        <%=MyUtil.ObjComboC("Tipo Transporte","clTransporteFunerario","",false,false,270,895,"","Select * from cTransporteFunerario order by dsTransporteFunerario","","",50,false,false)%>
        
        <%=MyUtil.DoBlock("Información del Servicio",0,0)%> 
        <%
        } 
        
        %>
        
        <%
        rs.close();
        rs=null;
        rs2.close();
        rs2=null;
        StrclExpediente = null;
        StrSql=null;
        strclUsr=null;
        
        StrdsEntFedUb = null;
        StrdsMunDelUb = null;
        StrdsEntFedFa = null;
        StrdsMunDelFa = null;     %>     
        
        <%=MyUtil.GeneraScripts()%>
        
        <input name='FechaMuerteMsk' id='FechaMuerteMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
        <input name='HoraMuerteMsk' id='HoraMuerteMsk' type='hidden' value='VN09VN09F:00VN00VN00'>
        
        <script>

function fnComboCarroza(){
if (document.all.Carroza.value=="1")  
      {document.all.clTipoCarrozaC.disabled=false;}
      else
      {document.all.clTipoCarrozaC.disabled=true;}
}

function fnComboTransporte(){
if (document.all.Transporte.value=="1")
      {document.all.clTransporteFunerarioC.disabled=false;}    
      else
      {document.all.clTransporteFunerarioC.disabled=true;}
}

        </script>
        
    </body>
</html>






