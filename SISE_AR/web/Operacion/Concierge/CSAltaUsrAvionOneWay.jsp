<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="Seguridad.SeguridadC,Combos.cbEntidad" errorPage="" %>
<html>
<head>
<title>Alta de Pasajero (One Way)</title>
</head>
<body class="cssBody">
<link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
<script src='../../Utilerias/Util.js'></script>
<script src='../../Utilerias/UtilMask.js'></script>
<script src='../../Utilerias/UtilDireccion.js'></script>
<%
       String strclUsr = "0";
       String StrclConcierge = "0";
       String StrclAsistencia = "0";
        
       if (session.getAttribute("clUsrApp")!= null) {
            strclUsr = session.getAttribute("clUsrApp").toString();
        }else{
            strclUsr= request.getParameter("clUsrApp").toString();
        } 
        
        if (request.getParameter("clConcierge")!= null) {
            StrclConcierge= request.getParameter("clConcierge").toString();
        } else{
            if (session.getAttribute("clConcierge")!= null) {
                StrclConcierge= session.getAttribute("clConcierge").toString();
            }
        }        
        
        if (session.getAttribute("clAsistencia")!= null) {
            StrclAsistencia = session.getAttribute("clAsistencia").toString();
        }else{
            StrclAsistencia= request.getParameter("clAsistencia").toString();
        }
       
       	String StrclPaginaWeb = "754";
	session.setAttribute("clPaginaWebP",StrclPaginaWeb);
       
       	MyUtil.InicializaParametrosC(754,Integer.parseInt(strclUsr));

    %>
     <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccion","","")%>

     <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="CSAltaUsrAvionOneWay2.jsp?'>"%>

                <INPUT id='clUsrApp' name='clUsrApp' type='hidden' value='<%=strclUsr%>'>
                <INPUT id='clAsistencia' name='clAsistencia' type='hidden' value='<%=StrclAsistencia%>'>
                <%=MyUtil.ObjInput("Nombre","Nombre","",true,true,200,80,"",true,false,50)%>
                <%=MyUtil.ObjComboC("Tipo","Tipo", "",true,true,30,80,"","select 0 Tipo,'ADULTO' dsTipo union Select 1 Tipo,'MENOR' dsTipo","","",30,true,false)%>
                
    <%=MyUtil.DoBlock("Registro de Pasajero",100,0)%> 
                <input type="button" class="cBtn" value="Cerrar" onclick="javascript:top.opener.fnLlenaPasajeros();window.close();">

    <%=MyUtil.GeneraScripts()%>
	<%
    	strclUsr = null;
%>
<script>
</script>
</body>
</html>
