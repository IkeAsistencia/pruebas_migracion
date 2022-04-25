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
    int iSaldo = 0;
    String StrSaldo = "0";
    String StrFecha = ""; 
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
     if (StrclCaucion.equals("0")) 
     {
         if (session.getAttribute("clCaucion")!= null)
         {
           StrclCaucion = session.getAttribute("clCaucion").toString(); 
         }     
     }
    
    ResultSet rs4 = UtileriasBDF.rsSQLNP( "Select convert(varchar(16),getdate(),120) fechaEt ");  
    if (rs4.next())
    {
       StrFecha = rs4.getString("fechaEt");
    }    
    
    StringBuffer StrSql = new StringBuffer();

    StrSql.append("Select coalesce(I.MontoIrrecuperable,0) as MontoIrrecuperable, ");
    StrSql.append(" (C.MontoRepDan+C.MontoSanPec+C.MontoObProc+C.MontoSusAct) - coalesce(SUM(R.MontoRecuperado),0) as SaldoPar,   ");
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
     StrSql.append(" coalesce(convert(varchar(10),C.FechaRevisionAdmon,120),'') FechaRevisionAdmon,");
     StrSql.append(" TPC.dsTipoPagoCaucion 'dsTipoPagoCaucion',");
     StrSql.append(" convert(varchar(8000),coalesce(C.Observaciones,'')) 'Observaciones'");
     StrSql.append(" From Caucion C ");
     StrSql.append(" LEFT JOIN Irrecuperacion I ON (C.CLCAUCION = I.CLCAUCION) ");
     StrSql.append(" LEFT JOIN Recuperacion R ON (C.CLCAUCION = R.CLCAUCION) ");
     StrSql.append(" inner Join cProveedor PP ON (PP.clProveedor = C.clProveedorExhibe) ");
     StrSql.append(" inner Join cTipoLibera TL ON (TL.clTipoLibera = C.clTipoLibera) "); 
     StrSql.append(" inner Join cEstatusCaucion E ON (E.clEstatus= C.clEstatusCaucion) ");
     StrSql.append(" inner join DelitoEvento DE ON (DE.clDelitoEvento=C.clDelitoEvento)");
     StrSql.append(" inner Join cDelito D ON (D.clDelito=DE.clDelito) ");
     StrSql.append(" Left Join PersonalxProv PProv ON (PProv.clPersonalxProv = C.clProvColaborador) ");
     StrSql.append(" Left Join cTipoPagoCaucion TPC on (TPC.clTipoPagoCaucion = C.clTipoPagoCaucion) ");
     StrSql.append(" Where C.clCaucion =").append(StrclCaucion);
     StrSql.append(" GROUP BY ");
     StrSql.append(" C.clCaucion, ");
     StrSql.append(" C.MontoRepDan,C.MontoSanPec,C.MontoObProc,C.MontoSusAct, ");
     StrSql.append(" coalesce(convert(varchar(10), C.FechaExhib,120),'') , ");
     StrSql.append(" coalesce(convert(varchar(10), C.FechaExped,120),'') , ");
     StrSql.append(" C.FolioCaucion,");
     StrSql.append(" coalesce(PP.NombreOpe,'') , coalesce(C.clProvColaborador,'') , coalesce(C.clProveedorExhibe,0) , ");
     StrSql.append(" coalesce(TL.dsTipoLibera,'') , ");
     StrSql.append(" coalesce(E.dsEstatus,'') , C.clEstatusCaucion,");
     StrSql.append(" C.clDelitoEvento, year(C.FechaExhib) , year(C.FechaExped), ");
     StrSql.append(" C.ResponsivaAfiliado, coalesce(C.Comprobante,''), coalesce(C.ExhibicionSoportes,0), coalesce(I.MontoIrrecuperable,0), (C.MontoRepDan+C.MontoSanPec+C.MontoObProc+C.MontoSusAct), ");
     StrSql.append(" C.RevisadaxAdministrativo, ");
     StrSql.append(" coalesce(convert(varchar(10),C.FechaRevisionAdmon,120),''),TPC.dsTipoPagoCaucion,convert(varchar(8000),coalesce(C.Observaciones,'')),coalesce(AbogadoTraslada,''), coalesce(D.dsDelito,''),coalesce(PProv.Nombre,''), ");
     StrSql.append(" coalesce(C.MontoRepDan,0),");
     StrSql.append(" coalesce(C.MontoSanPec,0),");
     StrSql.append(" coalesce(C.MontoObProc,0),");
     StrSql.append(" coalesce(C.MontoSusAct,0)");

     ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());     
     StrSql.delete(0,StrSql.length());
   
   %><script>fnOpenLinks()</script><%

   StrclPaginaWeb = "285";       
   MyUtil.InicializaParametrosC(285,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina

   session.setAttribute("clPaginaWebP",StrclPaginaWeb); %> 

   <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionCaucion","")%>     
   <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="CaucionesAdmon.jsp?'>"%><%  
   
   if (rs.next()) {StrMontoIrrec = rs.getString("MontoIrrecuperable");
        iSaldo = Integer.parseInt(rs.getString("SaldoPar")) - Integer.parseInt(StrMontoIrrec);
        StrSaldo = String.valueOf(iSaldo);
       
        %><script>document.all.btnElimina.disabled=true;</script><%
       
        StrclEstatusCau = rs.getString("clEstatusCaucion");       
        if ((StrclEstatusCau.compareToIgnoreCase("1")!=0) || (rs.getString("Revisadaxadministrativo").compareToIgnoreCase("1")==0))
        {  // No se puede modificar una Caución con estatus distinto de ACTIVA
           %><script>document.all.btnCambio.disabled=true;document.all.btnAlta.disabled=true;</script><%
         }
        session.setAttribute("clCaucion",rs.getString("clCaucion"));%>
        <INPUT id='clCaucion' name='clCaucion' type='hidden' value='<%=StrclCaucion%>'>
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>                
        <INPUT id='fechaEt' name='fechaEt' type='hidden' value='<%=rs4.getString("fechaEt")%>'>
        <%=MyUtil.ObjInput("Monto Reparación <br>Daño","MontoRepDan",rs.getString("MontoRepDan"),true,true,30,70,"0",false,false,15,"fnActualizaMontos(document.all.MontoRepDan)")%>
        <%=MyUtil.ObjInput("Monto Sanción <br>Pecunaria","MontoSanPec",rs.getString("MontoSanPec"),true,true,170,70,"0",false,false,15,"fnActualizaMontos(document.all.MontoSanPec)")%>
        <%=MyUtil.ObjInput("Monto Obligación <br>Procesal o Libertad","MontoObProc",rs.getString("MontoObProc"),true,true,320,70,"0",false,false,15,"fnActualizaMontos(document.all.MontoObProc)")%>
        <%=MyUtil.ObjInput("Monto Suspensión <br>Acto Reclamado","MontoSusAct",rs.getString("MontoSusAct"),true,true,470,70,"0",false,false,15,"fnActualizaMontos(document.all.MontoSusAct)")%>        

        <%=MyUtil.ObjComboC("Delito", "clDelitoEvento",rs.getString("dsDelito"),true,true,30,120,"","select DE.clDelitoEvento, D.dsDelito from DelitoEvento DE Inner join cDelito D ON(D.clDelito=DE.clDelito) Where clExpediente=" + StrclExpediente + " Union select '','' ","","",1000,true,true)%>                               
        <%=MyUtil.ObjInput("Folio de Caución","FolioCaucionVTR",rs.getString("FolioCaucion"),false,false,30,160,"",false,false,10)%>
        <%=MyUtil.ObjInput("Monto Total Caución","MontoCaucionVTR",rs.getString("MontoCaucionVTR"),false,false,200,160,"",false,false,15)%>
        <%=MyUtil.ObjInput("Saldo por Recuperar","Saldo",StrSaldo,false,false,370,160,"",false,false,15)%>
        <%=MyUtil.ObjInput("Monto Irrecuperable","MontoIrrecuperable",StrMontoIrrec,false,false,520,160,"",false,false,15)%>
        <%=MyUtil.ObjInput("Fecha de Expedición <br>(AAAA/MM/DD)","FechaExped",rs.getString("FechaExped"),true,true,30,200,"",true,true,25,"if(this.readOnly==false){fnValidaFecha(1," + rs.getString("AnioFecExp") + ")}")%>
        <%=MyUtil.ObjInput("Fecha de Exhibición <br>(AAAA/MM/DD)","FechaExhib",rs.getString("FechaExhib"),true,true,200,200,StrFecha,true,true,25,"if(this.readOnly==false){fnValidaFecha(2," + rs.getString("AnioFecExh") + ")}")%>
        <%=MyUtil.ObjComboC("Tipo Liberación", "clTipoLibera",rs.getString("dsTipoLibera"),true,true,370,210,"","Select clTipoLibera, dsTipoLibera From cTipoLibera","","",50,true,true)%><%                                       
        String strclProveedorExhibe=rs.getString("clProveedorExhibe");%>
        
        <%=MyUtil.ObjInput("Proveedor que Exhibe","ProveedorExhibe",rs.getString("ProveedorExhibe"),true,true,30,250,"",true,true,60,"if(this.readOnly==false){fnBuscaProv();}")%>
	<INPUT id='clProveedorExhibe' name='clProveedorExhibe' type='hidden' value='<%=strclProveedorExhibe%>'><%
                if (MyUtil.blnAccess[4]==true){
                    %><div class='VTable' style='position:absolute; z-index:30; left:350px; top:255px;'>
                      <IMG SRC='../../Imagenes/Lupa.gif' class='handM' onClick='fnBuscaProv();' WIDTH=20 HEIGHT=20></div>
              <% } %>
        
        <%=MyUtil.ObjComboC("Proveedor Colaborador", "clProvColaborador",rs.getString("ProvColaborador"),true,true,400,250,"","Select clPersonalxProv, Nombre From PersonalxProv where clProveedor= " + strclProveedorExhibe ,"","",50,true,true)%>
        <%=MyUtil.ObjInput("Abogado que Traslada","AbogadoTraslada",rs.getString("AbogadoTraslada"),true,true,200,290,"",true,true,80)%>

        <%=MyUtil.ObjComboC("Estatus Caución", "clEstatusCaucion",rs.getString("dsEstatus"),true,true,30,290,StrclEstatusCau,"Select clEstatus, dsEstatus From cEstatusCaucion order by dsEstatus","","",50,true,true)%>
        <%=MyUtil.ObjChkBox("Resp. Nuestro Usr.","ResponsivaAfiliado",rs.getString("ResponsivaAfiliado"), true,true,30,335,"0","SI","NO","")%>
        <%=MyUtil.ObjChkBox("Exhib. Soportes","ExhibicionSoportes",rs.getString("ExhibicionSoportes"), true,true,180,335,"0","SI","NO","")%>   
        <%=MyUtil.ObjInput("Comprobante","Comprobante",rs.getString("Comprobante"),true,true,330,335,"",false,false,60)%>
        <%=MyUtil.ObjComboC("Tipo de pago", "clTipoPagoCaucion",rs.getString("dsTipoPagoCaucion"),true,true,30,380,"","st_TipoPagoCaucion","","",50,true,true)%>
        <%=MyUtil.DoBlock("Administración de la Caución",0,0)%>

        <%=MyUtil.ObjChkBox("Revisada","RevisadaxAdministrativo",rs.getString("RevisadaxAdministrativo"),true,true,30,470,"0","SI","NO","fnRevisado()")%>     
        <%=MyUtil.ObjInput("Fecha de Revisión<br>(AAAA/MM/DD)","FechaRevisionVTR",rs.getString("FechaRevisionAdmon"),false,false,160,470,"",false,false,25,"")%>
        <%=MyUtil.DoBlock("Datos de la Revisión por Administración de Garantías",0,21)%>

        <%=MyUtil.ObjTextArea("Observaciones","Observaciones",rs.getString("Observaciones"),"59","3",true,true,380,470,"",false,false)%>
        <%=MyUtil.DoBlock("Observaciones",140,20)%>




<%
   }
   else { 
    }    %>
        <%=MyUtil.GeneraScripts()%><%
        rs4.close();
        rs.close();  
        rs4=null;
        rs=null;
        StrclUsrApp=null;
        StrclExpediente = null;    
        StrclCaucion = null; 
        StrSql = null; 
        StrclPaginaWeb=null;    
        StrSaldo = null;
        StrFecha = null; 
        StrMontoIrrec = null;
        StrclEstatusCau=null;
        
 %>
<input name='FechaMsk' id='FechaMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09'>

<script> 
 document.all.Comprobante.maxLength=60;  
 document.all.AbogadoTraslada.maxLength=100; 

function fnBuscaProv(){
         var pstrCadena = "../../Utilerias/FiltrosProv.jsp?strSQL=sp_WebBuscaProv ";
         pstrCadena = pstrCadena + "&NombreOpe= " + document.all.ProveedorExhibe.value;
         document.all.clProveedorExhibe.value='';
         window.open(pstrCadena,'newWin','scrollbars=yes,status=yes,width=700,height=500');
    }

function fnLlenaProvColab(){  
		var strConsulta = "sp_GetProvColab '" + document.all.clProveedorExhibe.value + "'";
		var pstrCadena = "../servlet/Utilerias.LlenaCombos?strSQL=" + strConsulta;
                document.all.clProvColaborador.value = '';
		pstrCadena = pstrCadena + "&strName=clProvColaboradorC";		
		fnOptionxDefault('clProvColaboradorC',pstrCadena);
	}
	
 function fnActualizaProv(pclProveedor, pNombreOperativo){
        document.all.clProveedorExhibe.value = pclProveedor;
        document.all.ProveedorExhibe.value = pNombreOperativo;
        fnLlenaProvColab();
    }
     
 function fnActualizaMontos(Campo){  
     if (isNaN(Campo.value)==true || Campo.value=='')
     {
       alert(Campo.name + ' debe ser numérico');
       Campo.value="0";
     } 
     document.all.MontoCaucionVTR.value=0;
     document.all.MontoCaucionVTR.value = eval(document.all.MontoRepDan.value) + eval(document.all.MontoSanPec.value) + eval(document.all.MontoObProc.value) + eval(document.all.MontoSusAct.value);
  }	
	
function fnRevisado()
{ 
  
  if (document.all.RevisadaxAdministrativo.value==true)  
    {
    document.all.FechaRevisionVTR.value = document.all.fechaEt.value;  // Fecha de sql 
    
    }  
  
    else {
        if (document.all.RevisadaxAdministrativo.value==false)
            {
    document.all.FechaRevisionVTR.value = " ";  
             }     
         }
}

 function fnValidaFecha(iTipo,AnioComp)
 { 
 
   intAnioExh = 0;
   intAnioExp = 0;
 
   if (iTipo == 2)  {  fnValMask(document.all.FechaExhib,document.all.FechaMsk.value,'FechaExhib')  } 
   else  {   fnValMask(document.all.FechaExped,document.all.FechaMsk.value,'FechaExped')     }
   
   intAnioExh = document.all.FechaExhib.value.substring(0,4);
   intAnioExp = document.all.FechaExped.value.substring(0,4);
 
   
   //  Validar no se cambie el año en las fechas
   if (document.all.Action.value == 2)   // Si es modificacion, se validan las fechas deben ser del mismo anio
    {
       if (iTipo == 2)
       {
          if (AnioComp != intAnioExh)
          {
           alert("El año informado de la Fecha de Exhibición no debe ser diferente al que se informó cuando se dió de alta");
           document.all.FechaExhib.focus(); 
            return;
          }
       }
       else
       {
          if (AnioComp != intAnioExp)
          {
           alert("El año informado de la Fecha de Expedición no debe ser diferente al que se informó cuando se dió de alta");
           document.all.FechaExped.focus(); 
            return;          
          }
       }       
    }
/*
   if (iTipo == 2)
   {
        if (document.all.FechaExped.value < document.all.FechaExhib.value)
        {
           alert("La Fecha de Expedición no puede ser menor a la Fecha de Exhibición");
           document.all.FechaExped.focus(); 
        }
   }     
   else
   {
        if (document.all.FechaExped.value < document.all.FechaExhib.value)
        {
           alert("La Fecha de Expedición no puede ser menor a la Fecha de Exhibición");
           document.all.FechaExhib.focus(); 
        }
   }
 */ 
 }

</script>
</body>
</html>


