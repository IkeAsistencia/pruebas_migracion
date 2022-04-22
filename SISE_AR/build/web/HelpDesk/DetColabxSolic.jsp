<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="com.ike.helpdesk.DAOHelpdesk,com.ike.helpdesk.HDColabxSolic,java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
<head><title>Detalle Colaborador Asignado</title>
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
</head>
<body class="cssBody">
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
<script src='../Utilerias/Util.js' ></script>
<script src='../Utilerias/UtilMask.js'></script>
<%  
    String StrclUsrxSol = "0";
    String StrclUsrApp="0";
    String StrclSolicitud="0";
    String StrclUsrAppCol="0";
    
    if (session.getAttribute("clUsrApp")!= null)
     {
       StrclUsrApp = session.getAttribute("clUsrApp").toString(); 
     }  

    if (SeguridadC.verificaHorarioC((Integer.parseInt(StrclUsrApp))) != true) 
     {%>
       Fuera de Horario
       <%
        return; 
     }     
    
    if (request.getParameter("clSolicitud") != null)
    {
      StrclSolicitud= request.getParameter("clSolicitud");
    }
    else
    {
     if (session.getAttribute("clSolicitud")!= null)
     {
      StrclSolicitud = session.getAttribute("clSolicitud").toString(); 
     }  
    }
    session.setAttribute("clSolicitud", StrclSolicitud);
    /*    
    if (request.getParameter("clUsrAppCol")!= null)
    {
    StrclUsrAppCol = request.getParameter("clUsrAppCol").toString(); 
    }  
    */  
    if (request.getParameter("clUsrxSol")!= null)
     {
       StrclUsrxSol = request.getParameter("clUsrxSol").toString(); 
     }  
               
       boolean blnAbierto = false;
       boolean blnAdmin = false;
       ResultSet rs = null;
       StringBuffer StrSql = new StringBuffer();

       StrSql.append("Select coalesce(sum(cast(HDAdmin as tinyint)),0) HDAdmin ");
       StrSql.append("from PermisoPartxGpoPag PP " );
       StrSql.append("inner join UsrxGpo UxG on (PP.clGpoUsr = UxG.clGpoUsr)");
       StrSql.append("where UxG.clUsrApp = ").append(StrclUsrApp);

       rs = UtileriasBDF.rsSQLNP(StrSql.toString());
       StrSql.delete(0,StrSql.length());

       if (rs.next()) {
        if (rs.getString("HDAdmin").toString().compareToIgnoreCase("0")!=0){
          blnAdmin=true;
        }
       }

       DAOHelpdesk daoh = new DAOHelpdesk();
       HDColabxSolic  UsrxSol = null;
       if (StrclUsrxSol.compareToIgnoreCase("0")!=0){
            UsrxSol = daoh.getColabxSol(StrclUsrxSol);
       }
       String StrclPaginaWeb = "569";
       session.setAttribute("clPaginaWebP",StrclPaginaWeb); %>
        <SCRIPT>fnOpenLinks()</script> <%
       MyUtil.InicializaParametrosC(569,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina 

       if (UsrxSol != null){
           if (StrclUsrxSol.compareToIgnoreCase("0")==0){
            blnAbierto = true;
           }
       }
       
       %>
       <%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion","")%>
            <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="DetColabxSolic.jsp?'>"%>

<%            
StrclUsrAppCol = UsrxSol != null ? String.valueOf(UsrxSol.getClUsrApp()) : "0";

if(StrclUsrAppCol.equalsIgnoreCase("0")){%>
            <script>document.all.btnCambio.disabled=true;</script>
  <%}else{%>
            <script>document.all.btnAlta.disabled=true;</script>
  <%}

%>          
            
            <INPUT id='clSolicitud' name='clSolicitud' type='hidden' value='<%=StrclSolicitud%>'><br>
            <INPUT id='clUsrxSol' name='clUsrxSol' type='hidden' value='<%=StrclUsrxSol%>'><br>
            <%=MyUtil.ObjInput("Folio de Solicitud","clSolicitudVTR",StrclSolicitud,false,false,20,100,"",false,false,15)%>
            <%=MyUtil.ObjInput("clUsrAppAsigna","clUsrAppAsigna",UsrxSol != null ? String.valueOf(UsrxSol.getClUsrAppAsigna()) : session.getAttribute("clUsrApp").toString() ,false,false,20,140,session.getAttribute("clUsrApp").toString(),false,false,10)%>                        
            <%=MyUtil.ObjInput("Usuario que Asigna","UsuarioA",UsrxSol != null ? UsrxSol.getNombreUsrQueAsigna() : "",false,false,170,100,"",false,false,70)%>
            <%=MyUtil.ObjComboC("Colaborador Asignado","clUsrApp",UsrxSol != null ? UsrxSol.getNombreColaborador() : "",true,blnAdmin&&!blnAbierto&&true,20,140,"","select C.clUsrApp,US.Nombre from HDcColaborador C inner join cUsrApp US on (C.clUsrApp = US.clUsrApp) where C.clUsrApp not in (select clUsrApp from HDUsrxSol where clSolicitud= "+ StrclSolicitud + " and clUsrApp <> " + StrclUsrAppCol + ") order by US.Nombre","","",35,true,true)%>           
<%
              if (UsrxSol != null){
                  if ((UsrxSol.getclEstatus()!=6) && (UsrxSol.getclEstatus ()!=7)){
                    blnAbierto=true;
                  }
              }
            %>
            <%=MyUtil.ObjComboC("Estatus","clEstatus",UsrxSol != null ? UsrxSol.getDsEstatusSol() : "",false,blnAbierto&&true,270,140,"3","select clEstatus, dsEstatusSol from HDcEstatus where cltipoestatus = 2 order by dsEstatusSol ","","",30,true,true)%>
            <%=MyUtil.ObjInput("Fecha de Asignación","FechaAsignacionVTR",UsrxSol != null ? UsrxSol.getFechaAsignacion() : "",false,false,20,180,"",false,false,20,"")%>            
            <%=MyUtil.ObjInput("Fecha de Término","FechaTerminoVTR",UsrxSol != null ? UsrxSol.getFechaTermino() : "",false,false,170,180,"",false,false,20,"")%>
            <%=MyUtil.ObjTextArea("Observaciones","Observaciones",UsrxSol != null ? UsrxSol.getObservaciones() : "","100","7",true,blnAbierto&&true,20,220,"",true,true)%>
            <%=MyUtil.DoBlock("Detalle de Colaborador Asignado",150,70)%>

          <%=MyUtil.GeneraScripts()%>
          <%
            if (!blnAdmin && (blnAbierto==false || (StrclUsrApp.compareToIgnoreCase(UsrxSol != null ? String.valueOf(UsrxSol.getClUsrApp()) : StrclUsrApp)!=0))) { %>
              <script>document.all.btnCambio.disabled=true;</script>
            <% }

            
        StrSql=null;
          
        StrclUsrxSol = null;
        StrclUsrApp=null;
        StrclSolicitud=null;
        StrclUsrAppCol=null;  
        StrclPaginaWeb=null;
                  
        if(rs!=null){
            rs.close();
            rs=null;
        }        
          
        daoh=null;
        UsrxSol=null;
        
          %>
<script>
    document.all.D4.style.visibility='hidden';
</script>
<input name='FechaMsk' id='FechaMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
<input name='FechaSingleMsk' id='FechaSingleMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09'>

</body>
</html>