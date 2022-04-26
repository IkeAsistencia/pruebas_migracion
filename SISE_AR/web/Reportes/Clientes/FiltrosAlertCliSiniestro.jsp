<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Seguridad.SeguridadC,Utilerias.UtileriasBDF,Combos.cbServicio" errorPage="" %>
<html>
<head><title>JSP Page</title>
<link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
</head>
<body topmargin=470 leftmargin=30 class="cssBody">
<%-- <jsp:useBean id="beanInstanceName" scope="session" class="beanPackage.BeanClassName" /> --%>
<%-- <jsp:getProperty name="beanInstanceName"  property="propertyName" /> --%>
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
<script src='../../Utilerias/Util.js'></script>
<script src='../../Utilerias/UtilMask.js'></script>
<script src='../../Utilerias/UtilServicio.js'></script>

<%
    String StrSql = ""; 
    String StrclUsrApp="0";
    String StrclPaginaWeb="0";
   
    if (session.getAttribute("clUsrApp")!= null)
     {
       StrclUsrApp = session.getAttribute("clUsrApp").toString(); 
     }  

    if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) 
     {%>       
       Fuera de Horario 
      <% return;  
    }    
     
     StrclPaginaWeb = "460";       
     MyUtil.InicializaParametrosC(460,Integer.parseInt(StrclUsrApp));   
%>     

<%    
    /*StrSql = "Select clUsrApp, Nombre from cUsrApp where Activo = 1 and clPerfilOperativo = 5 order by Nombre";
    ResultSet rs = UtileriasBDF.rsSQLC(con, StrSql);   */ 
%>
    <form action="AlertasCliente.jsp" id="Forma1" name="Forma1" target="Alertas">    
    
   <%=MyUtil.ObjComboC("Tipo de Servicio","clSubservicio","",true,true,30,30,"","Select clSubservicio, dsSubservicio from cSubservicio where clSubservicio in (211,212,213,214) order by dsSubservicio","document.all.Forma1.submit();","",40,false,false)%>
    <%=MyUtil.ObjComboC("Proceso","clProceso","",true,true,30,70,"","Select 1, 'Abiertos' dsProceso union Select 2, 'Terminados en las Últimas 48 horas' order by dsProceso","document.all.Forma1.submit();","",40,false,false)%>
    <%=MyUtil.ObjComboC("Entidad","CodEnt","",true,true,30,110,"","Select CodEnt, dsEntFed from centfed UNION (Select '', 'Todos') order by dsEntFed ","document.all.Forma1.submit();","",40,false,false)%>
    <%=MyUtil.DoBlock("Alertas Cliente",100,30)%>

    
<%
    //rs.close();
    //rs=null;
%>
   
    </form>

<script>
    document.all.clSubservicioC.disabled=false;
    document.all.clProcesoC.disabled=false;
    document.all.CodEntC.disabled=false;
    
    timeDV =0;
    function dnSetTimeD(){
       	timeDV = timeDV + 1;
       	if (timeDV == 1) {
			document.all.Forma1.submit();
			timeDV=0;
     	}
        setTimeout('dnSetTimeD()',20000);					
	}
   	dnSetTimeD();
   
</script>
</body>
</html>