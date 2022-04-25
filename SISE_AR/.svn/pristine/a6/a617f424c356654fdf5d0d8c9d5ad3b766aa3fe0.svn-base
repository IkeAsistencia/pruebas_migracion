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
    
    StrSql.append(" select  V.clExpediente,coalesce(V.NoSiniestro,'')NoSiniestro, ");
    StrSql.append(" convert(varchar(16),E.FechaRegistro,21)FechaRegistro , ");
    StrSql.append(" coalesce(A.Ajustador,'')Ajustador, ");
    StrSql.append(" coalesce(I.QueHice,'')QueHice, ");
    StrSql.append(" coalesce(A.ObsTermino,'') 'Informe' ");

    StrSql.append(" from vehiculoInvNu V  ");
    StrSql.append(" inner join AsistenciaLegal A on (V.clExpediente=A.clExpediente)  "); 
    StrSql.append(" inner join Expediente E on (V.clExpediente=E.clExpediente) ");
    StrSql.append(" left join Intervencion I on (E.clUltimaInterv=I.clIntervencion) ");

    StrSql.append(" where V.clexpediente = ").append(StrclExpediente);
    
        
      ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
      StrSql.delete(0,StrSql.length());
         
    
       String StrclPaginaWeb = "587";
       session.setAttribute("clPaginaWebP",StrclPaginaWeb);
       %><SCRIPT>fnOpenLinks()</script><%


       MyUtil.InicializaParametrosC(587,Integer.parseInt(StrclUsrApp)); 
       %>
       <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="ProcesoCivil.jsp?'>"%><%   
              
       
       if (rs.next()) {
           
            %>
                                    
            <%=MyUtil.ObjInput("Expediente","ExpedienteVTR",rs.getString("clExpediente"),false,false,30,100,"",false,false,10)%>
            <%=MyUtil.ObjInput("Siniestro","NoSiniestro",rs.getString("NoSiniestro"),false,false,120,100,"",false,false,25)%>
            <%=MyUtil.ObjInput("Fecha Registro","FechaRegistro",rs.getString("FechaRegistro"),false,false,300,100,"",false,false,19)%>
            <%=MyUtil.ObjInput("Ajustador","Ajustador",rs.getString("Ajustador"),false,false,30,140,"",false,false,43)%>
            <%=MyUtil.ObjInput("*Turnado a:","Turnado","",false,false,300,140,"",false,false,45)%>
            <%=MyUtil.DoBlock("Proceso Civil",70,0)%> 
                        
            <%=MyUtil.ObjInput("*Número de Juzgado","JuzgadoNum","",false,false,30,230,"",false,false,19)%>
            <%=MyUtil.ObjInput("*Número de Expediente","Expediente","",false,false,300,230,"",false,false,19)%>
            <%=MyUtil.ObjInput("*Fecha Demanda","FechaDemanda","",false,false,30,270,"",false,false,19)%>
            <%=MyUtil.ObjInput("*Nombre Demandante","NombreDemandante","",false,false,300,270,"",false,false,45)%>
            <%=MyUtil.ObjInput("*Nombre Demandado","NombreDemandado","",false,false,30,310,"",false,false,45)%>
            <%=MyUtil.ObjInput("*Monto Demanda","MontoDemanda","",false,false,300,310,"",false,false,45)%>
            <%=MyUtil.ObjTextArea("*Motivo de la Demanda","MotivoDema","","90","4",true,true,30,350,"",true,true)%>            
            <%=MyUtil.ObjTextArea("Informe de Seguimiento","QueHice",rs.getString("QueHice"),"90","4",true,true,30,430,"",true,true)%>
            <%=MyUtil.ObjInput("*Movimiento","Movimiento","",false,false,30,510,"",false,false,19)%>                              
            <%=MyUtil.ObjTextArea("*Comentario","Comentario","","62","3",true,true,170,510,"",true,true)%> 
            <%=MyUtil.DoBlock("Datos Generales del Proceso Civil",70,20)%>
        
            <%=MyUtil.ObjTextArea("Informe de Terminación del Caso","Informe",rs.getString("Informe"),"90","4",true,true,30,620,"",true,true)%>                  
            <%=MyUtil.ObjInput("*Fecha Terminación","FechaConcluye","",false,false,30,700,"",false,false,19)%>
            <%=MyUtil.DoBlock("Datos de Terminación del Caso",340,-10)%> 
                       
            
            
            <%
               session.setAttribute("clExpediente",StrclExpediente);
        }
       else {
            %> El Expediente no Tiene Proceso Civil
            

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




