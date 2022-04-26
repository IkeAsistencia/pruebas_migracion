<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC,Utilerias.StringToHex,com.ike.helpdesk.DAOHelpdesk,com.ike.helpdesk.HDSolicitud" errorPage="" %>
<html>
    <head>
        <title></title>
    </head>
    <body class="cssBody">
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj"/>
        <script src='../Utilerias/Util.js'></script>
        <script src='../Utilerias/UtilStore.js'></script>
        <%  
        String StrclSolicitud = "0";
        String strclUsrApp = "0";
        
        if (session.getAttribute("clUsrApp")!= null) {
            strclUsrApp = session.getAttribute("clUsrApp").toString();
        }
        
        if (SeguridadC.verificaHorarioC(Integer.parseInt(strclUsrApp)) != true) {
        %>
        Fuera de Horario
        <%
        return;
        }
        
        if (session.getAttribute("clSolicitud")!= null) {
            StrclSolicitud= session.getAttribute("clSolicitud").toString();
        }
        
        String StrclPaginaWeb = "599";
        session.setAttribute("clPaginaWebP",StrclPaginaWeb);
        MyUtil.InicializaParametrosC(599,Integer.parseInt(strclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta 
        
        String Store="";
        Store="sp_GuardaHDSeguimiento,sp_";
        session.setAttribute("sp_Stores",Store);
        String Commit="";
        Commit="clSeguimiento";
        session.setAttribute("Commit",Commit);
        
        
        
        DAOHelpdesk daoh = null;
        HDSolicitud  Solicitud = null;
        
        daoh = new DAOHelpdesk();
        Solicitud = daoh.getSolicitud(StrclSolicitud);
        
        StringToHex SH = new StringToHex();
        String StrLineCaptura = "";
        
        //StrLineCaptura =  SH.convertStringToHex(StrclSolicitud+"|"+Solicitud.getClUsrAppResponsable()+"|"+Solicitud.getFechaLC()+"|HelpDesk-Desarrollo|");

        %>
        <SCRIPT>fnOpenLinks()</script>   
        <%=MyUtil.doMenuAct("../servlet/com.ike.guarda.EjecutaSP","","fnAGuarda();fnsp_Guarda();")%>
        <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="DetalleSolicitud.jsp?'>"%>        
        
        <INPUT id='clPaginaWeb'name='clPaginaWeb'type='hidden'value='<%=StrclPaginaWeb%>'/>
        <INPUT id='Secuencia' name='Secuencia' type='hidden'value=''/>
        <INPUT id='SecuenciaG'name='SecuenciaG'type='hidden'value='clSolicitud,clEstatus,clUsrApp,Observaciones,Tiempo,LineaCaptura,LCG'/>
        <INPUT id='SecuenciaA'name='SecuenciaA'type='hidden'value=''/>
        
        <INPUT id='clSolicitud' name='clSolicitud' type='hidden' value='<%=StrclSolicitud%>'> 
        <INPUT id='clUsrApp' name='clUsrApp' type='hidden' value='<%=strclUsrApp%>'>       
        <INPUT ID="LineaCaptura" NAME="LineaCaptura" VALUE="<%=StrLineCaptura%>" TYPE="HIDDEN">
        
         
         
        <%=MyUtil.ObjComboC("Estatus","clEstatus","",true,true,30,70,"","sp_HDGetEstatus '"+strclUsrApp+"','"+StrclSolicitud+"'","fnValidaEstatus(this.value);","",50,true,false)%>
        <%=MyUtil.ObjTextArea("Observaciones","Observaciones","","100","7",true,true,30,140,"",true,false)%>
        <%=MyUtil.DoBlock("Seguimiento de solicitud",340,70)%>
        
        <div id="LiberacionCapa" style="visibility:hidden">
            <%=MyUtil.ObjChkBox("Tiene CAPA","TSC","0",true,true,30,300,"1","fnSC(this);")%>
            <input type="hidden" id="MSG" name="MSG" value="">
            <%=MyUtil.ObjInput("Usuario", "UserCapa", "", true, true, 180, 300, "", false, false, 25)%>
            <%=MyUtil.ObjInput("Contraseña", "PwdCapa", "", true, true, 330, 300, "", false, false, 25)%>
            <%=MyUtil.ObjInput("URL", "UrlCapa", "", true, true, 30, 350, "", false, false, 50)%>
            <%=MyUtil.DoBlock("Detalle de Liberacion (CAPA)",0,0)%>
        </div>
        
        <div id="Actividad" style="visibility:hidden">
            <div  style='position:absolute; z-index:525; left:300px; top:70px;'>
                <font color="navy" face="Arial" size="2" ><strong>Tiempo Empleado</strong></font>
            </div>
            <%=MyUtil.ObjInput("Horas", "TiempoH", "", true, true, 300, 90, "0", false, false, 5,"fnTiempo();")%>
            <%=MyUtil.ObjInput("Minutos", "TiempoMin", "", true, true, 360, 90, "0", false, false, 5,"fnTiempo();")%>
        </div>
        
        <input type="hidden" value="0" name="Tiempo" id="Tiempo">
        <%=MyUtil.GeneraScripts()%>
        
        </form>
         
         <div id="Adjunto" class='VTable' style='position:absolute; z-index:3; left:30px; top:105px;visibility:hidden'>
             
            <form ACTION="UploadArchivo.jsp" name="gestionafichero" id="gestionafichero" enctype="multipart/form-data" METHOD="post">   
                <input id="TipoFile" name="TipoFile" type="hidden" value="">
                <input id="Obs" name="Obs" type="hidden" value="">
                <p class='FTable'>Seleccionar Archivo<br>
                <input type="file" name="fichero" class="VTable" size="70" onblur="fnVerificaFile(this);"  >
            </form>
        </div>
        
        
        <%
        StrclSolicitud =null;
        strclUsrApp =null;
        %>
    </body>
    <script>
        
        function fnSC(C){
            if (C.checked == 1){
                document.all.Observaciones.value = "";
            }else{
                document.all.Observaciones.value = "";
            }
        }
        
        function fnTiempo(){
            
            var TH= document.all.TiempoH.value;
            var TM=document.all.TiempoMin.value;
            document.all.Tiempo.value=parseInt(TH)*60+parseInt(TM);
        }
        
        var dsEstatus ="";
        
          function fnVerificaFile (file){
            if(file.value!="")  { 
                fail=file.value.substring(file.value.indexOf('.'),file.value.length); 
                document.all.TipoFile.value=fail;                     
            } 
        }
        
        function fnValidaEstatus(Estatus){
            dsEstatus = document.all.clEstatusC.options[document.all.clEstatusC.selectedIndex].text;
            if (Estatus == 15){
                document.all.LiberacionCapa.style.visibility="visible";
                document.all.UrlCapa.value="http://sisecapamx.ikeasistencia.com:8080";
            }
            else{
                document.all.LiberacionCapa.style.visibility="hidden";
                document.all.UrlCapa.value="";
            }
            
            if (Estatus == 19){
                document.all.Actividad.style.visibility="visible";
            }else{
                document.all.Actividad.style.visibility="hidden";
                document.all.Tiempo.value="0";
                document.all.TiempoMin.value="0";
            }
            
            if (Estatus == 18){
                document.all.Adjunto.style.visibility="visible";
            }else{
                document.all.Adjunto.style.visibility="hidden";
            }
            
            
            
        }
        
        
        function fnAGuarda(){
            
            if (document.all.clEstatus.value == 19 &&  document.all.Tiempo.value=='0'){
                msgVal = msgVal + "Tiempo Empleado. ";
                document.all.btnGuarda.disabled = false;
                document.all.btnCancela.disabled = false;
            }
            
            if (document.all.clEstatus.value == 18 && document.all.fichero.value==''){
                msgVal = msgVal + "Archivo. ";
                document.all.btnGuarda.disabled = false;
                document.all.btnCancela.disabled = false;
            }
            
            if (document.all.clEstatus.value == 15){
                
                if (document.all.TSCC.checked==1){
                    document.all.Observaciones.value = '\nPara revisar el desarrollo solicitado ingrese a: '+
                        '\n\n\r'+document.all.UrlCapa.value+'\n\r con el usuario:'+document.all.UserCapa.value+' y contraseña: '+document.all.PwdCapa.value+
                        '\n\n\r'+'Para validar este desarrollo de <a href="<%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%>HDS.jsp?S=<%=StrLineCaptura%>">click Aquí</a>.'+
                        '\n\r'+'<font class="formatR">NOTA: El link de validación expira en 2 días.</font>';
                }
                else {
                      
                      document.all.MSG.value ='Para validar este desarrollo de <a href="<%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%>HDS.jsp?S=<%=StrLineCaptura%>">click Aquí</a>.'+
                        '\n\r'+'<font class="formatR">NOTA: El link de validación expira en 2 días.</font>';
                        
                      document.all.Observaciones.value = document.all.Observaciones.value + '\n\n\r'+ document.all.MSG.value;
                }
            }
            
               if (document.all.clEstatus.value == 27){
                     document.all.Observaciones.value =  '\nPara validar este desarrollo en producción de <a href="<%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%>HDS.jsp?S=<%=StrLineCaptura%>">click Aquí</a>.'+
                    '\n\r'+'<font class="formatR">NOTA: El link de validación expira en 2 días.</font>';
            }
            
            if (document.all.clEstatus.value == 18 && msgVal==''){
                document.all.forma.action='';
                document.all.Obs.value = document.all.Observaciones.value;
                fnOpenWindow();
                document.all.gestionafichero.target = "WinSave";
                document.all.gestionafichero.submit();
                document.all.gestionafichero.close();
            }
            else{
                document.all.forma.action='../servlet/com.ike.guarda.EjecutaSP';
            }
                
        }
        
    </script>
</html>

