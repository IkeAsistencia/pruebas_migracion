<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
<head><title>Costos</title>
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
</head>
<body class="cssBody">

<jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj" /> 
<script src='../Utilerias/Util.js' ></script>
<script src='../Utilerias/UtilMask.js' ></script>
<script src='../Utilerias/UtilCostos.js' ></script>



<%  

    String StrclExpediente = "0";   
    StringBuffer StrSql = new StringBuffer(); 
    String StrclUsrApp="0";
    String StrclPaginaWeb="0";
    String StrclPagoProveedor="0";
    String StrclServicio="";
    
    

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

        if (request.getParameter("clPagoProveedor")!= null)
        {
            StrclPagoProveedor= request.getParameter("clPagoProveedor").toString(); 
        }  

     StrSql.append(" Select pagado, coalesce(P.NombreOpe,'')'Proveedor' ,");
     StrSql.append(" CostoExpediente 'Monto' , convert(varchar(20),FechaRegistroPago,120) 'FechaPago', CASE PP.PAGADO WHEN 0 THEN 'NO' WHEN 1 THEN 'SI' ELSE '' END 'Paga'");
     StrSql.append(" From Expediente  E ");
     StrSql.append(" INNER JOIN PagoProveedor PP ON (PP.clExpediente = E.clExpediente) ");
     StrSql.append(" INNER JOIN cProveedor P ON (PP.clProveedor= P.clProveedor) ");
     StrSql.append(" Where E.clexpediente =").append(StrclExpediente).append("and clPagoProveedor= ").append(StrclPagoProveedor);
     
     ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());     
     
     StrSql.delete(0,StrSql.length());
     
    

    %><script>fnOpenLinks()</script><%

    StrclPaginaWeb = "534";       
    MyUtil.InicializaParametrosC(534,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina

    session.setAttribute("clPaginaWebP",StrclPaginaWeb); 

    %><%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaEliminaPagos","")%>
    <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%>Pagos.jsp?'>
    <%

    
    if (rs.next()) {  
    
        if(rs.getString("pagado").equalsIgnoreCase("0")){
            %><script>document.all.btnElimina.disabled=false;</script><%
        }else{
            %><script>document.all.btnElimina.disabled=true;</script><%
        }
        %>
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
        
        <%=MyUtil.ObjInput("Clave de Pago","clPagoProveedor",StrclPagoProveedor,false,false,30,100,"",true,true,10)%>
        <%=MyUtil.ObjInput("Proveedor","Proveedor",rs.getString("Proveedor"),false,false,150,100,"",false,false,50,"")%>
        <%=MyUtil.ObjInput("Expediente","clExpediente",StrclExpediente,false,false,450,100,"",true,true,10,"")%> 
        <%=MyUtil.ObjInput("Monto","Monto",rs.getString("Monto"),true,true,30,150,"0",false,false,7,"")%>
        <%=MyUtil.ObjInput("Fecha de Registro","FechaPago",rs.getString("FechaPago"),false,false,150,150,"0",false,false,25,"")%>
        <%=MyUtil.ObjInput("Pagado","Pagado",rs.getString("Paga"),true,true,450,150,"0",false,false,7,"")%>

         
        <%=MyUtil.DoBlock("Detalle Pago Proveedor",0,0)%>
        <%
    } 
    else 
    {
      %>
        <script>document.all.btnElimina.disabled=true;</script>
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
        
        <%=MyUtil.ObjInput("Clave de Pago","clPagoProveedor","",false,false,30,100,"",true,true,10)%>
        <%=MyUtil.ObjInput("Proveedor","Proveedor","",false,false,150,100,"",false,false,50,"")%>
        <%=MyUtil.ObjInput("Expediente","clExpediente","",false,false,450,100,"",true,true,10,"")%> 
        <%=MyUtil.ObjInput("Monto","Monto","",true,true,30,150,"0",false,false,7,"")%>
        <%=MyUtil.ObjInput("Fecha de Registro","FechaPago","",false,false,150,150,"0",false,false,25,"")%>
        <%=MyUtil.ObjInput("Pagado","Pagado","",true,true,450,150,"0",false,false,7,"")%>

         
        <%=MyUtil.DoBlock("Detalle Pago Proveedor",0,0)%><%
    }
    %>
    <%=MyUtil.GeneraScripts()%>
    <%
    rs.close();
    rs=null;
    
    
 %>
 
</body>
</html>

<script>


</script>

