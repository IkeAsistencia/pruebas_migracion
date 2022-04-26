<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<html>
<head>
<title>Detalle de los Datos del Acumulador</title>
</head>
<body class="cssBody">
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
<script src='../Utilerias/Util.js'></script>
<script src='../Utilerias/UtilMask.js'></script>
<script src='../Utilerias/UtilDireccion.js'></script>
<%
   	String StrclIngreso = "0";
        String StrclExpediente = "0";
        String StrNombreOpe ="";
        String StrclProveedor = "0";
        String StrdsConceptoIngreso = "";
        String StrMonto = "0";
        String StrclUsrApp = "0";
    
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

        if (request.getParameter("clIngreso")!= null)
        {
            StrclIngreso= request.getParameter("clIngreso").toString();
        }
      
        StringBuffer StrSql = new StringBuffer();
        
            StrSql.append(" select I.clExpediente, P.NombreOpe, PxE.clProveedor, C.dsConceptoIngreso, I.Monto ");
            StrSql.append(" from Ingresos I ");
            StrSql.append(" left join cConceptoIngreso C on (C.clConceptoIngreso = I.clConceptoIngreso)");
            StrSql.append(" left join ProveedorxExpediente PxE on (PxE.clExpediente = I.clExpediente)");
            StrSql.append(" inner join cProveedor P on (P.clProveedor = PxE.clProveedor)");
            StrSql.append(" where I.clIngreso = ").append(StrclIngreso);
                        
            ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
            StrSql.delete(0,StrSql.length());

       	String StrclPaginaWeb = "666";
	session.setAttribute("clPaginaWebP",StrclPaginaWeb);
        %>
         <script>fnOpenLinks()</script>
        <%
       	MyUtil.InicializaParametrosC(666,Integer.parseInt(StrclUsrApp)); %>
	<%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion","","")%>

     <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="Ingresos.jsp?'>"%>

     <script> document.all.btnCambio.disabled=true</script>
         <%
       if(rs.next()) {
        StrNombreOpe =rs.getString("NombreOpe");
        StrclProveedor = rs.getString("clProveedor");
        StrdsConceptoIngreso = rs.getString("dsConceptoIngreso");
        StrMonto = rs.getString("Monto");
     %>
                <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
                <INPUT id='clUsrApp' name='clUsrAppVenta' type='hidden' value='<%=StrclUsrApp%>'>

                <%=MyUtil.ObjComboC("Proveedor","clProveedor",StrNombreOpe,true,true,30,80,"","sp_LlenaComboProvxExp " + StrclExpediente,"","",30,true,true)%>
                <%=MyUtil.ObjComboC("Concepto","clConceptoIngreso",StrdsConceptoIngreso,true,true,30,120,"","select clConceptoIngreso, dsConceptoIngreso from cConceptoIngreso order by dsConceptoIngreso","","",30,true,true)%>
                <%=MyUtil.ObjInput("Monto","Monto",StrMonto,true,true,30,160,"",true,true,40)%>
                <%=MyUtil.DoBlock("Detalle de Ingreso",40,0)%> 
                

    <% } else {%>
    
                <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
                <INPUT id='clUsrApp' name='clUsrAppVenta' type='hidden' value='<%=StrclUsrApp%>'>

                <%=MyUtil.ObjComboC("Proveedor","clProveedor","",true,true,30,80,"","sp_LlenaComboProvxExp " + StrclExpediente,"","",30,true,true)%>
                <%=MyUtil.ObjComboC("Concepto","clConceptoIngreso","",true,true,30,120,"","select clConceptoIngreso, dsConceptoIngreso from cConceptoIngreso order by dsConceptoIngreso","","",30,true,true)%>
                <%=MyUtil.ObjInput("Monto","Monto",StrMonto,true,true,30,160,"",true,true,40)%>
                <%=MyUtil.DoBlock("Detalle de Ingreso",40,0)%> 
    <%}%>
    <%=MyUtil.GeneraScripts()%>
	<%
        rs.close();
        rs=null;
    	
        StrclExpediente = null;
    	StrclUsrApp = null;
        StrSql =null; 
%>

<script>
  
</script>
</body>
</html>
