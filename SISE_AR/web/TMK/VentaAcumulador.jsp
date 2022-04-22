<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<html>
    <head>
        <title></title>
    </head>
    <body class="cssBody" onload="fnPagCarrito();">
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
        <script src='../Utilerias/Util.js'></script>
        <script src='../Utilerias/UtilMask.js'></script>
        <script src='../Utilerias/UtilDireccion.js'></script>
        <script src='../Utilerias/UtilAuto.js'></script>
        <%
        com.ike.util.I18N i18n = com.ike.util.I18N.getInstance("es","AR");
        String StrclUsrApp = "0";
        String StrclExpediente = "0";
        String strclUsr = "0";
        String StrClaveAMIS ="";
        String StrCodigoMarca = "";
        String StrdsMarcaAuto = "";
        String StrdsTipoAuto = "";
        
        if (session.getAttribute("clUsrApp")!= null)
        {
            StrclUsrApp = session.getAttribute("clUsrApp").toString();
        }
        else if (request.getParameter("clUsrApp")!= null)
        {
            StrclUsrApp = request.getParameter("clUsrApp").toString();
        }
        
        if (request.getParameter("clExpediente")!= null)
        {
            StrclExpediente = request.getParameter("clExpediente").toString();
        }
        
        
        StringBuffer StrSql = new StringBuffer();
        
        StrSql.append("Select E.TieneAsistencia,");
        StrSql.append("case when AV.ReportaVenta=1 then 'USUARIO' when AV.ReportaVenta=2 then 'PROVEEDOR' when AV.ReportaVenta=3 then 'COORDINADOR' when AV.ReportaVenta=4 then 'OTRO' end 'ReportaVenta',");
        StrSql.append("case when AV.UsuarioAcepta=1 then 'SI' else 'NO'end 'UsuarioAcepta',");
        StrSql.append("case when AV.clFormaPago=4 then 'TARJETA DE CREDITO' when AV.clFormaPago=5 then 'EFECTIVO' when AV.clFormaPago=6 then 'OTRO' end  dsFormaPago,B.Nombre,AV.TarjetaNumero,");
        StrSql.append("case when Convert(varchar(20),AV.Vencimiento,120)='1900-01-01 00:00:00' then '' else Left(Convert(varchar(20),AV.Vencimiento,120),7) end 'Vencimiento',AV.CodigoSeguridad,AV.Monto,AV.Autorizacion,");
        StrSql.append("AV.ClaveAMIS,MA.dsMarcaAuto,TA.dsTipoAuto,TA.ClaveAMIS,");
        StrSql.append("AV.Modelo,AV.Color,AV.Placas,");
        StrSql.append("case when AV.Factura=1 then 'SI' else 'NO' end 'Factura',");
        StrSql.append("AV.Fax,AV.UsuarioRZ,AV.RFC,EF.dsEntFed,MD.dsMunDel,right('00000'+ rtrim(AV.CodMD),5) 'CodMD', AV.CodEnt,AV.Colonia,");
        StrSql.append("AV.CalleNum,AV.CP,FE.dsFormaEntrega ");
        StrSql.append("from AsistVentaAcumulador AV ");
        StrSql.append("left join cFormaPago FP on (AV.clFormaPago = FP.clFormaPago) ");
        StrSql.append("left join cBanco B on (AV.clBanco = B.clBanco) ");
        StrSql.append("left join cFormaEntrega FE on (AV.clFormaEntrega = FE.clFormaEntrega) ");
        StrSql.append("left join cEntFed EF on (AV.CodEnt = EF.CodEnt) ");
        StrSql.append("left join cMunDel MD on (right('00000'+ rtrim(AV.CodMD),5)= MD.CodMD and MD.CodEnt = EF.CodEnt) ");
        StrSql.append("left join cMarcaAuto MA on (AV.CodigoMarca = MA.CodigoMarca) ");
        StrSql.append("left join cTipoAuto TA on (AV.ClaveAMIS = TA.ClaveAMIS) ");
        StrSql.append("inner join Expediente E on (AV.clExpediente = E.clExpediente) ");
        StrSql.append("where AV.clExpediente = ").append(StrclExpediente);
        
        ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
        StrSql.delete(0,StrSql.length());
        
        
        String StrclPaginaWeb = "593";
        session.setAttribute("clPaginaWebP",StrclPaginaWeb);
        %>
        <script>fnOpenLinks()</script>
        <%
        MyUtil.InicializaParametrosC(593,Integer.parseInt(StrclUsrApp)); %>
        <%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaVentaAcumulador","","fnAntesGuardar();")%>
        
        <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="VentaAcumulador.jsp?'>"%>
        
        
        <%
        if(rs.next())
        {
            
            if(rs.getString("TieneAsistencia").compareToIgnoreCase("1")==0)
            {%>
        <script>document.all.btnAlta.disabled=true; document.all.btnElimina.disabled=true;</script>
        <%
            }
            else
            {%>
        <script>document.all.btnCambio.disabled=true; document.all.btnElimina.disabled=true;</script>
        <%
            }%>
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
        <INPUT id='Vencimiento' name='Vencimiento' type='hidden' value=' '>
        
        <%=MyUtil.ObjComboC("Reporta Venta","ReportaVenta",rs.getString("ReportaVenta"),true,false,30,80,"","sp_RespuestaCanalVenta","","",30,false,false)%>
        <%=MyUtil.ObjComboC("Usuario Acepta Compra","UsuarioAcepta",rs.getString("UsuarioAcepta"),true,false,200,80,"","sp_RespuestaVentaAcumulador","","",30,false,false)%>
        <%=MyUtil.ObjComboC("Forma de Pago","clFormaPago",rs.getString("dsFormaPago"),true,false,370,80,"","Select 4,'TARJETA DE CREDITO' union Select 5,'EFECTIVO'","fnsinoTarjeta();","",30,true,false)%>
        <%=MyUtil.ObjComboC("Banco Emisor","clBanco",rs.getString("Nombre"),true,false,30,120,"","Select * from cBanco","fnTarjeta(this.value);if(document.all.TarjetaNumeroVTR.readOnly==false){fnValMask(document.all.TarjetaNumeroVTR,document.all.TarjetaNumeroMsk.value,document.all.TarjetaNumeroVTR.name)}","",30,false,false)%>
        <%=MyUtil.ObjInput("Número de Tarjeta","TarjetaNumeroVTR",rs.getString("TarjetaNumero"),true,false,230,120,"",false,false,30,"if(this.readOnly==false){fnValMask(this,document.all.TarjetaNumeroMsk.value,this.name)}")%>
        <INPUT id='TarjetaNumero' name='TarjetaNumero' type='hidden' value='<%=rs.getString("TarjetaNumero")%>'>
        <%=MyUtil.ObjInput("Vencimiento (AAAA/MM)","VencimientoVTR",rs.getString("Vencimiento"),true,false,400,120,"",false,false,25,"if(this.readOnly==false){fnValMask(this,document.all.VencimientoMsk.value,this.name);fnFechVen()}")%>
        <%=MyUtil.ObjInput("Código de Seguridad","CodigoSeguridad",rs.getString("CodigoSeguridad"),true,false,560,120,"",false,false,4,"EsNumerico(document.all.CodigoSeguridad)")%>                 
        <%=MyUtil.ObjInput("Monto","Monto",rs.getString("Monto"),false,false,30,160,"",true,true,30,"EsNumerico(document.all.Monto)")%>  
        <%=MyUtil.ObjInput("No. Autorización","Autorizacion",rs.getString("Autorizacion"),true,false,200,160,"",false,false,30,"EsNumerico(document.all.Autorizacion)")%> 
        <%=MyUtil.ObjComboC("Requiere Factura","Factura",rs.getString("Factura"),true,true,370,160,"","sp_RespuestaVentaAcumulador","","",30,true,false)%>
        <%=MyUtil.ObjInput("No. Fax para Envío de Voucher","Fax",rs.getString("Fax"),true,true,530,160,"",false,false,30)%>
        <%
        StrClaveAMIS = rs.getString("ClaveAMIS");
        if (StrClaveAMIS ==null)
        {
            StrClaveAMIS = "";
        }
        StrdsMarcaAuto = rs.getString("dsMarcaAuto");
        if (StrdsMarcaAuto ==null)
        {
            StrdsMarcaAuto = "";
        }
        
        StrdsTipoAuto = rs.getString("dsTipoAuto");
        if (StrdsTipoAuto ==null)
        {
            StrdsTipoAuto = "";}
        %>
        <%=MyUtil.ObjComboC("Marca de Auto","CodigoMarca",StrdsMarcaAuto,true,true,30,200,"","select CodigoMarca, dsMarcaAuto from cMarcaAuto order by dsMarcaAuto","fnLlenaAMISAcumula()","",50,true,false)%>
        <%=MyUtil.ObjComboC("Tipo de Auto","ClaveAMIS",StrdsTipoAuto,true,true,200,200,"","select ClaveAmis,dsTipoAuto from cTipoAuto where ClaveAmis='" + StrClaveAMIS + "'" ,"","",50,true,false)%>
        <INPUT id='ClaveAMISVTR' name='ClaveAMISVTR' type='hidden' value='<%=StrClaveAMIS%>'>
        <%=MyUtil.ObjInput("Modelo","Modelo",rs.getString("Modelo"),true,true,550,200,"",true,false,6,"if(this.readOnly==false){fnValidaModelo(this)}")%>
        <%=MyUtil.ObjInput("Color","Color",rs.getString("Color"),true,true,610,200,"",true,false,10)%>
        <%=MyUtil.ObjInput("Placas","Placas",rs.getString("Placas"),true,true,690,200,"",true,false,8)%>
        <%=MyUtil.DoBlock("Detalles de la Venta",0 ,0)%>
        
        <%=MyUtil.ObjInput("Nombre ó Razón Social","UsuarioRZ",rs.getString("UsuarioRZ"),true,true,30,300,"",true,false,30)%> 
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.rfc"),"RFC",rs.getString("RFC"),true,true,200,300,"",true,false,25)%> 
        <%=MyUtil.ObjComboC(i18n.getMessage("message.title.entidad"),"CodEnt",rs.getString("dsEntFed"),true,true,345,300,"","Select CodEnt, dsEntFed from cEntFed order by dsEntFed ","fnLlenaMunicipios()","",40,true,false)%>
        <%=MyUtil.ObjComboC(i18n.getMessage("message.title.municipio"),"CodMD",rs.getString("dsMunDel"),true,true,540,300,"","Select CodMD, dsMunDel from cMunDel where CodMD='" + rs.getString("CodMD") + "' and CodEnt='"+ rs.getString("CodEnt") +"' order by dsMunDel ","","",40,true,false)%>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.colonia"),"Colonia",rs.getString("Colonia"),true,true,30,340,"",true,false,30)%>
        <%=MyUtil.ObjInput("Calle y Número","CalleNum",rs.getString("CalleNum"),true,true,200,340,"",true,false,50)%>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.cp"),"CP",rs.getString("CP"),true,true,470,340,"",true,false,10,"EsNumerico(document.all.CP)")%>
        <%=MyUtil.DoBlock("Datos de la Facturación",50,0)%>  
        <script>if (document.all.UsuarioAceptaC.value!=1){document.all.btnCambio.disabled=true}</script>
        
        <%
        }
        else
        {
        %><script>document.all.btnCambio.disabled=true; document.all.btnElimina.disabled=true;</script>
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
        <INPUT id='Vencimiento' name='Vencimiento' type='hidden' value=' '>
        <INPUT id='TarjetaNumero' name='TarjetaNumero' type='hidden' value=' '>
        <%=MyUtil.ObjComboC("Reporta Venta","ReportaVenta","",true,true,30,80,"","sp_RespuestaCanalVenta","","",30,true,false)%>
        <%=MyUtil.ObjComboC("Usuario Acepta Compra","UsuarioAcepta","",true,true,200,80,"","sp_RespuestaVentaAcumulador","fnUsuarioAcepta(this.value);","",30,true,false)%>
        <%=MyUtil.ObjComboC("Forma de Pago","clFormaPago","",true,true,370,80,"","Select 4,'TARJETA DE CREDITO' union Select 5,'EFECTIVO'","fnsinoTarjeta();","",30,false,false)%>
        <%=MyUtil.ObjComboC("Banco Emisor","clBanco","",true,true,30,120,"","Select * from cBanco","fnTarjeta(this.value);if(document.all.TarjetaNumeroVTR.readOnly==false){fnValMask(document.all.TarjetaNumeroVTR,document.all.TarjetaNumeroMsk.value,document.all.TarjetaNumeroVTR.name)}","",30,false,false)%>
        <%=MyUtil.ObjInput("Número de Tarjeta","TarjetaNumeroVTR","",true,true,230,120,"",false,false,30,"if(this.readOnly==false){fnValMask(this,document.all.TarjetaNumeroMsk.value,this.name)};document.all.TarjetaNumero.value=document.all.TarjetaNumeroVTR.value")%>
        <%=MyUtil.ObjInput("Vencimiento (AAAA/MM)","VencimientoVTR","",true,true,400,120,"",false,false,25,"if(this.readOnly==false){fnValMask(this,document.all.VencimientoMsk.value,this.name);fnFechVen()}")%>
        <%=MyUtil.ObjInput("Código de Seguridad","CodigoSeguridad","",true,true,560,120,"",false,false,4,"EsNumerico(document.all.CodigoSeguridad)")%>                 
        <%=MyUtil.ObjInput("Monto","Monto","",false,false,30,160,"",false,false,30,"EsNumerico(document.all.Monto)")%>  
        <INPUT class='cBtn' TYPE="button" VALUE="Actualizar Monto" ONCLICK="parent.ListaVenta.fnSumaMonto()"></INPUT>
        <%=MyUtil.ObjInput("No. Autorización","Autorizacion","",true,true,200,160,"",false,false,30,"EsNumerico(document.all.Autorizacion)")%> 
        <%=MyUtil.ObjComboC("Requiere Factura","Factura","",true,true,370,160,"","sp_RespuestaVentaAcumulador","","",30,false,false)%>
        <%=MyUtil.ObjInput("No. Fax para Envío de Voucher","Fax","",true,true,530,160,"",false,false,30)%>
        
        <%=MyUtil.ObjComboC("Marca de Auto","CodigoMarca","",true,true,30,200,"","select CodigoMarca, dsMarcaAuto from cMarcaAuto order by dsMarcaAuto","fnLlenaAMISAcumula()","",50,false,false)%>
        <%=MyUtil.ObjComboC("Tipo de Auto","ClaveAMIS","",true,true,200,200,"","select ClaveAmis,dsTipoAuto from cTipoAuto where ClaveAmis='0'" ,"","",50,false,false)%>
        <INPUT id='ClaveAMISVTR' name='ClaveAMISVTR' type='hidden' value=''>                
        <%=MyUtil.ObjInput("Modelo","Modelo","",true,true,550,200,"",false,false,6,"if(this.readOnly==false){fnValidaModelo(this)}")%>
        <%=MyUtil.ObjInput("Color","Color","",true,true,610,200,"",false,false,10)%>
        <%=MyUtil.ObjInput("Placas","Placas","",true,true,690,200,"",false,false,8)%>
        <%=MyUtil.DoBlock("Detalles de la Venta",0 ,0)%>
        
        <%=MyUtil.ObjInput("Nombre ó Razón Social","UsuarioRZ","",true,true,30,300,"",false,false,30)%> 
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.rfc"),"RFC","",true,true,200,300,"",false,false,25)%> 
        <%=MyUtil.ObjComboC(i18n.getMessage("message.title.entidad"),"CodEnt","",true,true,345,300,"","Select CodEnt, dsEntFed from cEntFed order by dsEntFed ","fnLlenaMunicipios()","",40,false,false)%>
        <%=MyUtil.ObjComboC(i18n.getMessage("message.title.municipio"),"CodMD","",true,true,540,300,"","","","",40,false,false)%>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.colonia"),"Colonia","",true,true,30,340,"",false,false,30)%>
        <%=MyUtil.ObjInput("Calle y Número","CalleNum","",true,true,200,340,"",false,false,50)%>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.cp"),"CP","",true,true,470,340,"",false,false,10,"EsNumerico(document.all.CP)")%>
        <%=MyUtil.DoBlock("Datos de la Facturación",50,0)%>  
        <%
        }
        %>
        <%=MyUtil.GeneraScripts()%>
        <%
        rs.close();
        rs=null;
        
        StrclExpediente = null;
        strclUsr = null;
        StrSql =null; 
        %>
        <input name='FechaCompraMsk' id='FechaCompraMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'> 
        <input name='VencimientoMsk' id='VencimientoMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09'>
        <input name='TarjetaNumeroMsk' id='TarjetaNumeroMsk' type='hidden'>
        <script>
    
    function fnTarjeta(opcion){
    if (opcion!=2){
        document.all.TarjetaNumeroMsk.value="VN09VN09VN09VN09F-/-VN09VN09VN09VN09F-/-VN09VN09VN09VN09F-/-VN09VN09VN09VN09";
        document.all.TarjetaNumeroVTR.maxLenght=19;
    }
    else{
        document.all.TarjetaNumeroMsk.value="VN09VN09VN09VN09F-/-VN09VN09VN09VN09VN09VN09F-/-VN09VN09VN09VN09VN09";
        document.all.TarjetaNumeroVTR.maxLenght=18;
    }
}  

