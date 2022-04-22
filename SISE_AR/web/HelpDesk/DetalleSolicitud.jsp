<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="com.ike.helpdesk.DAOHelpdesk,com.ike.helpdesk.HDSolicitud,java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head><title>Detalle Solicitud de Usuario</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
        <script src='../Utilerias/Util.js' ></script>
        <script src='../Utilerias/UtilMask.js'></script>
        <%  
        String StrclSolicitud = "0";
        String StrclUsrApp="0";
        String blnCambiaFecha = "0";
        
        if (session.getAttribute("clUsrApp")!= null) {
            StrclUsrApp = session.getAttribute("clUsrApp").toString();
        }
        
        
        if (request.getParameter("clSolicitud") != null) {
            StrclSolicitud = request.getParameter("clSolicitud");
        } else {
            if (session.getAttribute("clSolicitud")!= null) {
                StrclSolicitud = session.getAttribute("clSolicitud").toString();
            }
        }
        session.setAttribute("clSolicitud", StrclSolicitud);
        
        ResultSet rs = null;
        
        boolean blnAdmin = false;
        boolean blnAbierto = false;
        boolean blnRevisada = true;
        
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
                blnCambiaFecha = "1";
                
            }
        }
        
        DAOHelpdesk daoh = null;
        HDSolicitud  Solicitud = null;
        
        if (StrclSolicitud.compareToIgnoreCase("0")!=0){
            daoh = new DAOHelpdesk();
            Solicitud = daoh.getSolicitud(StrclSolicitud);
        %><SCRIPT>fnOpenLinks()</script>
        <%
        }
        String StrclPaginaWeb = "464";
        session.setAttribute("clPaginaWebP",StrclPaginaWeb);
        MyUtil.InicializaParametrosC(464,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
        if (StrclSolicitud.compareToIgnoreCase("0")==0){
            blnAbierto = true;
            blnRevisada = false;
        }
        
        %>
        <%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion","")%>
        <%
        if (Solicitud==null) {
        %><script>document.all.btnCambio.disabled=true;</script>
        
        <%
        }else{
            if (blnCambiaFecha.equalsIgnoreCase("1")){
        %>                                        
        <div class='VTable' style='position:absolute; z-index:40; left:550px; top:180px;'>
            <input class='cBtn' type='button' value='Cambiar Fecha Compromiso' onClick="window.open('CambiarFechaComp.jsp?&clSolicitud=<%=StrclSolicitud%>','','resizable=no,menubar=0,status=0,toolbar=0,height=250,width=600,screenX=-50,screenY=0')"></input>
        </div>
        <%}
        }
        
        %>
        <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="DetalleSolicitud.jsp?'>"%>
        
        <div class='VTable' style='position:absolute; z-index:40; left:300px; top:130px;'>
            
            <input class='cBtn' type='button' value='Con copia para...' onClick="if(document.all.Action.value==1){location.href='RegistraCopia.jsp?tipo=1';}else {location.href='RegistraCopia.jsp?tipo=0';}"></input>                                          
            
        </div>
        
        <INPUT id='clSolicitud' name='clSolicitud' type='hidden' value='<%=StrclSolicitud%>'>
        
        <%=MyUtil.ObjInput("Usuario que Registra","clUsrAppRegistra",Solicitud!=null ? String.valueOf(Solicitud.getClUsrRegistra()) : StrclUsrApp,false,false,600,90,StrclUsrApp,false,false,10)%>
        <%=MyUtil.ObjInput("Usuario que Revisa","clUsrRevisa",Solicitud!=null ? String.valueOf(Solicitud.getClUsrRevisa()) : "",false,false,600,130,"",false,false,10)%>
        <%=MyUtil.ObjInput("Usuario que Valida","clUsrValidaFirmas",Solicitud!=null ? String.valueOf(Solicitud.getClUsrValFirmas()) : "",false,false,700,130,"",false,false,10)%>
        
        <%=MyUtil.ObjInput("Solicitud","clSolicitudVtr",StrclSolicitud,false,false,20,70,"",false,false,10)%>
        <%=MyUtil.ObjInput("Usuario que Registra","UsuarioR",Solicitud!=null ? Solicitud.getUsrRegistra() : "",false,false,100,70,session.getAttribute("NombreUsuario").toString(),false,false,50)%>
        <%=MyUtil.ObjInput("Fecha de Registro","FechaRegistroVTR",Solicitud!=null ? Solicitud.getFechaRegistro() : "",false,false,450,70,"",false,false,20,"")%>
        <%
        if (Solicitud !=null){
            if ((Solicitud.getclEstatus()!=2) && (Solicitud.getclEstatus()!=5)){
                blnAbierto=true;
            }
            if (Solicitud.getRevisadaxSistemas().compareToIgnoreCase("No")==0){
                blnRevisada=false;
            }
        }
        %>
        <%=MyUtil.ObjComboC("Estatus","clEstatus",Solicitud !=null ? Solicitud.getDsEstatusSol() : "",false,!blnRevisada||blnAdmin,580,70,"1","select clEstatus, dsEstatusSol from HDcEstatus where cltipoestatus = 1 order by dsEstatusSol ","","",30,true,true)%>
        <%=MyUtil.ObjComboC("Tipo de Solicitud","clTipoSol",Solicitud!=null ? Solicitud.getDsTipoSol() : "",true,!blnRevisada||blnAdmin,20,120,"0","select clTipoSol, dsTipoSol from HDcTipoSol where activo= 1 order by dsTipoSol ","","",60,true,true)%>
        <%=MyUtil.ObjInput("Fecha Compromiso<br>aaaa/mm/dd","FechaCompromiso",Solicitud!=null ? Solicitud.getFechaCompromiso() : "",blnAdmin,false,420,157,"",false,false,20,"if(this.readOnly==false){fnValMask(this,document.all.FechaSingleMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("Asunto","Asunto",Solicitud!=null ? Solicitud.getAsunto() : "",true,!blnRevisada||blnAdmin,20,170,"",true,true,70,"")%>
        <%=MyUtil.ObjTextArea("Detalle de la Solicitud","DetalleSol",Solicitud!=null ? Solicitud.getDetalleSolicitud() : "","100","5",true,!blnRevisada||blnAdmin,20,215,"",true,true)%>
        <%=MyUtil.DoBlock("Detalle de Solicitud",0,60)%>
        
        <%=MyUtil.ObjComboC("Revisada","RevisadaxSistemas",Solicitud!=null ? Solicitud.getRevisadaxSistemas() : "" ,false,blnAdmin,20,370,"0","Select 0, 'No' union select 1, 'Si' ","if(this.value=='1'){document.all.clUsrRevisa.value='"+session.getAttribute("clUsrApp").toString()+"'}else{document.all.clUsrRevisa.value=''}","",10,true,true)%>            
        <%=MyUtil.ObjInput("Usuario que Revisa","UsuarioRev",Solicitud!=null ? Solicitud.getUsrRevisa() : "",false,false,180,370,"",false,false,50)%>            
        <%=MyUtil.ObjInput("Fecha de Revisión","FechaRevisVTR",Solicitud!=null ? Solicitud.getFechaRevis() : "",false,false,450,370,"",false,false,20,"")%>
        <%=MyUtil.ObjComboC("Prioridad","clPrioridadHD",Solicitud!=null ? Solicitud.getDsPrioridadHD() : "",true,blnAdmin,600,370,"","select clPrioridadHD, dsPrioridadHD from HDcPrioridad order by dsPrioridadHD ","","",30,true,true)%>
        <%=MyUtil.ObjComboC("Requiere Firmas","RequiereFirmas",Solicitud!=null ? Solicitud.getRequiereFirmas() : "",false,blnAdmin,20,415,"0","Select 0, 'No' union select 1, 'Si' ","","",10,true,true)%>            
        <%=MyUtil.ObjComboC("Firmas Recabadas","Firmas",Solicitud!=null ? Solicitud.getFirmas() : "",false,blnAdmin,180,415,"0","Select 0, 'No' union select 1, 'Si' ","if(this.value=='1'){document.all.clUsrValidaFirmas.value='"+session.getAttribute("clUsrApp").toString()+"'}else{document.all.clUsrValidaFirmas.value=''}","",10,true,true)%>            
        <%=MyUtil.ObjInput("Usuario que Recaba","UsuarioVal",Solicitud!=null ? Solicitud.getUsrValFirmas() : "",false,false,340,415,"",false,false,50)%>            
        <%=MyUtil.ObjInput("Fecha de Recabación","FechaValFirmasVTR",Solicitud!=null ? Solicitud.getFechaValFirmas() : "",false,false,620,415,"",false,false,20,"")%>
        <%=MyUtil.ObjTextArea("Observaciones","ObservacionesSist",Solicitud!=null ? Solicitud.getObservacionesSist() : "","100","7",false,blnAdmin,20,460,"",false,false)%>
        <%=MyUtil.ObjInput("Fecha de Inicio","FechaInicio",Solicitud!=null ? Solicitud.getFechaInicio() : "",blnAdmin,blnAdmin,600,460,"",false,false,20,"if(this.readOnly==false){fnValMask(this,document.all.FechaSingleMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("Fecha de Término","FechaTerminoVTR",Solicitud!=null ? Solicitud.getFechaTermino() : "",false,false,600,505,"",false,false,20,"")%>
        <%=MyUtil.DoBlock("Revisión por Sistemas",0,100)%><%
        
        
        %>
        <%=MyUtil.GeneraScripts()%> 
        <%
        if ((blnAbierto==false)||(blnRevisada==true && blnAdmin==false)){ %>
        <script>document.all.btnCambio.disabled=true;</script>
        <% }
        
        StrclUsrApp = null;
        StrclSolicitud=null;
        StrclPaginaWeb=null;
        blnCambiaFecha=null;
        
        StrSql=null;
        
        daoh=null;
        Solicitud=null;
        
        if(rs!=null){
            rs.close();
            rs=null;
        }
        
        %>
        <input name='FechaMsk' id='FechaMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
        <input name='FechaSingleMsk' id='FechaSingleMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09'>
        <script>
    document.all.D3.style.visibility="hidden"; //Usuario que registra
    document.all.D4.style.visibility="hidden"; //Usuario que Revisa
    document.all.D5.style.visibility="hidden"; //Usuario que recaba
   
   function fnVer()
   {
    alert(document.all.clTipoSol.value);
   }
        </script>
    </body>
</html>