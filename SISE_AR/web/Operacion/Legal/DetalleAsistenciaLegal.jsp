<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
<head><title>Detalle de Asistencia Legal</title>
<link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
</head>
<body class="cssBody" onload="fnGNPInfo()"  > 

<%-- <jsp:useBean id="beanInstanceName" scope="session" class="beanPackagAL.BeanClassName" /> --%>
<%-- <jsp:getProperty name="beanInstanceName"  property="propertyName" /> --%>

<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
<script src='../../Utilerias/Util.js' ></script>
<script src='../../Utilerias/UtilAuto.js' ></script>
<script src='../../Utilerias/UtilMask.js'></script>
<script src='../../Utilerias/UtilDireccion.js' ></script>
<script src='../../Utilerias/UtilCalendario.js'></script>
<link href="../../StyleClasses/Calendario.css" rel="stylesheet" type="text/css">

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
    String StrclPaginaWeb="0";  
    String StrclServicio="0";
    String StrclSubservicio="0";
    String StrCodEnt="";
    String StrdsGerencia = ""; 
    String StrFecAper = "";     
    String StrContactoNU = "";
    String StrCambC = "";
    boolean StrCon ;
     
    if (session.getAttribute("clExpediente")!= null)
     {
       StrclExpediente = session.getAttribute("clExpediente").toString();        
     }  
    if (session.getAttribute("clServicio")!= null)
     {
       StrclServicio = session.getAttribute("clServicio").toString();        
     }  
    if (session.getAttribute("clSubServicio")!= null)
     {
       StrclSubservicio = session.getAttribute("clSubServicio").toString();        
     }  
    if (session.getAttribute("FechaAp")!= null)
     {
       StrFecAper = session.getAttribute("FechaAp").toString();        
     }     

    StringBuffer StrSql = new StringBuffer();
    StrSql.append("Select TieneAsistencia,CodEnt From Expediente Where clExpediente=").append(StrclExpediente);
    ResultSet rs2 = UtileriasBDF.rsSQLNP( StrSql.toString());
    StrSql.delete(0,StrSql.length());
    
    if (rs2.next())  
     { 
      if (Integer.parseInt(rs2.getString("TieneAsistencia")) == 1)  
       {// out.println("Ya existe una asistencia registrada para el expediente: (" + StrclExpediente + ") " + rs2.getString("dsSubServicio") );   
          StrCodEnt=rs2.getString("CodEnt");
       }
      else
       {
           
          StrSql.append("Insert into AsistenciaLegal (clExpediente,Foraneo) values(").append(StrclExpediente).append(",0)");
          UtileriasBDF.ejecutaSQLNP(StrSql.toString());
          StrSql.delete(0,StrSql.length());
          StrSql.append("Update Expediente set FechaRegAsist = getdate(), TieneAsistencia = 1, FechaApAsist = '").append(StrFecAper).append("',clServicio=").append(StrclServicio).append(", clSubServicio=").append(StrclSubservicio).append(" Where clExpediente=").append(StrclExpediente);
          UtileriasBDF.ejecutaSQLNP(StrSql.toString());
          StrSql.delete(0,StrSql.length());
          
            StrSql.append(" Select E.TieneAsistencia, CodEnt");
            StrSql.append(" From Expediente E");
            StrSql.append(" Where E.clExpediente=").append(StrclExpediente);
            rs2 = UtileriasBDF.rsSQLNP( StrSql.toString());   
            StrSql.delete(0,StrSql.length());

            if (rs2.next())  
             { 
              if (Integer.parseInt(rs2.getString("TieneAsistencia")) == 1)   
               {
                  StrCodEnt=rs2.getString("CodEnt");

                  %><script> location.href='../Legal/DetalleInvVehNU.jsp?&Apartado=S';</script><%
               }
              else
               {
                  %><script> alert('Error. El expediente no tiene una asistencia asignada');</script><%
                  StrclExpediente = null;    
                  StrSql = null; 
                  StrclPaginaWeb=null;  
                  StrclServicio=null;
                  StrclSubservicio=null;
                  StrCodEnt=null;
                  StrdsGerencia = null; 
                  StrFecAper = null;     
                  StrclUsrApp=null;
                  rs2.close();
                  rs2=null;
                  
                  return; 
               }
            }
            else  { %><script> alert('Error');</script><%
                  StrclExpediente = null;    
                  StrSql = null; 
                  StrclPaginaWeb=null;  
                  StrclServicio=null;
                  StrclSubservicio=null;
                  StrCodEnt=null;
                  StrdsGerencia = null; 
                  StrFecAper = null;     
                  StrclUsrApp=null;
                  rs2.close();
                  rs2=null;
                  
                  return;}
      }

    }  
    else
     {
          %>El expediente no existe<%
          
          return;      
     } 

    if (session.getAttribute("clServicio")!= null)
     {
       StrclServicio = session.getAttribute("clServicio").toString(); 
     }  
    if (session.getAttribute("clSubServicio")!= null)
     {
       StrclSubservicio = session.getAttribute("clSubServicio").toString(); 
     }     
  
    StrSql.append(" select ge.clgerenciareg, gr.dsgerencia from gciaregxentidad ge " );
    StrSql.append(" left join cgerenciaregional gr on (gr.clgerenciareg=ge.clgerenciareg)" );
    StrSql.append(" where ge.codEnt ='").append(StrCodEnt).append("'");
    ResultSet rs4 = UtileriasBDF.rsSQLNP( StrSql.toString());  
    StrSql.delete(0,StrSql.length());

    if (rs4.next()){
       StrdsGerencia = rs4.getString("dsgerencia");
    }   
    
    StrSql.append("Select AL.clExpediente, AL.Foraneo as Foraneo, coalesce(CA.dsTipoCulpa,'') as dsTipoCulpa, coalesce(CD.dsTipoCulpa,'') as dsTipoCulpaD, ");
             StrSql.append(" coalesce(AL.ObsCulpaAjusta,'') as ObsCulpaAjusta, coalesce(AL.ObsCulpaDicta,'') as ObsCulpaDicta, ");
             StrSql.append(" coalesce(AL.Ajustador,'') as Ajustador, ");
             StrSql.append(" coalesce(AL.LugarAbogado,'')  as LugarAbogado," );
             StrSql.append(" coalesce(CN.clContactoNU,'')  as clContactoNU, " );
             StrSql.append(" coalesce(lc.dsLugarContacto,'')  as dsLugarContactoT, " );
             StrSql.append(" coalesce(CN.dsContactoNU,'')  as dsContactoNU, " );
             StrSql.append(" coalesce(AL.AvPrevia,'') as AvPrevia, coalesce(AL.RefAvPrevia,'') as RefAvPrevia, " );
             StrSql.append(" coalesce(AL.Causa,'') as Causa, coalesce(AL.RefCausa,'') as RefCausa, coalesce(AL.Toca,'') as Toca, coalesce(AL.RefToca,'') as RefToca, ");
             StrSql.append(" coalesce(AL.Amparo,'') as Amparo, coalesce(AL.RefAmparo,'') as RefAmparo, " );          
             StrSql.append(" coalesce(FC.dsFormaConcluye,'') as dsFormaConcluye, " ); 
             StrSql.append(" coalesce(convert(varchar(16),AL.FechaBaja,120),'') as FechaBaja, " ); 
             StrSql.append(" coalesce(cast(AL.ObsTermino as varchar(8000)),'') ObsTermino, " );
             StrSql.append(" rtrim(coalesce(Folio,''))  as Folio, " );
             //StrSql.append(" coalesce(AL.clLugarContacto,'')  as clLugarContacto, coalesce (Folio,'') as Folio, " );
             StrSql.append(" coalesce (RD.dsEstatusRecupDanos,'') as dsEstatusRecupDanos ");
             StrSql.append(" From AsistenciaLegal AL " );           
             StrSql.append(" left join cLugarContacto lc on (lc.clLugarContacto = AL.clLugarContacto) " );
             StrSql.append(" left join cContactoNU CN on (CN.clContactoNU = AL.clContactoNU) " );
             StrSql.append(" left join cTipoCulpa CA ON (CA.clCulpa = AL.clCulpaAjusta) " );
             StrSql.append(" left join cTipoCulpa CD ON (CD.clCulpa = AL.clCulpaDicta) " );
             StrSql.append(" left join cFormaConcluir FC ON (FC.clFormaConcluye = AL.clFormaConcluye) " );
             StrSql.append(" left Join cEstatusRecupDanos RD on (AL.clEstatusRecupDanos=RD.clEstatusRecupDanos) ");
             StrSql.append(" Where AL.clExpediente =").append(StrclExpediente);
