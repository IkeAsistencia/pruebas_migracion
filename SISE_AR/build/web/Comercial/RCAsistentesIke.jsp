<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="com.ike.ReuComer.DAORCAIKE,com.ike.ReuComer.to.RCAIKE,java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
<head><title>Registro de Copia</title>
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
</head>
<body class="cssBody">
<jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj" /> 
<script src='../Utilerias/Util.js' ></script>
<script src='../Utilerias/UtilMask.js'></script>

<%
    String strclUsrApp = "0";
    String strclAsistente = "0";
    String strclReunion = "0";
   
 
    if (session.getAttribute("clUsrApp")!=null)
    {
        strclUsrApp = session.getAttribute("clUsrApp").toString();
    }
   
    if (SeguridadC.verificaHorarioC((Integer.parseInt(strclUsrApp))) != true)
    {
%>
        Fuera de Horario
<%
        return; 
    }     

   if (request.getParameter("clReunion")!= null)
    {
        strclReunion = request.getParameter("clReunion").toString(); 
    }  
    else{
        if (session.getAttribute("clReunion")!= null)
        {
           strclReunion= session.getAttribute("clReunion").toString(); 
        }  
    }
    
   if (request.getParameter("clAsistente")!= null)
    {
        strclAsistente = request.getParameter("clAsistente").toString(); 
    }

    DAORCAIKE daoRCAIke = null;

    RCAIKE AsistenteIke = null;
    if (strclReunion.compareToIgnoreCase("0")!=0)
    {
        daoRCAIke = new DAORCAIKE();
        AsistenteIke = daoRCAIke.getAsistente(strclAsistente);
    }
    
       String StrclPaginaWeb = "668";
       session.setAttribute("clPaginaWebP",StrclPaginaWeb); 
       MyUtil.InicializaParametrosC(668,Integer.parseInt(strclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina 
    
%>
    <script>fnOpenLinks()</script>
    <%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion","","")%>
    <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%>../servlet/Utilerias.Lista?P=667&Apartado=S'></input>
    <INPUT id='clAsistente' name='clAsistente' type='hidden' value='<%=AsistenteIke != null ? AsistenteIke.getclAsistente() : ""%>'>
    <INPUT id='clReunion' name='clReunion' type='hidden' value='<%= strclReunion %>'>
    
    <%=MyUtil.ObjInput("Asistente","Asistente",AsistenteIke != null ? AsistenteIke.getNombre() : "",true,true,30,115,"",true,false,50,"if(this.readOnly==false){fnBuscaUsuario();}")%>
    <INPUT id='clUsrAppAsistente' name='clUsrAppAsistente' type='hidden' value='<%=AsistenteIke != null ? AsistenteIke.getclUsrAppAsistente() : "" %>'>
    <div class='VTable' style='position:absolute; z-index:25; left:300px; top:130px;'>
    <IMG SRC='../Imagenes/Lupa.gif' onClick='fnBuscaUsuario();' WIDTH=20 HEIGHT=20></div>
    <%=MyUtil.DoBlock("Asistentes Ike Asistencia",120,20)%>
    
    <%=MyUtil.GeneraScripts()%>
<script>
    function fnBuscaUsuario()
    {
     if (document.all.Asistente.value!='')
     {
      if (document.all.Action.value==1 || document.all.Action.value==2)
      {
       var pstrCadena = "../Utilerias/FiltroRCAsistentesIke.jsp?";
       pstrCadena = pstrCadena + "NombreUsr=" + document.all.Asistente.value + "&Criterio=0&clReunion=" + document.all.clReunion.value
       document.all.Asistente.value='';
       window.open(pstrCadena,'newWin','scrollbars=yes,status=yes,width=700,height=500');
      } 
     }
    }

    function fnActualizaDatosUsuario(Nombre,clUsrAppAsistente)
    {
     document.all.Asistente.value = Nombre;			
     document.all.clUsrAppAsistente.value = clUsrAppAsistente;
    }
    
</script>
</body>
</html>