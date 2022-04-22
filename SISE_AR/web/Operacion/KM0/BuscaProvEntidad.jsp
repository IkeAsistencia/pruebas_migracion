<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="Combos.cbEntidad,Utilerias.UtileriasBDF,java.sql.ResultSet" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head><title>JSP Page</title> 
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <script src='../../../Utilerias/Util.js' ></script>
    <script src='../../Utilerias/Util.js'></script>
    <script src='../../Utilerias/UtilDireccion.js'></script>
    
    
    <body class="cssBody">
        <%-- <jsp:useBean id="beanInstanceName" scope="session" class="beanPackage.BeanClassName" /> --%>
        <%-- <jsp:getProperty name="beanInstanceName"  property="propertyName" /> --%>
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
        <%  
        com.ike.util.I18N i18n = com.ike.util.I18N.getInstance("es","AR");
        String StrSql = "";
        String StrclUsrApp="0";
        String StrclPaginaWeb="0";
        String StrCodEnt ="0";
        String StrStrEnt ="0";
        String StrCodMD ="0";
        String StrStrMD ="0";
        
        
        if (session.getAttribute("clUsrApp")!= null)
        {
            StrclUsrApp = session.getAttribute("clUsrApp").toString();
        }
        
        if (session.getAttribute("CodEnt")!= null)
        {
            StrCodEnt = session.getAttribute("CodEnt").toString().trim();
        }
        
        if (session.getAttribute("dsEntFed")!= null)
        {
            StrStrEnt = session.getAttribute("dsEntFed").toString().trim();
        }
        
        if (session.getAttribute("dsMunDel")!= null)
        {
            StrStrMD = session.getAttribute("dsMunDel").toString().trim();
        }
        
        if (session.getAttribute("CodMD")!= null)
        {
            StrCodMD = session.getAttribute("CodMD").toString().trim();
        }
        
        StrclPaginaWeb = "572";
        MyUtil.InicializaParametrosC(572,Integer.parseInt(StrclUsrApp));
        session.setAttribute("clPaginaWebP",StrclPaginaWeb); 
        
        %>
        <form target='proveedores' id='Forma' name ='Forma'  action='ProveedoresEntidad.jsp?' method='get'>
            
            <%=MyUtil.ObjComboMem(i18n.getMessage("message.title.entidad"),"CodEnt",StrCodEnt,"",cbEntidad.GeneraHTML(20,StrStrEnt),false,true,25,60,"","fnLlenaMunicipiosKM()","",20,false,false)%>                
            <%=MyUtil.ObjComboMem(i18n.getMessage("message.title.municipio"),"CodMD",StrCodMD, "", cbEntidad.GeneraHTMLMD(30,StrCodEnt, StrStrMD), true,true,250,60,"","","",20,false,false)%>
            <%=MyUtil.DoBlock("Ubicación",100,0)%>
            
            <div class='VTable' style='position:absolute; z-index:25; left:10px; top:10px;'>
            <P align='left'><input type='button' value='BUSCAR' onClick='fnBuscaProvEntidad()' class='cBtn'></input></p>
        </form>
        <%    
        StrSql = null; 
        StrclUsrApp=null;
        StrclPaginaWeb=null;
        
        %>
        <script>
document.all.CodEnt.value='<%=StrCodEnt%>';
document.all.CodMD.value='<%=StrCodMD%>';
//document.all.CodMDC.disabled=false;
function fnBuscaProvEntidad()
{ 
    document.all.Forma.submit();
}
        </script>
    </body>
</html>
