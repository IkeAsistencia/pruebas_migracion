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
<script src='../Utilerias/UtilDireccion.js' ></script>
<%  

    String StrclProveedor = "0";
    String StrclCoberturaxProveedor = "0";

    
    

    String StrSql = "";
    String StrNomOpe = "";
    String StrclUsrApp="0";

    if (session.getAttribute("clUsrApp")!= null)
     {
       StrclUsrApp = session.getAttribute("clUsrApp").toString(); 
     }  
    
     if (session.getAttribute("clProveedor")!= null)
     {
       StrclProveedor = session.getAttribute("clProveedor").toString(); 
     }  

     if (request.getParameter("clCoberturaxProveedor")!= null)
     {
       StrclCoberturaxProveedor = request.getParameter("clCoberturaxProveedor").toString(); 
     }  

     if (session.getAttribute("NombreOpe")!= null)
     {
       StrNomOpe = session.getAttribute("NombreOpe").toString(); 
     }  

    if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) 
     {
       %><%="Fuera de Horario"%><%
       
        return; 
     }     
    StringBuffer StrSql1 = new StringBuffer();
    StrSql1.append("select CxP.CodEnt, EF.dsEntFed, coalesce(CxP.CodMD,'') CodMD, ");
StrSql1.append(" coalesce(MD.dsMunDel,'') dsMunDel  " );
StrSql1.append(" from  CoberturaxProveedor CxP " );
StrSql1.append(" inner join cEntFed EF on (CxP.CodEnt = EF.CodEnt) " );
StrSql1.append(" left join cMunDel MD on (MD.CodEnt = EF.CodEnt " );
StrSql1.append("                          and CxP.CodMD = MD.CodMD ) " );
StrSql1.append(" where CxP.clCoberturaxProveedor = ").append(StrclCoberturaxProveedor);
ResultSet rs = UtileriasBDF.rsSQLNP( StrSql1.toString());
    StrSql1.delete(0,StrSql1.length());
      
       String StrclPaginaWeb = "488";
       session.setAttribute("clPaginaWebP",StrclPaginaWeb);
       %>
       <SCRIPT>fnOpenLinks()</script>
       <%
       MyUtil.InicializaParametrosC(488,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina 
       %>
       <%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion","")%>
       <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="DetalleCobxProvR.jsp?'>"%>
       <%
           if (rs.next()) {
               %>
            <INPUT id='clProveedor' name='clProveedor' type='hidden' value='<%=StrclProveedor%>'>
            <INPUT id='clCoberturaxProveedor' name='clCoberturaxProveedor' type='hidden' value='<%=StrclCoberturaxProveedor %>'>
            <%=MyUtil.ObjInput("Nombre Operativo","NombreOpe",StrNomOpe,false,false,20,100,StrNomOpe,false,false,70)%>
            <%=MyUtil.ObjComboC("Entidad","CodEnt",rs.getString("dsEntFed"),true,true,20,140,"0","SELECT CodEnt, dsEntFed FROM cEntFed ORDER BY dsEntFed ","fnLlenaMunicipios()","",50,true,true)%>
            <%=MyUtil.ObjComboC("Municipio","CodMD",rs.getString("dsMunDel") ,true,true,250,140,"0","SELECT CodMD, dsMunDel FROM cMunDel where CodEnt = '" + rs.getString("CodEnt") + "' and CodMD = '" + rs.getString("CodMD") + "' ORDER BY dsMunDel ","","",50,true,true)%>
            <%
        }
       else {
           %>
            <INPUT id='clProveedor' name='clProveedor' type='hidden' value='<%=StrclProveedor%>'>
            <INPUT id='clCoberturaxProveedor' name='clCoberturaxProveedor' type='hidden' value='<%=StrclCoberturaxProveedor%>'>
            <%=MyUtil.ObjInput("Nombre Operativo","NombreOpe",StrNomOpe,false,false,20,100,StrNomOpe,false,false,70)%>
            <%=MyUtil.ObjComboC("Entidad","CodEnt","",true,true,20,140,"0","SELECT CodEnt, dsEntFed FROM cEntFed ORDER BY dsEntFed ","fnLlenaMunicipios()","",50,true,true)%>
            <%=MyUtil.ObjComboC("Municipio","CodMD","",true,true,250,140,"0","SELECT CodMD, dsMunDel FROM cMunDel where CodMD = '' ","","",50,true,true)%>
        <%    
        } 
         %>
       <%=MyUtil.DoBlock("Detalle de Cobertura Regional del Proveedor",0,30)%>
       <%=MyUtil.GeneraScripts()%>
<%
 rs.close();
    rs=null;
    
    StrSql1=null;
    StrclProveedor=null;
    StrclCoberturaxProveedor=null;
    StrNomOpe=null;
    StrclPaginaWeb=null;
%>
</body>
</html>
