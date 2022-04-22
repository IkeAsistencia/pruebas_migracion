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
            StrSql.append(" coalesce(RB.dsArticulo,'') as dsArticulo,");
            StrSql.append(" coalesce(convert(varchar(10),RB.FechaCompra,120),'') as FechaCompra,");
            StrSql.append(" coalesce(RB.CostoArticulo,'') as CostoArticulo,");
            StrSql.append(" coalesce(MS.dsMotivoSiniestro,'') as dsMotivoSiniestro,");
            StrSql.append(" RB.EnvioAbogado,");
            StrSql.append(" RB.CartaReclama,");
            StrSql.append(" RB.VoucherOriginal,");
            StrSql.append(" RB.EstadoCuenta,");
            StrSql.append(" RB.FacturaOriginal,");
            StrSql.append(" RB.IdentOficialCopia,");
            StrSql.append(" RB.TarjetaBlackCopia,");
            StrSql.append(" RB.DenunciaCopia,");
            StrSql.append(" coalesce(RB.OtroDocto,'') as OtroDocto,");
            StrSql.append(" RB.EntregoArticulo,");
            StrSql.append(" coalesce(TR.dsTipoReclamacion,'') as dsTipoReclamacion,");
            StrSql.append(" coalesce(RB.NumCuentaDep,'') as NumCuentaDep,");
            StrSql.append(" coalesce(RB.Sucursal,'') as Sucursal,");
            StrSql.append(" coalesce(RB.Banco,'') as Banco,");
            StrSql.append(" coalesce(RB.NombreTitular,'') as NombreTitular,");
            StrSql.append(" coalesce(RB.Clabe,'') as Clabe,");
            StrSql.append(" coalesce(convert(varchar(10),RB.FechaPago,120),'') as FechaPago,");
            StrSql.append(" coalesce(RB.CostoPagado,'0') as CostoPagado,");
            StrSql.append(" coalesce(convert(varchar(16),RB.FechaApertura,120),'') as FechaApertura,");
            StrSql.append(" coalesce(convert(varchar(16),RB.FechaRegistro,120),'') as FechaRegistro");
            StrSql.append(" From SeguroRoboBienes RB");
            StrSql.append(" Left Join cMotivoSiniestro MS On (RB.clMotivoSiniestro=MS.clMotivoSiniestro)");
            StrSql.append(" Left Join cTipoReclamacion TR On (RB.clTipoReclamacion=TR.clTipoReclamacion)");
            StrSql.append(" Where RB.clExpediente=").append(StrclExpediente);
 
       ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());     
       StrSql.delete(0,StrSql.length());          
       %><script>fnOpenLinks()</script><%				
  
       StrclPaginaWeb = "329";        
       MyUtil.InicializaParametrosC(329,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
       session.setAttribute("clPaginaWebP",StrclPaginaWeb); 

       %><%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist","")%> 
       <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="RoboBienes.jsp?'>"%><% 
       if (rs.next()) { 
            // El siguiente campo llave no se mete con MyUtil.ObjInput  %>
            <script>document.all.btnAlta.disabled=true;</script> 
            <script>document.all.btnElimina.disabled=true;</script>
            <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>

            <%=MyUtil.ObjInput("Descripción del Articulo","dsArticulo",rs.getString("dsArticulo"),true,true,30,85,"",true,true,60)%>
            <%=MyUtil.ObjInput("Fecha de Compra <br>aaaa/mm/dd","FechaCompra",rs.getString("FechaCompra"),true,true,360,72,"",true,true,20,"if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)}")%>
            <%=MyUtil.ObjInput("Costo del Articulo","CostoArticulo",rs.getString("CostoArticulo"),true,true,490,85,"",true,true,20,"EsNumerico(document.all.CostoArticulo)")%>
            <%=MyUtil.ObjComboC("Motivo del Siniestro", "clMotivoSiniestro",rs.getString("dsMotivoSiniestro"),true,true,30,130,"","Select clMotivoSiniestro,dsMotivoSiniestro from cMotivoSiniestro","","",140,true,true)%>
            <%=MyUtil.ObjChkBox("Envio de Abogado","EnvioAbogado",rs.getString("EnvioAbogado"), true,true,200,130,"0","SI","NO","")%>
            <%=MyUtil.ObjChkBox("Entrega de articulo dañado","EntregoArticulo",rs.getString("EntregoArticulo"), true,true,330,130,"0","SI","NO","")%>
            <%=MyUtil.ObjComboC("Reclamación", "clTipoReclamacion",rs.getString("dsTipoReclamacion"),true,true,530,130,"","SELECT clTipoReclamacion,dsTipoReclamacion FROM cTipoReclamacion","","",140,true,true)%>
            <%=MyUtil.ObjInput("No. de Cuenta para pago o deposito","NumCuentaDep",rs.getString("NumCuentaDep"),true,true,30,180,"",false,false,40)%>
            <%=MyUtil.ObjInput("Sucursal","Sucursal",rs.getString("Sucursal"),true,true,280,180,"",false,false,35)%>
            <%=MyUtil.ObjInput("Banco","Banco",rs.getString("Banco"),true,true,490,180,"",false,false,35)%>
            <%=MyUtil.ObjInput("Nombre del Titular","NombreTitular",rs.getString("NombreTitular"),true,true,30,235,"",false,false,40)%>
            <%=MyUtil.ObjInput("Clabe","Clabe",rs.getString("Clabe"),true,true,280,235,"",false,false,30)%>
            <%=MyUtil.ObjInput("Fecha de Pago <br>aaaa/mm/dd","FechaPago",rs.getString("FechaPago"),true,true,490,222,"",true,true,20,"if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)}")%>
            <%=MyUtil.ObjInput("Costo Pagado","CostoPagado",rs.getString("CostoPagado"),true,true,30,280,"",false,false,20,"EsNumerico(document.all.CostoPagado)")%>
            <%=MyUtil.ObjInput("Fecha de Apertura","FechaApertura",rs.getString("FechaApertura"),false,false,280,280,"",false,false,30)%>
            <%=MyUtil.ObjInput("Fecha de Registro","FechaRegistroVTR",rs.getString("FechaRegistro"),false,false,490,280,"",false,false,30)%>
            <%=MyUtil.DoBlock("Seguro por Robo de Bienes",0,0)%> 
            
            <%=MyUtil.ObjChkBox("Carta de solicitud de reclamación","CartaReclama",rs.getString("CartaReclama"), true,true,30,370,"0","SI","NO","")%>
            <%=MyUtil.ObjChkBox("Voucher Original","VoucherOriginal",rs.getString("VoucherOriginal"), true,true,280,370,"0","SI","NO","")%>
            <%=MyUtil.ObjChkBox("Estado de Cuenta","EstadoCuenta",rs.getString("EstadoCuenta"), true,true,420,370,"0","SI","NO","")%>
            <%=MyUtil.ObjChkBox("Ticket/Nota/Factura Original","FacturaOriginal",rs.getString("FacturaOriginal"), true,true,30,420,"0","SI","NO","")%>
            <%=MyUtil.ObjChkBox("Copia de Identificacion Oficial","IdentOficialCopia",rs.getString("IdentOficialCopia"), true,true,245,420,"0","SI","NO","")%>
            <%=MyUtil.ObjChkBox("Copia de la Tarjeta Black","TarjetaBlackCopia",rs.getString("TarjetaBlackCopia"), true,true,470,420,"0","SI","NO","")%>
            <%=MyUtil.ObjChkBox("Copia de la denuncia (En caso de robo)","DenunciaCopia",rs.getString("DenunciaCopia"), true,true,30,470,"0","SI","NO","")%>
            <%=MyUtil.ObjInput("Otro Documento: Especificar","OtroDocto",rs.getString("OtroDocto"),true,true,310,470,"",false,false,60)%>
         <%=MyUtil.DoBlock("Envio de documentación",10,0)%><% 
            
  
} 
       else {   %>
            <script>document.all.btnCambio.disabled=true;</script>
            <script>document.all.btnElimina.disabled=true;</script>
            <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
            
            <%=MyUtil.ObjInput("Descripción del Articulo","dsArticulo","",true,true,30,85,"",true,true,60)%>
            <%=MyUtil.ObjInput("Fecha de Compra <br>aaaa/mm/dd","FechaCompra","",true,true,360,72,"",true,true,20,"if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)}")%>
            <%=MyUtil.ObjInput("Costo del Articulo","CostoArticulo","",true,true,490,85,"",true,true,20,"EsNumerico(document.all.CostoArticulo)")%>
            <%=MyUtil.ObjComboC("Motivo del Siniestro", "clMotivoSiniestro","",true,true,30,130,"","Select clMotivoSiniestro,dsMotivoSiniestro from cMotivoSiniestro","","",140,true,true)%>
            <%=MyUtil.ObjChkBox("Envio de Abogado","EnvioAbogado","", true,true,200,130,"0","SI","NO","")%>
            <%=MyUtil.ObjChkBox("Entrega de articulo dañado","EntregoArticulo","", true,true,330,130,"0","SI","NO","")%>
            <%=MyUtil.ObjComboC("Reclamación", "clTipoReclamacion","",true,true,530,130,"","SELECT clTipoReclamacion,dsTipoReclamacion FROM cTipoReclamacion","","",140,true,true)%>
            <%=MyUtil.ObjInput("No. de Cuenta para pago o deposito","NumCuentaDep","",true,true,30,180,"",false,false,40)%>
            <%=MyUtil.ObjInput("Sucursal","Sucursal","",true,true,280,180,"",false,false,35)%>
            <%=MyUtil.ObjInput("Banco","Banco","",true,true,490,180,"",false,false,35)%>
            <%=MyUtil.ObjInput("Nombre del Titular","NombreTitular","",true,true,30,235,"",false,false,40)%>
            <%=MyUtil.ObjInput("Clabe","Clabe","",true,true,280,235,"",false,false,30)%>
            <%=MyUtil.ObjInput("Fecha de Pago <br>aaaa/mm/dd","FechaPago","",true,true,490,222,"",true,true,20,"if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)}")%>
            <%=MyUtil.ObjInput("Costo Pagado","CostoPagado","",true,true,30,280,"",false,false,20,"EsNumerico(document.all.CostoPagado)")%>
            <%=MyUtil.ObjInput("Fecha de Apertura","FechaApertura","",false,false,280,280,StrFecha,false,false,30)%>
            <%=MyUtil.ObjInput("Fecha de Registro","FechaRegistroVTR","",false,false,490,280,"",false,false,30)%>
            <%=MyUtil.DoBlock("Detalle de Seguro por Robo de Bienes",0,0)%> 
            
            <%=MyUtil.ObjChkBox("Carta de solicitud de reclamación","CartaReclama","", true,true,30,370,"0","SI","NO","")%>
            <%=MyUtil.ObjChkBox("Voucher Original","VoucherOriginal","", true,true,280,370,"0","SI","NO","")%>
            <%=MyUtil.ObjChkBox("Estado de Cuenta","EstadoCuenta","", true,true,420,370,"0","SI","NO","")%>
            <%=MyUtil.ObjChkBox("Ticket/Nota/Factura Original","FacturaOriginal","", true,true,30,420,"0","SI","NO","")%>
            <%=MyUtil.ObjChkBox("Copia de Identificacion Oficial","IdentOficialCopia","", true,true,245,420,"0","SI","NO","")%>
            <%=MyUtil.ObjChkBox("Copia de la Tarjeta Black","TarjetaBlackCopia","", true,true,470,420,"0","SI","NO","")%>
            <%=MyUtil.ObjChkBox("Copia de la denuncia (En caso de robo)","DenunciaCopia","", true,true,30,470,"0","SI","NO","")%>
            <%=MyUtil.ObjInput("Otro Documento: Especificar","OtroDocto","",true,true,310,470,"",false,false,60)%>
            <%=MyUtil.DoBlock("Envio de documentación",10,0)%><%
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
document.all.NombreTitular.maxLength=100; 
document.all.Clabe.maxLength=50; 
</script>
</body>
</html>

