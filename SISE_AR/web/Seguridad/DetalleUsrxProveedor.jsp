<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<html>
<head>
<title></title>
</head>
<body class="cssBody">
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
<script src='../Utilerias/Util.js'></script>
<%  
    String StrclUsrApp = "0";
    String StrclUsrAppParam = "0";
    String StrclProveedor = "0";
    
    
    if (session.getAttribute("clUsrApp")!= null){
        StrclUsrApp= session.getAttribute("clUsrApp").toString(); 
    }
    
    
    if (SeguridadC.verificaHorarioC( Integer.parseInt(StrclUsrApp)) != true){
        %>Fuera de Horario<%
        return;
    }
 
    if (session.getAttribute("clUsrAppParam")!= null){
        StrclUsrAppParam = session.getAttribute("clUsrAppParam").toString(); 
    }
    
    if (request.getParameter("clProveedor")!= null){
        StrclProveedor = request.getParameter("clProveedor").toString(); 
    }

    StringBuffer StrSQL = new StringBuffer();
    StrSQL.append(" Select U.Nombre, P.NombreOpe, * from UsrAppXProveedor UP");
    StrSQL.append(" inner join cUsrApp U on (U.clUsrApp = UP.clUsrApp)");
    StrSQL.append(" inner join cProveedor P on (P.clProveedor = UP.clProveedor)");
    StrSQL.append(" where UP.clProveedor=").append(StrclProveedor).append(" and UP.clUsrApp=").append(StrclUsrAppParam);
    
    ResultSet rs = UtileriasBDF.rsSQLNP( StrSQL.toString());
    StrSQL.delete(0,StrSQL.length());
    
    String StrclPaginaWeb = "412";
    session.setAttribute("clPaginaWebP",StrclPaginaWeb);
    
    MyUtil.InicializaParametrosC(412,Integer.parseInt(StrclUsrApp)); 
    %><%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion","")%>
    <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%>DetalleUsrxProveedor.jsp?'>
    <%
    if (rs.next()) {
        String StrNombre = rs.getString("Nombre");
                if (StrNombre ==null){
                    StrNombre = "";
                }
        %>
        <INPUT id='clUsrApp' name='clUsrApp' type='hidden' value='<%=StrclUsrAppParam%>'>
        <%=MyUtil.ObjInput("Nombre Usuario","clUsrAppVTR",StrNombre,false,false,30,70,StrNombre,false,false,60)%>
        <%=MyUtil.ObjInput("Proveedor","Proveedor",rs.getString("NombreOpe"),true,true,30,120,"",true,true,60,"if(this.readOnly==false){fnBuscaProv();}")%>
        <INPUT id='clProveedor' name='clProveedor' type='hidden' value='<%=StrclProveedor%>'><%
                if (MyUtil.blnAccess[4]==true){
                    %><div class='VTable' style='position:absolute; z-index:30; left:360px; top:130px;'>
                    <IMG SRC='../Imagenes/Lupa.gif' class='handM' onClick='fnBuscaProv();' WIDTH=20 HEIGHT=20></div><%
                } %>

        <%
    } else {
        %>
        <INPUT id='clUsrApp' name='clUsrApp' type='hidden' value='<%=StrclUsrAppParam%>'>
        <INPUT id='clProveedor' name='clProveedor' type='hidden' value='<%=StrclProveedor%>'>
        <%=MyUtil.ObjInput("Nombre Usuario","clUsrAppVTR","",false,false,30,70,"",false,false,60)%>
        <%=MyUtil.ObjInput("Proveedor","Proveedor","",true,true,30,120,"",true,true,60,"if(this.readOnly==false){fnBuscaProv();}")%>
        <%
                if (MyUtil.blnAccess[4]==true){
                    %><div class='VTable' style='position:absolute; z-index:30; left:360px; top:130px;'>
                    <IMG SRC='../Imagenes/Lupa.gif' class='handM' onClick='fnBuscaProv();' WIDTH=20 HEIGHT=20></div><%
                } %>

        <%
    }
    rs.close();
    rs=null;
    %><%=MyUtil.DoBlock("Usuario por Proveedor",200,10)%>
    <%=MyUtil.GeneraScripts()%>
<script> 
     function fnBuscaProv(){
         var pstrCadena = "../Utilerias/FiltrosProv.jsp?strSQL=sp_WebBuscaProveedores ";
         pstrCadena = pstrCadena + "&NombreOpe= " + document.all.Proveedor.value;
         document.all.clProveedor.value='';
         window.open(pstrCadena,'newWin','scrollbars=yes,status=yes,width=700,height=500');
    }
    
    function fnActualizaProv(pclProveedor, pNombreOperativo){
        document.all.clProveedor.value = pclProveedor;
        document.all.Proveedor.value = pNombreOperativo;
    }
</script>
</body>
</html>
