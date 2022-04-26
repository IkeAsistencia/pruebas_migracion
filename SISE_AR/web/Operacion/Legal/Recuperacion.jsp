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
       %><%="Fuera de Horario"%><%
       StrclUsrApp=null;
       return;        
     }    
    String StrclExpediente = "0";   
    String StrclCaucion = "0"; 
    String StrclRecuperacion = "0";     
    String StrclPaginaWeb="0";  
    String StrFolioCaucion="";
    String StrclEstatusCaucion = "0"; 

    if (session.getAttribute("clExpediente")!= null)
     {
       StrclExpediente = session.getAttribute("clExpediente").toString(); 
     }      
    if (session.getAttribute("clCaucion")!= null)
     { 
       StrclCaucion = session.getAttribute("clCaucion").toString(); 
     }      
    if (request.getParameter("clRecuperacion")!= null)
     {
       StrclRecuperacion= request.getParameter("clRecuperacion").toString(); 
     }
  
    StringBuffer StrSql1 = new StringBuffer();
    StrSql1.append(" Select coalesce(FolioCaucion,0) as FolioCaucion, clEstatusCaucion ");
    StrSql1.append(" From Caucion Where clCaucion =").append(StrclCaucion);
    ResultSet rs2 = UtileriasBDF.rsSQLNP( StrSql1.toString());
    StrSql1.delete(0,StrSql1.length());
   
   if (rs2.next()) 
   {
     StrFolioCaucion=rs2.getString("FolioCaucion"); 
     StrclEstatusCaucion=rs2.getString("clEstatusCaucion"); 
   } else{
       %>
     <script>alert('Elija una Caución para trabajar');</script>
     <%
     rs2.close();  
     rs2=null;
     StrclExpediente = null;   
     StrclCaucion = null; 
     StrclRecuperacion = null;     
     StrclPaginaWeb=null;  
     StrFolioCaucion=null;
     StrclEstatusCaucion = null;
     StrclUsrApp=null;
     return; 
   }

