<%-- 
    Document   : CSAltaEventoPreferencia
    Created on : 15/12/2009, 04:18:39 PM
    Author     : rfernandez
--%>

<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="Seguridad.SeguridadC,Combos.cbEntidad,com.ike.concierge.DAOConciergePreferencia,com.ike.concierge.ConciergePreferencia" errorPage="" %>
<html>
<head>
<title>Alta de Evento Preferencia</title>
</head>
<body class="cssBody">
<link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
<script src='../../Utilerias/Util.js'></script>
<script src='../../Utilerias/UtilMask.js'></script>
<script src='../../Utilerias/UtilDireccion.js'></script>
    <script src='../../Utilerias/UtilCalendarioV.js'></script>
    <link href="../../StyleClasses/Calendario.css" rel="stylesheet" type="text/css">
<%
       String strclUsr = "0";
       String StrclConcierge = "0";
       String StrclCSHistoricoP = "0";
       
       DAOConciergePreferencia daop=null;
       ConciergePreferencia conciergepre=null;

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
        if (request.getParameter("clCSHistoricoP")!= null) {
            StrclCSHistoricoP= request.getParameter("clCSHistoricoP").toString();
        } else{
            if (session.getAttribute("clCSHistoricoP")!= null) {
                StrclCSHistoricoP= session.getAttribute("clCSHistoricoP").toString();
            }
        }

       	String StrclPaginaWeb = "1072";
	session.setAttribute("clPaginaWebP",StrclPaginaWeb);

       	MyUtil.InicializaParametrosC(1072,Integer.parseInt(strclUsr));
         if(strclUsr!=null){
            daop = new DAOConciergePreferencia();
            conciergepre = daop.getConciergePreferencia(StrclCSHistoricoP);
        }
    %>
	<%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccion","","")%>

     <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="CSAltaEventoPreferencia2.jsp?'>"%>

                <INPUT id='clCSHistoricoP' name='clCSHistoricoP' type='hidden' value='<%=StrclCSHistoricoP%>'>
                <INPUT id='clConcierge' name='clConcierge' type='hidden' value='<%=StrclConcierge%>'>
                <INPUT id='clUsrApp' name='clUsrApp' type='hidden' value='<%=strclUsr%>'>

                <%=MyUtil.ObjComboC("Preferencia","clCSPreferencias", conciergepre!=null ? conciergepre.getdsCSPreferencias(): "",true,true,30,80,"","select clCSPreferencias,dsCSPreferencias from CScPreferencias","","",30,true,false)%>
                <%=MyUtil.ObjInput("Descripcion","Evento",conciergepre!=null ? conciergepre.getEvento():"",true,true,200,80,"",true,false,35)%>
            	              
    <%=MyUtil.DoBlock("Registro de Preferencia",20,0)%>
                <input type="button" class="cBtn" value="Cerrar" onclick="javascript:top.opener.location.reload();window.close();">

    <%=MyUtil.GeneraScripts()%>
	<%
    	strclUsr = null;
        daop=null;
        conciergepre=null;
%>

</body>
</html>
