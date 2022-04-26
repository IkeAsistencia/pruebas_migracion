<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
<head><title>Citas de Abogado</title>
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
</head>
<body class="cssBody">
<jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj" /> 
<script src='../Utilerias/Util.js' ></script>
<script src='../Utilerias/UtilMask.js' ></script>


<%  
    String StrclCitaProveedor = "0"; 
    StringBuffer StrSql = new StringBuffer(); 
    String StrclUsrApp="0";
    String StrclPaginaWeb="0";  
    
    
   
    if (session.getAttribute("clUsrApp")!= null)
     {
       StrclUsrApp = session.getAttribute("clUsrApp").toString(); 
     }  

    if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) 
     {
       %>Fuera de Horario<% return;  
     }    
     
     if (request.getParameter("clCitaProveedor")!= null)
      	{
            StrclCitaProveedor= request.getParameter("clCitaProveedor").toString(); 
       	}  
   
    StrSql.append("Select PC.clCitaProveedor, PC.clProveedor, coalesce(P.NombreOpe,'') NombreOpe, convert(varchar(16),PC.Fecha,120) Fecha, PC.Lugar, coalesce(EC.dsEstatus,'') dsEstatus ");
    StrSql.append(" From ProveedorCitas PC ");
    StrSql.append(" Inner join cProveedor P ON(P.clProveedor=PC.clProveedor) ");
    StrSql.append(" Inner join cEstatusCitasAbog EC ON(EC.clEstatus=PC.clEstatus) ");
    StrSql.append(" Where PC.clCitaProveedor =").append(StrclCitaProveedor);
    
    ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());     
    StrSql.delete(0,StrSql.length());
    %><script>fnOpenLinks()</script><%

    StrclPaginaWeb = "310";       
    MyUtil.InicializaParametrosC(310,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina

    session.setAttribute("clPaginaWebP",StrclPaginaWeb); 

    %><%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion","")%>
    <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%>CitasAbogado.jsp?'>
    <%
    if (rs.next()) { 
        // El siguiente campo llave no se mete con MyUtil.ObjInput 
        %><INPUT id='clCitaProveedor' name='clCitaProveedor' type='hidden' value='<%=rs.getString("clCitaProveedor")%>'>
        <%=MyUtil.ObjComboC("Proveedor ","clProveedor",rs.getString("NombreOpe"),true,true,30,70,"","select clProveedor, NombreOpe From cProveedor Where Citas=1 Order by NombreOpe","","",100,true,true)%>
        <%=MyUtil.ObjInput("Fecha de Cita<br>(aaaa/mm/dd hh:mm)","Fecha",rs.getString("Fecha"),true,true,30,110,"",true,true,22,"if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("Lugar de la Cita","Lugar",rs.getString("Lugar"),true,true,200,120,"",true,true,40)%>
        <%=MyUtil.ObjComboC("Estatus","clEstatus",rs.getString("dsEstatus"),true,true,30,160,"","select clEstatus, dsEstatus from cEstatusCitasAbog","","",100,true,true)%>
        <%
    } 
    else { 
        %><INPUT id='clCitaProveedor' name='clCitaProveedor' type='hidden' value='0'>
        <%=MyUtil.ObjComboC("Proveedor ","clProveedor","",true,true,30,70,"","select clProveedor, NombreOpe From cProveedor Where Citas=1 Order by NombreOpe","","",100,true,true)%>
        <%=MyUtil.ObjInput("Fecha de Cita<br>(aaaa/mm/dd hh:mm)","Fecha","",true,true,30,110,"",true,true,22,"if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("Lugar de la Cita","Lugar","",true,true,200,120,"",true,true,40)%>
        <%=MyUtil.ObjComboC("Estatus","clEstatus","",true,true,30,160,"","select clEstatus, dsEstatus from cEstatusCitasAbog","","",100,true,true)%>
    <%
    }    
    %><%=MyUtil.DoBlock("Detalle de Citas de Abogado",140,0)%>
    <%=MyUtil.GeneraScripts()%><%
    rs.close();
    rs=null;
    
 %>
<input name='FechaMsk' id='FechaMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>  
<script>    
     document.all.Lugar.maxLength=40;   
</script>
</body>
</html>

