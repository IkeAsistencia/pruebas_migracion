<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Seguridad.SeguridadC,Utilerias.UtileriasBDF" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
<head><title>JSP Page</title> 
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
</head>
<body class="cssBody">

<%-- <jsp:useBean id="beanInstanceName" scope="session" class="beanPackage.BeanClassName" /> --%>
<%-- <jsp:getProperty name="beanInstanceName"  property="propertyName" /> --%>

<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
<script src='../Utilerias/Util.js' ></script>

<%  

    String StrclDeficienciaxExpediente= "0";
    String StrclUsrApp="0";
    String StrclExpediente="0";
    String StrclEstatusDef="0";
    String StrclQuejaxSupervision = "0";
    String StrclQuejaxSupervisionI = "0";
    String StrclAreaOperativa = "0";
    
    

    
    if (session.getAttribute("clUsrApp")!= null)
     {
       StrclUsrApp = session.getAttribute("clUsrApp").toString(); 
     }  

    if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) 
     {%>
       Fuera de Horario
       <% return; 
     }    
    if (request.getParameter("clDeficienciaxExpediente") != null)
    {
      StrclDeficienciaxExpediente = request.getParameter("clDeficienciaxExpediente");
    }    

    if (session.getAttribute("clExpediente")!= null)
         {
           StrclExpediente= session.getAttribute("clExpediente").toString(); 
        }  
    if (request.getParameter("clQuejaxSupervision") != null)
    {
      StrclQuejaxSupervision = request.getParameter("clQuejaxSupervision");
    }    
      StringBuffer StrSql = new StringBuffer();
      
      StrSql.append(" Select clareaOperativa From Expediente E" );
      StrSql.append(" inner join cServicio S on (E.clservicio= S.clServicio)");
      StrSql.append("where clExpediente= ").append(StrclExpediente);
       ResultSet rs2 = UtileriasBDF.rsSQLNP( StrSql.toString());    
       StrSql.delete(0,StrSql.length()); 
       
       if (rs2.next()){
          StrclAreaOperativa= rs2.getString("clareaOperativa");  
          }
      
      
      //obtiene el estatus de la deficiencia
      StrSql.append("SELECT clEstatusDef ");;;;;;
      StrSql.append(" FROM DeficienciasxExpediente");
      StrSql.append(" Where clDeficienciaxExpediente=").append(StrclDeficienciaxExpediente);
      ResultSet rsEst = UtileriasBDF.rsSQLNP( StrSql.toString());
      if (rsEst.next()){
          StrclEstatusDef=rsEst.getString("clEstatusDef");
      }
      
      StrSql.delete(0,StrSql.length());  
    
   
       StrSql.append("sp_DetalleDeficiencixExp ").append(StrclDeficienciaxExpediente);
       
       
       ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
       StrSql.delete(0,StrSql.length());  
       String StrclPaginaWeb = "295"; 
       session.setAttribute("clPaginaWebP",StrclPaginaWeb);
       MyUtil.InicializaParametrosC(295,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
       %>
       <%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion","fnAccionesAlta();fnValidaclQueja();","fnValidaUsrProv();")%>         
       <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%= request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1) + "DetalleMarcaDeficiencias.jsp?"%>'>   
       <input type="hidden" id="clAreaOperativa" name="clAreaOperativa" value="<%=StrclAreaOperativa%>">
     <%  if (Integer.parseInt(StrclEstatusDef)!=1){    //Valida si esta concluido o justificado
            StrSql.append(" select count(*) as 'Permiso' "); 
            StrSql.append(" from PermisoPartxGpoPag PP " );
            StrSql.append(" inner join UsrxGpo UxG on (PP.clGpoUsr = UxG.clGpoUsr) ");
            StrSql.append(" Where PP.clPaginaWeb =295 and UxG.clUsrApp = ").append(StrclUsrApp).append(" and PP.CambioEnDeficienciasCerradas = 1");
            ResultSet rsPagDet = UtileriasBDF.rsSQLNP( StrSql.toString());
            if (rsPagDet.next()){
               if (rsPagDet.getString("Permiso").compareToIgnoreCase("0")==0){  //valida si tiene permisos de cambiar deficiencia justificadas o concluidas 
           %>
                     <script>document.all.btnCambio.disabled=true;document.all.btnElimina.disabled=true;</script>
            <%}
           }
           rsPagDet.close();
           rsPagDet=null; 
        }
      if (rs.next()) {
      
      %>
            
            
            <INPUT id='clDeficienciaxExpediente' name='clDeficienciaxExpediente' type='hidden' value='<%= StrclDeficienciaxExpediente%>'>
            <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%= StrclExpediente %>'>
            <INPUT id='clUsrAppMarca' name='clUsrAppMarca' type='hidden' value='<%= StrclUsrApp %>'>
            <INPUT id='clQuejaxSupervision' name='clQuejaxSupervision' type='hidden' value='<%= rs.getString("clQuejaxSupervision") %>'>
            <%=MyUtil.ObjComboC("Tipo de Deficiencia", "clTipoDeficienciaVTR",rs.getString("dsTipoDeficiencia"),true,true,30,70,"","SELECT clTipoDeficiencia,dsTipoDeficiencia  FROM cTipoDeficiencia","fnLlenaAreaDef()","",50,true,true)%>
            <%=MyUtil.ObjComboC("Area", "clAreaDef",rs.getString("dsAreaDefiencia"),true,true,30,110,"","SELECT clAreaDeficiencia,dsAreaDefiencia from cAreaDeficiencia where clAreaDeficiencia=" + rs.getString("clAreaDef"),"fnLlenaDeficiencias(1)","",50,true,true)%>
            <%=MyUtil.ObjComboC("Coordinador con Deficiencia ", "clUsrAppDef",rs.getString("UsrDeficiencia"),true,true,280,110,"","sp_LlenaComboUsrDef " + StrclExpediente,"fnLlenaDeficiencias(2)","",50,false,false)%>
            <%=MyUtil.ObjComboC("Proveedor con Deficiencia", "clProveedorDef",rs.getString("Proveedor"),true,true,280,110,"","sp_LlenaComboProvxExp " + StrclExpediente,"fnLlenaDeficiencias(2)","",50,false,false)%>
            <%=MyUtil.ObjComboC("Deficiencia", "clDeficiencia",rs.getString("dsDeficiencia"),true,true,30,150,"","select * from cDeficiencias where clDeficiencia=" +  rs.getString("clDeficiencia"),"fnLlenaSubDeficiencias(this.value);","",50,true,true)%>
            <%=MyUtil.ObjComboC("SubDeficiencia", "clSubDeficiencia",rs.getString("dsSubDeficiencia"),true,true,30,190,"","sp_GetSubDeficiencia '" +  rs.getString("clDeficiencia")+"'","","",50,false,false)%>
            <%=MyUtil.ObjTextArea("Observaciones del Supervisor","ObservacionesSup",rs.getString("ObservacionesSup"),"100","5",true,true,30,230,"",false,false)%>
            <%=MyUtil.ObjComboC("Estatus Deficiencia", "clEstatusDef",rs.getString("dsEstatusDef"),false,true,30,320,"1","SELECT clEstatusDef,dsEstatusDef FROM CESTATUSDEF","","",50,false,true)%>

      <%  }
       else {%>
       
            <INPUT id='clDeficienciaxExpediente' name='clDeficienciaxExpediente' type='hidden' value='0'>
            <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente %>'>
            <INPUT id='clUsrAppMarca' name='clUsrAppMarca' type='hidden' value='<%=StrclUsrApp %>'>
            <INPUT id='clQuejaxSupervision' name='clQuejaxSupervision' type='hidden' value='<%= StrclQuejaxSupervision %>'>
            <%=MyUtil.ObjComboC("Tipo de Deficiencia", "clTipoDeficienciaVTR","",true,true,30,70,"","SELECT clTipoDeficiencia,dsTipoDeficiencia  FROM cTipoDeficiencia","fnLlenaAreaDef()","",50,true,true)%>
            <%=MyUtil.ObjComboC("Area", "clAreaDef","",true,true,30,110,"","SELECT clAreaDeficiencia,dsAreaDefiencia from cAreaDeficiencia where clAreaDeficiencia=-1","fnLlenaDeficiencias(1)","",50,true,true)%>
            <%=MyUtil.ObjComboC("Coordinador con Deficiencia ", "clUsrAppDef","",true,true,280,110,"","sp_LlenaComboUsrDef " + StrclExpediente,"fnLlenaDeficiencias(2)","",50,false,false)%>
            <%=MyUtil.ObjComboC("Proveedor con Deficiencia", "clProveedorDef","",true,true,280,110,"","sp_LlenaComboProvxExp " + StrclExpediente,"fnLlenaDeficiencias(2)","",50,false,false)%>
                        <%=MyUtil.ObjComboC("Deficiencia", "clDeficiencia","",true,true,30,150,"","select * from cDeficiencias where clDeficiencia=-1","fnLlenaSubDeficiencias(this.value);","",50,true,true)%>
            <%=MyUtil.ObjComboC("SubDeficiencia", "clSubDeficiencia","",true,true,30,190,"","","","",50,false,false)%>
            <%=MyUtil.ObjTextArea("Observaciones del Supervisor","ObservacionesSup","","100","5",true,true,30,230,"",false,false)%>
            <%=MyUtil.ObjComboC("Estatus Deficiencia", "clEstatusDef","",false,true,30,320,"1","SELECT clEstatusDef,dsEstatusDef FROM CESTATUSDEF","","",50,false,true)%>
        <%}%>           
        <%=MyUtil.DoBlock("Detalle de Marca Deficiencias",450,0)%>
        <%=MyUtil.GeneraScripts()%>
        <% StrSql=null;
           rsEst.close();
           rsEst=null;
           rs.close();
           rs=null; 
             
            %> 