document.all.CodigoSeguridad.maxLength=4;
document.all.CP.maxLength=5;
document.all.Modelo.maxLength=4;
document.all.Placas.maxLength=8;

function fnAntesGuardar(){
    if (document.all.clFormaPagoC.value == 4 && (document.all.clBancoC.value == "" || document.all.TarjetaNumero.value == "" || document.all.Vencimiento.value == "" || document.all.CodigoSeguridad.value == ""  ||  document.all.Autorizacion.value == ""))
        {
          msgVal = msgVal + "Favor de proveer los datos completos de Pago por Tarjeta de Crédito. "; document.all.btnGuarda.disabled=false;document.all.btnCancela.disabled=false;
        }
    if ( document.all.UsuarioAceptaC.value==1 && (document.all.Monto.value == "0.0" || document.all.Monto.value == '0') )
        {
          msgVal = msgVal + "El Monto de la Venta es igual a '0.0' "; document.all.btnGuarda.disabled=false;document.all.btnCancela.disabled=false;
        }
    if (document.all.UsuarioAceptaC.value==1){
            if (document.all.clFormaPagoC.value==''){msgVal=msgVal + ' Forma de Pago. '}
            if (document.all.Monto.value==''){msgVal=msgVal + ' Monto. '}
            if (document.all.CodigoMarcaC.value==''){msgVal=msgVal + ' Marca de Auto. '}
            if (document.all.ClaveAMISC.value==''){msgVal=msgVal + ' Tipo de Auto. '}
            if (document.all.Modelo.value==''){msgVal=msgVal + ' Modelo. '}
            if (document.all.Color.value==''){msgVal=msgVal + ' Color. '}
            if (document.all.Placas.value==''){msgVal=msgVal + ' Placas. '}
            if (document.all.UsuarioRZ.value==''){msgVal=msgVal + ' Nombre ó Razón Social. '}
            if (document.all.RFC.value==''){msgVal=msgVal + ' <%=i18n.getMessage("message.title.rfc")%> '}
            if (document.all.CodEntC.value==''){msgVal=msgVal + ' <%=i18n.getMessage("message.title.entidad")%>. '}
            if (document.all.CodMDC.value==''){msgVal=msgVal + ' Municipio / Delegación. '}
            if (document.all.Colonia.value==''){msgVal=msgVal + ' Colonia. '}
            if (document.all.CalleNum.value==''){msgVal=msgVal + ' Calle y Número. '}
            if (document.all.CP.value==''){msgVal=msgVal + ' C.P.. '} 
            document.all.btnGuarda.disabled=false; document.all.btnCancela.disabled=false;
        }    
}

