<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head><title>Costo x SubServicio x Proveedor</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <%-- <jsp:useBean id="beanInstanceName" scope="session" class="beanPackage.BeanClassName" /> --%>
        <%-- <jsp:getProperty name="beanInstanceName"  property="propertyName" /> --%>
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
        <script src='../Utilerias/Util.js' ></script>
        <script src='../Utilerias/UtilServicio.js' ></script>
        <script src='../Utilerias/UtilCostos.js' ></script>
        <%
        String StrclProveedor = "0";
        String StrclCostoxProvxSubserv = "0";
        String StrNomOpe = "";
        String StrclUsrApp = "0";
        String StrclPaginaWeb = "";

        if(session.getAttribute("clUsrApp")!= null){
            StrclUsrApp = session.getAttribute("clUsrApp").toString();
        }

        if(session.getAttribute("clProveedor")!= null){
            StrclProveedor = session.getAttribute("clProveedor").toString();
        }
        
        if(request.getParameter("clCostoXProvXSubserv")!= null){
            StrclCostoxProvxSubserv = request.getParameter("clCostoXProvXSubserv").toString();
        }
        
        if(session.getAttribute("NombreOpe")!= null){
            StrNomOpe = session.getAttribute("NombreOpe").toString();
        }

        if(SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true){
            %>Fuera de Horario<%
            return;
        }

        StringBuffer StrSql = new StringBuffer();
        StrSql.append(" st_getCostoxProvxSS ").append(StrclCostoxProvxSubserv);
        ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
        StrSql.delete(0,StrSql.length());

        StrclPaginaWeb = "5032";
        
        session.setAttribute("clPaginaWebP",StrclPaginaWeb);
        %><SCRIPT>fnOpenLinks()</script><%
        
        MyUtil.InicializaParametrosC(5032,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
        %>
        
        <%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion","")%>
        <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="DetalleCostoxSubxProvVet.jsp?'>"%>
        <%
        if(rs.next()){
            %>
            <INPUT id='clCostoXProvXSubserv' name='clCostoXProvXSubserv' type='hidden' value='<%=StrclCostoxProvxSubserv%>'>
            <%=MyUtil.ObjInput("Nombre Operativo","NombreOpe",StrNomOpe,false,false,20,100,StrNomOpe,false,false,70)%>
            <%=MyUtil.ObjComboC("Servicio","clServicio",rs.getString("dsServicio"),true,true,20,140,"0","SELECT clServicio, dsServicio FROM cServicio ORDER BY dsServicio ","fnLlenaSubServicios()","",50,true,true)%>
            <%=MyUtil.ObjComboC("Subservicio","clSubServicio",rs.getString("dsSubServicio"),true,true,250,140,"0","SELECT clSubServicio, dsSubServicio FROM cSubServicio where clServicio = " + rs.getString("clServicio") + " ORDER BY dsSubServicio ","fnLlenaConceptos(11)","",50,true,true)%>
            <%=MyUtil.ObjComboC("Concepto","clConcepto",rs.getString("dsConcepto"),true,true,20,180,"0","SELECT clConcepto, dsConcepto FROM cConceptoCosto ORDER BY dsConcepto ","","",50,true,true)%>
            <%=MyUtil.ObjInput("Costo Base","Costo",rs.getString("Costo"),true,true,20,220,"0",true,true,10)%>
            <%
        }else{
            %>
            <INPUT id='clProveedor' name='clProveedor' type='hidden' value='<%=StrclProveedor%>'>
            <INPUT id='clCostoXProvXSubserv' name='clCostoXProvXSubserv' type='hidden' value='<%=StrclCostoxProvxSubserv%>'>
            <%=MyUtil.ObjInput("Nombre Operativo","NombreOpe",StrNomOpe,false,false,20,100,StrNomOpe,false,false,70)%>
            <%=MyUtil.ObjComboC("Servicio","clServicio","",true,true,20,140,"0","SELECT clServicio, dsServicio FROM cServicio ORDER BY dsServicio ","fnLlenaSubServicios()","",50,true,true)%>
            <%=MyUtil.ObjComboC("Subservicio","clSubServicio","",true,true,250,140,"0","SELECT clSubServicio, dsSubServicio FROM cSubServicio where clServicio = 0 ORDER BY dsSubServicio ","fnLlenaConceptos(11)","",50,true,true)%>
            <%=MyUtil.ObjComboC("Concepto","clConcepto","",true,true,20,180,"0","SELECT clConcepto, dsConcepto FROM cConceptoCosto ORDER BY dsConcepto ","","",50,true,true)%>
            <%=MyUtil.ObjInput("Costo Base","Costo","",true,true,20,220,"0",true,true,10)%>
        <%
        }
        %>
        <%=MyUtil.DoBlock("Detalle de Costo x Subservicio por Proveedor",0,30)%>
        <%=MyUtil.GeneraScripts()%>
        <%
        StrclProveedor = null;
        StrclCostoxProvxSubserv = null;
        StrNomOpe = null;
        StrclPaginaWeb = null;
        StrclUsrApp = null;
        StrSql = null;
        rs.close();
        rs=null;
        %>
    </body>
</html>