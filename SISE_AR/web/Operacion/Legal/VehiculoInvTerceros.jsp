<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
<head><title>Datos de Vehiculo Involucrado</title>
<link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
</head>
<body class="cssBody">
<%-- <jsp:useBean id="beanInstanceName" scope="session" class="beanPackagAL.BeanClassName" /> --%>
<%-- <jsp:getProperty name="beanInstanceName"  property="propertyName" /> --%>
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
<script src='../../Utilerias/Util.js' ></script>
<script src='../../Utilerias/UtilAuto.js' ></script>
<script src='../../Utilerias/UtilMask.js'></script>
<%  
    String StrclUsrApp="0";
    
    

    if (session.getAttribute("clUsrApp")!= null)
     {
       StrclUsrApp = session.getAttribute("clUsrApp").toString(); 
     }  

    if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) 
     { %>
       Fuera de Horario
       <%
       StrclUsrApp=null;
       return;  
     }    
    String StrclExpediente = "0";   
    String StrclVehiculo = "0";
    String StrclPaginaWeb="0";
    String StrFecha="";
    String StrFechaDetencion="";
    String StrFechaDetConduc="";
     
    if (session.getAttribute("clExpediente")!= null)
     {
       StrclExpediente = session.getAttribute("clExpediente").toString(); 
     }      

    if (request.getParameter("clVehiculo")!= null)
     {
       StrclVehiculo = request.getParameter("clVehiculo").toString(); 
     }      
     
    StringBuffer StrSql = new StringBuffer();
    
    StrSql.append("Select clExpediente From AsistenciaLegal Where clExpediente =").append(StrclExpediente); 
    
    ResultSet rs2 = UtileriasBDF.rsSQLNP( StrSql.toString());
    StrSql.delete(0,StrSql.length());
    
    if (rs2.next())  
     { 
     }   
    else
     { %>
          No existe Aistencia Legal, debe crearla primero!
          <%
          rs2.close();
          rs2=null;
          StrclExpediente = null;   
          StrclVehiculo = null;
          StrSql = null; 
          StrclPaginaWeb=null;
          StrFecha=null;
          StrFechaDetencion=null;
          StrFechaDetConduc=null;
          StrclUsrApp=null;
          return;      
     } 
     rs2.close();
    
    ResultSet rs4 = UtileriasBDF.rsSQLNP( "Select convert(varchar(16),getdate(),120) fechaEt");

    if (rs4.next()){
       StrFecha = rs4.getString("fechaEt");
    }
    rs4.close();
    
    StrSql.append("Select V.clVehiculo,coalesce(A.dsAseguradora,'') as dsAseguradora, coalesce(V.Conductor,'') as Conductor, coalesce(V.NoSiniestro,'') as NoSiniestro, ");
    StrSql.append(" coalesce(V.NoPoliza,'') as NoPoliza, coalesce(V.ClaveAMIS,'') as ClaveAMIS, coalesce(M.dsMarcaAuto,'') as dsMarcaAuto, coalesce(V.CodigoMarca,'') as CodigoMarca, ");
    StrSql.append(" coalesce(T.dsTipoAuto,'') as dsTipoAuto, coalesce(V.Modelo,'') as Modelo, coalesce(V.Placas,'') as Placas, ");
    StrSql.append(" coalesce(V.Color,'') as Color, coalesce(V.Serie,'') as Serie, coalesce(V.NoMotor,'') as NoMotor, ");
    StrSql.append(" coalesce(E.dsEstatusUnidad,'') as dsEstatusUnidad,  ");
    StrSql.append(" coalesce(convert(varchar(16), V.FechaDetencion,120),'') as FechaDetencion, ");
    StrSql.append(" V.clEstatusUnidad, ");
    StrSql.append(" coalesce(convert(varchar(16), V.FechaLibera,120),'') as FechaLibera, ");
    StrSql.append(" coalesce(TV.dsTipoVehiculo,'') as dsTipoVehiculo, ");
    StrSql.append(" coalesce(EP.dsEstatusPersona,'') as dsEstatusConduc,  ");
    StrSql.append(" coalesce(convert(varchar(16), V.FechaDetConduc,120),'') as FechaDetConduc, ");
    StrSql.append(" V.clEstatusConduc, ");
    StrSql.append(" coalesce(convert(varchar(16), V.FechaLibConduc,120),'') as FechaLibConduc ");
    StrSql.append(" From VehiculoInvTerc V ");
    StrSql.append(" left join cAseguradora A ON (A.clAseguradora = V.clAseguradora) ");
    StrSql.append(" left join cEstatusUnidad E ON (E.clEstatusUnidad = V.clEstatusUnidad) ");
    StrSql.append(" left join cEstatusPersona EP ON (EP.clEstatusPersona = V.clEstatusConduc) ");
    StrSql.append(" left join cMarcaAuto M ON (M.CodigoMarca = V.CodigoMarca) ");
    StrSql.append(" left join cTipoAuto T ON (T.CodigoMarca = V.CodigoMarca AND T.ClaveAMIS = V.ClaveAMIS) ");
    StrSql.append(" left join cTipoVehiculo TV ON (TV.clTipoVehiculo = V.clTipoVehiculo) ");
    StrSql.append(" Where V.clVehiculo =").append(StrclVehiculo);
    
         ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
         StrSql.delete(0,StrSql.length());
        %>
       <script>fnOpenLinks()</script>
       <%
       StrclPaginaWeb = "191";       
       MyUtil.InicializaParametrosC(191,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
 
       session.setAttribute("clPaginaWebP",StrclPaginaWeb); 
       %>
       <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccion","","fnAntesGuardar();")%>
     <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="VehiculoInvTerceros.jsp?'>"%>
       <%
       if (rs.next()) {                         
       %>
            <INPUT id='clVehiculo' name='clVehiculo' type='hidden' value='<%=rs.getString("clVehiculo")%>'>
            <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
            
            <%=MyUtil.ObjComboC("Marca", "CodigoMarca", rs.getString("dsMarcaAuto"),true,true,30,80,"","Select CodigoMarca, dsMarcaAuto From cMarcaAuto Order by dsMarcaAuto","fnLlenaAMIS()","",60,true,true)%>
            <%=MyUtil.ObjComboC("Tipo de Auto", "ClaveAMIS",rs.getString("dsTipoAuto"),true,true,250,80,"","Select ClaveAMIS, dsTipoAuto From cTipoAuto Where CodigoMarca='" + rs.getString("CodigoMarca") + "' Order by dsTipoAuto","fnActualizaAMIS()","",100,true,true)%>
            <%=MyUtil.ObjInput("Clave AMIS","ClaveAMISVTR",rs.getString("ClaveAMIS"), false,false,30,120,"",false,false,15)%>
            <%=MyUtil.ObjInput("Año","Modelo",rs.getString("Modelo"),true,true,140,120,"",false,false,4)%>
            <%=MyUtil.ObjInput("Placas","Placas",rs.getString("Placas"),true,true,250,120,"",false,false,8)%>
            <%=MyUtil.ObjInput("Color","Color",rs.getString("Color"),true,true,400,120,"",false,false,17)%>
            <%=MyUtil.ObjComboC("Tipo de Vehiculo","clTipoVehiculo",rs.getString("dsTipoVehiculo"),true,true,30,160,"","Select clTipoVehiculo, dsTipoVehiculo From cTipoVehiculo ","","",25,true,true)%>
            <%=MyUtil.ObjInput("Serie","Serie",rs.getString("Serie"),true,true,250,160,"",false,false,25)%>
            <%=MyUtil.ObjInput("No. Motor","NoMotor",rs.getString("NoMotor"),true,true,400,160,"",false,false,25)%>
            <%=MyUtil.ObjComboC("Estatus de la Unidad","clEstatusUnidad",rs.getString("dsEstatusUnidad"),true,true,30,210,"","Select clEstatusUnidad, dsEstatusUnidad From cEstatusUnidad","","",60,true,true)%>
            <%
            StrFechaDetencion =rs.getString("FechaDetencion");
                if (StrFechaDetencion==null){
                        StrFechaDetencion = "";
                   }
            %>
         <%=MyUtil.ObjInput("Fecha de Detención<br>(aaaa/mm/dd hh:mm)","FechaDetencion",StrFechaDetencion,true,true,250,200,"",false,false,25,"if(this.readOnly==false){fnValMask(this,document.all.FechaDetencionMsk.value,this.name)}")%>
         <%=MyUtil.ObjInput("Fecha de Liberación<br>(AAAA/MM/DD HH:MM)","FechaLibera",rs.getString("FechaLibera"),true,true,400,200,"",false,false,25,"if(this.readOnly==false){fnValMask(this,document.all.FechaLiberaMsk.value,this.name)}")%>
         <%=MyUtil.DoBlock("Auto Involucrado de Tercero",-10,0)%>
            
            <%=MyUtil.ObjInput("Nombre del Conductor","Conductor",rs.getString("Conductor"),true,true,30,300,"", true,true,55)%>
            <%=MyUtil.ObjComboC("Estatus del Conductor ","clEstatusConduc",rs.getString("dsEstatusConduc"),true,true,350,300,"","Select clEstatusPersona, dsEstatusPersona From cEstatusPersona ","","",25,true,true)%>
            <%
              StrFechaDetConduc =rs.getString("FechaDetConduc");
                if (StrFechaDetConduc==null){
                        StrFechaDetConduc = "";
                    }
         %>
        <%=MyUtil.ObjInput("Fecha de Detención<br>(aaaa/mm/dd hh:mm)","FechaDetConduc",StrFechaDetConduc,true,true,30,340,"",false,false,25,"if(this.readOnly==false){fnValMask(this,document.all.FechaDetencionMsk.value,this.name)}")%>

            <%=MyUtil.ObjInput("Fecha de Liberación<br>(AAAA/MM/DD HH:MM)","FechaLibConduc",rs.getString("FechaLibConduc"),true,true,180,340,"",false,false,25,"if(this.readOnly==false){fnValMask(this,document.all.FechaLiberaMsk.value,this.name)}")%>
            <%=MyUtil.DoBlock("Datos del Conductor",40,0)%>

            <%=MyUtil.ObjComboC("Aseguradora","clAseguradora",rs.getString("dsAseguradora"),true,true,30,440,"","Select clAseguradora, dsAseguradora From cAseguradora ","","",50,true,true)%>
            <%=MyUtil.ObjInput("Número de Siniestro","NoSiniestro",rs.getString("NoSiniestro"),true,true,400,440,"", false,false,25)%>
            <%=MyUtil.ObjInput("Número de Póliza","NoPoliza",rs.getString("NoPoliza"),true,true,550,440,"",false,false,25)%>
            <%=MyUtil.DoBlock("Datos del Seguro",-10,0)%>
            <%
       }
       else {
            %>
            <script>document.all.btnCambio.disabled=true;</script>
            <INPUT id='clVehiculo' name='clVehiculo' type='hidden' value='0'>
            <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
            <INPUT id='fechaEt' name='fechaEt' type='hidden' value='<%=StrFecha%>'>

            <%=MyUtil.ObjComboC("Marca", "CodigoMarca", "",true,true,30,80,"","Select CodigoMarca, dsMarcaAuto From cMarcaAuto Order by dsMarcaAuto","fnLlenaAMIS()","",60,true,true)%>
            <%=MyUtil.ObjComboC("Tipo de Auto", "ClaveAMIS","",true,true,250,80,"","Select ClaveAMIS, dsTipoAuto From cTipoAuto Where CodigoMarca='0' Order by dsTipoAuto","fnActualizaAMIS()","",100,true,true)%>
            <%=MyUtil.ObjInput("Clave AMIS","ClaveAMISVTR","", false,false,30,120,"",false,false,15)%>
            <%=MyUtil.ObjInput("Año","Modelo","",true,true,140,120,"",false,false,4)%>
            <%=MyUtil.ObjInput("Placas","Placas","",true,true,250,120,"",false,false,8)%>
            <%=MyUtil.ObjInput("Color","Color","",true,true,400,120,"",false,false,17)%>
            <%=MyUtil.ObjComboC("Tipo de Vehiculo","clTipoVehiculo","",true,true,30,160,"","Select clTipoVehiculo, dsTipoVehiculo From cTipoVehiculo ","","",25,true,true)%>
            <%=MyUtil.ObjInput("Serie","Serie","",true,true,250,160,"",false,false,25)%>
            <%=MyUtil.ObjInput("No. Motor","NoMotor","",true,true,400,160,"",false,false,25)%>
            <%=MyUtil.ObjComboC("Estatus de la Unidad","clEstatusUnidad","",true,true,30,210,"","Select clEstatusUnidad, dsEstatusUnidad From cEstatusUnidad","fnEstatus()","",60,true,true)%>
            <%=MyUtil.ObjInput("Fecha de Detención<br>(AAAA/MM/DD HH:MM)","FechaDetencion","",true,true,250,200,"",false,false,25,"if(this.readOnly==false){fnValMask(this,document.all.FechaDetencionMsk.value,this.name)}")%>
            <%=MyUtil.ObjInput("Fecha de Liberación<br>(AAAA/MM/DD HH:MM)","FechaLibera","",true,true,400,200,"",false,false,25,"if(this.readOnly==false){fnValMask(this,document.all.FechaLiberaMsk.value,this.name)}")%>
            <%=MyUtil.DoBlock("Auto Involucrado de Tercero",-10,0)%>
            
            <%=MyUtil.ObjInput("Nombre del Conductor","Conductor","",true,true,30,300,"", true,true,55)%>
            <%=MyUtil.ObjComboC("Estatus del Conductor ","clEstatusConduc","",true,true,350,300,"","Select clEstatusPersona, dsEstatusPersona From cEstatusPersona ","fnEstatusCond()","",25,true,true)%>
            <%=MyUtil.ObjInput("Fecha de Detención<br>(AAAA/MM/DD HH:MM)","FechaDetConduc","",true,true,30,340,"",false,false,25,"if(this.readOnly==false){fnValMask(this,document.all.FechaDetencionMsk.value,this.name)}")%>
            <%=MyUtil.ObjInput("Fecha de Liberación<br>(AAAA/MM/DD HH:MM)","FechaLibConduc","",true,true,180,340,"",false,false,25,"if(this.readOnly==false){fnValMask(this,document.all.FechaLiberaMsk.value,this.name)}")%>
            <%=MyUtil.DoBlock("Datos del Conductor",40,0)%>

            <%=MyUtil.ObjComboC("Aseguradora","clAseguradora","",true,true,30,440,"","Select clAseguradora, dsAseguradora From cAseguradora ","","",50,true,true)%>
            <%=MyUtil.ObjInput("Número de Siniestro","NoSiniestro","",true,true,400,440,"", false,false,25)%>
            <%=MyUtil.ObjInput("Número de Póliza","NoPoliza","",true,true,550,440,"",false,false,25)%>
            <%=MyUtil.DoBlock("Datos del Seguro",-10,0)%>
            <%
       }   
        rs.close();
        rs=null;
        StrclExpediente = null;   
        StrclVehiculo = null;
        StrSql = null; 
        StrclPaginaWeb=null;
        StrFecha=null;
        StrFechaDetencion=null;
        StrFechaDetConduc=null;
        StrclUsrApp=null;
        
 %>
        <%=MyUtil.GeneraScripts()%>
<input name='FechaDetencionMsk' id='FechaDetencionMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
<input name='FechaLiberaMsk' id='FechaLiberaMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
 <script>
     document.all.Conductor.maxLength=100; 
     document.all.NoSiniestro.maxLength=30;   
     document.all.NoPoliza.maxLength=15;   
     document.all.Modelo.maxLength=4;   
     document.all.Placas.maxLength=8;   
     document.all.Color.maxLength=20;  
     document.all.Serie.maxLength=20;   
     document.all.NoMotor.maxLength=20;   
 
function fnEstatus()
     { 
       // Estatus de la Unidad Detenido
       if (document.all.clEstatusUnidad.value == 2)  
       {
            document.all.FechaDetencion.value = document.all.fechaEt.value;  // Fecha de sql 
       }  
       else
       {
          
       }  
     } 
     
     
     function fnEstatusCond()
     { 
       // Estatus de la Unidad Detenido
       if (document.all.clEstatusConduc.value == 2)  
       {
            document.all.FechaDetConduc.value = document.all.fechaEt.value;  // Fecha de sql 
       }  
       else
       {
          
       }  
     } 
     
    function fnAntesGuardar()
     {
      if (document.all.clEstatusConduc.value == 2)  
       {
            if(document.all.FechaDetConduc.value==""){
            msgVal=msgVal + " Fecha de Detención del Conductor ";
            }
       }else{
            if(document.all.clEstatusConduc.value == 5 &&  document.all.FechaDetConduc.value!="" && document.all.FechaLibConduc.value==""){
                    msgVal=msgVal + " Fecha de Liberacion del Conductor ";
           /*     if(document.all.FechaLibConduc.value==""){
                msgVal=msgVal + " Fecha de Liberacion del Conductor ";
                }
                if(document.all.FechaDetConduc.value==""){
                    msgVal=msgVal + " Fecha de Detención del Conductor ";
                }*/
            }
        
        }
       
      if (document.all.clEstatusUnidad.value == 2)  
        {
           if(document.all.FechaDetencion.value==""){
            msgVal=msgVal + " Fecha de Detención del Vehículo ";
            }  
         }else{
            if(document.all.clEstatusUnidad.value == 1 &&  document.all.FechaDetencion.value!="" && document.all.FechaLibera.value==""){
                    msgVal=msgVal + " Fecha de Liberacion del Vehículo ";
            /*   if(document.all.FechaLibera.value==""){
                msgVal=msgVal + " Fecha de Liberacion del Vehículo ";
                }
                 if(document.all.FechaDetencion.value==""){
                msgVal=msgVal + " Fecha de Detencion del Vehículo ";
                }*/
            }
        
        }
      if (document.all.FechaDetConduc.value!="" && document.all.FechaLibConduc.value!=""){
            if(document.all.FechaLibConduc.value <= document.all.FechaDetConduc.value){
            msgVal=msgVal + " La Fecha de Liberacion del Conductor debe ser mayor a la de Detencion ";
            }
      }
      if (document.all.FechaDetencion.value!="" && document.all.FechaLibera.value!=""){
            if(document.all.FechaLibera.value <= document.all.FechaDetencion.value){
            msgVal=msgVal + " La Fecha de Liberacion del Vehículo debe ser mayor a la de Detencion ";
            }
      }
      if (document.all.FechaDetConduc.value=="" && document.all.FechaLibConduc.value!="" && document.all.clEstatusConduc.value == 5){
            msgVal=msgVal + " Fecha de Detencion del Conductor ";
      }
      if (document.all.FechaDetencion.value=="" && document.all.FechaLibera.value!="" && document.all.clEstatusUnidad.value == 1){
            msgVal=msgVal + " Fecha de Detencion del Vehículo ";
      }

      if (document.all.clEstatusConduc.value == 2){
            document.all.FechaLibConduc.value="";
      }
      if (document.all.clEstatusUnidad.value == 2){
            document.all.FechaLibera.value="";
      }

      
    }     
</script>
</body>
</html>