function fnFechVen(){
    if (document.all.VencimientoVTR.value != ""){
    document.all.Vencimiento.value = document.all.VencimientoVTR.value + '-01 00:00:00';
    window.open('Vencimiento.jsp?Vencimiento=' + document.all.Vencimiento.value, 'Vencimiento' ,'scrolling=yes, width= 100 ,height= 100'); 
    }
}

function fnVencimiento(resp){
    if (resp!=1){
        alert("La Fecha de Vencimiento de la Tarjeta no es válida.");
        document.all.VencimientoVTR.value = ""; document.all.Vencimiento.value = "";
        document.all.VencimientoVTR.focus(); document.all.btnGuarda.disabled=false;
    }
}
  
function fnPagCarrito(){
    parent.ListaVenta.location.reload();
}

function fnsino()
{ if (document.all.FacturaC.value!=1)
    {   
        hide("D21");
        hide("D22");
        hide("D23");
        hide("D24");
        hide("D25");
        hide("D26");
        hide("D27");
        hide("D28");
    }        
    else { if (document.all.FacturaC.value==1){       
        show("D21");
        show("D22");
        show("D23");
        show("D24");
        show("D25");
        show("D26");
        show("D27");
        show("D28");
         } 
    } 
}

function fnsinoTarjeta()
{ if (document.all.clFormaPagoC.value!=4)
    {    
        document.all.clBancoC.value=""
        document.all.TarjetaNumero.value=""
        document.all.VencimientoVTR.value=""
        document.all.Vencimiento.value=""
        document.all.CodigoSeguridad.value=""
        document.all.Autorizacion.value=""
        document.all.Fax.value=""
        hide("D6");
        hide("D7");
        hide("D8");
        hide("D9");
        hide("D11");
        hide("D13");
        }
    else { if (document.all.clFormaPagoC.value==4){       
         show("D6");
         show("D7");
         show("D8");
         show("D9");
         show("D11");
         show("D13");
        } 
    } 
}

