<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="Combos.cbTarifa,java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
<head><title>Costos Legal</title>
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
</head>
<body class="cssBody">
<%-- <jsp:useBean id="beanInstanceName" scope="session" class="beanPackagAL.BeanClassName" /> --%>
<%-- <jsp:getProperty name="beanInstanceName"  property="propertyName" /> --%>
<jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj" /> 
<script src='../Utilerias/Util.js' ></script>
<script src='../Utilerias/UtilMask.js' ></script>
<script src='../Utilerias/UtilCostos.js' ></script>
<%  
    String StrclExpediente = "0";   
    StringBuffer StrSql = new StringBuffer(); 
    String StrclUsrApp="0";
    String StrclPaginaWeb="0";
    String StrclCosto="0";
    
    

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

   	if (request.getParameter("clCosto")!= null)
      	{
            StrclCosto= request.getParameter("clCosto").toString(); 
       	}  
    
    
    StrSql.append("Select C.clCosto, c.CostoSEA,C.CostoExced,coalesce(C.CostoNU,0) CostoNU,");
    StrSql.append(" c.PendientePago,c.Concepto, ");
    StrSql.append(" p.NombreOpe 'dsProveedor',COALESCE(CC.dsConcepto,'') dsConcepto , coalesce(cast(T.clTarifa as varchar(15)),'') clTarifa, COALESCE(T.dsTarifa,'') dsTarifa, ");
    StrSql.append(" COALESCE(C.clCostoXProvXSubserv,'')'clCostoXProvXSubserv',COALESCE(CS.Clave,'') 'Clave'");
    StrSql.append(" FROM Costos C");
    StrSql.append(" INNER JOIN cProveedor P on(P.clProveedor=C.clProveedor) ");
    StrSql.append(" LEFT JOIN CCONCEPTOCOSTO CC ON(CC.clConcepto=C.clConcepto)");
    StrSql.append(" LEFT JOIN cTarifa T ON(T.clTarifa=C.clTarifa)");
    StrSql.append(" LEFT JOIN CostoxSubservxEFLegal CS ON(C.clCostoxSubservxEF=CS.clCostoxSubservxEF) ");
    StrSql.append(" Where clCosto =").append(StrclCosto);
    
    ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());     
        
   %><script>fnOpenLinks()</script><%

   StrclPaginaWeb = "282";       
   MyUtil.InicializaParametrosC(282,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina

   session.setAttribute("clPaginaWebP",StrclPaginaWeb); 

   %><%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion","fnHabilitaCampos(chkTipoBusca)")%>
   <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%>DetalleCostosLegal.jsp?'>
   <% if (rs.next()) {                         
        %>
        <script>document.all.btnAlta.disabled=true;</script>
        <INPUT id='clCosto' name='clCosto' type='hidden' value='<%=rs.getString("clCosto")%>'>
        <INPUT id='Nomina' name='Nomina' type='hidden' value='1'>
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
        <INPUT id='clCostoxSubservxEF' name='clCostoxSubservxEF' type='hidden' value='<%=rs.getString("Clave")%>'>
        <%=MyUtil.ObjComboC("Proveedor", "clProveedor",rs.getString("dsProveedor"),true,true,30,70,"","sp_LlenaComboProvxExpPagoNomina " + StrclExpediente,"","",50,true,true)%>
        <%=MyUtil.ObjChkBox("Busqueda Por :","chkTipoBusca","",true,true,290,70,"","CLAVE","CONCEPTO","fnHabilitaCampos(this)")%>
        <%=MyUtil.ObjInput("Clave","ClaveX",rs.getString("Clave"),true,true,490,150,"",false,false,7)%>
        <%=MyUtil.ObjComboC("Concepto", "clConcepto",rs.getString("dsConcepto"),true,true,30,110,"","sp_LlenaConceptos " + StrclExpediente + ",'1'","fnLlenaTarifas()","",50,true,true)%>
        <% String strTarifa = rs.getString("dsTarifa"); %>
        <%=MyUtil.ObjComboMem("Tarifa", "clTarifa",strTarifa, rs.getString("clTarifa"),cbTarifa.GeneraHTML(50,strTarifa), true,true,30,150,"","","",50,true,true)%>
        <%=MyUtil.ObjInput("Concepto","Concepto",rs.getString("Concepto"),false,false,30,190,"",false,false,50)%>
        <%=MyUtil.ObjInput("Costo Sea","CostoSEA",rs.getString("CostoSEA"),false,false,30,230,"",false,false,7)%> 

        <div class='VTable' style='position:absolute; z-index:25; left:470px; top:120px;'>
        <INPUT type='button' VALUE='Busca Costo' onClick='fnRegresaCostoLegal()' class='cBtn'></div>

        <div class='VTable' style='position:absolute; z-index:25; left:470px; top:80px;'>
        <INPUT type='button' VALUE='Registro de Pago' onClick='this.disabled=true;fnRegistraPago();' class='cBtn'></div>

        <%=MyUtil.DoBlock("Costo",0,0)%><%

   } 
   else { 
        %>
        <INPUT id='clCosto' name='clCosto' type='hidden' value='<%=StrclCosto%>'>
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
        <INPUT id='Nomina' name='Nomina' type='hidden' value='1'>
        <INPUT id='clCostoxSubservxEF' name='clCostoxSubservxEF' type='hidden' value='0'>
        <%=MyUtil.ObjComboC("Proveedor", "clProveedor","",true,true,30,70,"","sp_LlenaComboProvxExpPagoNomina " + StrclExpediente,"","",50,true,true)%>
        <%=MyUtil.ObjChkBox("Busqueda Por :","chkTipoBusca","",true,true,290,70,"","CLAVE","CONCEPTO","fnHabilitaCampos(this)")%>
        <%=MyUtil.ObjComboC("Concepto", "clConcepto","",true,true,30,110,"","sp_LlenaConceptos " + StrclExpediente + ",'0'","fnLlenaTarifas('')","",50,true,true)%>
        <%=MyUtil.ObjComboMem("Tarifa", "clTarifa","","",cbTarifa.GeneraHTML(50,""),true,true,30,150,"","","",50,true,true)%>
        <%=MyUtil.ObjInput("Clave","ClaveX","",true,true,490,150,"",false,false,7)%>
        <%=MyUtil.ObjInput("Concepto","Concepto","",false,false,30,190,"",false,false,50)%>
        <%=MyUtil.ObjInput("Costo Sea","CostoSEA","",false,false,30,230,"",false,false,7)%>

        <div class='VTable' style='position:absolute; z-index:25; left:470px; top:120px;'>
        <INPUT type='button' VALUE='Busca Costo' onClick='fnRegresaCostoLegal()' class='cBtn'></div>

        <div class='VTable' style='position:absolute; z-index:25; left:470px; top:80px;'>
        <INPUT type='button' VALUE='Registro de Pago' onClick='this.disabled=true;fnRegistraPago();' class='cBtn'></div>

        <%=MyUtil.DoBlock("Costo",0,0)%><%
   }    
   %><%=MyUtil.GeneraScripts()%>
   <% rs.close();       
   rs=null;
   StrSql.delete(0,StrSql.length());
   
 %>
</body>
</html>
<script>


function fnLlenaTarifas(pTipo){  
       if(pTipo=="TODO"){
          var strConsulta = "Select clTarifa,dsTarifa From cTarifa"; //Llena todos los registros
       }
       else {
          document.all.Concepto.value=document.all.clConceptoC.options[document.all.clConceptoC.selectedIndex].text;
          var strConsulta = "sp_LlenaComboTarifa '" + document.all.clConcepto.value + "'";
       }   
       var pstrCadena = "../servlet/Utilerias.LlenaCombos?strSQL=" + strConsulta;
       document.all.clTarifa.value = '';
       pstrCadena = pstrCadena + "&strName=clTarifaC";		
       fnOptionxDefault('clTarifaC',pstrCadena);
}


function fnRegresaCostoLegal(){
   if (document.all.Action.value==1){
        if (document.all.clProveedor.value!=''){
            var pstrCadena = "RegresaCostoLegal.jsp?clProveedor=" + document.all.clProveedor.value  
                                  + "&clConcepto=" + document.all.clConcepto.value
                                  + "&clTarifa=" + document.all.clTarifa.value
                                  + "&Clave=" + document.all.ClaveX.value;

             window.open(pstrCadena,'newWin','scrollbars=yes,status=yes,width=700,height=500');
        }
        else{
         alert('Debe informar un proveedor');
        }
    }    
}

function fnActualizaDatosCostoLegal(pCosto,pClave,pConcepto,pTarifa,pclCostoxSubservxEF){
   if (pclCostoxSubservxEF!=0){
        document.all.CostoSEA.value = pCosto;
        document.all.ClaveX.value = pClave;
        document.all.clConceptoC.value = parseInt(pConcepto);
        document.all.clConcepto.value = parseInt(pConcepto);
        document.all.clTarifaC.value = parseInt(pTarifa);
        document.all.clTarifa.value  =  parseInt(pTarifa);
        document.all.clCostoxSubservxEF.value=pclCostoxSubservxEF;
        document.all.Concepto.value=document.all.clConceptoC.options[document.all.clConceptoC.selectedIndex].text;
      }  
}

function fnHabilitaCampos(pCampo){
   if (pCampo.checked){
      document.all.clConceptoC.disabled=true;
      document.all.clTarifaC.disabled=true;
      document.all.ClaveX.disabled=false;
      document.all.Concepto.value=''
      document.all.CostoSEA.value=''
      fnLlenaTarifas('TODO');
    }
   else{
      document.all.clConceptoC.disabled=false;
      document.all.clTarifaC.disabled=false;
      document.all.ClaveX.disabled=true;
      document.all.ClaveX.value='';
      document.all.Concepto.value=''
      document.all.CostoSEA.value=''
   }
}

</script>

