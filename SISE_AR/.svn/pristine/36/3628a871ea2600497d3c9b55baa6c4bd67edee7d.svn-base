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
<script src='../../Utilerias/UtilFianza.js' ></script>
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
    String StrclFianza = "0";  
    String StrclPaginaWeb="0";
    String StrclProveedorExhibe="";
    String Strvalue="";

    if (session.getAttribute("clExpediente")!= null)
     {
       StrclExpediente = session.getAttribute("clExpediente").toString(); 
     }      
     if (request.getParameter("clFianza")!= null)
     {
       StrclFianza = request.getParameter("clFianza").toString(); 
     }   
     if (StrclFianza.equals("0")) 
     {
         if (session.getAttribute("clFianza")!= null)
         {
           StrclFianza = session.getAttribute("clFianza").toString(); 
         }     
     }
     session.setAttribute("clFianza",StrclFianza);
     
     StringBuffer StrSql = new StringBuffer();
     StrSql.append("Select ");
     StrSql.append(" F.clProveedorExhibe, ");
     StrSql.append(" A.Nombre, ");
     StrSql.append(" coalesce(PP.NombreOpe,'') as ProveedorExhibe, ");
     StrSql.append(" coalesce(PProv.Nombre,'') as ProvColaborador, ");
     StrSql.append(" FA.Folio, ");
     StrSql.append(" FA.clFolioAfianzadora, ");
     StrSql.append(" coalesce(F.AbogadoExhibe,'') as AbogadoExhibe, ");
     StrSql.append(" coalesce(convert(varchar(10), F.FechaExhib,120),'') as FechaExhib, ");
     StrSql.append(" F.FolioFianza, ");
     StrSql.append(" coalesce(MontoFianza,'0') as MontoFianza, ");
     StrSql.append(" F.MontoRepDan, ");
     StrSql.append(" F.MontoSanPec, ");
     StrSql.append(" F.MontoObProc, ");
     StrSql.append(" F.MontoSusAct, ");     
     StrSql.append(" coalesce(TL.dsTipoLibera,'') as dsTipoLibera, ");
     StrSql.append(" coalesce(E.dsEstatus,'') as dsEstatus, ");
     StrSql.append(" F.ResponsivaAfiliado, ");
     StrSql.append(" F.ExhibicionSoportes, ");
     StrSql.append(" coalesce(rtrim(D.dsDelito),'') as dsDelito, ");
     StrSql.append(" coalesce(AbogadoTraslada,'') as AbogadoTraslada, ");
     StrSql.append(" coalesce(F.Comprobante,'') as Comprobante,");
     StrSql.append(" FA.Folio as Folio2, ");
     StrSql.append(" FA.Limite, ");
     StrSql.append(" FA.FechaExpedicion FechaExped , ");
     StrSql.append(" FA.FechaVencimiento, ");
     StrSql.append(" F.RevisadaxAdministrativo, ");
     StrSql.append(" coalesce(convert(varchar(10),F.FechaRevisionAdmon,120),'') FechaRevisionAdmon, ");
     StrSql.append(" coalesce(PrimaFianza,'0') as PrimaFianza, coalesce(Pagada,0) as Pagada ");
     StrSql.append(" From Fianza F ");
     StrSql.append(" inner join cAfianzadora A on (A.clAfianzadora = F.clAfianzadora) ");
     StrSql.append(" inner join FolioxAfianzadora FA on (FA.clFolioAfianzadora = F.clFolioAfianzadora) ");
     StrSql.append(" inner Join cProveedor PP ON (PP.clProveedor = F.clProveedorExhibe) ");
     StrSql.append(" inner Join cTipoLibera TL ON (TL.clTipoLibera = F.clTipoLibera) "); 
     StrSql.append(" inner Join cEstatusFianza E ON (E.clEstatus= F.clEstatusFianza) ");
     StrSql.append(" inner join DelitoEvento DE on (DE.clDelitoEvento=F.clDelitoEvento) ");
     StrSql.append(" inner Join cDelito D ON (D.clDelito=DE.clDelito) ");
     StrSql.append(" Left Join PersonalxProv PProv ON (PProv.clPersonalxProv = F.clProvColaborador) ");
     StrSql.append(" Where F.clFianza =").append(StrclFianza);
     
ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());     
     StrSql.delete(0,StrSql.length());
   
   %><script>fnOpenLinks()</script><%
   StrclPaginaWeb = "299";       
   MyUtil.InicializaParametrosC(299,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina

   session.setAttribute("clPaginaWebP",StrclPaginaWeb);  %>

   <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccion","","fnVerificaDelito();")%>
   <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="FianzasAdmon.jsp?'>"%><% 
   
   if (rs.next()) {
       
        %><script>document.all.btnElimina.disabled=true;</script>
          <script>document.all.btnAlta.disabled=true;</script><%
          
        StrclProveedorExhibe = rs.getString("clProveedorExhibe");
                if (StrclProveedorExhibe ==null){
                    StrclProveedorExhibe = "";
                }  %>
        <INPUT id='clFianza' name='clFianza' type='hidden' value='<%=StrclFianza%>'>                         
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>               
        
        <%=MyUtil.ObjComboC("Afianzadora", "clAfianzadora",rs.getString("Nombre"), true,true,30,70,"","select clAfianzadora, Nombre from cAfianzadora ","fnLlenaProvFian(); fncalculo()","",40,true,true)%>
        <%=MyUtil.ObjComboC("Proveedor que Exhibe", "clProveedorExhibe",rs.getString("ProveedorExhibe"),true,true,30,120,"","select '','' union Select clProveedor, NombreOpe From cProveedor WHERE clProveedor = " + StrclProveedorExhibe,"fnLlenaFoliosLibres(); fnLlenaProvColab()","",50,true,true)%>
        <%=MyUtil.ObjComboC("Proveedor Colaborador", "clProvColaborador",rs.getString("ProvColaborador"),true,true,330,120,"","Select clPersonalxProv, Nombre From PersonalxProv Where clProveedor=" + StrclProveedorExhibe,"","",50,false,false)%>
        <%=MyUtil.ObjComboC("Folio de Afianzadora", "clFolioAfianzadora",rs.getString("Folio"),true,true,630,120,"","Select clFolioAfianzadora, Folio From FolioxAfianzadora WHERE clFolioAfianzadora = " + rs.getString("clFolioAfianzadora") ,"fnBuscaDatFianza()","",40,true,true)%>                               
        <%=MyUtil.ObjInput("Abogado que Exhibe","AbogadoExhibe",rs.getString("AbogadoExhibe"),true,true,30,170,"",true,true,50)%>   
        <%=MyUtil.ObjInput("Fecha de Exhibición <br>(AAAA/MM/DD)","FechaExhib",rs.getString("FechaExhib"),true,true,330,160,"",true,true,25,"if(this.readOnly==false){fnValidaFecha(2,0)}")%>
        <%=MyUtil.ObjInput("Folio de Fianza","FolioFianzaVTR",rs.getString("FolioFianza"),false,false,500,170,"",false,false,10)%>
        <%=MyUtil.ObjInput("Monto Fianza","MontoFianza",rs.getString("MontoFianza"),false,false,630,170,"",false,false,15)%>
        <%=MyUtil.ObjInput("Monto Reparación <br>Daño","MontoRepDan",rs.getString("MontoRepDan"),true,true,30,210,"0",false,false,15,"fnActualizaMontos(document.all.MontoRepDan)")%>
        <%=MyUtil.ObjInput("Monto Sanción <br>Pecunaria","MontoSanPec",rs.getString("MontoSanPec"),true,true,170,210,"0",false,false,15,"fnActualizaMontos(document.all.MontoSanPec)")%>
        <%=MyUtil.ObjInput("Monto Obligación <br>Procesal o Libertad","MontoObProc",rs.getString("MontoObProc"),true,true,320,210,"0",false,false,15,"fnActualizaMontos(document.all.MontoObProc)")%>
        <%=MyUtil.ObjInput("Monto Suspensión <br>Acto Reclamado","MontoSusAct",rs.getString("MontoSusAct"),true,true,470,210,"0",false,false,15,"fnActualizaMontos(document.all.MontoSusAct)")%>        
        
        <%=MyUtil.ObjComboC("Tipo Liberación", "clTipoLibera",rs.getString("dsTipoLibera"),true,true,30,260,"","Select clTipoLibera, dsTipoLibera From cTipoLibera","","",50,true,true)%>
        <%=MyUtil.ObjComboC("Estatus Fianza", "clEstatusFianza",rs.getString("dsEstatus"),true,true,200,260,"2","Select clEstatus, dsEstatus From cEstatusFianza order by dsEstatus","","",50,false,false)%>                                
        <%=MyUtil.ObjChkBox("Responsiva NU","ResponsivaAfiliado",rs.getString("ResponsivaAfiliado"), true,true,450,260,"0","SI","NO","")%>     
        <%=MyUtil.ObjChkBox("Exhib. Soportes","ExhibicionSoportes",rs.getString("ExhibicionSoportes"), true,true,580,260,"0","SI","NO","")%>
        <%=MyUtil.ObjComboC("Delito", "clDelitoEvento",rs.getString("dsDelito"),true,true,30,300,"","select DE.clDelitoEvento, D.dsDelito from DelitoEvento DE Inner join cDelito D ON(D.clDelito=DE.clDelito) Where clExpediente=" + StrclExpediente + " Union select '0','' ","","",140,true,true)%>
        <%=MyUtil.ObjInput("Abogado Traslada","AbogadoTraslada",rs.getString("AbogadoTraslada"),true,true,30,340,"",true,true,50)%>
        <%=MyUtil.ObjInput("Comprobante","Comprobante",rs.getString("Comprobante"),true,true,330,340,"",true,true,60)%> 
        <%=MyUtil.DoBlock("Administración de Fianza",0,0)%>   

        <%=MyUtil.ObjInput("Folio de Afianzadora","FolioFianzaVTR2",rs.getString("Folio2"),false,false,30,420,"",false,false,20)%>    
        <%=MyUtil.ObjInput("Limite","Limite",rs.getString("Limite"),false,false,220,420,"",false,false,20)%>
        <%=MyUtil.ObjInput("Fecha de Expedición <br>(AAAA/MM/DD)","FechaExped",rs.getString("FechaExped"),false,false,30,470 ,"",false,false,25,"")%>
        <%=MyUtil.ObjInput("Fecha de Vencimiento <br>(AAAA/MM/DD)","FechaVencimiento",rs.getString("FechaVencimiento"),false,false,220,465,"",false,false,25,"")%>
        <%=MyUtil.DoBlock("Datos del Folio de Fianza",150,0)%>

        <%=MyUtil.ObjChkBox("Revisada","RevisadaxAdministrativo",rs.getString("RevisadaxAdministrativo"), true,true,30,560,"0","SI","NO","")%>   
        <%=MyUtil.ObjInput("Fecha de Revisión<br>(AAAA/MM/DD)","FechaRevisionVTR",rs.getString("FechaRevisionAdmon"),false,false,120,555,"",false,false,25,"")%>
        <%=MyUtil.ObjInput("Prima de Fianza","PrimaFianza",rs.getString("PrimaFianza"),false,true,300,567,"",false,false,15)%><%
        Strvalue=rs.getString("Pagada"); %>
        <%=MyUtil.ObjChkBox("Pagada","Pagada",Strvalue,!Strvalue.equalsIgnoreCase("1"),!Strvalue.equalsIgnoreCase("1"),420,567,"0","SI","NO","")%>
        <%=MyUtil.DoBlock("Datos de la Revisión por Administración de Garantías",0,25)%><%
   }
   else { 
    }
       %><%=MyUtil.GeneraScripts()%><%
        rs.close();
        rs=null;
        StrclExpediente =null;    
        StrclFianza = null;  
        StrSql = null; 
        StrclPaginaWeb=null;
        StrclProveedorExhibe=null;
        Strvalue=null;
        StrclUsrApp=null;
        
 %>
<input name='FechaExhibMsk' id='FechaExhibMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09'>

<script> 

function fnPagada(){
document.all.PagadaC.disabled=true;
    
}


     
 //document.all.Comprobante.maxLength=60;    

 function fncalculo(){  
 if (document.all.clAfianzadora.value==14){
 alert("Hola mundo");
 }
 
		
	}
 
 
 
  function fnLlenaProvColab(){  
		var strConsulta = "sp_GetProvColab '" + document.all.clProveedorExhibe.value + "'";
		var pstrCadena = "../../servlet/Utilerias.LlenaCombos?strSQL=" + strConsulta;
                document.all.clProvColaborador.value = '';
		pstrCadena = pstrCadena + "&strName=clProvColaboradorC";		
		fnOptionxDefault('clProvColaboradorC',pstrCadena);
	}
 
   function fnActualizaMontos(Campo){  
     if (isNaN(Campo.value)==true || Campo.value=='')
     {
       alert(Campo.name + ' debe ser numérico');
       Campo.value="0";
     } 
     document.all.MontoFianza.value=0;
     document.all.MontoFianza.value = eval(document.all.MontoRepDan.value) + eval(document.all.MontoSanPec.value) + eval(document.all.MontoObProc.value) + eval(document.all.MontoSusAct.value);
  }	
	
 function fnValidaFecha(iTipo,AnioComp)
 { 
 /*
   intAnioExh = 0;
   intAnioExp = 0;
 
   if (iTipo == 2)  {  fnValMask(document.all.FechaExhib,document.all.FechaExhibMsk.value,'FechaExhib')  } 
   else  {   fnValMask(document.all.FechaExped,document.all.FechaExpedMsk.value,'FechaExped')     }
   
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
*/    

   if (iTipo == 2)
   {
        if (document.all.FechaExped.value > document.all.FechaExhib.value)
        {
           alert("La Fecha de Exhibición no puede ser menor a la Fecha de Expedición");
           document.all.FechaExhib.value=''; 
        }
   }     
   else
   {
        if (document.all.FechaExped.value > document.all.FechaExhib.value)
        {
           alert("La Fecha de Exhibición no puede ser menor a la Fecha de Expedición");
           document.all.FechaExhib.focus(); 
        }
   }  

 } 
 
  function fnVerificaDelito(){
    if(document.all.clDelitoEvento.value=="0"){
               msgVal=msgVal + " Delito ";
                document.all.btnGuarda.disabled=false;
                document.all.btnCancela.disabled=false;
            }
 } 
</script>
</body>
</html>