<script>
  
 //Oculta las campos proveedor y usuario
       var Tipo= eval(document.all.clTipoDeficienciaVTR.value);
       document.all.D5.style.visibility='hidden';
       document.all.D6.style.visibility='hidden';
       switch (Tipo){
           case 1:    //Coordinador
                document.all.D5.style.visibility='visible';
                document.all.D6.style.visibility='hidden';
                break;
          case 2:      //Proveedor
                document.all.D5.style.visibility='hidden';
                document.all.D6.style.visibility='visible';
                break;
       }

function fnAccionesAlta(){
   document.all.D5.style.visibility='hidden';
   document.all.D6.style.visibility='hidden';
}
       
function fnLlenaAreaDef(){  
       var strConsulta = "sp_LlenaComboAreaDef '" + document.all.clTipoDeficienciaVTR.value + "','" + document.all.clAreaOperativa.value+"'";
       var pstrCadena = "../servlet/Utilerias.LlenaCombos?strSQL=" + strConsulta;
       document.all.clAreaDef.value = '';
       pstrCadena = pstrCadena + "&strName=clAreaDefC";		
       fnOptionxDefault('clAreaDefC',pstrCadena);
       
       document.all.clUsrAppDefC.value='';
       document.all.clProveedorDefC.value='';
       document.all.clUsrAppDef.value='';
       document.all.clProveedorDef.value='';
       
       var Tipo= eval(document.all.clTipoDeficienciaVTR.value);
       switch (Tipo){
           case 1:    //Coordinador
                document.all.D5.style.visibility='visible';
                document.all.D6.style.visibility='hidden';
                break;
          case 2:      //Proveedor
                document.all.D5.style.visibility='hidden';
                document.all.D6.style.visibility='visible';
                break;
          case 3:    //Area
                document.all.D5.style.visibility='hidden';
                document.all.D6.style.visibility='hidden';
                break; 
       }
}

