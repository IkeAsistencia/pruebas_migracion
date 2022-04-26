<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Seguridad.SeguridadC,Utilerias.UtileriasBDF" errorPage="" %>
<html>
<head>
<title></title>
</head>
<body class="cssBody">
<link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>

<script src='../../Utilerias/Util.js'></script>
<%  
    	String StrclExpediente = "0";
    	String strclUsr = "";
        String StrFecha = "";
        
        

      	if (session.getAttribute("clUsrApp")!= null)
      	{
       		strclUsr = session.getAttribute("clUsrApp").toString(); 
        }  
        
      	if (session.getAttribute("clExpediente")!= null)
      	{
            StrclExpediente= session.getAttribute("clExpediente").toString(); 
       	}  
        
        if (request.getParameter("Fecha")!= null)
        {
            StrFecha= request.getParameter("Fecha").toString().trim(); 
        }  

        StringBuffer StrSql = new StringBuffer();
        
        StrSql.append(" Select getdate() Fecha");
        ResultSet rsFecha = UtileriasBDF.rsSQLNP( StrSql.toString());
        StrSql.delete(0,StrSql.length());
        
        if(rsFecha.next()){
            StrFecha = rsFecha.getString("Fecha");
        }
        
        
            StrSql.append(" Select SS.clExpediente,ES.dsEstatus,SS.Fecha,SS.Importe,SS.Observaciones");
            StrSql.append(" from SeguimientoSiniestro SS");
            StrSql.append(" inner join cStatusSiniestro ES on (SS.clEstatus=ES.clEstatus)");
            StrSql.append(" where SS.clExpediente=").append(StrclExpediente).append("and Fecha='").append(StrFecha).append("' ");
            
       
       	String StrclPaginaWeb = "450";
	session.setAttribute("clPaginaWebP",StrclPaginaWeb);
        %>
        <SCRIPT>fnOpenLinks()</script>
        <%
        ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
        StrSql.delete(0,StrSql.length());
        
       	MyUtil.InicializaParametrosC(450,Integer.parseInt(strclUsr)); 
        %>
        <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccion","","")%>

        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='../Utilerias/Lista.jsp?P=449&Apartado=S'>
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
        <%
        if (rs.next()) {
            %>  <script>document.all.btnElimina.disabled=true;</script>
                <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=rs.getString("clExpediente")%>'>
                <INPUT id='clUsrApp' name='clUsrApp' type='hidden' value='<%=rs.getString("clUsrApp")%>'>
                <INPUT id='Fecha' name='Fecha' type='hidden' value='<%=rs.getString("Fecha")%>'>
                <%=MyUtil.ObjComboC("Estatus del Siniestro","clEstatus",rs.getString("dsEstatus"),true,true,30,80,"","Select clEstatus,dsEstatus from cStatusSiniestro","","",50,true,true)%>
                <%=MyUtil.ObjInput("Importe","Importe",rs.getString("Importe"),true,true,330,80,"",false,false,20,"EsNumerico(document.all.Importe)")%>
                <%=MyUtil.ObjTextArea("Observaciones","Observaciones",rs.getString("Observaciones"),"100","3",true,true,30,130,"",false,false)%>
                <%=MyUtil.DoBlock("Seguimiento Siniestro Hogar",50,20)%>
    <%
        }
	else{
            %>
                <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
                <INPUT id='clUsrApp' name='clUsrApp' type='hidden' value='<%=strclUsr%>'>
                <INPUT id='Fecha' name='Fecha' type='hidden' value='<%=StrFecha%>'>
                <%=MyUtil.ObjComboC("Estatus del Siniestro","clEstatus","",true,true,30,80,"","Select clEstatus,dsEstatus from cStatusSiniestro","","",50,true,true)%>
                <%=MyUtil.ObjInput("Importe","Importe","",true,true,330,80,"",false,false,20,"EsNumerico(document.all.Importe)")%>
                <%=MyUtil.ObjTextArea("Observaciones","Observaciones","","100","3",true,true,30,130,"",false,false)%>
                <%=MyUtil.DoBlock("Seguimiento Siniestro Hogar",50,20)%>
              <%
	}
         rs.close();
         rs=null;
         rsFecha.close();
         rsFecha=null;
         
         StrclExpediente = null;
         StrSql=null;
         strclUsr=null;
         StrFecha=null;
        %>
	<%=MyUtil.GeneraScripts()%>
	
<script>

</script>
</body>
</html>