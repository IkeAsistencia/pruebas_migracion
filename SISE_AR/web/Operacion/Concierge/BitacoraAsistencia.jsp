<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC,com.ike.concierge.DAOConciergeG,com.ike.concierge.to.ConciergeG,com.ike.concierge.DAOReferenciasxAsist,com.ike.concierge.to.ReferenciasxAsist" errorPage="" %>
<html>
    <head>
        <title>Agenda Concierge</title>
        <link rel="stylesheet" id="cssRef" href="floating_window_with_tabs-skin2.css" media="screen">
        <script type="text/javascript">
            var floating_window_skin = 2;
        </script>
        <script type="text/javascript" src="floating_window_with_tabs.js"></script>     
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <title>Bitácora de Expediente</title>
    </head>
    <script src='../../Utilerias/Util.js'></script>
    
    <%
    String StrclUsrApp="0";
    String StrclConcierge = "";
    String StrclAsistencia="0";
    DAOConciergeG daosg=null;
    ConciergeG conciergeg=null;
    
    DAOReferenciasxAsist daoRef=null;
    ReferenciasxAsist ref=null;   
    
    if (session.getAttribute("clUsrApp")!= null){
        StrclUsrApp = session.getAttribute("clUsrApp").toString();
    }
    
    if (session.getAttribute("clConcierge")!= null) {
        StrclConcierge= session.getAttribute("clConcierge").toString();
    }
    /*if (session.getAttribute("clAsistencia")!= null){
    StrclAsistencia = session.getAttribute("clAsistencia").toString();
    }*/
    if (request.getParameter("clAsistencia")!= null) {
        StrclAsistencia= request.getParameter("clAsistencia").toString();
    } else{
        if (session.getAttribute("clAsistencia")!= null) {
            StrclAsistencia= session.getAttribute("clAsistencia").toString();
        }
    }
    if(StrclUsrApp!=null){
        daosg = new DAOConciergeG();
        conciergeg = daosg.getConciergeGenerico(StrclConcierge);
        
        daoRef = new DAOReferenciasxAsist();
        ref = daoRef.getclAsistencia(StrclAsistencia);
    }
    
	//---------------------------------------------------------------
	// SE AGREGA CODIGO PARA EL MANEJO DE LAS ASISTENCIAS DUPLICADAS.
    String StrclAsistenciaVTR = "";
    if(session.getAttribute("clAsistenciaVTR")!=null){
        StrclAsistenciaVTR = session.getAttribute("clAsistenciaVTR").toString();
    }
	//---------------------------------------------------------------	
    
    if (StrclAsistencia.equalsIgnoreCase(null) || StrclAsistencia.equalsIgnoreCase("0")) {
    %>
    <%="Debe de Ingresar una Asistencia Valida, Consulte a sus administrador"%>
    <%
    return;
    }
    
    if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {
    %>Fuera de Horario<%
    StrclUsrApp=null;
    StrclAsistencia=null;
    return;
    }
    String StrclPaginaWeb = "720";
    session.setAttribute("clPaginaWebP",StrclPaginaWeb);
    %><body class='cssBody' topmargin='10'>
        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj"/>
        <p class='cssTitDet'>Bitácora de Asistencia</p>
        <SCRIPT>fnOpenLinks()</script>
        <% 
        
        MyUtil.InicializaParametrosC(720,Integer.parseInt(StrclUsrApp));
        
        StringBuffer strSql = new StringBuffer();
        StringBuffer strSalida = new StringBuffer();
        UtileriasBDF.rsTableNP(strSql.append("sp_BitacoraAsis ").append(StrclAsistencia).append(",0,").append(StrclUsrApp).toString(), strSalida);
        %><%=strSalida.toString()%><%
        strSql.delete(0,strSql.length());
        strSalida.delete(0,strSalida.length());
        %>
        </table>
        <p class='cssTitDet'>Bitácora de Referencia</p>
        <% 
        UtileriasBDF.rsTableNP(strSql.append("sp_BitacoraAsis ").append(StrclAsistencia).append(",1,").append(StrclUsrApp).toString(), strSalida);
        %><%=strSalida.toString()%><%
        strSql.delete(0,strSql.length());
        strSalida.delete(0,strSalida.length());
        
        %>
        <%@ include file="csVentanaFlotante.jspf" %>
        <%
        
        strSalida = null;
        strSql=null;
        StrclUsrApp=null;
        StrclAsistencia=null;
        conciergeg=null;
        StrclConcierge = null;
        daosg=null;
        daoRef=null;
        ref=null;
        %>
        </table>
        <script type="text/javascript">
            initFloatingWindowWithTabs('window4',Array('Nuestro Usuario','Referencias'),350,250,700,20,false,false,true,true,false);
        </script>
    </body>
</html>
