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

    
    
   StrSql.append("  select  V.clExpediente,coalesce(V.NoSiniestro,'')NoSiniestro,convert(varchar(16),E.FechaRegistro,21)FechaRegistro, "); 
   StrSql.append(" coalesce(p.NombreOpe,'') Abogado,'Pendiente' TurnadoA,  coalesce(tc.dsTipoCulpa,'') ResultadoP,FechaResultDict 'FechaDictamen', ");
   StrSql.append(" AceptaResponsabilidad,'Pendiente' HayArregloTerc,coalesce(F.Monto,0) 'MontoF',coalesce(C.Monto,0) 'MontoC',coalesce(ObsCulpaDicta,'') 'Informe', ");
   StrSql.append(" FechaConsignacion,Causa,MotivoConsigna  ");
   StrSql.append(" from vehiculoInvNu V   ");
   StrSql.append(" inner join AsistenciaLegal A on (V.clExpediente=A.clExpediente)   ");
   StrSql.append(" inner join Expediente E on (V.clExpediente=E.clExpediente)  ");
   StrSql.append(" left join ProveedorxExpediente pe on(pe.clexpediente=e.clexpediente and Titular=1)  ");
   StrSql.append(" left join cProveedor p on(pe.clproveedor=p.clproveedor)  ");
   StrSql.append(" left join (select clexpediente,sum(MontoFianza) 'Monto' from Fianza group by clexpediente) F on (V.clexpediente=F.clexpediente)  ");
   StrSql.append(" left join (select clexpediente,sum(MontoObProc + MontoSusAct + MontoRepDan + MontoSanPec) 'Monto'  from Caucion group by clexpediente) C on (V.clexpediente=C.clexpediente)  ");
   StrSql.append(" left join cTipoCulpa tc on(tc.clCulpa=A.clCulpaDicta)  ");
   StrSql.append(" where V.clexpediente = ").append(StrclExpediente);

        
      ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
      StrSql.delete(0,StrSql.length());
    
       String StrclPaginaWeb = "579";
       session.setAttribute("clPaginaWebP",StrclPaginaWeb);
       %><SCRIPT>fnOpenLinks()</script><%


       MyUtil.InicializaParametrosC(579,Integer.parseInt(StrclUsrApp)); 
       %><%=MyUtil.doMenuAct("../../../servlet/Utilerias.EjecutaAccion","")%>
       <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="AveriguacionPrevia.jsp?'>"%><%   
              
          

          
       
       
       if (rs.next()) {
           
            %>
           <a class='R2TablePlasma'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RESOLUCION DE LA AVERIGUACION PREVIA</a>                        
            <%=MyUtil.ObjInput("Expediente","ExpedienteVTR",rs.getString("clExpediente"),false,false,30,100,"",false,false,10)%>
            <%=MyUtil.ObjInput("Siniestro","NoSiniestro",rs.getString("NoSiniestro"),false,false,120,100,"",false,false,25)%>
            <%=MyUtil.ObjInput("Fecha Registro","FechaRegistro",rs.getString("FechaRegistro"),false,false,300,100,"",false,false,19)%>
            <%=MyUtil.ObjInput("Abogado","Abogado",rs.getString("Abogado"),false,false,30,140,"",false,false,43)%>
            <%=MyUtil.ObjInput("*Turnado a:","Turnado","",false,false,300,140,"",false,false,45)%>
            <%=MyUtil.DoBlock("Informacion General",70,0)%> 

            <%=MyUtil.ObjTextArea("Resultado Pericial","ResultadoP",rs.getString("ResultadoP"),"90","4",true,true,30,230,"",true,true)%>
            <%=MyUtil.ObjInput("Fecha del resultado","FechaDictamen",rs.getString("FechaDictamen"),false,false,30,310,"",false,false,19)%>
            <%=MyUtil.DoBlock("Datos de la Resoluación de la Averiguación Previa",350,0)%>  

            <%=MyUtil.ObjChkBox("NA","NA","0", true,true,30,400,"0","")%>
            <%=MyUtil.ObjChkBox("Acepta Responsabilidad","ARNA","0", true,true,150,410,"0","SI","NO","")%>
            <%=MyUtil.ObjChkBox("Hay Arreglo con el Tercero","ArrTerc","0", true,true,350,410,"0","SI","NO","")%>
            <%=MyUtil.ObjChkBox("Fianza","Fi","0", true,true,150,450,"0","SI","NO","")%>
            <%=MyUtil.ObjInput("Monto","Fianza",rs.getString("MontoF"),false,false,230,455,"",false,false,19)%>
            <%=MyUtil.ObjChkBox("Caucion","Ca","0", true,true,350,450,"0","SI","NO","")%>
            <%=MyUtil.ObjInput("Monto","Caucion",rs.getString("MontoC"),false,false,430,455,"",false,false,19)%>

            <%=MyUtil.ObjChkBox("Tercero","Tercero","0", true,true,30,500,"0","")%>
            <%=MyUtil.ObjChkBox("Acepta Responsabilidad","ARTercero","0", true,true,150,510,"0","SI","NO","")%>

            <%=MyUtil.ObjChkBox("NA y Tercero","NATercero","0", true,true,30,560,"0","")%>
            <%=MyUtil.ObjChkBox("Acepta Responsabilidad","ARNA","0", true,true,150,570,"0","SI","NO","")%>
            <%=MyUtil.ObjChkBox("Fianza","Fi","0", true,true,150,610,"0","SI","NO","")%>
            <%=MyUtil.ObjInput("Monto","Fianza","",false,false,230,615,"",false,false,19)%>
            <%=MyUtil.ObjChkBox("Caucion","Ca","0", true,true,350,610,"0","SI","NO","")%>
            <%=MyUtil.ObjInput("Monto","Caucion","",false,false,430,615,"",false,false,19)%>
            
            <%=MyUtil.ObjChkBox("No existe  técnica para  determinar responsabilidad","Noexiste","0", true,true,30,650,"0","")%>
            <%=MyUtil.ObjTextArea("Informe","Informe",rs.getString("Informe"),"90","4",true,true,100,680,"",true,true)%>
            
            <%=MyUtil.ObjChkBox("No Ejercicio Provicional","Noejerc","0", true,true,30,760,"0","")%>
            <%=MyUtil.DoBlock("Responsable Resultado",0,0)%>  
            
            <%=MyUtil.ObjInput("Fecha de Consignación a  Juzgado","FechaConsignacion",rs.getString("FechaConsignacion"),false,false,30,840,"",false,false,19)%>
            <%=MyUtil.ObjInput("Número de Causa Penal","Causa",rs.getString("Causa"),false,false,250,840,"",false,false,19)%>
            <%=MyUtil.ObjTextArea("Motivos de Consignación","MotivoConsigna",rs.getString("MotivoConsigna"),"90","4",true,true,30,880,"",true,true)%>

            <%=MyUtil.DoBlock("Consignación a Juzgado",100,50)%>  
            

            
<%
               session.setAttribute("clExpediente",StrclExpediente);
        }
       else {
            %> El Expediente no Tiene Resolución de Averiguación Previa 
            

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


