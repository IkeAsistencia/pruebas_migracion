<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%> 
<html>
<head><title>Cauciones</title> 
<link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
</head>
<body class="cssBody">

<%-- <jsp:useBean id="beanInstanceName" scope="session" class="beanPackagAL.BeanClassName" /> --%>
<%-- <jsp:getProperty name="beanInstanceName"  property="propertyName" /> --%>

<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
<script src='../../Utilerias/Util.js' ></script>
<script src='../../Utilerias/UtilMask.js'></script> 

<%  
    String StrclUsrApp="0";
    
    
    
    if (session.getAttribute("clUsrApp")!= null)
     {
       StrclUsrApp = session.getAttribute("clUsrApp").toString(); 
     }  
    if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) 
     {
       %>Fuera de Horario<% 
       StrclUsrApp=null;
       
       return;        
     } 
    String StrclExpediente = "0";    
    String StrclCaucion = "0"; 
    String StrclPaginaWeb="0";    
    String StrEstatus="";
    
    int iSaldo = 0;
    String StrSaldo = "0";
    String StrMontoIrrec = "0";
    String StrclEstatusCau="0";

    if (session.getAttribute("clExpediente")!= null)
     {
       StrclExpediente = session.getAttribute("clExpediente").toString(); 
     }      
     if (request.getParameter("clCaucion")!= null)
     {
       StrclCaucion= request.getParameter("clCaucion").toString(); 
     }   

    StringBuffer StrSql = new StringBuffer();
    StrSql.append(" Select coalesce(I.MontoIrrecuperable,0) as MontoIrrecuperable, ");
    StrSql.append(" (C.MontoRepDan+C.MontoSanPec+C.MontoObProc+C.MontoSusAct) - coalesce(SUM(R.MontoRecuperado),0) as SaldoPar, ");
    StrSql.append(" C.clEstatusCaucion, C.RevisadaxAdministrativo,  C.clCaucion, ");
    StrSql.append(" coalesce(C.MontoRepDan,0) as MontoRepDan,");
    StrSql.append(" coalesce(C.MontoSanPec,0) as MontoSanPec,");
    StrSql.append(" coalesce(C.MontoObProc,0) as MontoObProc,");
    StrSql.append(" coalesce(C.MontoSusAct,0) as MontoSusAct, coalesce(D.dsDelito,'') as dsDelito, ");
    StrSql.append(" C.FolioCaucion,");
    StrSql.append(" (C.MontoRepDan+C.MontoSanPec+C.MontoObProc+C.MontoSusAct) as MontoCaucionVTR, ");
    StrSql.append(" coalesce(convert(varchar(10), C.FechaExped,120),'') as FechaExped, year(C.FechaExped) as AnioFecExp,");
    StrSql.append(" coalesce(convert(varchar(10), C.FechaExhib,120),'') as FechaExhib, year(C.FechaExhib) as AnioFecExh, ");
    StrSql.append(" coalesce(TL.dsTipoLibera,'') as dsTipoLibera, ");
    StrSql.append(" coalesce(PP.NombreOpe,'') as ProveedorExhibe, coalesce(C.clProveedorExhibe,0) clProveedorExhibe, ");
    StrSql.append(" coalesce(PProv.Nombre,'') as ProvColaborador, coalesce(C.clProvColaborador,'') as clProvColaborador, ");
    StrSql.append(" coalesce(AbogadoTraslada,'') as AbogadoTraslada, ");
    StrSql.append(" coalesce(E.dsEstatus,'') as dsEstatus, ");
     StrSql.append(" C.clDelitoEvento, ");
     StrSql.append(" C.ResponsivaAfiliado, coalesce(C.Comprobante,'') as Comprobante,");
     StrSql.append(" coalesce(C.ExhibicionSoportes,0) as ExhibicionSoportes,  ");
     StrSql.append(" coalesce(convert(varchar(10),C.FechaRevisionAdmon,120),'') FechaRevisionAdmon, ");
     StrSql.append(" TPC.dsTipoPagoCaucion 'dsTipoPagoCaucion',");
     StrSql.append(" convert(varchar(8000),coalesce(C.Observaciones,'')) 'Observaciones'");
     StrSql.append(" From Caucion C ");
     StrSql.append(" LEFT JOIN Irrecuperacion I ON (C.CLCAUCION = I.CLCAUCION) ");
     StrSql.append(" LEFT JOIN Recuperacion R ON (C.CLCAUCION = R.CLCAUCION) ");
     StrSql.append("  inner Join cProveedor PP ON (PP.clProveedor = C.clProveedorExhibe) ");
     StrSql.append(" inner Join cTipoLibera TL ON (TL.clTipoLibera = C.clTipoLibera) ");
     StrSql.append("  inner Join cEstatusCaucion E ON (E.clEstatus= C.clEstatusCaucion) ");
     StrSql.append("  inner join DelitoEvento DE ON (DE.clDelitoEvento=C.clDelitoEvento)");
     StrSql.append("  inner Join cDelito D ON (D.clDelito=DE.clDelito) ");
     StrSql.append("  Left Join PersonalxProv PProv ON (PProv.clPersonalxProv = C.clProvColaborador) ");
     StrSql.append("  Left Join cTipoPagoCaucion TPC on (TPC.clTipoPagoCaucion = C.clTipoPagoCaucion) ");     
     StrSql.append("  Where C.clCaucion =").append(StrclCaucion);
     StrSql.append("  GROUP BY "); 
     StrSql.append("  C.clCaucion, ");
     StrSql.append("  C.MontoRepDan,C.MontoSanPec,C.MontoObProc,C.MontoSusAct, ");
     StrSql.append("  coalesce(convert(varchar(10), C.FechaExhib,120),'') , ");
     StrSql.append("  coalesce(convert(varchar(10), C.FechaExped,120),'') , ");
     StrSql.append("  C.FolioCaucion,");
     StrSql.append("  coalesce(PP.NombreOpe,'') , coalesce(C.clProvColaborador,'') , coalesce(C.clProveedorExhibe,0) , ");
     StrSql.append("  coalesce(TL.dsTipoLibera,'') , ");
     StrSql.append("  coalesce(E.dsEstatus,'') , C.clEstatusCaucion,");
     StrSql.append("  C.clDelitoEvento, year(C.FechaExhib) , year(C.FechaExped), ");
     StrSql.append("  C.ResponsivaAfiliado, coalesce(C.Comprobante,''), coalesce(C.ExhibicionSoportes,0), coalesce(I.MontoIrrecuperable,0), (C.MontoRepDan+C.MontoSanPec+C.MontoObProc+C.MontoSusAct), ");
     StrSql.append("  C.RevisadaxAdministrativo, ");
     StrSql.append("  coalesce(convert(varchar(10),C.FechaRevisionAdmon,120),''),TPC.dsTipoPagoCaucion,convert(varchar(8000),coalesce(C.Observaciones,'')),coalesce(AbogadoTraslada,''), coalesce(D.dsDelito,''),coalesce(PProv.Nombre,''), ");
     StrSql.append("  coalesce(C.MontoRepDan,0),");
     StrSql.append("  coalesce(C.MontoSanPec,0),");
     StrSql.append("  coalesce(C.MontoObProc,0),");
     StrSql.append("  coalesce(C.MontoSusAct,0)");
    
     ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
     StrSql.delete(0,StrSql.length());
 
        ResultSet rsFecha = UtileriasBDF.rsSQLNP( "Select convert(varchar(10),getdate(),120) Fecha");
        String StrFecha ="";
     if (rsFecha.next()){
           StrFecha = rsFecha.getString("Fecha");
        }
   
     ResultSet rs4 = UtileriasBDF.rsSQLNP( "Select dsEstatus, clEstatus from cEstatusCaucion where dsEstatus = 'Activa'");
     if (rs4.next()) {StrEstatus=rs4.getString("clEstatus"); }
   
   %><script>fnOpenLinks()</script><%

   StrclPaginaWeb = "196";       
   MyUtil.InicializaParametrosC(196,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina

   session.setAttribute("clPaginaWebP",StrclPaginaWeb);  %>

   <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionCaucion","")%>        
   <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="Cauciones.jsp?'>"%><%
   
   if (rs.next()) {
       
        StrMontoIrrec = rs.getString("MontoIrrecuperable");
        iSaldo = Integer.parseInt(rs.getString("SaldoPar")) - Integer.parseInt(StrMontoIrrec);
        StrSaldo = String.valueOf(iSaldo);
       
        %><script>document.all.btnElimina.disabled=true;</script><% 
       
        StrclEstatusCau = rs.getString("clEstatusCaucion");       
        if ((StrclEstatusCau.compareToIgnoreCase("1")!=0) || (rs.getString("Revisadaxadministrativo").compareToIgnoreCase("1")==0))
        {  // No se puede modificar una Cauci�n con estatus distinto de ACTIVA
           %><script>document.all.btnCambio.disabled=true;document.all.btnAlta.disabled=true;</script><% 
         }
        session.setAttribute("clCaucion",rs.getString("clCaucion"));%> 
        <INPUT id='clCaucion' name='clCaucion' type='hidden' value='<%=StrclCaucion%>'>                         
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
        <%=MyUtil.ObjInput("Monto Reparaci�n <br>Da�o","MontoRepDan",rs.getString("MontoRepDan"),true,true,30,70,"0",false,false,15,"fnActualizaMontos(document.all.MontoRepDan)")%>             
        <%=MyUtil.ObjInput("Monto Sanci�n <br>Pecunaria","MontoSanPec",rs.getString("MontoSanPec"),true,true,170,70,"0",false,false,15,"fnActualizaMontos(document.all.MontoSanPec)")%>
        <%=MyUtil.ObjInput("Monto Obligaci�n <br>Procesal o Libertad","MontoObProc",rs.getString("MontoObProc"),true,true,320,70,"0",false,false,15,"fnActualizaMontos(document.all.MontoObProc)")%>
        <%=MyUtil.ObjInput("Monto Suspensi�n <br>Acto Reclamado","MontoSusAct",rs.getString("MontoSusAct"),true,true,470,70,"0",false,false,15,"fnActualizaMontos(document.all.MontoSusAct)")%>

        <%=MyUtil.ObjComboC("Delito", "clDelitoEvento",rs.getString("dsDelito"),true,true,30,120,"","select DE.clDelitoEvento, D.dsDelito from DelitoEvento DE Inner join cDelito D ON(D.clDelito=DE.clDelito) Where clExpediente=" + StrclExpediente + " Union select '','' ","","",1000,true,true)%>                                
        <%=MyUtil.ObjInput("Folio de Cauci�n","FolioCaucionVTR",rs.getString("FolioCaucion"),false,false,30,160,"",false,false,10)%>
        <%=MyUtil.ObjInput("Monto Total Cauci�n","MontoCaucionVTR",rs.getString("MontoCaucionVTR"),false,false,200,160,"",false,false,15)%>
        <%=MyUtil.ObjInput("Saldo por Recuperar","Saldo",StrSaldo,false,false,370,160,"",false,false,15)%>
        <%=MyUtil.ObjInput("Monto Irrecuperable","MontoIrrecuperable",StrMontoIrrec,false,false,520,160,"",false,false,15)%>
        <%=MyUtil.ObjComboC("Tipo de pago", "clTipoPagoCaucion",rs.getString("dsTipoPagoCaucion"),false,false,30,210,"","st_TipoPagoCaucion","","",50,false,false)%>
        <%=MyUtil.ObjInput("Fecha de Expedici�n <br>(AAAA/MM/DD)","FechaExped",rs.getString("FechaExped"),true,true,200,200,"",true,true,25,"if(this.readOnly==false){fnValidaFecha(1," + rs.getString("AnioFecExp") + ")}")%>
        <%=MyUtil.ObjInput("Fecha de Exhibici�n <br>(AAAA/MM/DD)","FechaExhib",rs.getString("FechaExhib"),false,false,370,200,StrFecha,true,true,25,"if(this.readOnly==false){fnValidaFecha(2," + rs.getString("AnioFecExh") + ")}")%>
        <%=MyUtil.ObjComboC("Tipo Liberaci�n", "clTipoLibera",rs.getString("dsTipoLibera"),true,true,520,210,"","Select clTipoLibera, dsTipoLibera From cTipoLibera","","",50,true,true)%><%
        String strclProveedorExhibe=rs.getString("clProveedorExhibe");%>
        
        <%=MyUtil.ObjInput("Proveedor que Exhibe","ProveedorExhibe",rs.getString("ProveedorExhibe"),true,false,30,250,"",true,true,60,"if(this.readOnly==false){fnBuscaProv();}")%>
	<INPUT id='clProveedorExhibe' name='clProveedorExhibe' type='hidden' value='<%=strclProveedorExhibe%>'><%
                if (MyUtil.blnAccess[4]==true){
                    %><div class='VTable' style='position:absolute; z-index:30; left:350px; top:255px;'>
                    <IMG SRC='../../Imagenes/Lupa.gif' class='handM' onClick='fnBuscaProv();' WIDTH=20 HEIGHT=20></div> <%
                } %>
        <%=MyUtil.ObjComboC("Proveedor Colaborador", "clProvColaborador",rs.getString("ProvColaborador"),true,true,400,250,"","Select clPersonalxProv, Nombre From PersonalxProv where clProveedor= " + strclProveedorExhibe ,"","",50,true,true)%>
        <%=MyUtil.ObjInput("Abogado que Traslada","AbogadoTraslada",rs.getString("AbogadoTraslada"),true,true,200,290,"",true,true,80)%>
        <%=MyUtil.ObjComboC("Estatus Cauci�n", "clEstatusCaucion",rs.getString("dsEstatus"),false,false,30,290,StrclEstatusCau,"Select clEstatus, dsEstatus From cEstatusCaucion order by dsEstatus","","",50,true,true)%>                                
        <%=MyUtil.ObjTextArea("Observaciones","Observaciones",rs.getString("Observaciones"),"59","3",false,false,30,330,"",false,false)%>
        <%=MyUtil.DoBlock("Datos de la Cauci�n",0,20)%><%
}
   else { 
        %><script>document.all.btnElimina.disabled=true;document.all.btnCambio.disabled=true;</script>
        <INPUT id='clCaucion' name='clCaucion' type='hidden' value='0'>
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>                 
        <INPUT id='clUsrApp' name='clUsrApp' type='hidden' value='<%=StrclUsrApp%>'>        
        <INPUT id='clEstatusCaucion' name='clEstatusCaucion' type='hidden' value='<%=StrEstatus%>'> 
        
        <%=MyUtil.ObjInput("Monto Reparaci�n <br>Da�o","MontoRepDan","",true,true,30,70,"0",false,false,15,"fnActualizaMontos(document.all.MontoRepDan)")%>
        <%=MyUtil.ObjInput("Monto Sanci�n <br>Pecunaria","MontoSanPec","",true,true,170,70,"0",false,false,15,"fnActualizaMontos(document.all.MontoSanPec)")%>
        <%=MyUtil.ObjInput("Monto Obligaci�n <br>Procesal o Libertad","MontoObProc","",true,true,320,70,"0",false,false,15,"fnActualizaMontos(document.all.MontoObProc)")%>
        <%=MyUtil.ObjInput("Monto Suspensi�n <br>Acto Reclamado","MontoSusAct","",true,true,470,70,"0",false,false,15,"fnActualizaMontos(document.all.MontoSusAct)")%>
        
        <%=MyUtil.ObjComboC("Delito", "clDelitoEvento","",true,true,30,120,"","select DE.clDelitoEvento, D.dsDelito from DelitoEvento DE Inner join cDelito D ON(D.clDelito=DE.clDelito) Where clExpediente=" + StrclExpediente + " Union select '','' ","","",1000,true,true)%>
        <%=MyUtil.ObjInput("Folio de Cauci�n","FolioCaucionVTR","",false,false,30,160,"",false,false,10)%>
        <%=MyUtil.ObjInput("Monto Total Cauci�n","MontoCaucionVTR","",false,false,200,160,"",false,false,15)%>
        <%=MyUtil.ObjComboC("Tipo de pago", "clTipoPagoCaucion","",false,false,370,160,"","st_TipoPagoCaucion","","",50,false,false)%>
        <%=MyUtil.ObjInput("Fecha de Expedici�n <br>(AAAA/MM/DD)","FechaExped","",true,true,30,200,"",true,true,25,"if(this.readOnly==false){fnValidaFecha(1,0)}")%>
        <%=MyUtil.ObjInput("Fecha de Exhibici�n <br>(AAAA/MM/DD)","FechaExhib","",false,false,200,200,StrFecha,true,true,25,"if(this.readOnly==false){fnValidaFecha(2,0)}")%>
        <%=MyUtil.ObjComboC("Tipo Liberaci�n", "clTipoLibera","",true,true,370,210,"","Select clTipoLibera, dsTipoLibera From cTipoLibera","","",50,true,true)%>
        <%=MyUtil.ObjInput("Proveedor que Exhibe","ProveedorExhibe","",true,false,30,250,"",true,true,60,"if(this.readOnly==false){fnBuscaProv();}")%>
	<INPUT id='clProveedorExhibe' name='clProveedorExhibe' type='hidden' value=''><%
                if (MyUtil.blnAccess[4]==true){
                    %><div class='VTable' style='position:absolute; z-index:30; left:350px; top:255px;'>
                    <IMG SRC='../../Imagenes/Lupa.gif' class='handM' onClick='fnBuscaProv();' WIDTH=20 HEIGHT=20></div><%
                }%>
        <%=MyUtil.ObjComboC("Proveedor Colaborador", "clProvColaborador","",true,true,400,250,"","Select clPersonalxProv, Nombre From PersonalxProv where clProveedor= 0" ,"","",50,true,true)%>
        <%=MyUtil.ObjInput("Abogado que Traslada","AbogadoTraslada","",true,true,200,290,"",true,true,80)%>
        <%=MyUtil.ObjComboC("Estatus Cauci�n", "clEstatusCaucion",rs4.getString("dsEstatus"),false,false,30,290,rs4.getString("clEstatus"),"Select clEstatus, dsEstatus from cEstatusCaucion","","",50,true,true)%>
        <%=MyUtil.ObjTextArea("Observaciones","Observaciones","","59","3",false,false,30,330,"",false,false)%>
        <%=MyUtil.DoBlock("Datos de la Cauci�n",60,20)%><%
    }%>
        <%=MyUtil.GeneraScripts()%><%
        rs.close();
        rsFecha.close();
        rs4.close();
        rs=null;
        rsFecha=null;
        rs4=null;
        StrclUsrApp=null;        
        StrclExpediente = null;    
        StrclCaucion = null; 
        StrSql = null; 
        StrclPaginaWeb=null;    
        StrEstatus=null;
        StrSaldo = null;
        StrMontoIrrec = null;
        StrclEstatusCau=null;
        
 %>
<input name='FechaExpedMsk' id='FechaExpedMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09'>
<input name='FechaExhibMsk' id='FechaExhibMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09'>

<script> 
 
 function fnLlenaProvColab(){  
		var strConsulta = "sp_GetProvColab '" + document.all.clProveedorExhibe.value + "'";
		var pstrCadena = "../servlet/Utilerias.LlenaCombos?strSQL=" + strConsulta;
                document.all.clProvColaborador.value = '';
		pstrCadena = pstrCadena + "&strName=clProvColaboradorC";		
		fnOptionxDefault('clProvColaboradorC',pstrCadena);
	}

 function fnActualizaMontos(Campo){  
     if (isNaN(Campo.value)==true || Campo.value=='')
     {
       alert(Campo.name + ' debe ser num�rico');
       Campo.value="0";
     } 
     document.all.MontoCaucionVTR.value=0;
     document.all.MontoCaucionVTR.value = eval(document.all.MontoRepDan.value) + eval(document.all.MontoSanPec.value) + eval(document.all.MontoObProc.value) + eval(document.all.MontoSusAct.value);
  }	
     function fnBuscaProv(){
         var pstrCadena = "../../Utilerias/FiltrosProv.jsp?strSQL=sp_WebBuscaProv ";
         pstrCadena = pstrCadena + "&NombreOpe= " + document.all.ProveedorExhibe.value;
         document.all.clProveedorExhibe.value='';
         window.open(pstrCadena,'newWin','scrollbars=yes,status=yes,width=700,height=500');
    }
    
    function fnActualizaProv(pclProveedor, pNombreOperativo){
        document.all.clProveedorExhibe.value = pclProveedor;
        document.all.ProveedorExhibe.value = pNombreOperativo;
        fnLlenaProvColab();
    }


 function fnValidaFecha(iTipo,AnioComp)
 { 
 
   intAnioExh = 0;
   intAnioExp = 0;
 
   if (iTipo == 2)  {  fnValMask(document.all.FechaExhib,document.all.FechaExhibMsk.value,'FechaExhib')  } 
   else  {   fnValMask(document.all.FechaExped,document.all.FechaExpedMsk.value,'FechaExped')     }
   
   intAnioExh = document.all.FechaExhib.value.substring(0,4);
   intAnioExp = document.all.FechaExped.value.substring(0,4);
 
   
   //  Validar no se cambie el a�o en las fechas
   if (document.all.Action.value == 2)   // Si es modificacion, se validan las fechas deben ser del mismo anio
    {
       if (iTipo == 2)
       {
          if (AnioComp != intAnioExh)
          {
           alert("El a�o informado de la Fecha de Exhibici�n no debe ser diferente al que se inform� cuando se di� de alta");
           document.all.FechaExhib.focus(); 
            return;
          }
       }
       else
       {
          if (AnioComp != intAnioExp)
          {
           alert("El a�o informado de la Fecha de Expedici�n no debe ser diferente al que se inform� cuando se di� de alta");
           document.all.FechaExped.focus(); 
            return;          
          }
       }       
    }
 }

</script>
</body>
</html>


