<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
<head><title>JSP Page</title>
<link href="../../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
</head>
<body class="cssBody">


<jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj"/>

<script src='../../../Utilerias/Util.js' ></script>
<script src='../../../Utilerias/UtilServicio.js' ></script>

<%  

    String StrclExpediente = "0";
    String StrclUsrApp="0";

    

    if (session.getAttribute("clUsrApp")!= null)
     {
       StrclUsrApp = session.getAttribute("clUsrApp").toString(); 
     }  
    
 
    if (request.getParameter("clExpediente")!= null)
    {
        StrclExpediente= request.getParameter("clExpediente").toString(); 
    }  
    else{
        if (session.getAttribute("clExpediente")!= null)
        {
            StrclExpediente= session.getAttribute("clExpediente").toString(); 
        }  
    } 

    
    if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) 
     {
       %>Fuera de Horario<%  return; 
     }     
    
 

    StringBuffer StrSql = new StringBuffer ();
    
    StrSql.append(" select top 1  V.clExpediente,coalesce(V.NoSiniestro,'')NoSiniestro,convert(varchar(16),E.FechaRegistro,21)FechaRegistro , ");
    StrSql.append(" coalesce(A.Ajustador,'')Ajustador,A.SiniestroRelevante,coalesce(A.FolioVolantejur,'')FolioVolantejur, ");
    StrSql.append(" P.NombreOpe,cast(V.DescDanosVh as varchar (800))'DanosVNU',coalesce( V.DanoAjustaNU,0)DanoAjustaNU, ");
    StrSql.append(" coalesce(V.DanoDictamenNU,0)DanoDictamenNU,ES.dsEstatusPersona,EU.dsEstatusUnidad,  ");
    StrSql.append(" (select count(P1.clTipoPersona)from PersonaInvolucrada P1 where P1.clTipoPersona =3 and P1.clexpediente=V.clexpediente )'NoOcupantes',  ");
    StrSql.append(" coalesce((select max(case when PV.clestatuspersona in(1,4,6) then 1 else 0 end)  ");
    StrSql.append(" from PersonaInvolucrada PV where  PV.clexpediente =V.clexpediente and PV.cltipopersona=3  ");
    StrSql.append(" group by PV.clexpediente),'')'LO' ,I.Conductor,I.Modelo,I.Color,I.Placas,M.dsMarcaAuto,T.dsTipoAuto,coalesce(I.Serie,'')Serie, ");
    StrSql.append(" ET.dsEstatusUnidad,coalesce( V.DanoAjustaCP,0)DanoAjustaCP, cast(I.DescDanosVh as varchar (800))'DanosVCP', ");
    StrSql.append(" (select count(P1.clTipoPersona)from PersonaInvolucrada P1 where P1.clTipoPersona =2 and P1.clexpediente=V.clexpediente )'NoTerceros', ");
    StrSql.append(" coalesce(C.dsTipoCulpa,'')'Culpa' ");

    StrSql.append(" from vehiculoInvNu V  ");
    StrSql.append(" inner join AsistenciaLegal A on (V.clExpediente=A.clExpediente)  ");
    StrSql.append(" inner join Expediente E on (V.clExpediente=E.clExpediente)  ");
    StrSql.append(" inner join proveedorxexpediente PE on (V.clexpediente=PE.clexpediente and Titular=1)  ");
    StrSql.append(" inner join cProveedor P on (PE.clproveedor=P.clproveedor)  ");
    StrSql.append(" inner join cEstatusPersona ES on (V.clEstatusConduc=ES.clEstatusPersona)  ");
    StrSql.append(" inner join cEstatusUnidad EU on (V.clEstatusUnidad=EU.clEstatusUnidad)  ");
    StrSql.append(" inner join PersonaInvolucrada PIN on (V.clExpediente=PIN.clExpediente)  ");
    StrSql.append(" left join VehiculoInvTerc I  on (V.clexpediente = I.clexpediente)  ");
    StrSql.append(" left join cMarcaAuto M on (I.CodigoMarca=M.CodigoMarca) ");
    StrSql.append(" left join cTipoAuto T on (I.CodigoMarca=T.CodigoMarca and I.ClaveAMIS=T.ClaveAMIS) ");
    StrSql.append(" left join cEstatusUnidad ET on (I.clEstatusUnidad=ET.clEstatusUnidad) ");
    StrSql.append(" left join cTipoCulpa C on (A.clCulpaAjusta=C.clCulpa) ");
    StrSql.append(" where V.clexpediente = ").append(StrclExpediente);

    StrSql.append(" group by V.clExpediente,V.NoSiniestro,E.FechaRegistro,A.Ajustador,P.NombreOpe, V.DanoAjustaNU,V.DanoDictamenNU,ES.dsEstatusPersona,  ");
    StrSql.append(" EU.dsEstatusUnidad ,I.Conductor,I.Modelo,I.Color,I.Placas,M.dsMarcaAuto,T.dsTipoAuto,I.Serie,ET.dsEstatusUnidad,V.DanoAjustaCP,C.dsTipoCulpa, ");
    StrSql.append(" A.SiniestroRelevante,A.FolioVolantejur,cast(V.DescDanosVh as varchar (800)),cast(I.DescDanosVh as varchar (800)) ");
        
      ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
      StrSql.delete(0,StrSql.length());
    
       String StrclPaginaWeb = "578";
       session.setAttribute("clPaginaWebP",StrclPaginaWeb);
       %><SCRIPT>fnOpenLinks()</script><%


       MyUtil.InicializaParametrosC(578,Integer.parseInt(StrclUsrApp)); 
       %>
       <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="VolanteJuridico.jsp?'>"%><%   
              
       
       if (rs.next()) {
           
            %>
                                    
            <%=MyUtil.ObjInput("Expediente","ExpedienteVTR",rs.getString("clExpediente"),false,false,30,100,"",false,false,10)%>
            <%=MyUtil.ObjInput("Siniestro","NoSiniestro",rs.getString("NoSiniestro"),false,false,120,100,"",false,false,25)%>
            <%=MyUtil.ObjInput("Fecha Registro","FechaRegistro",rs.getString("FechaRegistro"),false,false,300,100,"",false,false,19)%>
            <%=MyUtil.ObjInput("Ajustador","Ajustador",rs.getString("Ajustador"),false,false,30,140,"",false,false,43)%>
            <%=MyUtil.ObjInput("*Turnado a:","Turnado","",false,false,300,140,"",false,false,45)%>
            <%=MyUtil.DoBlock("Informacion general",70,0)%>
            
            <%=MyUtil.ObjChkBox("Siniestro Relevante","SiniestroRelevante",rs.getString("SiniestroRelevante"), true,true,30,230,"0","")%>
            <%=MyUtil.ObjInput("Folio Volante Jurídico","FolioVolantejur",rs.getString("FolioVolantejur"),false,false,300,235,"",false,false,10)%>
            <%=MyUtil.ObjInput("Proveedor","NombreOpe",rs.getString("NombreOpe"),false,false,30,275,"",false,false,45)%>
            <%=MyUtil.ObjInput("*Supervisor","Supervisor","",false,false,300,275,"",false,false,45)%>
            <%=MyUtil.ObjTextArea("Daños Vehiculo Asegurado","DanosVNU",rs.getString("DanosVNU"),"90","5",true,true,30,315,"",true,true)%>
            <%=MyUtil.ObjInput("Estimado Daños V. Asegurado","Estimado",rs.getString("DanoAjustaNU"),false,false,30,400,"",false,false,15)%>
            <%=MyUtil.ObjInput("Conductor Lesionado/Occiso","Lesionado",rs.getString("dsEstatusPersona"),false,false,300,400,"",false,false,15)%>
            <%=MyUtil.ObjChkBox("*Conductor Detenido","CondDetenido","", true,true,30,450,"0","")%>
            <%=MyUtil.ObjInput("Vehiculo Asegurado Detenido","dsEstatusUnidad",rs.getString("dsEstatusUnidad"),false,false,300,440,"",false,false,15)%>
            <%=MyUtil.ObjChkBox("Ocup. Lesionados/Occisos","Ocupantes",rs.getString("LO"), true,true,30,480,"0","")%>
            <%=MyUtil.ObjInput("No. Ocupantes","NoOcupantes",rs.getString("NoOcupantes"),false,false,300,480,"",false,false,15)%>                       
            <%=MyUtil.DoBlock("Datos del Volante Jurídico",70,0)%>
            
            <%=MyUtil.ObjInput("Conductor","Conductor",rs.getString("Conductor"),false,false,30,570,"",false,false,35)%>
            <%=MyUtil.ObjInput("Modelo","Modelo",rs.getString("Modelo"),false,false,260,570,"",false,false,6)%>
            <%=MyUtil.ObjInput("Color","Color",rs.getString("Color"),false,false,330,570,"",false,false,10)%>
            <%=MyUtil.ObjInput("Placas","Placas",rs.getString("Placas"),false,false,470,570,"",false,false,10)%>
            <%=MyUtil.ObjInput("Marca","dsMarcaAuto",rs.getString("dsMarcaAuto"),false,false,30,610,"",false,false,35)%>
            <%=MyUtil.ObjInput("Tipo Auto","dsTipoAuto",rs.getString("dsTipoAuto"),false,false,260,610,"",false,false,35)%>
            <%=MyUtil.ObjInput("Serie","Serie",rs.getString("Serie"),false,false,470,610,"",false,false,10)%>
            <%=MyUtil.ObjInput("Vehiculo Tercero Detenido","dsEstatusUnidad",rs.getString("dsEstatusUnidad"),false,false,30,650,"",false,false,15)%>
            <%=MyUtil.ObjInput("Estimado Daños V. Tercero","DanoAjustaCP",rs.getString("DanoAjustaCP"),false,false,260,650,"",false,false,15)%>
            <%=MyUtil.ObjTextArea("Daños Vehiculo Tercero","DanosVCP",rs.getString("DanosVCP"),"90","5",true,true,30,690,"",true,true)%>
            <%=MyUtil.ObjInput("No. Terceros","NoTerceros",rs.getString("NoTerceros"),false,false,30,775,"",false,false,15)%>
            <%=MyUtil.ObjInput("Responsabilidad","Culpa",rs.getString("Culpa"),false,false,30,815,"",false,false,15)%>
            <%=MyUtil.DoBlock("Datos Vehículo Terceros",-100,0)%>
            
            
            <%
               session.setAttribute("clExpediente",StrclExpediente);
        }
       else {
            %> El Expediente no Tiene Volante Juridico 
            

<% 
            
        }                     
       %>

              
       <%=MyUtil.GeneraScripts()%><%
       
       rs.close();
       rs=null;
       StrSql=null;
            
       StrclExpediente = null;
       StrclUsrApp=null;

        
%> 

<script>        
</script>

</body>
</html>

