<%--
 Document   : EquipoSalidaSP
 Create on  : 2011-03-14
 Author     : bsanchez
--%>

<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%@ page import="Utilerias.UtileriasBDF,Seguridad.SeguridadC,java.sql.ResultSet,com.ike.helpdeskSP.DAOEquipoSalidaSP,com.ike.helpdeskSP.to.EquipoSalidaSP;" %>

<html>
    <head><title>EquipoSalidaSP</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj"/>
        <script src='../Utilerias/Util.js' ></script>
        <script src='../Utilerias/UtilStore.js' ></script>
        <script src='../Utilerias/UtilCalendario.js' ></script>
        <link href='../StyleClasses/Calendario.css' rel='stylesheet' type='text/css'>
        
        <% 
        String StrclUsr  = "0";
        String StrclPaginaWeb  = "0";
        String StrclEquipoSalidaSP = "0";
        
        if ( session.getAttribute("clUsrApp") != null) {
            StrclUsr = session.getAttribute("clUsrApp").toString();
        }
        
        if ( SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsr) ) != true ) {  %> 
        Fuera de Horario <% 
        StrclUsr = null;
        StrclPaginaWeb = null;
        StrclEquipoSalidaSP = null;
        return;
        }
        
        if ( request.getParameter("clEquipoSalidaSP")!= null )  {
            StrclEquipoSalidaSP = request.getParameter("clEquipoSalidaSP").toString();
            session.setAttribute("clEquipoSalidaSP",StrclEquipoSalidaSP);
        } else {
            if ( session.getAttribute("clEquipoSalidaSP")!= null )  {
                StrclEquipoSalidaSP = session.getAttribute("clEquipoSalidaSP").toString();
            }
        }
        
        DAOEquipoSalidaSP daoEquipoSalidaSP = null;
        EquipoSalidaSP  ES = null;
        
        if(Integer.valueOf(StrclEquipoSalidaSP) > 0){
            daoEquipoSalidaSP = new DAOEquipoSalidaSP();
            ES = daoEquipoSalidaSP.getclEquipoSalidaSP(StrclEquipoSalidaSP.toString());
        }
        
        
        
        %><script>fnOpenLinks()</script><% 
        
        StrclPaginaWeb = "1334";
        session.setAttribute("clPaginaWebP",StrclPaginaWeb);
        
        //<<<<<<<<<<<< Servlet Generico >>>>>>>>>>>
        String Store = "";
        Store="st_GuardaEquipoSalidaSP,st_ActualizaEquipoSalidaSP";
        session.setAttribute("sp_Stores",Store);
        
        session.setAttribute("clEquipoSalidaSP",StrclEquipoSalidaSP);
        
        String Commit = "";
        Commit = "clEquipoSalidaSP";
        session.setAttribute("Commit",Commit);
        
        %> 
        
        <%MyUtil.InicializaParametrosC(Integer.parseInt(StrclPaginaWeb),Integer.parseInt(StrclUsr));%>
        <%=MyUtil.doMenuAct("../servlet/com.ike.guarda.EjecutaSP","fn_Alta();","fn_Cambio();","fnsp_Guarda();")%>
        
        
        <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="EquipoSalidaSP.jsp?'>"%> 
        
        <input id="clPaginaWeb" name="clPaginaWeb" type="hidden" value="<%=StrclPaginaWeb%>" > 
        <input id="Secuencia" name="Secuencia" type="hidden" value=""> 
        <input id="SecuenciaG" name="SecuenciaG" type="hidden" value="ResponsableEntrega,ResponsableSalida,FechaEntrega,FechaSalida,Comentarios,clEstatus"> 
        <input id="SecuenciaA" name="SecuenciaA" type="hidden" value="clEquipoSalidaSP,ResponsableEntrega,ResponsableSalida,FechaEntrega,FechaSalida,Comentarios,clEstatus,clEstatusES"> 
        <input id="clUsrApp" name="clUsrApp" type="hidden" value="<%=StrclUsr%>" > 
        
        <%  int iY = 80; %>
        
        <input id="clEquipoSalidaSP" name="clEquipoSalidaSP" type="hidden" value="<%=StrclEquipoSalidaSP%>" > 
        
        <%=MyUtil.ObjInput("Folio","clEquipoSalida",ES != null ? ES.getclEquipoSalidaSP():"",false,false,30,iY+10,"",false,false,20)%> 
        
        <%=MyUtil.ObjInput("Responsable Entrega","ResponsableEntrega",ES != null ? ES.getResponsableEntrega():"",true,true,350,iY+50,"",true,true,50)%> 
        
        <%=MyUtil.ObjInput("Responsable Salida","ResponsableSalida",ES != null ? ES.getResponsableSalida():"",true,true,30,iY+50,"",true,true,50)%> 
        
        <INPUT id='clUsrAppSP' name='clUsrAppSP' type='hidden' value=''>
        <%=MyUtil.ObjInput("Usuario que solicita", "NombreSP", "", false, false, 670, iY+50, "", true, false, 50, "")%>
        <div class='VTable' style='position:absolute; z-index:25; left:925px; top:135px;'>
        <IMG SRC='../Imagenes/Lupa.gif' onClick='fnBuscaUsrSP();' WIDTH=20 HEIGHT=20></div>
        
        <%=MyUtil.ObjInputF("Fecha Entrega (AAAA-MM-DD)","FechaEntrega",ES != null ? ES.getFechaEntrega(): "",true,true,350,iY+100,"",false,false,20,1,"")%> 
        
        <%=MyUtil.ObjInputF("Fecha Salida (AAAA-MM-DD)","FechaSalida",ES != null ? ES.getFechaSalida(): "",true,true,30,iY+100,"",false,false,20,1,"")%> 
        
        <%=MyUtil.ObjTextArea("Comentarios","Comentarios",ES != null ? ES.getComentarios(): "","100","5",true,true,30,iY+190,"",false,false)%> 
        
        <%=MyUtil.ObjComboC("Motivo de Salida","clEstatus",ES != null ? ES.getdsMotivoSalida(): "",true,true,30,iY+270,"","Select clEstatus, dsEstatus from  cEstatusPerifericos Where clEstatus in (5,6,7,8,9)","","",20,true,true)%> 
        
        <%=MyUtil.ObjComboC("Estatus Hoja de Equipo de Salida","clEstatusES",ES != null ? ES.getDsEstatusES(): "",true,true,300,iY+270,"","Select clEstatus, dsEstatus from dbo.cEstatusSP where clEstatus in (3,4)","","",20,false,true)%> 
        
        <%=MyUtil.DoBlock("Detalle Equipo de Salida",300,15)%> 
        
        <%=MyUtil.GeneraScripts()%> 
        
        <div  id="asigna" name="asigna" class='VTable' style='position:absolute; z-index:25; left:600px; top:250px; visibility:hidden'>
        <INPUT ID="Buscar" name="Buscar" type='button' VALUE='Asignar Equipo...' onClick="location.href='../servlet/Utilerias.Lista?P=1339&Apartado=S'" class='cBtn'></div>  
        
        <% if(ES != null){
        %><script>document.all.asigna.style.visibility='visible';</script><%
        }
        %>
        <%  //<<<<<<<<<<<<<<<< Limpiar Variables >>>>>>>>>
        StrclUsr = null;
        StrclPaginaWeb = null;
        StrclEquipoSalidaSP=null;
        daoEquipoSalidaSP = null;
        ES = null;  
        %>  
        
        <script>
//----------------------------------------------------------------------
function fn_Alta(){
          document.all.asigna.style.visibility='hidden';
}
//----------------------------------------------------------------------
function fn_Cambio(){
document.all.asigna.style.visibility='hidden';
}

 function fnBuscaUsrSP(){

            if (document.all.Action.value==1 || document.all.Action.value==2){
                var pstrCadena = "../Utilerias/FiltroUsrSP.jsp?strSQL=sp_BuscaUsrSP ";
                pstrCadena = pstrCadena + "&Usuario= " + document.all.NombreSP.value;
                window.open(pstrCadena,'newWin','scrollbars=yes,status=yes,width=700,height=500,top=200,left=50');
            }
        }

        function fnActualizaUsrSP(NombreSP,clUsrAppSP,Correo){

            if (document.all.Action.value ==1 || document.all.Action.value==2){
                document.all.NombreSP.value = NombreSP;
                document.all.clUsrAppSP.value = clUsrAppSP;
               //document.all.Correo.value=Correo;
            }
        }

        function fnLimpiaCampos(){
            document.all.clUsrAppSP.value='0';
        }

        </script>
    </body>
</html>
