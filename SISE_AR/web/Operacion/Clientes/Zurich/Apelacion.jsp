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
    StrSql.append(" coalesce(A.ObsTermino,'') 'Informe' ");

    StrSql.append(" from vehiculoInvNu V  ");
    StrSql.append(" inner join AsistenciaLegal A on (V.clExpediente=A.clExpediente)  "); 
    StrSql.append(" inner join Expediente E on (V.clExpediente=E.clExpediente) ");

    StrSql.append(" where V.clexpediente = ").append(StrclExpediente);
    
        
      ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
      StrSql.delete(0,StrSql.length());
         
    
       String StrclPaginaWeb = "585";
       session.setAttribute("clPaginaWebP",StrclPaginaWeb);
       %><SCRIPT>fnOpenLinks()</script><%


       MyUtil.InicializaParametrosC(585,Integer.parseInt(StrclUsrApp)); 
       %>
       <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="Apelacion.jsp?'>"%><%   
              
       
       if (rs.next()) {
           
            %>
                                    
            <%=MyUtil.ObjInput("Expediente","ExpedienteVTR",rs.getString("clExpediente"),false,false,30,100,"",false,false,10)%>
            <%=MyUtil.ObjInput("Siniestro","NoSiniestro",rs.getString("NoSiniestro"),false,false,120,100,"",false,false,25)%>
            <%=MyUtil.ObjInput("Fecha Registro","FechaRegistro",rs.getString("FechaRegistro"),false,false,300,100,"",false,false,19)%>
            <%=MyUtil.ObjInput("Ajustador","Ajustador",rs.getString("Ajustador"),false,false,30,140,"",false,false,43)%>
            <%=MyUtil.ObjInput("*Turnado a:","Turnado","",false,false,300,140,"",false,false,45)%>
            <%=MyUtil.DoBlock("Apelación",70,0)%> 
            
            <%=MyUtil.ObjInput("*Fecha Apelación","FechaApelacion","",false,false,30,230,"",false,false,19)%>
            <%=MyUtil.ObjInput("*Fecha Resultado Apelación","FechaApelacionRes","",false,false,300,230,"",false,false,19)%>
            <%=MyUtil.ObjTextArea("*Fundamento/Resultado","Fundamento","","90","4",true,true,30,270,"",true,true)%>
            <%=MyUtil.ObjChkBox("*NA Absuelto","AbsueltoNU","", true,true,30,350,"0","")%>
            <%=MyUtil.ObjChkBox("*Tercero Absuelto","AbsueltoCP","", true,true,300,350,"0","")%>
            <%=MyUtil.ObjChkBox("*Abogado Realiza Apelación","AbsueltoNU","", true,true,30,380,"0","")%>
            <%=MyUtil.ObjChkBox("*Tercero Realiza Apelación","AbsueltoCP","", true,true,300,380,"0","")%>           
            <%=MyUtil.DoBlock("Datos de la Apelación",70,-10)%> 
            
            <%=MyUtil.ObjTextArea("Informe de Terminación del Caso","Informe",rs.getString("Informe"),"90","4",true,true,30,460,"",true,true)%>                  
            <%=MyUtil.ObjInput("*Fecha Terminación","FechaConcluye","",false,false,30,540,"",false,false,19)%>
            <%=MyUtil.ObjChkBox("*Tercero Inicia Proceso Civil","ProcesoCivilCP","", true,true,300,550,"0","")%>
            <%=MyUtil.DoBlock("Datos de Terminación del Caso",70,-10)%>                        
            
            <%
               session.setAttribute("clExpediente",StrclExpediente);
        }
       else {
            %> El Expediente no Tiene Apelacion
            

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



