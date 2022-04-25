<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
<head><title>JSP Page</title>
<link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
</head> 
<body class="cssBody">
<%-- <jsp:useBean id="beanInstanceName" scope="session" class="beanPackage.BeanClassName" /> --%>
<%-- <jsp:getProperty name="beanInstanceName"  property="propertyName" /> --%>
<jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj" /> 

<script src='../../Utilerias/Util.js' ></script>
<script src='../../Utilerias/UtilDireccion.js' ></script>
<script src='../../Utilerias/UtilMask.js'></script>
<%  
    String StrclExpediente = "0";   
    String StrclUsrApp="0";
    String StrclPaginaWeb="0";
    String StrFecha =""; 
    String StrCodEnt="0";
    String StrdsGerencia = ""; 
    
    

    if (session.getAttribute("clUsrApp")!= null)
     {
       StrclUsrApp = session.getAttribute("clUsrApp").toString(); 
     }  

    if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) 
    
     {
       %>Fuera de Horario<%
       
       return;  
     }    
     
    if (session.getAttribute("clExpediente")!= null)
     {
       StrclExpediente = session.getAttribute("clExpediente").toString(); 
     }  
 
    StringBuffer StrSql = new StringBuffer();
    
    
    // checar si ya existe asistencia para el expediente, si existe, ya no procede la alta
    StrSql.append(" Select TieneAsistencia, CodEnt");
    StrSql.append(" From Expediente ");
    StrSql.append(" Where clExpediente=").append(StrclExpediente);
    ResultSet rs2 = UtileriasBDF.rsSQLNP( StrSql.toString());     
    StrSql.delete(0,StrSql.length());

    if (rs2.next())  {   StrCodEnt=rs2.getString("CodEnt"); }   
    else
     {
          %>El expediente no existe<%
          rs2.close();
          
          return;      
     } 

    ResultSet rs3 = UtileriasBDF.rsSQLNP( "Select convert(varchar(20),getdate(),120) FechaApertura ");  
    if (rs3.next()){
       StrFecha = rs3.getString("FechaApertura");
    }  
 
    StrSql.append(" select ge.clgerenciareg, gr.dsgerencia from gciaregxentidad ge ");
             StrSql.append(" left join cgerenciaregional gr on (gr.clgerenciareg=ge.clgerenciareg)");
             StrSql.append(" where ge.codEnt ='").append(StrCodEnt).append("'");
    ResultSet rs4 = UtileriasBDF.rsSQLNP( StrSql.toString());  
    StrSql.delete(0,StrSql.length());
    
    if (rs4.next()){
       StrdsGerencia = rs4.getString("dsgerencia");
    }       
   
    StrSql.append("Select ");
            StrSql.append(" coalesce(GE.dsArticulo,'') as dsArticulo,");
            StrSql.append(" coalesce(convert(varchar(10),GE.FechaExpGaran,120),'') as FechaExpGaran,");
            StrSql.append(" coalesce(GE.PeriodoGarantia,'') as PeriodoGarantia,");
            StrSql.append(" coalesce(GE.TiempoExtGarantia,'') as TiempoExtGarantia,");
            StrSql.append(" coalesce(GE.CostoArticulo,'0') as CostoArticulo,");
            StrSql.append(" coalesce(GE.TipoFallaArticulo,'') as TipoFallaArticulo,");
            StrSql.append(" coalesce(PS.dsProceSeguir,'') as dsProceSeguir,");
            StrSql.append(" coalesce(GE.CostoReparacion,'0') as CostoReparacion,");
            StrSql.append(" GE.EntregoArticulo,");
            StrSql.append(" coalesce(TR.dsTipoReclamacion,'') as dsTipoReclamacion,");            
            StrSql.append(" coalesce(GE.NumCuentaDep,'') as NumCuentaDep,");
            StrSql.append(" coalesce(GE.Sucursal,'') as Sucursal,");
            StrSql.append(" coalesce(GE.Banco,'') as Banco,");
            StrSql.append(" coalesce(GE.NombreBenef,'') as NombreBenef,");
            StrSql.append(" coalesce(GE.Clabe,'') as Clabe,");
            StrSql.append(" coalesce(convert(varchar(10),GE.FechaPagoEnt,120),'') as FechaPagoEnt,");
            StrSql.append(" coalesce(GE.CostoPagado,'0') as CostoPagado,");
            StrSql.append(" coalesce(convert(varchar(16),GE.FechaApertura,120),'') as FechaApertura,");
            StrSql.append(" coalesce(convert(varchar(16),GE.FechaRegistro,120),'') as FechaRegistro,");
            StrSql.append(" GE.CartaReclama,");
            StrSql.append(" GE.VoucherOriginal,");
            StrSql.append(" GE.EstadoCuenta,");
            StrSql.append(" GE.FacturaOriginal,");
            StrSql.append(" GE.IdentOficialCopia,");
            StrSql.append(" GE.TarjetaBlackCopia,");
            StrSql.append(" GE.PolizaGarantia,");
            StrSql.append(" coalesce(GE.OtroDocto,'') as OtroDocto");
            StrSql.append(" From GarantiaExtendida GE");
            StrSql.append(" Left Join cProcedimientoSeguir PS ON (GE.clProceSeguir=PS.clProceSeguir)");
            StrSql.append(" Left Join cTipoReclamacion TR ON (GE.clTipoReclamacion=TR.clTipoReclamacion)");
            StrSql.append(" Where clExpediente=").append(StrclExpediente);
 
    ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());     
    StrSql.delete(0,StrSql.length());
        
       %><script>fnOpenLinks()</script><%
  
       StrclPaginaWeb = "331";        
       MyUtil.InicializaParametrosC(331,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
       session.setAttribute("clPaginaWebP",StrclPaginaWeb); 

       %><%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist","")%> 
       <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="GarantiaExtendida.jsp?'>"%><% 
   
       if (rs.next()) { 
            // El siguiente campo llave no se mete con MyUtil.ObjInput  %>
            <script>document.all.btnAlta.disabled=true;</script>   
            <script>document.all.btnElimina.disabled=true;</script>
            <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>  
             
            <%=MyUtil.ObjInput("Descripción del Articulo","dsArticulo",rs.getString("dsArticulo"),true,true,30,85,"",true,true,50)%>
            <%=MyUtil.ObjInput("Fecha de Expedicion de Garantia<br>aaaa/mm/dd","FechaExpGaran",rs.getString("FechaExpGaran"),true,true,320,72,"",false,false,20,"if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)}")%>
            <%=MyUtil.ObjInput("Periodo de Garantia del Fabricante","PeriodoGarantia",rs.getString("PeriodoGarantia"),true,true,550,85,"",false,false,20)%>
            <%=MyUtil.ObjInput("Tiempo de Extension de Garantia","TiempoExtGarantia",rs.getString("TiempoExtGarantia"),true,true,30,130,"",false,false,30)%>
            <%=MyUtil.ObjInput("Costo del Articulo","CostoArticulo",rs.getString("CostoArticulo"),true,true,270,130,"",true,true,20,"EsNumerico(document.all.CostoArticulo)")%>
            <%=MyUtil.ObjInput("Tipo de Falla del Articulo","TipoFallaArticulo",rs.getString("TipoFallaArticulo"),true,true,420,130,"",true,true,60)%>
            <%=MyUtil.ObjComboC("Procedimiento a Seguir", "clProceSeguir",rs.getString("dsProceSeguir"),true,true,30,180,"","Select clProceSeguir,dsProceSeguir from cProcedimientoSeguir","","",140,true,true)%>
            <%=MyUtil.ObjInput("Costo de la Reparación","CostoReparacion",rs.getString("CostoReparacion"),true,true,270,180,"",false,false,20,"EsNumerico(document.all.CostoArticulo)")%>
            <%=MyUtil.ObjChkBox("Entrega de articulo dañado","EntregoArticulo",rs.getString("EntregoArticulo"), true,true,480,180,"0","SI","NO","")%>
            <%=MyUtil.ObjComboC("Reclamación", "clTipoReclamacion",rs.getString("dsTipoReclamacion"),true,true,30,230,"","SELECT clTipoReclamacion,dsTipoReclamacion FROM cTipoReclamacion","","",140,true,true)%>
            <%=MyUtil.ObjInput("No. de Cuenta para pago o deposito","NumCuentaDep",rs.getString("NumCuentaDep"),true,true,240,230,"",false,false,40)%>
            <%=MyUtil.ObjInput("Sucursal","Sucursal",rs.getString("Sucursal"),true,true,480,230,"",false,false,35)%>
            <%=MyUtil.ObjInput("Banco","Banco",rs.getString("Banco"),true,true,30,280,"",false,false,35)%>
            <%=MyUtil.ObjInput("Nombre del Titular","NombreBenef",rs.getString("NombreBenef"),true,true,240,280,"",false,false,40)%>
            <%=MyUtil.ObjInput("Clabe","Clabe",rs.getString("Clabe"),true,true,480,280,"",false,false,30)%>
            <%=MyUtil.ObjInput("Fecha de Pago <br>aaaa/mm/dd","FechaPagoEnt",rs.getString("FechaPagoEnt"),true,true,30,330,"",false,false,20,"if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)}")%>
            <%=MyUtil.ObjInput("Costo Pagado","CostoPagado",rs.getString("CostoPagado"),true,true,240,340,"",false,false,20,"EsNumerico(document.all.CostoPagado)")%>
            <%=MyUtil.ObjInput("Fecha de Apertura","FechaApertura",rs.getString("FechaApertura"),false,false,30,390,"",false,false,30)%>
            <%=MyUtil.ObjInput("Fecha de Registro","FechaRegistroVTR",rs.getString("FechaRegistro"),false,false,240,390,"",false,false,30)%>
 <%=MyUtil.DoBlock("Detalle de Garantia Extendida",60,0)%>
            
            <%=MyUtil.ObjChkBox("Carta de solicitud de reclamación","CartaReclama",rs.getString("CartaReclama"), true,true,30,480,"0","SI","NO","")%>
            <%=MyUtil.ObjChkBox("Voucher Original","VoucherOriginal",rs.getString("VoucherOriginal"), true,true,280,480,"0","SI","NO","")%>
            <%=MyUtil.ObjChkBox("Estado de Cuenta","EstadoCuenta",rs.getString("EstadoCuenta"), true,true,420,480,"0","SI","NO","")%>
            <%=MyUtil.ObjChkBox("Ticket/Nota/Factura Original","FacturaOriginal",rs.getString("FacturaOriginal"), true,true,30,530,"0","SI","NO","")%>
            <%=MyUtil.ObjChkBox("Copia de Identificacion Oficial","IdentOficialCopia",rs.getString("IdentOficialCopia"), true,true,245,530,"0","SI","NO","")%>
            <%=MyUtil.ObjChkBox("Copia de la Tarjeta Black","TarjetaBlackCopia",rs.getString("TarjetaBlackCopia"), true,true,470,530,"0","SI","NO","")%>
            <%=MyUtil.ObjChkBox("Poliza de Garantia del Fabricante","PolizaGarantia",rs.getString("PolizaGarantia"), true,true,30,580,"0","SI","NO","")%>
            <%=MyUtil.ObjInput("Otro Documento: Especificar","OtroDocto",rs.getString("OtroDocto"),true,true,310,580,"",false,false,60)%>
         <%=MyUtil.DoBlock("Envio de documentación",10,0)%><% //Bloque detalle de Gerencia Regional  
            
  
} 
       else {   %>
            <script>document.all.btnCambio.disabled=true;</script>
            <script>document.all.btnElimina.disabled=true;</script>
            <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>  
            
            <%=MyUtil.ObjInput("Descripción del Articulo","dsArticulo","",true,true,30,85,"",true,true,50)%>
            <%=MyUtil.ObjInput("Fecha de Expedicion de Garantia<br>aaaa/mm/dd","FechaExpGaran","",true,true,320,72,"",false,false,20,"if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)}")%>
            <%=MyUtil.ObjInput("Periodo de Garantia del Fabricante","PeriodoGarantia","",true,true,550,85,"",false,false,20)%>
            <%=MyUtil.ObjInput("Tiempo de Extension de Garantia","TiempoExtGarantia","",true,true,30,130,"",false,false,30)%>
            <%=MyUtil.ObjInput("Costo del Articulo","CostoArticulo","",true,true,270,130,"",true,true,20,"EsNumerico(document.all.CostoArticulo)")%>
            <%=MyUtil.ObjInput("Tipo de Falla del Articulo","TipoFallaArticulo","",true,true,420,130,"",true,true,60)%>
            <%=MyUtil.ObjComboC("Procedimiento a Seguir", "clProceSeguir","",true,true,30,180,"","Select clProceSeguir,dsProceSeguir from cProcedimientoSeguir","","",140,true,true)%>
            <%=MyUtil.ObjInput("Costo de la Reparación","CostoReparacion","",true,true,270,180,"",false,false,20,"EsNumerico(document.all.CostoArticulo)")%>
            <%=MyUtil.ObjChkBox("Entrega de articulo dañado","EntregoArticulo","", true,true,480,180,"0","SI","NO","")%>
            <%=MyUtil.ObjComboC("Reclamación", "clTipoReclamacion","",true,true,30,230,"","SELECT clTipoReclamacion,dsTipoReclamacion FROM cTipoReclamacion","","",140,true,true)%>
            <%=MyUtil.ObjInput("No. de Cuenta para pago o deposito","NumCuentaDep","",true,true,240,230,"",false,false,40)%>
            <%=MyUtil.ObjInput("Sucursal","Sucursal","",true,true,480,230,"",false,false,35)%>
            <%=MyUtil.ObjInput("Banco","Banco","",true,true,30,280,"",false,false,35)%>
            <%=MyUtil.ObjInput("Nombre del Titular","NombreBenef","",true,true,240,280,"",false,false,40)%>
            <%=MyUtil.ObjInput("Clabe","Clabe","",true,true,480,280,"",false,false,30)%>
            <%=MyUtil.ObjInput("Fecha de Pago <br>aaaa/mm/dd","FechaPagoEnt","",true,true,30,330,"",false,false,20,"if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)}")%>
            <%=MyUtil.ObjInput("Costo Pagado","CostoPagado","",true,true,240,340,"",false,false,20,"EsNumerico(document.all.CostoPagado)")%>
            <%=MyUtil.ObjInput("Fecha de Apertura","FechaApertura","",false,false,30,390,StrFecha,false,false,30)%>
            <%=MyUtil.ObjInput("Fecha de Registro","FechaRegistroVTR","",false,false,240,390,"",false,false,30)%>
 <%=MyUtil.DoBlock("Detalle de Garantia Extendida",60,0)%> 
            
            <%=MyUtil.ObjChkBox("Carta de solicitud de reclamación","CartaReclama","", true,true,30,480,"0","SI","NO","")%>
            <%=MyUtil.ObjChkBox("Voucher Original","VoucherOriginal","", true,true,280,480,"0","SI","NO","")%>
            <%=MyUtil.ObjChkBox("Estado de Cuenta","EstadoCuenta","", true,true,420,480,"0","SI","NO","")%>
            <%=MyUtil.ObjChkBox("Ticket/Nota/Factura Original","FacturaOriginal","", true,true,30,530,"0","SI","NO","")%>
            <%=MyUtil.ObjChkBox("Copia de Identificacion Oficial","IdentOficialCopia","", true,true,245,530,"0","SI","NO","")%>
            <%=MyUtil.ObjChkBox("Copia de la Tarjeta Black","TarjetaBlackCopia","", true,true,470,530,"0","SI","NO","")%>
            <%=MyUtil.ObjChkBox("Poliza de Garantia del Fabricante","PolizaGarantia","", true,true,30,580,"0","SI","NO","")%>
            <%=MyUtil.ObjInput("Otro Documento: Especificar","OtroDocto","",true,true,310,580,"",false,false,60)%>
         <%=MyUtil.DoBlock("Envio de documentación",10,0)%> <%
            
        }  %>
        <%=MyUtil.GeneraScripts()%><%   
        rs2.close();
        rs3.close();
        rs4.close();
        rs.close();
        
%>
<input name='FechaMsk' id='FechaMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09'>
<script> 
document.all.dsArticulo.maxLength=100; 
document.all.OtroDocto.maxLength=50; 
document.all.NumCuentaDep.maxLength=50; 
document.all.Sucursal.maxLength=50; 
document.all.Banco.maxLength=50; 
document.all.NombreBenef.maxLength=100; 
document.all.Clabe.maxLength=50; 
</script>
</body>
</html>

