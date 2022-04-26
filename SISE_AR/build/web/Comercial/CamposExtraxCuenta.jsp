<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
<head><title>JSP Page</title>
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
</head>
<body class="cssBody">

<%-- <jsp:useBean id="beanInstanceName" scope="session" class="beanPackage.BeanClassName" /> --%>
<%-- <jsp:getProperty name="beanInstanceName"  property="propertyName" /> --%>

<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
<script src='../Utilerias/Util.js' ></script>
<script src='../Utilerias/UtilServicio.js' ></script>

<%  

    String StrclUsrApp="0";

    if (session.getAttribute("clUsrApp")!= null)
     {
       StrclUsrApp = session.getAttribute("clUsrApp").toString(); 
     }  
    
    

    if (SeguridadC.verificaHorarioC((Integer.parseInt(StrclUsrApp))) != true) 
     {
       %>Fuera de Horario<%
          
         return; 
     } 

    String StrclCampoExCta = "0";
    String StrclCuenta = "0";
    String StrSqlCuenta = "";

    if (request.getParameter("clCampoExCta") != null)
    {
      StrclCampoExCta = request.getParameter("clCampoExCta");
    }    
    
    if (session.getAttribute("clCuenta") != null)
    {
      StrclCuenta = session.getAttribute("clCuenta").toString();
    }    

       StringBuffer StrSql = new StringBuffer();
       StrSql.append("Select Nombre as Cuenta From cCuenta Where clCuenta=").append(StrclCuenta);
       ResultSet rsCta = UtileriasBDF.rsSQLNP( StrSql.toString());
       StrSql.delete(0,StrSql.length());
       if (rsCta.next()){};
    
       StrSql.append("select C.Nombre as Cuenta, E.Nombre as CampoExtra, E.clCampoExtra, ");
            StrSql.append(" S.clServicio, SUB.clSubServicio, ");
            StrSql.append(" S.dsServicio, SUB.dsSubservicio ");
            StrSql.append(" From CampoExtraxCuenta CxC ");
            StrSql.append(" Inner Join cCampoExtra E ON (CxC.clCampoExtra=E.clCampoExtra) ");
            StrSql.append(" Inner Join cCuenta C ON (CxC.clCuenta=C.clCuenta) ");
            StrSql.append(" Inner join cServicio S on (CxC.clServicio = S.clServicio ) ");
            StrSql.append(" Inner join cSubServicio SUB on (CxC.clSubServicio = SUB.clSubServicio ) ");
            StrSql.append(" Where CxC.clCampoExCta=").append(StrclCampoExCta);
       ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
       StrSql.delete(0,StrSql.length());       

       String StrclPaginaWeb = "15";
       session.setAttribute("clPaginaWebP",StrclPaginaWeb);
       MyUtil.InicializaParametrosC( 15,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina    
       %><%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion","")%>        
       <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="CamposExtraxCuenta.jsp?'>"%> 
       <INPUT id='clCuenta' name='clCuenta' type='hidden' value='<%=StrclCuenta%>'><br><br><br><br>  
       <INPUT id='clCampoExCta' name='clCampoExCta' type='hidden' value='<%=StrclCampoExCta%>'><br><br><br><br><%
       
       if (rs.next()) { %>
            <%=MyUtil.ObjInput("Cuenta","Cuenta",rs.getString("Cuenta"),false,false,30,100,rs.getString("Cuenta"),false,false,55)%>
            <%=MyUtil.ObjComboC("Campo Extra","clCampoExtra",rs.getString("CampoExtra"),true,true,500,140,"","Select clCampoExtra, Nombre From cCampoExtra WHERE clCampoExtra=" + rs.getString("clCampoExtra") + " order by Nombre","","",50,true,true)%>
            <%=MyUtil.ObjComboC("Servicio","clServicio",rs.getString("dsServicio"),true,true,30,140,"","Select clServicio, dsServicio From cServicio order by dsServicio","fnLlenaSubServicios()","",50,true,true)%>
            <%=MyUtil.ObjComboC("Subservicio","clSubServicio",rs.getString("dsSubservicio"),true,true,240,140,"","Select clSubServicio, dsSubServicio From cSubServicio where clSubServicio  ="+ rs.getString("clSubservicio") + " order by dsSubservicio","fnLlenaCamExtras()","",50,true,true)%><%
        }
       else { %>
            <%=MyUtil.ObjInput("Cuenta","Cuenta",rsCta.getString("Cuenta"),false,false,30,100,rsCta.getString("Cuenta"),false,false,55)%>
            <%=MyUtil.ObjComboC("Campo Extra","clCampoExtra","",true,true,500,140,"","","","",50,true,true)%>
            <%=MyUtil.ObjComboC("Servicio","clServicio","",true,true,30,140,"","Select clServicio, dsServicio From cServicio order by dsServicio","fnLlenaSubServicios()","",50,true,true)%>
            <%=MyUtil.ObjComboC("Subservicio","clSubServicio","",true,true,240,140,"","Select clSubServicio, dsSubServicio From cSubServicio where clSubServicio  = 0 order by dsSubservicio","fnLlenaCamExtras()","",50,true,true)%><%
        }  %>
        <%=MyUtil.DoBlock("Detalle de Campo Extra Por Cuenta",50,0)%>                         
        <%=MyUtil.GeneraScripts()%><% 
        rsCta.close();
        rsCta=null;
        rs.close();
        rs=null;
        
        
        StrclPaginaWeb = null;
        StrclCampoExCta = null;
        StrclCuenta = null;
        StrSql = null;
        StrSqlCuenta = null;
        StrclUsrApp= null;
%>

<script>
	function fnLlenaCamExtras(){
                $clServicio = document.all.clServicio.value;
                if ($clServicio==''){$clServicio=0}
                $clSubServicio = document.all.clSubServicio.value;
                if ($clSubServicio==''){$clSubServicio=0}
		var strConsulta = "sp_GetCamposExtra " + document.all.clCuenta.value + "," + document.all.clServicio.value + "," + document.all.clSubServicio.value;
		var pstrCadena = "../servlet/Utilerias.LlenaCombos?strSQL=" + strConsulta;
		pstrCadena = pstrCadena + "&strName=clCampoExtraC";		
		fnOptionxDefault('clCampoExtraC',pstrCadena);
	}
</script>
</body>
</html>
