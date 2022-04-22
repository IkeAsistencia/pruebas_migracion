<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<html>
    <head>
        <title></title>
    </head>
    <body class="cssBody" onload=''>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
        <script src='../Utilerias/Util.js'></script>
        <script src='../Utilerias/UtilMask.js'></script>
        <script src='../Utilerias/UtilDireccion.js'></script>
        <script src='../Utilerias/UtilAuto.js'></script>
        <%
        com.ike.util.I18N i18n = com.ike.util.I18N.getInstance("es","AR");
        String StrclExpediente = "0";
        String StrclUsrApp = "0";
        String StrClaveAMIS ="";
        String StrCodigoMarca = "";
        String StrdsMarcaAuto = "";
        String StrdsTipoAuto = "";
        String StrClave="0";
        String StrFechaCompra="";
        String StrPoliza="";
        String StrclAcumulador="0";
        String StrSerie="";
        String StrMeses="0";
        String StrUltra="0";
        
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
        if (session.getAttribute("Clave")!= null)
        {
            StrClave = session.getAttribute("Clave").toString();
        }
        
        StringBuffer StrSql2 = new StringBuffer();
        
        StrSql2.append(" Select convert(varchar(16),FechaIni,120) as FechaCompra,Clave as Poliza, AI.clAcumulador, AI.SerieAcumulador as Serie,");
        StrSql2.append(" datediff(month,A.FechaIni,getdate()) 'Meses', CA.Ultra ");
        StrSql2.append(" from 	cAfiliadoDur A");
        StrSql2.append(" inner 	join AfiliadoInfoAdicionalDur AI on (A.clAfiliado=AI.clAfiliado) ");
        StrSql2.append(" inner 	join cAcumulador CA on (AI.clAcumulador=CA.clAcumulador) ");
        StrSql2.append(" where 	clave='").append(StrClave).append("'");
        
        ResultSet rs2 = UtileriasBDF.rsSQLNP( StrSql2.toString());
        StrSql2.delete(0,StrSql2.length());
        
        if (rs2.next())
        {
            
            StrFechaCompra = rs2.getString("FechaCompra");
            if (StrFechaCompra ==null)
            {
                StrFechaCompra = "";
            }
            StrPoliza = rs2.getString("Poliza");
            if (StrPoliza ==null)
            {
                StrPoliza = "";
            }
            
            StrclAcumulador = rs2.getString("clAcumulador");
            if (StrclAcumulador ==null)
            {
                StrclAcumulador = "";}
            
            StrSerie = rs2.getString("Serie");
            if (StrSerie ==null)
            {
                StrSerie = "";
            }
            StrMeses = rs2.getString("Meses");
            if (StrMeses ==null)
            {
                StrMeses = "0";
            }
            
            StrUltra = rs2.getString("Ultra");
            if (StrUltra ==null)
            {
                StrUltra = "0";
            }
            
            StringBuffer StrSql = new StringBuffer();
            
            StrSql.append(" Select E.TieneAsistencia,AG.FechaCompra,AG.NumSerie,(Select dsAcumulador from cAcumulador where clAcumulador=AG.clAcumulador) 'dsAcumulador',AG.NumPoliza,");
            StrSql.append(" Case when AG.Procede=1 then 'SI' else 'NO' end 'Procede'," );
            StrSql.append(" AG.PorcentajeGarantia,AG.MontoGarantia,");
            StrSql.append(" AG.NumSerieNuevo,(Select dsAcumulador from cAcumulador where clAcumulador=AG.clAcumuladorNuevo) 'dsAcumuladorNuevo',AG.NumPolizaNuevo,");
            StrSql.append(" CASE when AG.UsuarioAcepta=1 then 'SI' else 'NO' end 'UsuarioAcepta',");
            StrSql.append(" case when AG.clFormaPago=4 then 'TARJETA DE CREDITO' when AG.clFormaPago=5 then 'EFECTIVO' when AG.clFormaPago=6 then 'OTRO' end 'dsFormaPago',");
            StrSql.append(" B.Nombre,AG.TarjetaNumero,");
            StrSql.append(" case when Convert(varchar(20),AG.Vencimiento,120)='1900-01-01 00:00:00' then '' else Left(Convert(varchar(20),AG.Vencimiento,120),7) end 'Vencimiento',");
            StrSql.append(" AG.CodigoSeguridad, convert(varchar(10),AG.Monto,20) 'Monto', AG.Autorizacion,");
            StrSql.append(" MA.dsMarcaAuto,TA.dsTipoAuto,TA.ClaveAMIS,AG.Modelo,AG.Color,AG.Placas,");
            StrSql.append(" case when AG.Factura=1 then 'SI' else 'NO' end 'Factura',");
            StrSql.append(" AG.Fax, AG.UsuarioRZ, AG.RFC, EF.dsEntFed, MD.dsMunDel, right('00000'+ rtrim(AG.CodMD),5) 'CodMD',AG.CodEnt, AG.Colonia, AG.CalleNum,");
            StrSql.append(" AG.CP, FE.dsFormaEntrega");
            StrSql.append(" from AsistGarantiaAcumulador AG");
            StrSql.append(" left join cAcumulador AC on (AG.clAcumulador=AC.clAcumulador and AG.clAcumuladorNuevo=AC.clAcumulador)");
            StrSql.append(" left join cBanco B on (AG.clBanco = B.clBanco)");
            StrSql.append(" left join cMarcaAuto MA on (AG.CodigoMarca = MA.CodigoMarca)");
            StrSql.append(" left join cTipoAuto TA on (AG.ClaveAMIS = TA.ClaveAMIS)");
            StrSql.append(" left join cEntFed EF on (AG.CodEnt = EF.CodEnt)");
            StrSql.append(" left join cMunDel MD on (right('00000'+ rtrim(AG.CodMD),5) = MD.CodMD and EF.CodEnt = MD.CodEnt)");
            StrSql.append(" left join cFormaEntrega FE on (AG.clFormaEntrega = FE.clFormaEntrega)");
            StrSql.append(" inner join Expediente E on (E.clExpediente = AG.clExpediente)");
            StrSql.append(" where AG.clExpediente = ").append(StrclExpediente);
            
            ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
            StrSql.delete(0,StrSql.length());
            
            String StrclPaginaWeb = "661";
            session.setAttribute("clPaginaWebP",StrclPaginaWeb);
        %>
        <script>fnOpenLinks()</script>
        <%
        MyUtil.InicializaParametrosC(661,Integer.parseInt(StrclUsrApp)); %>
        <%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaGarantiaAcumulador","","fnAntesGuardar();")%>
        
        <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="GarantiaAcumulador.jsp?'>"%>
        <%
        if(rs.next())
        {
        
        %>
        
        <%
        if(rs.getString("TieneAsistencia").compareToIgnoreCase("1")==0)
        {%>
        <script>document.all.btnAlta.disabled=true; document.all.btnElimina.disabled=true; </script>
        <%
        }
        else
        {%>
        <script>document.all.btnCambio.disabled=true; document.all.btnElimina.disabled=true;</script>
        <%
        }%>
        
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
        <INPUT id='Vencimiento' name='Vencimiento' type='hidden' value=' '>
        <%=MyUtil.ObjInput("Fecha de Compra <BR>(AAAA-MM-DD HH:MM)","FechaCompra",rs.getString("FechaCompra"),false,false,30,80,"",false,false,30)%>
        <%=MyUtil.ObjInput("No. de Serie <BR>del Acumulador","NumSerie",rs.getString("NumSerie"),false,false,200,80,"",false,false,40)%>
        <%=MyUtil.ObjComboC("Tipo de <BR>Acumulador","clAcumulador",rs.getString("dsAcumulador"),false,false,420,80,"","select clAcumulador, dsAcumulador from cAcumulador order by dsAcumulador","","",30,false,false)%>
        <input type="hidden" id="Ultra" name="Ultra" value="<%=StrUltra%>"></input>
        <%=MyUtil.ObjInput("Número de Póliza","NumPoliza",rs.getString("NumPoliza"),false,false,30,140,"",false,false,40)%>
        <%=MyUtil.ObjComboC("¿Procede Garantía?","Procede",rs.getString("Procede"),false,true,250,140,"","select 1,'SI' UNION select 2,'NO'","fnProcedeGarantia(this.value)","",30,false,false)%>
        <%=MyUtil.ObjInput("Porcentaje Garantía","PorcentajeGarantia",rs.getString("PorcentajeGarantia"),true,false,420,140,"",false,false,30)%>
        <%=MyUtil.ObjInput("Aplicación de Garantía","MontoGarantia",rs.getString("MontoGarantia"),false,false,600,140,"",false,false,50)%>
        <%=MyUtil.ObjInput("No. de Serie <BR>del Nuevo Acumulador","NumSerieNuevo",rs.getString("NumSerieNuevo"),false,false,30,180,"",false,false,40)%>
        <%=MyUtil.ObjComboC("Tipo de <BR>Acumulador Nuevo","clAcumuladorNuevo",rs.getString("dsAcumuladorNuevo"),false,true,250,180,"","select clAcumulador, dsAcumulador from cAcumulador order by dsAcumulador","fnDescuentoAcumulador(this.value);fnCalculoPorcentaje(this.value)","",30,false,false)%>
        <%=MyUtil.ObjInput("Número de Póliza del Acumulador Nuevo","NumPolizaNuevo",rs.getString("NumPolizaNuevo"),false,false,420,190,"",false,false,40)%>
        <%=MyUtil.DoBlock("Registro de Garantía",100,0)%>
        
        <%=MyUtil.ObjComboC("Usuario Acepta Garantía","UsuarioAcepta",rs.getString("UsuarioAcepta"),false,true,30,300,"","sp_RespuestaVentaAcumulador","fnUsuarioAcepta(this.value)","",30,false,false)%>
        <%=MyUtil.ObjComboC("Forma de Pago","clFormaPago",rs.getString("dsFormaPago"),false,false,200,300,"","Select 4,'TARJETA DE CREDITO' union Select 5,'EFECTIVO'","fnsinoTarjeta();","",30,true,false)%>
        <%=MyUtil.ObjComboC("Banco Emisor","clBanco",rs.getString("Nombre"),false,false,30,340,"","Select * from cBanco","fnTarjeta(this.value);if(document.all.TarjetaNumeroVTR.readOnly==false){fnValMask(document.all.TarjetaNumeroVTR,document.all.TarjetaNumeroMsk.value,document.all.TarjetaNumeroVTR.name)}","",30,false,false)%>
        <%=MyUtil.ObjInput("Número de Tarjeta","TarjetaNumeroVTR",rs.getString("TarjetaNumero"),false,false,230,340,"",false,false,30,"if(this.readOnly==false){fnValMask(this,document.all.TarjetaNumeroMsk.value,this.name);document.all.TarjetaNumero.value = TarjetaNumeroVTR.value;}")%>
        <INPUT id='TarjetaNumero' name='TarjetaNumero' type='hidden' value='<%=rs.getString("TarjetaNumero")%>'>
        <%=MyUtil.ObjInput("Vencimiento (AAAA/MM)","VencimientoVTR",rs.getString("Vencimiento"),false,false,400,340,"",false,false,25,"if(this.readOnly==false){fnValMask(this,document.all.VencimientoMsk.value,this.name);fnFechVen()}")%>
        <%=MyUtil.ObjInput("Código de Seguridad","CodigoSeguridad",rs.getString("CodigoSeguridad"),false,false,560,340,"",false,false,4,"EsNumerico(document.all.CodigoSeguridad)")%>                 
        <%=MyUtil.ObjInput("Monto","Monto",rs.getString("Monto"),false,false,30,380,"",false,false,30,"EsNumerico(document.all.Monto)")%>  
        <INPUT value="Actualizar Monto" type="button" CLASS="cBtn" ONCLICK="fnDescuentoAcumulador(document.all.clAcumuladorNuevo.value);fnCalculoPorcentaje(document.all.clAcumuladorNuevo.value)">
        <%=MyUtil.ObjInput("No. Voucher","Autorizacion",rs.getString("Autorizacion"),false,false,200,380,"",false,false,30,"EsNumerico(document.all.Autorizacion)")%> 
        <%=MyUtil.ObjComboC("Requiere Factura","Factura",rs.getString("Factura"),false,false,370,380,"","sp_RespuestaVentaAcumulador","","",30,true,false)%>
        <%=MyUtil.ObjInput("No. Fax para Envío de Voucher","Fax",rs.getString("Fax"),false,false,530,380,"",false,false,30)%>
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
        <%=MyUtil.ObjComboC("Marca de Auto","CodigoMarca",StrdsMarcaAuto,false,false,30,420,"","select CodigoMarca, dsMarcaAuto from cMarcaAuto order by dsMarcaAuto","fnLlenaAMISAcumula()","",50,false,false)%>
        <%=MyUtil.ObjComboC("Tipo de Auto","ClaveAMIS",StrdsTipoAuto,false,false,200,420,"","select ClaveAmis,dsTipoAuto from cTipoAuto where ClaveAmis='" + StrClaveAMIS + "'" ,"","",50,false,false)%>
        <INPUT id='ClaveAMISVTR' name='ClaveAMISVTR' type='hidden' value='<%=StrClaveAMIS%>'>
        <%=MyUtil.ObjInput("Modelo","Modelo",rs.getString("Modelo"),false,false,550,420,"",false,false,6,"if(this.readOnly==false){fnValidaModelo(this)}")%>
        <%=MyUtil.ObjInput("Color","Color",rs.getString("Color"),false,false,610,420,"",false,false,10)%>
        <%=MyUtil.ObjInput("Placas","Placas",rs.getString("Placas"),false,false,690,420,"",false,false,8)%>
        <%=MyUtil.DoBlock("Detalles de la Garantía",0 ,0)%>
        
        <%=MyUtil.ObjInput("Nombre ó Razón Social","UsuarioRZ",rs.getString("UsuarioRZ"),false,false,30,540,"",false,false,30)%> 
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.rfc"),"RFC",rs.getString("RFC"),false,false,200,540,"",false,false,25)%> 
        <%=MyUtil.ObjComboC(i18n.getMessage("message.title.entidad"),"CodEnt",rs.getString("dsEntFed"),false,false,345,540,"","Select CodEnt, dsEntFed from cEntFed order by dsEntFed ","fnLlenaMunicipios()","",40,false,false)%>
        <%=MyUtil.ObjComboC(i18n.getMessage("message.title.municipio"),"CodMD",rs.getString("dsMunDel"),false,false,540,540,"","Select CodMD, dsMunDel from cMunDel where CodMD='" + rs.getString("CodMD") + "' and CodEnt='"+ rs.getString("CodEnt") +"' order by dsMunDel ","","",40,false,false)%>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.colonia"),"Colonia",rs.getString("Colonia"),false,false,30,580,"",false,false,30)%>
        <%=MyUtil.ObjInput("Calle y Número","CalleNum",rs.getString("CalleNum"),false,false,200,580,"",false,false,50)%>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.cp"),"CP",rs.getString("CP"),false,false,470,580,"",false,false,10,"EsNumerico(document.all.CP)")%>
        <%=MyUtil.DoBlock("Datos de la Facturación",50,0)%>  
        
        <%
        }
        else
        {
        %> <script>document.all.btnCambio.disabled=true; document.all.btnElimina.disabled=true;</script>
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
        <INPUT id='Vencimiento' name='Vencimiento' type='hidden' value=''>
        <INPUT id='TarjetaNumero' name='TarjetaNumero' type='hidden' value=''>
        <%=MyUtil.ObjInput("Fecha de Compra <BR>(AAAA-MM-DD HH:MM)","FechaCompra",StrFechaCompra,false,false,30,80,StrFechaCompra,false,false,30)%>
        <%=MyUtil.ObjInput("No. de Serie <BR>del Acumulador","NumSerie",StrSerie,false,false,200,80,StrSerie,false,false,40,"fnBuscaSerie(this.value);")%>
        <%=MyUtil.ObjComboC("Tipo de <BR>Acumulador","clAcumulador",StrclAcumulador,false,false,420,80,StrclAcumulador,"select clAcumulador, dsAcumulador from cAcumulador order by dsAcumulador","","",30,false,false)%>
        <input type="hidden" id="Ultra" name="Ultra" value="<%=StrUltra%>"></input>
        <%=MyUtil.ObjInput("Número de Póliza","NumPoliza",StrPoliza,false,false,30,140,StrPoliza,false,false,40)%>
        <%=MyUtil.ObjComboC("¿Procede Garantía?","Procede","",true,true,250,140,"","select 1,'SI' UNION select 2,'NO'","fnProcedeGarantia(this.value)","",30,false,false)%>
        <%=MyUtil.ObjInput("Porcentaje Garantía","PorcentajeGarantia","",false,false,420,140,"",false,false,30)%>
        <%=MyUtil.ObjInput("Aplicación de Garantía","MontoGarantia","",false,false,600,140,"",false,false,50)%>
        <%=MyUtil.ObjInput("No. de Serie <BR>del Nuevo Acumulador","NumSerieNuevo","",false,false,30,180,"",false,false,40)%>
        <%=MyUtil.ObjComboC("Tipo de <BR>Acumulador Nuevo","clAcumuladorNuevo","",false,false,250,180,"","select clAcumulador, dsAcumulador from cAcumulador order by dsAcumulador","fnDescuentoAcumulador(this.value);fnCalculoPorcentaje(this.value);","",30,false,false)%>
        <%=MyUtil.ObjInput("Número de Póliza del Acumulador Nuevo","NumPolizaNuevo","",false,false,420,190,"",false,false,40)%>
        <%=MyUtil.DoBlock("Registro de Garantía",100 ,0)%>
        
        <%=MyUtil.ObjComboC("Usuario Acepta Garantía","UsuarioAcepta","",false,false,30,300,"","sp_RespuestaVentaAcumulador","fnUsuarioAcepta(this.value)","",30,false,false)%>
        <%=MyUtil.ObjComboC("Forma de Pago","clFormaPago","",false,false,200,300,"","Select 4,'TARJETA DE CREDITO' union Select 5,'EFECTIVO'","fnsinoTarjeta();","",30,false,false)%>
        <%=MyUtil.ObjComboC("Banco Emisor","clBanco","",false,false,30,340,"","Select * from cBanco","fnTarjeta(this.value);if(document.all.TarjetaNumeroVTR.readOnly==false){fnValMask(document.all.TarjetaNumeroVTR,document.all.TarjetaNumeroMsk.value,document.all.TarjetaNumeroVTR.name)}","",30,false,false)%>
        <%=MyUtil.ObjInput("Número de Tarjeta","TarjetaNumeroVTR","",false,false,230,340,"",false,false,30,"if(this.readOnly==false){fnValMask(this,document.all.TarjetaNumeroMsk.value,this.name)};document.all.TarjetaNumero.value = TarjetaNumeroVTR.value;")%>
        <%=MyUtil.ObjInput("Vencimiento (AAAA/MM)","VencimientoVTR","",false,false,400,340,"",false,false,25,"if(this.readOnly==false){fnValMask(this,document.all.VencimientoMsk.value,this.name);fnFechVen()}")%>
        <%=MyUtil.ObjInput("Código de Seguridad","CodigoSeguridad","",false,false,560,340,"",false,false,4,"EsNumerico(document.all.CodigoSeguridad)")%>                 
        <%=MyUtil.ObjInput("Monto","Monto","",false,false,30,380,"",false,false,30,"EsNumerico(document.all.Monto)")%>  
        <%=MyUtil.ObjInput("No. Voucher","Autorizacion","",false,false,200,380,"",false,false,30,"EsNumerico(document.all.Autorizacion)")%> 
        <%=MyUtil.ObjComboC("Requiere Factura","Factura","",false,false,370,380,"","sp_RespuestaVentaAcumulador","","",30,false,false)%>
        <%=MyUtil.ObjInput("No. Fax para Envío de Voucher","Fax","",false,false,530,380,"",false,false,30)%>
        
        <%=MyUtil.ObjComboC("Marca de Auto","CodigoMarca","",false,false,30,420,"","select CodigoMarca, dsMarcaAuto from cMarcaAuto order by dsMarcaAuto","fnLlenaAMISAcumula()","",50,false,false)%>
        <%=MyUtil.ObjComboC("Tipo de Auto","ClaveAMIS","",false,false,200,420,"","select ClaveAmis,dsTipoAuto from cTipoAuto where ClaveAmis='0'" ,"","",50,false,false)%>
        <INPUT id='ClaveAMISVTR' name='ClaveAMISVTR' type='hidden' value=''>
        <%=MyUtil.ObjInput("Modelo","Modelo","",false,false,550,420,"",false,false,6,"if(this.readOnly==false){fnValidaModelo(this)}")%>
        <%=MyUtil.ObjInput("Color","Color","",false,false,610,420,"",false,false,10)%>
        <%=MyUtil.ObjInput("Placas","Placas","",false,false,690,420,"",false,false,8)%>
        <%=MyUtil.DoBlock("Detalles de la Garantía",0 ,0)%>
        
        <%=MyUtil.ObjInput("Nombre ó Razón Social","UsuarioRZ","",false,false,30,540,"",false,false,30)%> 
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.rfc"),"RFC","",false,false,200,540,"",false,false,25)%> 
        <%=MyUtil.ObjComboC(i18n.getMessage("message.title.entidad"),"CodEnt","",false,false,345,540,"","Select CodEnt, dsEntFed from cEntFed order by dsEntFed ","fnLlenaMunicipios()","",40,false,false)%>
        <%=MyUtil.ObjComboC(i18n.getMessage("message.title.municipio"),"CodMD","",false,false,540,540,"","","","",40,false,true)%>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.colonia"),"Colonia","",false,false,30,580,"",false,false,30)%>
        <%=MyUtil.ObjInput("Calle y Número","CalleNum","",false,false,200,580,"",false,false,50)%>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.cp"),"CP","",false,false,470,580,"",false,false,10,"EsNumerico(document.all.CP)")%>
        <%=MyUtil.DoBlock("Datos de la Facturación",50,0)%>  
        <%
        }
        %>
        <%=MyUtil.GeneraScripts()%>
        <%
        rs.close();
        rs=null;
        
        StrclExpediente = null;
        StrclUsrApp = null;
        StrSql =null;      
        
        %>
        <input name='TarjetaNumeroMsk' id='TarjetaNumeroMsk' type='hidden'>
        <input name='FechaCompraMsk' id='FechaCompraMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'> 
        <input name='VencimientoMsk' id='VencimientoMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09'>
        
        <script>
if (document.all.VencimientoVTR.value=="1900-01-01 00:00:00.0"){ document.all.VencimientoVTR.value="" }    

    function fnLlenaAMISAcumula(){ 
            var pstrCadena = "../servlet/Combos.LlenaAMIS?CodigoMarca=" + document.all.CodigoMarca.value;
            document.all.ClaveAMIS.value = '';
            document.all.ClaveAMISVTR.value = '';
            pstrCadena = pstrCadena + "&strName=ClaveAMISC";		
            fnOptionxDefault('ClaveAMISC',pstrCadena);
    }

function fnTarjeta(opcion){
    if (opcion!=2){
        document.all.TarjetaNumeroMsk.value="VN09VN09VN09VN09F-/-VN09VN09VN09VN09F-/-VN09VN09VN09VN09F-/-VN09VN09VN09VN09";
        document.all.TarjetaNumeroMsk.maxLenght=16;
        document.all.TarjetaNumeroVTR.maxLenght=19;
    }
    else{
        document.all.TarjetaNumeroMsk.value="VN09VN09VN09VN09F-/-VN09VN09VN09VN09VN09VN09F-/-VN09VN09VN09VN09VN09";
        document.all.TarjetaNumeroMsk.maxLenght=15;
        document.all.TarjetaNumeroVTR.maxLenght=18;
    }
}    
    
document.all.CodigoSeguridad.maxLength=4;
document.all.CP.maxLength=5;
document.all.Modelo.maxLength=4;
document.all.Placas.maxLength=8;

function fnAntesGuardar(){
   if (document.all.PorcentajeGarantia.value=="0.0") {document.all.PorcentajeGarantia.value=0}

   if (document.all.clFormaPagoC.value == 4 && (document.all.clBancoC.value == "" || document.all.TarjetaNumero.value == "" || document.all.Vencimiento.value == "" || document.all.CodigoSeguridad.value == ""  ||  document.all.Autorizacion.value == ""))
        {
          msgVal = msgVal + "Favor de proveer los datos completos de Pago por Tarjeta de Crédito"; document.all.btnGuarda.disabled=false;document.all.btnCancela.disabled=false;
        }
    if (document.all.UsuarioAceptaC.value==1){
            if (document.all.clFormaPagoC.value==''){msgVal=msgVal + ' Forma de Pago. '}
            if (document.all.Monto.value == "0.0" || document.all.Monto.value == "0"){msgVal=msgVal + ' Monto. '}
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
        document.all.VencimientoVTR.focus();
        document.all.btnGuarda.disabled=false;document.all.btnCancela.disabled=false;
    }
}
  
function fnsino()
{ if (document.all.FacturaC.value!=1)
    {   
        hide("D32");
        hide("D33");
        hide("D34");
        hide("D35");
        hide("D36");
        hide("D37");
        hide("D38");
        hide("D39");
    }        
    else { if (document.all.FacturaC.value==1){       
        show("D32");
        show("D33");
        show("D34");
        show("D35");
        show("D36");
        show("D37");
        show("D38");
        show("D39");
         } 
    } 
}

function fnsinoTarjeta()
{ if (document.all.clFormaPagoC.value!=4)
    {    
        document.all.clBancoC.value=""
        document.all.TarjetaNumeroVTR.value=""
        document.all.VencimientoVTR.value=""
        document.all.Vencimiento.value=""
        document.all.CodigoSeguridad.value=""
        document.all.Autorizacion.value=""
        document.all.Fax.value=""
        hide("D17");
        hide("D18");
        hide("D19");
        hide("D20");
        hide("D22");
        }
    else { if (document.all.clFormaPagoC.value==4){       
         show("D17");
         show("D18");
         show("D19");
         show("D20");
         show("D21");
         show("D22");
        } 
    } 
}

function fnProcedeGarantia(opcion){
 if (opcion!=1){
    document.all.clAcumuladorNuevoC.disabled=true;
    document.all.NumSerieNuevo.disabled=true;
    document.all.NumPolizaNuevo.disabled=true;
    document.all.PorcentajeGarantia.value="";
    document.all.MontoGarantia.value="";
    document.all.Monto.value="";
    document.all.clAcumuladorNuevoC.value="";
    document.all.UsuarioAceptaC.value=""; document.all.UsuarioAceptaC.disabled=true; fnUsuarioAcepta(0);
     }
 else {
    document.all.clAcumuladorNuevoC.disabled=false;
    document.all.NumSerieNuevo.disabled=false; document.all.NumSerieNuevo.readOnly=false;
    document.all.NumPolizaNuevo.disabled=false;document.all.NumPolizaNuevo.readOnly=false;
    }
 }
 
 function fnCalculoPorcentaje(opcion){
    if (opcion!=0){
    document.all.UsuarioAceptaC.disabled=false;
    } else {
    document.all.UsuarioAceptaC.disabled=true;
    }
}

function fnUsuarioAcepta(opcion){
    if (opcion!=1){
        document.all.clFormaPagoC.disabled=true;
        document.all.clBancoC.disabled=true;
        document.all.TarjetaNumeroVTR.disabled=true;document.all.TarjetaNumeroVTR.value="";document.all.TarjetaNumero.value="";
        document.all.VencimientoVTR.disabled=true;document.all.VencimientoVTR.value="";document.all.Vencimiento.value="";
        document.all.CodigoSeguridad.disabled=true;
        document.all.Monto.readOnly=true;
        document.all.Autorizacion.disabled=true;
        document.all.FacturaC.disabled=true;
        document.all.Fax.disabled=true;
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

        
    }else{
        document.all.clFormaPagoC.disabled=false;document.all.clFormaPagoC.readOnly=false;
        document.all.clBancoC.disabled=false;document.all.clBancoC.readOnly=false;
        document.all.TarjetaNumeroVTR.disabled=false;document.all.TarjetaNumeroVTR.readOnly=false;
        document.all.VencimientoVTR.disabled=false;document.all.VencimientoVTR.readOnly=false;
        document.all.CodigoSeguridad.disabled=false;document.all.CodigoSeguridad.readOnly=false;
        document.all.Monto.disabled=false;document.all.Monto.readOnly=true;
        document.all.Autorizacion.disabled=false;document.all.Autorizacion.readOnly=false;
        document.all.FacturaC.disabled=false;document.all.FacturaC.readOnly=false;
        document.all.Fax.disabled=false;document.all.Fax.readOnly=false;
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

 
function fnProveeNumSerie(FechaCompra,NumSerie,dsAcumulador,Ultra){
        document.all.FechaCompra.value=FechaCompra;
        document.all.NumSerie.value=NumSerie;
        document.all.clAcumuladorC.value=dsAcumulador;
        document.all.Ultra.value=Ultra;
}

function fnBuscaSerie(NumSerie){
     var direccion;
     direccion = 'BuscaNumSerie.jsp?NumSerie='+NumSerie;
     window.open(direccion, 'BuscaSerie' ,'scrolling=yes, width=400 ,height=150');
}

function fnDescuentoAcumulador(clAcumulador)
{ var fechacompra,Ultra,direccion;

if (clAcumulador==""){
        document.all.PorcentajeGarantia.value="";
        document.all.MontoGarantia.value="";
        document.all.Monto.value="";
        document.all.NumSerieNuevo.readOnly=false; document.all.NumPolizaNuevo.readOnly=false;
        document.all.NumSerieNuevo.value=""; document.all.NumPolizaNuevo.value="";
}else{

if (document.all.ProcedeC.value==1 && (document.all.Monto.value=="0" || document.all.Monto.value=="0.0" || document.all.Monto.value=="")){
    fechacompra = document.all.FechaCompra.value;
    Ultra= document.all.Ultra.value;
     direccion = 'DescuentoAcumulador.jsp?clAcumuladorNuevo='+ clAcumulador +'&fechacompra='+ fechacompra +'&Ultra='+ Ultra;
     window.open(direccion, 'Descuento' ,'scrolling=yes, width=400 ,height=150');
     document.all.NumSerieNuevo.readOnly=false; document.all.NumPolizaNuevo.readOnly=false;
     }
}
}

function fnProveeDescuento(MontoNormal,Descuento,TotalUsr,Porcentaje){
        document.all.PorcentajeGarantia.value=Porcentaje;
        document.all.MontoGarantia.value= 'Precio Normal: $' + MontoNormal + ', Descuento: $' + Descuento;
        document.all.Monto.value=TotalUsr;
}

    function fnValidaError(){
        blnAceptar=0;
        document.all.btnGuarda.disabled=false;
        document.all.btnCancela.disabled=false;
        WSave.close();
    }

        </script>
        
        <%
        }
        else
        {
        %>
        <br><p aling="center"> <font class="VTable">La clave proporcionada no corresponde a Clientes Duracell </font></p>
        <%
        }
        rs2.close();
        rs2=null;
        StrSql2=null;
        %>
    </body>
</html>