//    out.println(StrSql);
    
    ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());     
    StrSql.delete(0,StrSql.length());        
    
       %><script>fnOpenLinks()</script><%	
       
       StrclPaginaWeb = "179";       
       MyUtil.InicializaParametrosC(179,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
 
       session.setAttribute("clPaginaWebP",StrclPaginaWeb); 

       %><%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist","","fnValidaContacto();fnGNPInfoObli();")%>
       <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="DetalleAsistenciaLegal.jsp?'>"%><%       
       
       if (rs.next()) { 
           
            StrSql.append(" select EX.clCuenta, EX.Contacto From Expediente EX " );
            StrSql.append(" where EX.clExpediente =").append(StrclExpediente);
            ResultSet rs5 = UtileriasBDF.rsSQLNP( StrSql.toString());  
            StrSql.delete(0,StrSql.length());
           
    
            if (rs5.next()) {
                String StrNuestroUsuario = rs5.getString("Contacto");
                String StrclCuenta = rs5.getString("clCuenta"); 
            %><script>document.all.btnAlta.disabled=true;</script>
            <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
            <INPUT id='clServicio' name='clServicio' type='hidden' value='<%=StrclServicio%>'>
            <INPUT id='clSubServicio' name='clSubServicio' type='hidden' value='<%=StrclSubservicio%>'>
            <INPUT id='clCuentaVTR' name='clCuentaVTR' type='hidden' value='<%=StrclCuenta%>'>
            <INPUT id='NuestroUsuarioVTR' name='NuestroUsuarioVTR' type='hidden' value='<%=StrNuestroUsuario%>'>

            <%=MyUtil.ObjChkBox("Foraneo","Foraneo",rs.getString("Foraneo"), true,true,590,70,"0","SI","NO","")%>
            <%=MyUtil.ObjComboC("Culpa Según Ajustador","clCulpaAjusta",rs.getString("dsTipoCulpa"),true,true,30,70,"","Select clCulpa, dsTipoCulpa From cTipoCulpa ", "","",30,false,false)%>
            <%=MyUtil.ObjComboC("Culpa Según Dictamen","clCulpaDicta",rs.getString("dsTipoCulpaD"),true,true,350,70,"","Select clCulpa, dsTipoCulpa From cTipoCulpa ","","",30,false,false)%>
            <%=MyUtil.ObjTextArea("Observaciones de Culpa según Ajustador","ObsCulpaAjusta",rs.getString("ObsCulpaAjusta"), "55","3",true,true,30,110,"",false,false)%>
            <%=MyUtil.ObjTextArea("Observaciones de Culpa según Dictamen","ObsCulpaDicta",rs.getString("ObsCulpaDicta"), "55","3",true,true,350,110,"",false,false)%>
            <%=MyUtil.ObjInput("Nombre del Ajustador","Ajustador",rs.getString("Ajustador"),true,true,30,170,"",false,false,40)%>
            <div style='position:absolute; z-index:25; left:248px; top:187px;' name='AstAjustador' id='AstAjustador'><img alt="Campo obligatorio para GNP" src="../../Imagenes/AsteriscoGNP.gif" width="10" height="10" ></div> 
            <%=MyUtil.ObjTextArea("Forma de Atención","LugarAbogado",rs.getString("LugarAbogado"), "40","3",true,true,265,170,"",false,false)%>
            <%/*
            StrCambC = rs.getString("clContactoNU");
            if (StrCambC.equalsIgnoreCase("1") || StrCambC.equalsIgnoreCase("2"))
            {
            StrCon=false;
            }
            else
            {
            StrCon=true;
            }*/
            %>
            <%=MyUtil.ObjComboC("Contacto","clLugarContacto",rs.getString("dsLugarContactoT"),true,true,500,170,"","select clLugarContacto,dsLugarContacto from cLugarContacto","fnDesactiva()","",40,false,false)%>
            <%=MyUtil.ObjComboC("LLAMAR N/U","clContactoNU",rs.getString("dsContactoNU"),true,true,670,170,"","select clContactoNU,dsContactoNU from cContactoNU","fnDesactivaC()","",40,false,false)%>
            <%=MyUtil.ObjInput("Gerencia Regional","GerenciaRG",StrdsGerencia,false,false,30,225,"",false,false,40)%>
            <%=MyUtil.ObjInput("Folio","Folio",rs.getString("Folio"),true,true,265,225,"",false,false,40)%>
            <%=MyUtil.ObjComboC("Estatus de Recuperación", "clEstatusRecupDanos",rs.getString("dsEstatusRecupDanos"),true,true,500,225,"","Select clEstatusRecupDanos, dsEstatusRecupDanos From cEstatusRecupDanos","","",50,false,false)%>                      
            <%=MyUtil.DoBlock("Detalle de Asistencia Legal",60,0)%>

            <%=MyUtil.ObjInput("Averiguación Previa","AvPrevia",rs.getString("AvPrevia"),true,true,30,310,"",false,false,20)%> 
            <%=MyUtil.ObjInput("Ministerio Público","RefAvPrevia",rs.getString("RefAvPrevia"), true,true,180,310,"",false,false,30)%>
            <%=MyUtil.ObjInput("Causa","Causa",rs.getString("Causa"),true,true,360,310,"",false,false,20)%> 
            <%=MyUtil.ObjInput("Juzgado","RefCausa",rs.getString("RefCausa"),true,true,490,310,"",false,false,30)%>
            <%=MyUtil.ObjInput("Toca","Toca",rs.getString("Toca"),true,true,30,340,"",false,false,20)%>
            <%=MyUtil.ObjInput("Sala","RefToca",rs.getString("RefToca"),true,true,180,340,"",false,false,30)%>
            <%=MyUtil.ObjInput("Amparo","Amparo",rs.getString("Amparo"),true,true,360,340,"",false,false,20)%>             
            <%=MyUtil.ObjInput("Juzgado","RefAmparo",rs.getString("RefAmparo"),true,true,490,340,"",false,false,30)%>
            <%=MyUtil.DoBlock("Información de la Averiguación",0,10)%>  
            
            <%=MyUtil.ObjComboC("Forma en que concluyó","clFormaConcluye",rs.getString("dsFormaConcluye"),true,true,30,440,"","Select clFormaConcluye, dsFormaConcluye From cFormaConcluir ","","",40,false,false)%>
            <%=MyUtil.ObjInputF("Fecha de autorización a Baja (AAAA-MM-DD HH:MM)","FechaBaja",rs.getString("FechaBaja"),true,true,350,440,"",false,false,20, 2, "if(this.readOnly==false){fnValMask(this,document.all.FechaMskH.value,this.name)}")%>                        
            <%=MyUtil.ObjTextArea("Observaciones Finales","ObsTermino",rs.getString("ObsTermino"), "120","4",true,true,30,480,"",false,false)%>
            <%=MyUtil.DoBlock("Información Adicional",240,50)%><%
            }
                        rs5.close();
                        rs5 = null;
       }       
       else { 
           
            StrSql.append(" select EX.clCuenta, EX.Contacto From Expediente EX " );
            StrSql.append(" where EX.clExpediente =").append(StrclExpediente);
            ResultSet rs5 = UtileriasBDF.rsSQLNP( StrSql.toString());  
            StrSql.delete(0,StrSql.length());
           
    
            if (rs5.next()) {
                String StrNuestroUsuario = rs5.getString("Contacto");
                String StrclCuenta = rs5.getString("clCuenta");
                
                                if (StrclCuenta.equalsIgnoreCase("113")){
                        %> <div style='position:absolute; z-index:25; left:248px; top:187px;' name='boton' id='boton'><img alt="Campo Obligatorio para GNP" src="../../Imagenes/AsteriscoGNP.gif" width="10" height="10" ></div> 
            <%}
            %><script>document.all.btnCambio.disabled=true;</script>
            <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
            <INPUT id='clServicio' name='clServicio' type='hidden' value='<%=StrclServicio%>'>
            <INPUT id='clSubServicio' name='clSubServicio' type='hidden' value='<%=StrclSubservicio%>'>
            <INPUT id='clCuentaVTR' name='clCuentaVTR' type='hidden' value='<%=StrclCuenta%>'>
            <INPUT id='NuestroUsuarioVTR' name='NuestroUsuarioVTR' type='hidden' value='<%=StrNuestroUsuario%>'>
            <%=MyUtil.ObjChkBox("Foraneo","Foraneo","", true,true,590,70,"0","SI","NO","")%>                         
            <%=MyUtil.ObjComboC("Culpa Según Ajustador","clCulpaAjusta","",true,true,30,70,"","Select clCulpa, dsTipoCulpa From cTipoCulpa ", "","",30,false,false)%>
            <%=MyUtil.ObjComboC("Culpa Según Dictamen","clCulpaDicta","",true,true,350,70,"","Select clCulpa, dsTipoCulpa From cTipoCulpa ","","",30,false,false)%>
            <%=MyUtil.ObjTextArea("Observaciones de Culpa según Ajustador","ObsCulpaAjusta","", "55","3",true,true,30,110,"",false,false)%>
            <%=MyUtil.ObjTextArea("Observaciones de Culpa según Dictamen","ObsCulpaDicta","", "55","3",true,true,350,110,"",false,false)%>
            <%=MyUtil.ObjInput("Nombre del Ajustador","Ajustador","",true,true,30,170,"",false,false,40)%>  
            <%=MyUtil.ObjTextArea("Forma de Atención","LugarAbogado","", "40","3",true,true,265,170,"",false,false)%>
            <%=MyUtil.ObjComboC("Contacto","clLugarContacto","",true,true,500,170,"","select clLugarContacto,dsLugarContacto from cLugarContacto","fnDesactiva()","",40,false,false)%>           
            <%=MyUtil.ObjComboC("LLAMAR N/U","clContactoNU","",true,true,670,170,"","select clContactoNU,dsContactoNU from cContactoNU","fnDesactivaC()","",40,false,false)%>
            <%=MyUtil.ObjInput("Gerencia Regional","GerenciaRG","",false,false,30,225,StrdsGerencia,false,false,40)%>
            <%=MyUtil.ObjInput("Folio","Folio","",true,true,265,225,"",false,false,40)%> 
            <%=MyUtil.ObjComboC("Estatus de Recuperación", "clEstatusRecupDanos","",true,true,500,225,"","Select clEstatusRecupDanos, dsEstatusRecupDanos From cEstatusRecupDanos","","",50,false,false)%>                      
            <%=MyUtil.DoBlock("Detalle de Asistencia Legal",60,0)%>   
        
            <%=MyUtil.ObjInput("Averiguación Previa","AvPrevia","",true,true,30,310,"",false,false,20)%>
            <%=MyUtil.ObjInput("Ministerio Público","RefAvPrevia","", true,true,180,310,"",false,false,30)%>
            <%=MyUtil.ObjInput("Causa","Causa","",true,true,360,310,"",false,false,20)%>
            <%=MyUtil.ObjInput("Juzgado","RefCausa","",true,true,490,310,"",false,false,30)%>
            <%=MyUtil.ObjInput("Toca","Toca","",true,true,30,340,"",false,false,20)%>
            <%=MyUtil.ObjInput("Sala","RefToca","",true,true,180,340,"",false,false,30)%>
            <%=MyUtil.ObjInput("Amparo","Amparo","",true,true,360,340,"",false,false,20)%>
            <%=MyUtil.ObjInput("Juzgado","RefAmparo","",true,true,490,340,"",false,false,30)%>
            <%=MyUtil.DoBlock("Información de la Averiguación",0,10)%>  
            <%=MyUtil.ObjComboC("Forma en que concluyó","clFormaConcluye","",true,true,30,440,"","Select clFormaConcluye, dsFormaConcluye From cFormaConcluir ","","",40,false,false)%>
            <%=MyUtil.ObjInputF("Fecha de autorización a Baja (AAAA-MM-DD HH:MM)","FechaBaja","",true,true,350,440,"",false,false,20, 2, "if(this.readOnly==false){fnValMask(this,document.all.FechaMskH.value,this.name)}")%>                        
            <%=MyUtil.ObjTextArea("Observaciones Finales","ObsTermino","", "120","4",true,true,30,480,"",false,false)%>
            <%=MyUtil.DoBlock("Información Adicional",240,50)%><%
            }
                        rs5.close();
                        rs5 = null;
       }   
        
        
// campos extra.....     
/*
       String strclCuenta="0";
       if(session.getAttribute("clCuenta")!=null){
            strclCuenta = session.getAttribute("clCuenta").toString();
       }
       ResultSet rsCampos = UtileriasBDF.rsSQLNP( "sp_GetCamposExtraxCta '" + strclCuenta  + "','" + StrclSubservicio + "'");
       int iX=30;
       int iY=700;
       int iFields=0;
       
       if (rs.getRow()>0) {
           while (rsCampos.next()){ 
               rs.first();
               if (iFields==3){iFields=0;iX=30;iY+=40;}
               switch(rsCampos.getInt("clTipoObjeto")){
                    case 1: 
                        // InputText
                        out.println(MyUtil.ObjInput(rsCampos.getString("Titulo"),rsCampos.getString("Nombre"),rs.getString(rsCampos.getString("ValorRef").trim()),rsCampos.getBoolean("EditAlta"),rsCampos.getBoolean("EditCambio"),iX,iY,"",rsCampos.getBoolean("ReqAlta"),rsCampos.getBoolean("ReqCambio"),rsCampos.getInt("tSize")));
                        break;
                        
                    case 2:
                        // Combo
                        out.println(MyUtil.ObjComboC(rsCampos.getString("Titulo"),rsCampos.getString("Nombre"),rs.getString(rsCampos.getString("ValorRef")),rsCampos.getBoolean("EditAlta"),rsCampos.getBoolean("EditCambio"),iX,iY,"",rsCampos.getString("SentenciaSQL"),"","",rsCampos.getInt("tSize"),rsCampos.getBoolean("ReqAlta"),rsCampos.getBoolean("ReqCambio")));
                        break;
                        
                    default: 
                        out.println("Otro");
                        break;
               }
               iX+=250;
           }
       }
       else{
           while (rsCampos.next()){ 
               if (iFields==3){iFields=0;iX=30;iY+=40;}
               
               switch(rsCampos.getInt("clTipoObjeto")){
                    case 1: 
                        // InputText
                        out.println(MyUtil.ObjInput(rsCampos.getString("Titulo"),rsCampos.getString("Nombre"),"",rsCampos.getBoolean("EditAlta"),rsCampos.getBoolean("EditCambio"),30,530,"",rsCampos.getBoolean("ReqAlta"),rsCampos.getBoolean("ReqCambio"),rsCampos.getInt("tSize")));
                        break;

                    case 2:
                        // Combo
                        out.println(MyUtil.ObjComboC(rsCampos.getString("Titulo"),rsCampos.getString("Nombre"),"",rsCampos.getBoolean("EditAlta"),rsCampos.getBoolean("EditCambio"),iX,iY,"",rsCampos.getString("SentenciaSQL"),"","",rsCampos.getInt("tSize"),rsCampos.getBoolean("ReqAlta"),rsCampos.getBoolean("ReqCambio")));
                        break;
                    default: out.println("Otro");
                        break;
               }
               iX+=250;
           }
       }
  
       out.println(MyUtil.DoBlock("Campos Extra de la Cuenta",140,0));
   
// hasta aqui...       
 */      
        %><%=MyUtil.GeneraScripts()%><%
        rs2.close();
        rs4.close();

        rs.close();
        StrclExpediente = null;    
        StrSql = null; 
        StrclPaginaWeb=null;  
        StrclServicio=null;
        StrclSubservicio=null;
        StrCodEnt=null;
        StrdsGerencia = null; 
        StrFecAper = null;     
        StrclUsrApp=null;
        rs2=null;
        rs4=null;
        rs=null;
        
 %>
 
<input name='FechaMskH' id='FechaMskH' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F   VN09VN09F:::VN09VN09'>      
 
<script>
     document.all.ObsCulpaAjusta.maxLength=500; 
     document.all.ObsCulpaDicta.maxLength=500;   
     document.all.AvPrevia.maxLength=20;   
     document.all.RefAvPrevia.maxLength=60;   
     document.all.Causa.maxLength=20;   
     document.all.RefCausa.maxLength=60;  
     document.all.Toca.maxLength=20;   
     document.all.RefToca.maxLength=60;   
     document.all.Amparo.maxLength=20;   
     document.all.RefAmparo.maxLength=60;  
     document.all.Ajustador.maxLength=60;   
     
     function fnDesactiva(){
       if (document.all.clLugarContactoC.value==1 || document.all.clLugarContactoC.value==2 || document.all.clLugarContactoC.value==3 || document.all.clLugarContactoC.value==4 || document.all.clLugarContactoC.value==5){
        document.all.clContactoNU.value = "0"; 
        document.all.clContactoNUC.value = "";     
       }
     }
     
     function fnDesactivaC(){
       if (document.all.clContactoNUC.value==1 || document.all.clContactoNUC.value==2 ){
       document.all.clLugarContacto.value = "0"; 
       document.all.clLugarContactoC.value = "";     
       }
     }
     function fnValidaContacto(){
       if (document.all.clLugarContactoC.value=="" && document.all.clContactoNUC.value==""){
       msgVal=msgVal + " Falta Informar Contacto o Llamar N/U ";
       document.all.btnGuarda.disabled= false;
       document.all.btnCancela.disabled= false;
       }
     }
         
    function fnGNPInfo(){
        if  (document.all.clCuentaVTR.value=="113") {
            fnDivshow("AstAjustador");
            if (document.all.Ajustador.value=="") {document.all.Ajustador.value=document.all.NuestroUsuarioVTR.value;}
            if (document.all.ObsCulpaDicta.value==""){ document.all.ObsCulpaDicta.value="SD";}
            if (document.all.LugarAbogado.value==""){document.all.LugarAbogado.value="SD";}
            if (document.all.Folio.value==""){ document.all.Folio.value="SD";}
            if (document.all.AvPrevia.value==""){ document.all.AvPrevia.value="SD";}
            if (document.all.RefAvPrevia.value==""){ document.all.RefAvPrevia.value="SD";}
            }
        else { fnDivhide("AstAjustador");}    
      
        if (document.all.FechaBaja.value=="1900-01-01 00:00") {document.all.FechaBaja.value=""}
    }
    
    function fnGNPInfoObli(){
      if  (document.all.clCuentaVTR.value=="113") {
        if (document.all.Ajustador.value=="") msgVal=msgVal + ". Nombre del Ajustador. ";
        }      
    }
    
    function fnDivhide(i) {
        if (document.all) {
        var ourhelp = eval ("document.all."+ i)
        ourhelp.style.visibility="hidden";
        }
    }

    function fnDivshow(i) {
        if (document.all) {
        var ourhelp = eval ("document.all."+ i)
        ourhelp.style.visibility="visible";
        }
    }


    
</script>

</body>
</html>
