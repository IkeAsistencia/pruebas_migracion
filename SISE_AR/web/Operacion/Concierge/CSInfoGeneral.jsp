<%-- 
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="Seguridad.SeguridadC,Combos.cbEstatus,com.ike.concierge.DAOConciergeG,com.ike.concierge.to.ConciergeG" errorPage="" %>
<html>
    <head><title>Solicitud de Informacion General</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" id="cssRef" href="floating_window_with_tabs-skin2.css" media="screen">
        <script type="text/javascript">
            var floating_window_skin = 2;
        </script>
        <script type="text/javascript" src="floating_window_with_tabs.js"></script>
    </head>
    <body class="cssBody" onload="fnVerificaFecha();">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
        <script src='../../Utilerias/Util.js' ></script>
        <script src='../../Utilerias/UtilConciergeAsistencias.js'></script>
        <script src='../../Utilerias/UtilMask.js'></script> 
        <div class='VTable' style='position:absolute; z-index:25; left:400px; top:15px;'><p align="center"><font color="navy" face="Arial" size="3" ><b><i> Banquetes y Eventos Privados </i></b>  <br> </p></div>
        <script src='../../Utilerias/UtilCalendarioV.js'></script>
        <link href="../../StyleClasses/Calendario.css" rel="stylesheet" type="text/css">
        <%  
        String StrclConcierge = "";
        String StrclSubservicio = "";
        String StrclAsistencia = "0";
        String strclUsr = "";
        /*DAOConciergeBanquete daos=null;
        Conciergebanquete conciergebanquete=null;*/
        DAOConciergeG daosg=null;
        ConciergeG conciergeg=null;
        
        if (session.getAttribute("clUsrApp")!= null) {
            strclUsr = session.getAttribute("clUsrApp").toString();
        }
        
        if (session.getAttribute("clConcierge")!= null) {
            StrclConcierge= session.getAttribute("clConcierge").toString();
        }
        
        if (request.getParameter("clAsistencia")!= null) {
            StrclAsistencia= request.getParameter("clAsistencia").toString();
        } else{
            if (session.getAttribute("clAsistencia")!= null) {
                StrclAsistencia= session.getAttribute("clAsistencia").toString();
            }
        }
        if (request.getParameter("clSubservicio")!= null) {
            StrclSubservicio= request.getParameter("clSubservicio").toString();
        } else{
            if (session.getAttribute("clSubservicio")!= null) {
                StrclSubservicio= session.getAttribute("clSubservicio").toString();
            }
        }
        session.setAttribute("clAsistencia",StrclAsistencia);
        session.setAttribute("clSubservicio",StrclSubservicio);
        String StrclPaginaWeb = "749";
        session.setAttribute("clPaginaWebP",StrclPaginaWeb);
       /* if(strclUsr!=null){
            daos = new DAOConciergeBanquete();
            //conciergebanquete = daos.getCSBanquete(StrclAsistencia);
            conciergebanquete= daos.getCSBanquete(StrclAsistencia);
        }*/
        if(strclUsr!=null){
            daosg = new DAOConciergeG();
            conciergeg = daosg.getConciergeGenerico(StrclConcierge);
        }
        %>
        <SCRIPT>fnOpenLinks()</script> 
        <%        
        MyUtil.InicializaParametrosC(749,Integer.parseInt(strclUsr)); 
        %><%=MyUtil.doMenuAct("../../servlet/Concierge.CSAltaInfoGeneral","fnAccionesAlta();","fnAntesGuardar();")%><%
        
        %><%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="CSInfoGeneral.jsp?'>"%>
        
        <INPUT id='clConcierge' name='clConcierge' type='hidden' value='<%=StrclConcierge%>'>
        <INPUT id='FechaApAsist' name='FechaApAsist' type='hidden' value=''>
        <INPUT id='clAsistencia' name='clAsistencia' type='hidden' value='<%=StrclAsistencia%>'>
        <%String strEstatus = conciergeinfogral!=null ? conciergeinfogral.getDsEstatus() : ""; %>
        <%=MyUtil.ObjComboC("Estatus","clEstatus",conciergeinfogral!=null ? conciergeinfogral.getDsEstatus(): "",false,false,30,80,conciergeinfogral!=null ? conciergeinfogral.getclEstatus(): "","sp_GetCSstatus","","",30,false,false)%>
        <%=MyUtil.ObjInput("Asistencia","AsistenciaVTR",conciergeinfogral!=null ? conciergeinfogral.getClAsistencia().trim() : "",false,false,350,80,conciergeinfogral!=null ? conciergeinfogral.getClAsistencia().trim() : "",false,false,10)%>
        <%=MyUtil.ObjTextArea("Descripcion del Evento","Comentarios",conciergeinfogral!=null ? conciergeinfogral.getDsEstatus(): "","83","3",true,true,30,120,"",true,true)%>
        <%=MyUtil.DoBlock("Datos Generales del Evento",300,10)%>
        
        <%=MyUtil.ObjInput("Información Solicitada","Informacion",conciergeinfogral!=null ? conciergeinfogral.getdsEstatus() : "",true,true,30,220,"",true,true,75)%>
        <%=MyUtil.ObjInput("Ciudad","Ciudad",conciergeinfogral!=null ? conciergeinfogral.getdsEstatus() : "",true,true,30,260,"",false,false,50)%>
        <%=MyUtil.ObjInput("Estado","Estado","",true,true,350,260,"",false,false,50)%>
        <%=MyUtil.ObjInput("Pais","Pais","",true,true,650,260,"",false,false,50)%>
        <%=MyUtil.ObjInputF("Fecha Inicio<strong>(aaaa/mm/dd hh:mm)</strong>","FechaI","",true,true,30,300,"",true,true,20, 2, "")%>  </div>
        <%=MyUtil.ObjInputF("Fecha Termino<strong>(aaaa/mm/dd hh:mm)</strong>","FechaT", "",true,true,300,255,"",true,true,20, 2, "")%>  </div>        
        <%=MyUtil.ObjInput("Telefono","Telefono", "",true,true,30,340,"",true,true,25)%>
        <%=MyUtil.ObjInput("Celular","Celular","",true,true,350,340, "",true,true,25)%>
        <%=MyUtil.ObjInput("Email","Email", "",true,true,30,380,"",true,true,25)%>
        <%=MyUtil.ObjInput("Otro","Otro","",true,true,350,380, "",true,true,25)%>
        <%=MyUtil.ObjInput("Archivo Enviado","Archivo","",true,true,30,380, "",true,true,75)%>
        <%=MyUtil.ObjInput("Ubicación","Ubicacion","",true,true,30,420, "",true,true,75)%>
        <%=MyUtil.DoBlock("Informacion General",100,5)%>
        
        <input name='FechaProgMsk' id='FechaProgMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
       
        <%@ include file="csVentanaFlotante.jspf" %>
        
        <%
        StrclConcierge = null;
        StrclSubservicio = null;
        StrclAsistencia = null;
        /*daos=null;
        conciergebanquete=null;*/
        daosg=null;
        conciergeg=null;
        %>
        <%=MyUtil.GeneraScripts()%>
        <script>

      
function fnAccionesAlta(){
   if (document.all.Action.value==1){
      
             var pstrCadena = "../../Utilerias/RegresaFechaActual.jsp";
             window.open(pstrCadena,'newWin','width=10,height=10,left=1500,top=2000');
       
     }
}
function fnActualizaFechaActual(pFecha){
document.all.FechaApAsist.value = pFecha;			
}
//Función para quitarle los cero a la fecha
function fnVerificaFecha() {
     document.all.FechaI.value=fnFechaID(document.all.FechaI.value);
     document.all.FechaT.value=fnFechaID(document.all.FechaT.value);
}

//función que regresa la fecha sin hora
function fnFechaID(Fecha){
       if (Fecha!=""){
          FechaSinHora=Fecha;
          FechaSinHora=FechaSinHora.substring(0,10);
          return FechaSinHora;
       }
       else {
          FechaSinHora='';
          return FechaSinHora;
       }
}
        </script>
        <script type="text/javascript">
    initFloatingWindowWithTabs('window4',Array('Datos de Nuestro Usuario'),250,100,500,20,false,false,true,true,false);
        </script>
    </body>
</html>   
--%>