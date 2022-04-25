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
        <script src='../Utilerias/UtilDireccion.js' ></script>
        <%  
        com.ike.util.I18N i18n = com.ike.util.I18N.getInstance("es","AR");
        String StrclCostoxSubservxEF = "0";
        String StrclUsrApp="0";
        String StrclPaginaWeb="0";
        
        
        
        if (session.getAttribute("clUsrApp")!= null)
        {
            StrclUsrApp = session.getAttribute("clUsrApp").toString();
        }
        
        if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true)
        {
        %>
        Fuera de Horario
        <%
        
        return;
        }
        
        if (request.getParameter("clCostoxSubservxEF") != null)
        {
            StrclCostoxSubservxEF = request.getParameter("clCostoxSubservxEF");
        }
        
        StringBuffer StrSql = new StringBuffer();
        
        StrSql.append(" select CC.dsConcepto, C.clConcepto,");
        StrSql.append(" coalesce(S.dsServicio,'') as 'dsServicio', C.clServicio,");
        StrSql.append(" coalesce(SS.dsSubservicio,'') as 'dsSubServicio', C.clSubservicio,");
        StrSql.append(" coalesce(E.dsEntFed,'') as 'dsEntFed', C.CodEnt,");
        StrSql.append(" coalesce(M.dsMunDel,'') as 'dsMunDel', C.CodMD,");
        StrSql.append(" coalesce(C.Costo,'') as Costo");
        StrSql.append(" from CostoxSubservxEF C ");
        StrSql.append(" inner join cConceptoCosto CC ON (CC.clConcepto=C.clConcepto)");
        StrSql.append(" inner join cEntFed E ON (E.CodEnt=C.CodEnt)");
        StrSql.append(" left join cSubservicio SS ON (SS.clSubservicio=C.clSubservicio)");
        StrSql.append(" left join cServicio S ON (S.clServicio=C.clServicio)");
        StrSql.append(" left join cMunDel M ON (M.CodMD=C.CodMD and M.CodEnt=C.CodEnt)");
        StrSql.append(" Where C.clCostoxSubservxEF = ").append(StrclCostoxSubservxEF);
        
        ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
        StrSql.delete(0,StrSql.length());
        
        StrclPaginaWeb = "259";
        MyUtil.InicializaParametrosC(259,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
        
        session.setAttribute("clPaginaWebP",StrclPaginaWeb);
        %>
        <%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion","")%>
        <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="DetalleCostoxSubservxEFHog.jsp?'>"%>
        <%
        if (rs.next())
        {
            // El siguiente campo llave no se mete con MyUtil.ObjInput
        %>
        <INPUT id='clCostoxSubservxEF' name='clCostoxSubservxEF' type='hidden' value='<%=StrclCostoxSubservxEF%>'>
        
        <%=MyUtil.ObjComboC("Concepto","clConcepto",rs.getString("dsConcepto"),true,false,30,100,"","Select clConcepto, dsConcepto From cConceptoCosto Where clAreaOperativa= 4 Order by dsConcepto","","",100,true,false)%>
        <%=MyUtil.ObjComboC("Servicio","clServicio",rs.getString("dsServicio"),true,false,30,140,"","Select clServicio,dsServicio From cServicio Where clAreaOperativa =4 Order by dsServicio","fnLlenaSubServicios()","",60,true,false)%>
        <%=MyUtil.ObjComboC("SubServicio","clSubServicio",rs.getString("dsSubServicio"),true,false,30,180,"","Select clSubServicio, dsSubServicio From cSubServicio Where clServicio=" + rs.getString("clServicio") + " Order by dsSubServicio","","",160,true,false)%>
        <%=MyUtil.ObjComboC(i18n.getMessage("message.title.entidad"),"CodEnt",rs.getString("dsEntFed"),true,false,30,220,"","Select CodEnt, dsEntFed From cEntFed Order by dsEntFed","fnLlenaMunicipios()","",70,true,false)%>
        <%=MyUtil.ObjComboC(i18n.getMessage("message.title.municipio"),"CodMD",rs.getString("dsMunDel"),true,false,30,260,"","Select CodMD, dsMunDel From cMunDel Where CodEnt='" + rs.getString("CodEnt") + "' Order by dsMunDel","","",160,false,false)%>
        <%=MyUtil.ObjInput("Costo","Costo",rs.getString("Costo"),true,true,30,300,"",true,true,25,"EsNumerico(document.all.Costo)")%>
        <% 
        }
        else
        {
        %>
        <INPUT id='clCostoxSubservxEF' name='clCostoxSubservxEF' type='hidden' value='"+ StrclCostoxSubservxEF +"'>
        
        <%=MyUtil.ObjComboC("Concepto","clConcepto","",true,false,30,100,"","Select clConcepto, dsConcepto From cConceptoCosto Where clAreaOperativa= 4 Order by dsConcepto","","",100,true,false)%>
        <%=MyUtil.ObjComboC("Servicio","clServicio","",true,false,30,140,"","Select clServicio,dsServicio From cServicio Where clAreaOperativa =4 Order by dsServicio","fnLlenaSubServicios()","",60,true,false)%>
        <%=MyUtil.ObjComboC("SubServicio","clSubServicio","",true,false,30,180,"","Select clSubServicio, dsSubServicio From cSubServicio Where clServicio=18 Order by dsSubServicio","","",160,true,false)%>
        <%=MyUtil.ObjComboC(i18n.getMessage("message.title.entidad"),"CodEnt","",true,false,30,220,"","Select CodEnt, dsEntFed From cEntFed Order by dsEntFed","fnLlenaMunicipios()","",70,true,false)%>
        <%=MyUtil.ObjComboC(i18n.getMessage("message.title.municipio"),"CodMD","",true,false,30,260,"","Select CodMD, dsMunDel From cMunDel Where CodEnt='DF' Order by dsMunDel","","",160,false,false)%>
        <%=MyUtil.ObjInput("Costo","Costo","",true,true,30,300,"",true,true,25,"EsNumerico(document.all.Costo)")%>
        <%
        }
        StrclCostoxSubservxEF=null;
        StrclUsrApp=null;
        StrclPaginaWeb=null;
        StrSql=null;
        rs.close();
        
        rs=null;
        %>
        <%=MyUtil.DoBlock("Detalle de Costo por Concepto de Hogar por " + i18n.getMessage("message.title.entidad"),300,0)%>
        <%=MyUtil.GeneraScripts()%>
    </body>
</html>
