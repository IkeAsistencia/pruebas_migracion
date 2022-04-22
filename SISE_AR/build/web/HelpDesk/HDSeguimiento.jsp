<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<html>
<head>
<title></title>
</head>
<body class="cssBody">
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
<jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj"/>
<script src='../Utilerias/Util.js'></script>
<script src='../Utilerias/UtilProveedor.js'></script>
<%  
  String StrclSolicitud = "0";
  String strclUsrApp = "0";
      
  if (session.getAttribute("clUsrApp")!= null)
  {
   strclUsrApp = session.getAttribute("clUsrApp").toString();
  }  

  if (SeguridadC.verificaHorarioC(Integer.parseInt(strclUsrApp)) != true) 
  {
%>
Fuera de Horario
<%
  return;  
  }    

  if (session.getAttribute("clSolicitud")!= null)
  {
   StrclSolicitud= session.getAttribute("clSolicitud").toString(); 
  }  
        
  String StrclPaginaWeb = "599";
  session.setAttribute("clPaginaWebP",StrclPaginaWeb); 
  MyUtil.InicializaParametrosC(599,Integer.parseInt(strclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina 
%>
<SCRIPT>fnOpenLinks()</script>   
<%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion","")%>
<%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="DetalleSolicitud.jsp?'>"%>        

<INPUT id='clSolicitud' name='clSolicitud' type='hidden' value='<%=StrclSolicitud%>'> 
<INPUT id='clUsrApp' name='clUsrApp' type='hidden' value='<%=strclUsrApp%>'>        
<%=MyUtil.ObjComboC("Estatus","clEstatus","",true,true,30,70,"","select clEstatus,dsEstatusSol from HDcEstatus where clTipoEstatus = 4","","",50,true,false)%>
<%=MyUtil.ObjTextArea("Observaciones","Observaciones","","100","7",true,true,30,110,"",true,false)%>
<%=MyUtil.DoBlock("Seguimiento de solicitud",340,90)%>

<%=MyUtil.GeneraScripts()%>
<%
  StrclSolicitud =null;
  strclUsrApp =null;
  StrclPaginaWeb=null;
  
%>
</body>
</html>
