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
    String StrDanos="0";

    

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
    
    

    StrSql.append(" select E.clExpediente,E.FechaRegistro,ES.dsEstatus,E.Contacto,E.NuestroUsuario ");
    StrSql.append(" from Expediente E ");
    StrSql.append("inner join cEstatus ES on (E.clestatus=ES.clestatus) ");
    StrSql.append(" where E.clexpediente = ").append(StrclExpediente);

        
      ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
      StrSql.delete(0,StrSql.length());
    
       String StrclPaginaWeb = "577";
       session.setAttribute("clPaginaWebP",StrclPaginaWeb);
       %><SCRIPT>fnOpenLinks()</script><%


       MyUtil.InicializaParametrosC(577,Integer.parseInt(StrclUsrApp)); 
       %>
       <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="DetalleExpeZurich.jsp?'>"%><%   
              
          

          
       
       
       if (rs.next()) {
           
            %>
            
            <%=MyUtil.ObjInput("Expediente","ExpedienteVTR",rs.getString("clExpediente"),false,false,30,100,"",false,false,10)%>
            <%=MyUtil.ObjInput("Fecha Registro","FechaRegistro",rs.getString("FechaRegistro"),false,false,130,100,"",false,false,19)%>
            <%=MyUtil.ObjInput("Estatus","Estatus",rs.getString("dsEstatus"),false,false,300,100,"",false,false,40)%>
            <%=MyUtil.ObjInput("Quien Reporta","Contacto",rs.getString("Contacto"),false,false,30,140,"",false,false,40)%>
            <%=MyUtil.ObjInput("Nuestro Usuario","NuestroUsuario",rs.getString("NuestroUsuario"),false,false,300,140,"",false,false,40)%>
            <%=MyUtil.ObjInput("Nuestro Usuario","NuestroUsuario",rs.getString("NuestroUsuario"),false,false,300,140,"",false,false,40)%>

            <%=MyUtil.DoBlock("Detalle Expediente Zurich",70,0)%>
            

            
            
            <%
               session.setAttribute("clExpediente",StrclExpediente);
        }
       else {
            %> El Expediente no Existe 
            

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