StrSql1.append("Select R.clRecuperacion, R.clCaucion, ");
StrSql1.append(" coalesce(R.MontoRecuperado,0) as MontoRecuperado, R.clProveedorRecupera,");
StrSql1.append(" coalesce(convert(varchar(10), R.FechaRecuperacion,120),'') as FechaRecuperacion, ");
StrSql1.append(" R.FolioRecuperacion, ");
StrSql1.append(" coalesce(PP.NombreOpe,'') as ProveedorRecupera, coalesce(PProv.Nombre,'') as ProvColaborador, ");
StrSql1.append(" R.MontoRepDan, R.MontoSanPec, R.MontoObProc, R.MontoSusAct ");
StrSql1.append(" From Recuperacion R ");
StrSql1.append(" Left Join cProveedor PP ON (PP.clProveedor = R.clProveedorRecupera) ");
StrSql1.append(" Left Join PersonalxProv PProv ON (PProv.clPersonalxProv = R.clProvColaborador) ");
StrSql1.append(" Where R.clRecuperacion =").append(StrclRecuperacion); 
   ResultSet rs = UtileriasBDF.rsSQLNP( StrSql1.toString());     
   StrSql1.delete(0,StrSql1.length());      
   
   StrclPaginaWeb = "276";       
   MyUtil.InicializaParametrosC(276,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
%>
  <script>fnOpenLinks()</script>
<%  
   session.setAttribute("clPaginaWebP",StrclPaginaWeb);  
%>

   <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionRecupCaucion","")%>     
   
   
   <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="Recuperacion.jsp?'>"%>
   <%
   if (rs.next()) {
      
        if (StrclEstatusCaucion.equals("2"))
        {  // No se puede modificar una Caución con estatus CANCELADA
            %>
           <script>document.all.btnCambio.disabled=true;</script>
           <script>document.all.btnAlta.disabled=true;</script>
           <script>document.all.btnElimina.disabled=true;</script>
           <%
        }
       %>
        <INPUT id='clRecuperacion' name='clRecuperacion' type='hidden' value='<%=rs.getString("clRecuperacion")%>'>
        <INPUT id='clCaucion' name='clCaucion' type='hidden' value='<%=rs.getString("clCaucion") %>'>
 
        <%=MyUtil.ObjInput("Folio de la Caución","FolioCaucionVTR",StrFolioCaucion,false,false,30,70,StrFolioCaucion,false,false,20)%>
        <%=MyUtil.ObjInput("Folio de Recuperación","FolioVTR",rs.getString("FolioRecuperacion"),false,false,190,70,"",false,false,20)%>    
        <%=MyUtil.ObjInput("Fecha de Recuperación <br>(AAAA/MM/DD)","FechaRecuperacion",rs.getString("FechaRecuperacion"),true,true,350,70,"",true,true,25,"if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("Monto Recuperado","MontoRecuperado",rs.getString("MontoRecuperado"),true,true,30,120,"",true,true,15,"EsNumerico(document.all.MontoRecuperado)")%>             

    <%  String strclProveedorRecupera=rs.getString("clProveedorRecupera");%>
    
        <%=MyUtil.ObjInput("Proveedor que Recupera","ProveedorRecupera",rs.getString("ProveedorRecupera"),true,false,170,120,"",true,true,60,"if(this.readOnly==false){fnBuscaProv();}")%>
	<INPUT id='clProveedorRecupera' name='clProveedorRecupera' type='hidden' value="<%=strclProveedorRecupera%>">
                <%if (MyUtil.blnAccess[4]==true){%>
                    <div class='VTable' style='position:absolute; z-index:30; left:500px; top:130px;'>
                    <IMG SRC='../../Imagenes/Lupa.gif' class='handM' onClick='fnBuscaProv();' WIDTH=20 HEIGHT=20></div>
                <%
                }
                %>
        <%=MyUtil.ObjComboC("Colaborador que Recupera", "clProvColaborador",rs.getString("ProvColaborador"),true,true,530,120,"","Select clPersonalxProv, Nombre From PersonalxProv Where clProveedor=" + strclProveedorRecupera,"","",50,true,true)%>
        <%=MyUtil.ObjInput("Monto Reparación <br>Daño","MontoRepDan",rs.getString("MontoRepDan"),true,true,30,170,"0",false,false,15,"fnActualizaMontos(document.all.MontoRepDan)")%>             
        <%=MyUtil.ObjInput("Monto Sanción <br>Pecunaria","MontoSanPec",rs.getString("MontoSanPec"),true,true,170,170,"0",false,false,15,"fnActualizaMontos(document.all.MontoSanPec)")%>             
        <%=MyUtil.ObjInput("Monto Obligación <br>Procesal o Libertad","MontoObProc",rs.getString("MontoObProc"),true,true,320,170,"0",false,false,15,"fnActualizaMontos(document.all.MontoObProc)")%>             
        <%=MyUtil.ObjInput("Monto Suspensión <br>Acto Reclamado","MontoSusAct",rs.getString("MontoSusAct"),true,true,470,170,"0",false,false,15,"fnActualizaMontos(document.all.MontoSusAct)")%>
        <%=MyUtil.DoBlock("Datos de la Recuperación",15,0)%>
<%
   }
   else { 

        if (StrclEstatusCaucion.equals("2"))
        {  // No se puede modificar una Caución con estatus CANCELADA
            %>
           <script>document.all.btnCambio.disabled=true;</script>
           <script>document.all.btnAlta.disabled=true;</script>
           <script>document.all.btnElimina.disabled=true;</script>
           <%
        }
       %>
        <INPUT id='clRecuperacion' name='clRecuperacion' type='hidden' value='0'>
        <INPUT id='clCaucion' name='clCaucion' type='hidden' value='<%=StrclCaucion%>'>
        <%=MyUtil.ObjInput("Folio de la Caución","FolioCaucionVTR",StrFolioCaucion,false,false,30,70,StrFolioCaucion,false,false,20)%>
        <%=MyUtil.ObjInput("Folio de Recuperación","FolioVTR","",false,false,190,70,"",false,false,20)%>
        <%=MyUtil.ObjInput("Fecha de Recuperación <br>(AAAA/MM/DD)","FechaRecuperacion","",true,true,350,70,"",true,true,25,"if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("Monto Recuperado","MontoRecuperado","",false,false,30,120,"",false,false,15,"EsNumerico(document.all.MontoRecuperado)")%>
        
        <%=MyUtil.ObjInput("Proveedor que Recupera","ProveedorRecupera","",true,false,170,120,"",true,true,60,"if(this.readOnly==false){fnBuscaProv();}")%>
	<INPUT id='clProveedorRecupera' name='clProveedorRecupera' type='hidden' value=''>
                <%if (MyUtil.blnAccess[4]==true){%>
                    <div class='VTable' style='position:absolute; z-index:30; left:500px; top:130px;'>
                    <IMG SRC='../../Imagenes/Lupa.gif' class='handM' onClick='fnBuscaProv();' WIDTH=20 HEIGHT=20></div>
                <%}%>
        
        <%=MyUtil.ObjComboC("Colaborador que Recupera", "clProvColaborador","",true,true,530,120,"","","","",50,true,true)%>
        <%=MyUtil.ObjInput("Monto Reparación <br>Daño","MontoRepDan","",true,true,30,170,"0",false,false,15,"fnActualizaMontos(document.all.MontoRepDan)")%>
        <%=MyUtil.ObjInput("Monto Sanción <br>Pecunaria","MontoSanPec","",true,true,170,170,"0",false,false,15,"fnActualizaMontos(document.all.MontoSanPec)")%>
        <%=MyUtil.ObjInput("Monto Obligación <br>Procesal o Libertad","MontoObProc","",true,true,330,170,"0",false,false,15,"fnActualizaMontos(document.all.MontoObProc)")%>
        <%=MyUtil.ObjInput("Monto Suspensión <br>Acto Reclamado","MontoSusAct","",true,true,500,170,"0",false,false,15,"fnActualizaMontos(document.all.MontoSusAct)")%>
        <%=MyUtil.DoBlock("Datos de la Recuperación",15,0)%>
     <%
     }    
     %>
    <%=MyUtil.GeneraScripts()%>
    <%
    rs2.close();
    rs.close();
    rs2=null;
    rs=null;
    StrclExpediente = null;   
    StrclCaucion = null; 
    StrclRecuperacion = null;     
    StrSql1 = null; 
    StrclPaginaWeb=null;  
    StrFolioCaucion=null;
    StrclEstatusCaucion = null;
    StrclUsrApp=null;
    
 %>
<input name='FechaMsk' id='FechaMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09'>

<script> 

 function fnLlenaProvColab(){  
		var strConsulta = "sp_GetProvColab '" + document.all.clProveedorRecupera.value + "'";
		var pstrCadena = "../servlet/Utilerias.LlenaCombos?strSQL=" + strConsulta;
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
     document.all.MontoRecuperado.value=0;
     document.all.MontoRecuperado.value = eval(document.all.MontoRepDan.value) + eval(document.all.MontoSanPec.value) + eval(document.all.MontoObProc.value) + eval(document.all.MontoSusAct.value);
  }	
  
     function fnBuscaProv(){
         var pstrCadena = "../../Utilerias/FiltrosProv.jsp?strSQL=sp_WebBuscaProv ";
         pstrCadena = pstrCadena + "&NombreOpe= " + document.all.ProveedorRecupera.value;
         document.all.clProveedorRecupera.value='';
         window.open(pstrCadena,'newWin','scrollbars=yes,status=yes,width=700,height=500');
    }
    
    function fnActualizaProv(pclProveedor, pNombreOperativo){
        document.all.clProveedorRecupera.value = pclProveedor;
        document.all.ProveedorRecupera.value = pNombreOperativo;
        fnLlenaProvColab();
    }
</script>
</body>
</html>