function hide(i) {
if (document.all) {
var ourhelp = eval ("document.all."+ i)
ourhelp.style.visibility="hidden";
}
}

function show(i) {
if (document.all) {
var ourhelp = eval ("document.all."+ i)
ourhelp.style.visibility="visible";
}
}

function fnUsuarioAcepta(opcion){
    if (opcion!=1){
        window.open('BorrarAcumuladorxExp.jsp?clExpediente=' + document.all.clExpediente.value + '&clusrAppventa=<%=StrclUsrApp%>', 'Borrado' ,'scrolling=yes, width= 100 ,height= 100'); 
        fnPagCarrito();
        document.all.clFormaPagoC.disabled=true;document.all.clFormaPagoC.className='VTable';document.all.clFormaPagoC.value="";
        document.all.clBancoC.disabled=true;document.all.clBancoC.className='VTable';document.all.clBancoC.value="";
        document.all.TarjetaNumeroVTR.readOnly=true;document.all.TarjetaNumeroVTR.className='VTable';document.all.TarjetaNumeroVTR.value="";
        document.all.TarjetaNumero.value="";
        document.all.VencimientoVTR.readOnly=true;document.all.VencimientoVTR.className='VTable';document.all.VencimientoVTR.value="";
        document.all.Vencimiento.value="";
        document.all.CodigoSeguridad.readOnly=true;document.all.CodigoSeguridad.className='VTable';document.all.CodigoSeguridad.value="";
        document.all.Monto.readOnly=true;document.all.Monto.className='VTable';document.all.Monto.value="";
        document.all.Autorizacion.readOnly=true;document.all.Autorizacion.className='VTable';document.all.Autorizacion.value="";
        document.all.FacturaC.disabled=true;document.all.FacturaC.className='VTable';document.all.FacturaC.value="";
        document.all.Fax.readOnly=true;document.all.Fax.className='VTable';document.all.Fax.value="";
        document.all.CodigoMarcaC.disabled=true;document.all.CodigoMarcaC.className='VTable';document.all.CodigoMarcaC.value="";
        document.all.ClaveAMISC.disabled=true;document.all.ClaveAMISC.className='VTable';document.all.ClaveAMISC.value="";
        document.all.Modelo.readOnly=true;document.all.Modelo.className='VTable';document.all.Modelo.value="";
        document.all.Color.readOnly=true;document.all.Color.className='VTable';document.all.Color.value="";
        document.all.Placas.readOnly=true;document.all.Placas.className='VTable';document.all.Placas.value="";
        document.all.UsuarioRZ.readOnly=true;document.all.UsuarioRZ.className='VTable';document.all.UsuarioRZ.value="";
        document.all.RFC.readOnly=true;document.all.RFC.className='VTable';document.all.RFC.value="";
        document.all.CodEntC.disabled=true;document.all.CodEntC.className='VTable';document.all.CodEntC.value="";
        document.all.CodMDC.disabled=true;document.all.CodMDC.className='VTable';document.all.CodMDC.value="";
        document.all.Colonia.readOnly=true;document.all.Colonia.className='VTable';document.all.Colonia.value="";
        document.all.CalleNum.readOnly=true;document.all.CalleNum.className='VTable';document.all.CalleNum.value="";
        document.all.CP.readOnly=true;document.all.CP.className='VTable';document.all.CP.value="";
    } else {
        document.all.clFormaPagoC.disabled=false;document.all.clFormaPagoC.className='VTable';
        document.all.clBancoC.disabled=false;document.all.clBancoC.className='VTable';
        document.all.TarjetaNumeroVTR.readOnly=false;document.all.TarjetaNumeroVTR.className='VTable';
        document.all.VencimientoVTR.readOnly=false;document.all.VencimientoVTR.className='VTable';
        document.all.CodigoSeguridad.readOnly=false;document.all.CodigoSeguridad.className='VTable';
        document.all.Monto.readOnly=true;document.all.Monto.className='FReq';
        document.all.Autorizacion.readOnly=false;document.all.Autorizacion.className='VTable';
        document.all.FacturaC.disabled=false;document.all.FacturaC.className='FReq';
        document.all.Fax.readOnly=false;document.all.Fax.className='VTable';
        document.all.CodigoMarcaC.disabled=false;document.all.CodigoMarcaC.className='FReq';
        document.all.ClaveAMISC.disabled=false;document.all.ClaveAMISC.className='FReq';
        document.all.Modelo.readOnly=false;document.all.Modelo.className='FReq';
        document.all.Color.readOnly=false;document.all.Color.className='FReq';
        document.all.Placas.readOnly=false;document.all.Placas.className='FReq';
        document.all.UsuarioRZ.readOnly=false;document.all.UsuarioRZ.className='FReq';
        document.all.RFC.readOnly=false;document.all.RFC.className='FReq';
        document.all.CodEntC.disabled=false;document.all.CodEntC.className='FReq';
        document.all.CodMDC.disabled=false;document.all.CodMDC.className='FReq';
        document.all.Colonia.readOnly=false;document.all.Colonia.className='FReq';
        document.all.CalleNum.readOnly=false;document.all.CalleNum.className='FReq';
        document.all.CP.readOnly=false;document.all.CP.className='FReq';
        
    }
}
        </script>
    </body>
</html>