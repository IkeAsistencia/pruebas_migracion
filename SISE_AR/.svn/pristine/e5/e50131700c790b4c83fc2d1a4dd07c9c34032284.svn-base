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
    
    StrSql.append(" select  V.clExpediente,coalesce(V.NoSiniestro,'')NoSiniestro,convert(varchar(16),E.FechaRegistro,21)FechaRegistro , ");
    StrSql.append(" coalesce(A.Ajustador,'')Ajustador, coalesce(V.DanoAjustaNU,'')DanoAjustaNU, ");
    StrSql.append(" EU.dsEstatusUnidad,coalesce(convert(varchar(16),V.FechaLibera,20),'')FechaLibera, ");
    StrSql.append(" coalesce(V.MotivoNoLiberacion,'')MotivoNoLib,convert(varchar(16),FechaConsignacion,21)FechaConsignacion, ");
    StrSql.append(" coalesce(A.Causa,'')Causa, coalesce(MotivoConsigna,'')MotivoConsigna, ");
    StrSql.append(" coalesce(A.ObsTermino,'') 'Informe' ");

    StrSql.append(" from vehiculoInvNu V  ");
    StrSql.append(" inner join AsistenciaLegal A on (V.clExpediente=A.clExpediente)  ");
    StrSql.append(" inner join Expediente E on (V.clExpediente=E.clExpediente) ");
    StrSql.append(" inner join cEstatusUnidad EU on (V.clEstatusUnidad=EU.clEstatusUnidad) ");

    StrSql.append(" where V.clexpediente = ").append(StrclExpediente);
    
        
      ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
      StrSql.delete(0,StrSql.length());
         
    
       String StrclPaginaWeb = "583";
       session.setAttribute("clPaginaWebP",StrclPaginaWeb);
       %><SCRIPT>fnOpenLinks()</script><%


       MyUtil.InicializaParametrosC(583,Integer.parseInt(StrclUsrApp)); 
       %>
       <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="PagoRecuperacion.jsp?'>"%><%   
              
       
       if (rs.next()) {
           
            %>
                                    
            <%=MyUtil.ObjInput("Expediente","ExpedienteVTR",rs.getString("clExpediente"),false,false,30,100,"",false,false,10)%>
            <%=MyUtil.ObjInput("Siniestro","NoSiniestro",rs.getString("NoSiniestro"),false,false,120,100,"",false,false,25)%>
            <%=MyUtil.ObjInput("Fecha Registro","FechaRegistro",rs.getString("FechaRegistro"),false,false,300,100,"",false,false,19)%>
            <%=MyUtil.ObjInput("Ajustador","Ajustador",rs.getString("Ajustador"),false,false,30,140,"",false,false,43)%>
            <%=MyUtil.ObjInput("*Turnado a:","Turnado","",false,false,300,140,"",false,false,45)%>
            <%=MyUtil.DoBlock("Pago y Recuperación",70,0)%> 
            
            <%=MyUtil.ObjInput("Estimado Daños V. Asegurado","Estimado",rs.getString("DanoAjustaNU"),false,false,30,230,"",false,false,15)%>
            <%=MyUtil.DoBlock("Datos de Pago y Recuperación",340,0)%>
            
            <%=MyUtil.ObjInput("Vehiculo Asegurado Detenido:","dsEstatusUnidad",rs.getString("dsEstatusUnidad"),false,false,30,320,"",false,false,15)%>            
            <%=MyUtil.ObjInput("Fecha Liberacion","FechaLibera",rs.getString("FechaLibera"),false,false,300,320,"",false,false,19)%>
            <%=MyUtil.ObjTextArea("Motivo No Liberacion.","MotivoNoLiberacion",rs.getString("MotivoNoLib"),"90","5",true,true,30,360,"",true,true)%>
            <%=MyUtil.ObjChkBox("*Delitos que se siguen de Oficio ","DelitoOf","", true,true,30,450,"0","")%>
            <%=MyUtil.ObjTextArea("Cuales","Cuales","","42","3",true,true,300,450,"",true,true)%>            
            <%=MyUtil.ObjInput("Fecha Consignación a Juzgado","FechaConsignacion",rs.getString("FechaConsignacion"),false,false,30,515,"",false,false,19)%>
            <%=MyUtil.ObjInput("Numero de Causa Penal","Causa",rs.getString("Causa"),false,false,300,515,"",false,false,19)%>
            <%=MyUtil.ObjTextArea("Motivo Consignación","MotivoConsigna",rs.getString("MotivoConsigna"),"90","5",true,true,30,555,"",true,true)%>
            <%=MyUtil.ObjTextArea("Informe de Terminación del Caso","Informe",rs.getString("Informe"),"90","5",true,true,30,645,"",true,true)%>
            <%=MyUtil.ObjInput("*Fecha Terminación","FechaConcluye","",false,false,30,735,"",false,false,19)%>
            
            <%=MyUtil.DoBlock("Terminacion o Continuación del Proceso",70,0)%> 
                                              
            
            <%
               session.setAttribute("clExpediente",StrclExpediente);
        }
       else {
            %> El Expediente no Tiene Pago y Recuperacion 
            

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