function fnLlenaDeficiencias(pCampoSolicitado){
      //pCampoSolicitado 1 Area; 2 Coordinador; 2 Proveedor
  
       //var Tipo= eval(document.all.clTipoDeficienciaVTR.value);
       //if (((pCampoSolicitado==1)&&(Tipo==3))||(pCampoSolicitado==2)){
           var strConsulta = "sp_LlenaComboDeficiencias '" + document.all.clExpediente.value + "','" + document.all.clAreaDef.value + "','" + document.all.clUsrAppDef.value + "','" + document.all.clProveedorDef.value + "','" + document.all.clTipoDeficienciaVTR.value +"'";
          // alert(strConsulta);
           var pstrCadena = "../servlet/Utilerias.LlenaCombos?strSQL=" + strConsulta;
           document.all.clDeficiencia.value = '';
           pstrCadena = pstrCadena + "&strName=clDeficienciaC";		
           fnOptionxDefault('clDeficienciaC',pstrCadena);
        // }  
}

function fnLlenaSubDeficiencias(clDef){
           var strConsulta = "sp_GetSubDeficiencia '" + clDef + "'";
           var pstrCadena = "../servlet/Utilerias.LlenaCombos?strSQL=" + strConsulta;
           document.all.clSubDeficiencia.value = '';
//alert(strConsulta);
           pstrCadena = pstrCadena + "&strName=clSubDeficienciaC";		
           fnOptionxDefault('clSubDeficienciaC',pstrCadena);
}

function fnValidaUsrProv(){

  if (document.all.Action.value!=3){
       var Tipo= eval(document.all.clTipoDeficienciaVTR.value);   
       switch (Tipo){
           case 1:    //Coordinador
                if (document.all.clUsrAppDef.value==''){ 
                    msgVal="Debe el informar el Usuario con Deficiencia";
                }    
                break;
          case 2:      //Proveedor
                if (document.all.clProveedorDef.value==''){ 
                   msgVal="Debe el informar el Proveedor con Deficiencia";
                }   
                break;
          case 3:    //Area
                //msgVal="";
                break; 
       }
   }    

}
function fnValidaclQueja()
{
        if (document.all.Action.value==1)
            {
              var pstrCadena = "../Utilerias/RegresaQueja.jsp?clExpediente=" + document.all.clExpediente.value;
              window.open(pstrCadena,'newWin','width=10,height=10,left=1500,top=2000');
            }
}
function fnActualizaQ(pQueja)
  {
        if (document.all.clQuejaxSupervision.value == pQueja)
          {
              document.all.clQuejaxSupervision.value =0;
          }
          else 
          {
             if(document.all.clQuejaxSupervision.value != pQueja)
             {
             document.all.clQuejaxSupervision.value=document.all.clQuejaxSupervision.value;
             }
  }       }



</script>


</body>
</html>
