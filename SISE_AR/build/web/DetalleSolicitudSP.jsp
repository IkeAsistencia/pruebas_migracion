<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="com.ike.helpdeskSP.DAOHelpdeskSP,com.ike.helpdeskSP.HelpdeskSP,java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head><title>Detalle Solicitud de Usuario SP</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody" onload="">
        
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
        <script src='../Utilerias/Util.js' ></script>
        <script src='../Utilerias/UtilMask.js'></script>
        <script src='../Utilerias/UtilDireccion.js'></script>
        <script src='../Utilerias/UtilStore.js'></script>
        <script src='../Utilerias/UtilCalendario.js'></script>
        <div class='VTable' style='position:absolute; z-index:25; left:400px; top:15px;'><p align="center"><font color="navy" face="Arial" size="3" ><b><i>Solicitud de Servicio Help Desk Soporte Tecnico</i></b>  <br> </p></div>
        <link href="../StyleClasses/Calendario.css" rel="stylesheet" type="text/css">
        
        <%
        String StrclSolicitud = "0";
        String StrclUsrApp = "0";
        String StrclEstatus = "0";
        
        
        if (session.getAttribute("clUsrApp") != null) {
            StrclUsrApp = session.getAttribute("clUsrApp").toString();
        }
        if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {
        %>Fuera de Horario <%
        
        StrclUsrApp = null;
        return;
        }
        
        if (session.getAttribute("clSolicitud") != null) {
            StrclSolicitud = session.getAttribute("clSolicitud").toString();
        }
        
        if (request.getParameter("clSolicitud") != null) {
            StrclSolicitud = request.getParameter("clSolicitud").toString();
        }
        
        session.setAttribute("clSolicitud", StrclSolicitud);
        
        DAOHelpdeskSP daoHelpdeskSP = null;
        HelpdeskSP HD = null;
        
        daoHelpdeskSP = new DAOHelpdeskSP();
        HD = daoHelpdeskSP.getHelpdeskSP(StrclSolicitud.toString());
        
        //-------------- VERIFICA EL GPO DEL USR
        ResultSet rs = UtileriasBDF.rsSQLNP("st_ValidaGposHD_SP " + StrclUsrApp);
        String StrAdminist = "";
        String StrColaborador = "";
        String StrUsuarios = "";
        String StrCalificacion = "";
        String StrSolicitudxCalificar = "";
        if (rs.next()) {
            StrAdminist = rs.getString("Administrador");
            StrColaborador = rs.getString("Colaborador");
            //  StrUsuarios=rs.getString("Usuario");
            StrCalificacion = rs.getString("Calificacion");
            StrSolicitudxCalificar = rs.getString("Solicitud");
            
            session.setAttribute("SolicitudxCalificar", StrSolicitudxCalificar);
        }
        
        String StrclPaginaWeb = "971";
        session.setAttribute("clPaginaWebP", StrclPaginaWeb);
        %>
        <%//servlet generico
        String Store = "";
        
        Store = "st_GuardaHelpdeskSP,st_ActualizaHelpdeskSP";
        
        session.setAttribute("sp_Stores", Store);
        
        String Commit = "";
        Commit = "clSolicitud";
        
        session.setAttribute("Commit", Commit);
        %>
        <script>fnOpenLinks()</script>
        
        <%MyUtil.InicializaParametrosC(971, Integer.parseInt(StrclUsrApp));%>
        <%=MyUtil.doMenuAct("../servlet/com.ike.guarda.EjecutaSP", "fnValidaCalificacion();", "fnCamposObligatorios();fnsp_Guarda();")%>
        
        <%
        if (HD != null) {
            if (HD.getclEstatus().equalsIgnoreCase("4") || HD.getclEstatus().equalsIgnoreCase("5")) {
        %>
        <script>
        document.all.btnCambio.disabled=true;
        </script>
        <%}
        }
        %>
        
        <input id="Calificacion" name="Calificacion" type="hidden" value="<%=StrCalificacion%>">
        <input id="SolicitudxCalificar" name="SolicitudxCalificar" type="hidden" value="<%=StrSolicitudxCalificar%>">
        
        <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="DetalleSolicitudSP.jsp?'>"%>
        <%  int iY = 40;%>
        
        <input id="Secuencia" name="Secuencia" type="hidden" value="">
        <input id="SecuenciaG" name="SecuenciaG" type="hidden"  VALUE="clUsrApp,FechaRegistro,clEstatus,clAreaOperativaSP,clPiso,Extencion,DetalleSol,clColaboradorAsignadoSP,Seguimiento,ActividadR,FechaCompromiso,clTipoFallaSP,clUsrAppSP,Correo">
        <input id="SecuenciaA" name="SecuenciaA" type="hidden"  VALUE="clSolicitud,clUsrApp,clEstatus,clAreaOperativaSP,clPiso,Extencion,DetalleSol,clColaboradorAsignadoSP,Seguimiento,ActividadR,FechaCompromiso,clTipoFallaSP,clUsrAppSP,Correo">
        
        <!--INPUT id='clSolicitud' name='clSolicitud' type='text' value='< %=StrclSolicitud%>'-->
        <INPUT id='clPaginaWeb' name='clPaginaWeb' type='HIDDEN' value='<%=StrclPaginaWeb%>'>
        <INPUT id='clUsrApp' name='clUsrApp' type='HIDDEN' value='<%=StrclUsrApp%>'>
        
        
        <!--%=MyUtil.ObjInput("Usuario que Registra","clUsrAppRegistra",HD != null ? HD.getNombre(): "",false,false,20,110,session.getAttribute("NombreUsuario").toString(),false,false,55)%-->
        <%=MyUtil.ObjInput("Fecha de Registro", "FechaRegistro", HD != null ? HD.getFechaRegistro() : "", false, false, 195, 70, "", false, false, 20, "")%>
        <%=MyUtil.ObjInput("FOLIO", "clSolicitud", HD != null ? HD.getclSolicitud() : "", false, false, 20, 70, "", false, false, 10, "")%>
        <%=MyUtil.ObjComboC("Area", "clAreaOperativaSP", HD != null ? HD.getdsAreaOperativa() : "", true, false, 20, 155, "", "select * from cAreaOperativaSP order by dsAreaOperativa asc ", "", "", 30, true, false)%>
        <%=MyUtil.ObjComboC("Tipo de Falla y/o Solicitud", "clTipoFallaSP", HD != null ? HD.getdsTipoFallaSP() : "", true, false, 330, 155, "", "select * from cTipoFallaSP order by  dstipofallasp asc ", "", "", 25, true, false)%>
        <%=MyUtil.ObjComboC("Piso", "clPiso", HD != null ? HD.getdsPiso() : "", true, false, 20, 200, "", "select *from cPisoSP ", "", "", 10, true, false)%>
        <%=MyUtil.ObjInput("EXTENSION", "Extencion", HD != null ? HD.getExtencion() : "", true, true, 245, 200, "", true, false, 10, "")%>
        <%=MyUtil.ObjInput("CORREO (USUARIO SOLICITA)", "Correo", HD != null ? HD.getCorreo() : "", true, false, 330, 200, "", true, false, 40, "validaCorreo();")%>
        <div class='VTable' style='position:absolute; z-index:20; left:370px; top:120px;'>
            <% if (StrAdminist.equalsIgnoreCase("1")) {%>
            <INPUT type='button' VALUE='Nuevo Usuario' onClick='fnUsrSP();' class='cBtn'>
            <%}%>
        </div>
        
        <%=MyUtil.ObjTextArea("Descripcion del servicio que Solicita", "DetalleSol", HD != null ? HD.getDetalleSol() : "", "90", "5", true, false, 20, 250, "", false, false)%>
        
        <INPUT id='clUsrAppSP' name='clUsrAppSP' type='hidden' value='<%=HD != null ? HD.getclUsrAppSP() : "0"%>'>
        <%=MyUtil.ObjInput("Usuario que solicita", "NombreSP", HD != null ? HD.getNombreUsrSP() : "", false, false, 20, 110, "", true, false, 50, "")%>
        <div class='VTable' style='position:absolute; z-index:25; left:295px; top:120px;'>
        <IMG SRC='../Imagenes/Lupa.gif' onClick='fnBuscaUsrSP();' WIDTH=20 HEIGHT=20></div>
        
        <%=MyUtil.DoBlock("Solicitud de servicio", 120, 50)%>
        
        <DIV ID=CDR>
            <%=MyUtil.ObjTextArea("Seguimiento de Solicitud", "Seguimiento", HD != null ? HD.getSeguimiento() : "", "90", "4", true, true, 20, 385, "", false, false)%>
            <%=MyUtil.ObjTextArea("Actividad Realizada", "ActividadR", HD != null ? HD.getActividadR() : "", "90", "4", true, true, 20, 460, "", false, false)%>
            <%=MyUtil.ObjComboC("Estatus", "clEstatus", HD != null ? HD.getdsEstatus() : "", false, true, 20, 535, "1", "st_GetEstatusHDS " + StrclEstatus, "", "", 30, false, false)%>
            
            <%=MyUtil.DoBlock("Seguimiento / Actividad", 320, 0)%>
        </DIV>
        
        <%
        StrclEstatus = HD != null ? HD.getclEstatus() : "0";
        %>
        <DIV ID='nacho'>
            <%=MyUtil.ObjComboC("Colaborador", "clColaboradorAsignadoSP", HD != null ? HD.getdsColaboradorAsignadoSP() : "", true, true, 20, 620, "", "select *  from cColaboradorAsignadoSP", "", "", 30, false, false)%>
            <%=MyUtil.ObjInputF("Fecha Compromiso", "FechaCompromiso", HD != null ? HD.getFechaCompromiso() : "", false, true, 310, 620, "", false, false, 18, 1, "if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)}")%>
            <%=MyUtil.DoBlock("Colaborador Asignado", 30, 0)%>
        </DIV>
        
        
        <%if (StrColaborador.equalsIgnoreCase("1") || StrAdminist.equalsIgnoreCase("1")) {%>
        <script> document.all.CDR.style.visibility="visible"; </script>
        <%} else {%>
        <script> document.all.CDR.style.visibility="hidden"; </script>
        <% }%>
        
        <%if (StrAdminist.equalsIgnoreCase("1")) {%>
        <script> document.all.nacho.style.visibility="visible";</script>
        <%} else {%>
        <script> document.all.nacho.style.visibility="hidden";</script>
        <% }%>
        
        <%=MyUtil.GeneraScripts()%>
        
        <input name='FechaMsk' id='FechaMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
        <input name='FechaSingleMsk' id='FechaSingleMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09'>
        
        <div style='position:absolute; z-index:1000; left:20%; top:17%' id="DivSave">
            <% if (!StrSolicitudxCalificar.equalsIgnoreCase("0") && StrCalificacion.equalsIgnoreCase("0") ) {%>
            <iframe src="MensajeCalificadoSP.jsp" width=500 height=250 scrolling="no" frameborder="no">
            </iframe>
            <%}%>
        </div>
        
        <script>document.all.DivSave.style.visibility='hidden';</script>
        
        <%
        HD = null;
        daoHelpdeskSP = null;
        
        StrclSolicitud = null;
        StrclUsrApp = null;
        StrAdminist = null;
        StrColaborador = null;
        StrUsuarios = null;
        StrclUsrApp = null;
        Store=null;
        Commit=null;
        StrclEstatus=null;
        StrCalificacion=null;
        StrSolicitudxCalificar=null;
        StrclPaginaWeb=null;
        
        if (rs!=null){
            rs.close();
            rs=null;
        }
        
        %>
        <script>

        function fnValidaCalificacion(){
            //alert(document.all.Calificacion.value+' '+document.all.SolicitudxCalificar.value);

            if (document.all.SolicitudxCalificar.value!=0 && document.all.Calificacion.value== 0){
                document.all.DivSave.style.visibility='visible';
                document.all.btnAlta.disabled=false;
                document.all.btnGuarda.disabled=true;
                document.all.btnCancela.disabled=true;
            }
            else{
                fnLimpiaCampos();
                fnTraeCorreo();
            }
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
                document.all.Correo.value=Correo;
            }
        }

        function fnLimpiaCampos(){
            document.all.clUsrAppSP.value='0';
        }

        function fnCamposObligatorios(){
            if (document.all.clEstatus.value==2){
                if ( document.all.clColaboradorAsignadoSP.value==0 ) {
                    msgVal=msgVal + " Colaborador.";
                }
            }

            if (document.all.clColaboradorAsignadoSP.value!=0){
                if ( document.all.clEstatus.value==0 ) {
                    msgVal=msgVal + " Estatus.";
                }
            }

            document.all.btnGuarda.disabled=false;
            document.all.btnCancela.disabled=false;
        }


        // <<<<<<<<<<<<<<<<  FUNCION PARA TRER CORERO >>>>>>>>>>>>>>>>
        function fnTraeCorreo(){

            if (document.all.Action.value==1){
                var pstrCadena = "../HelpDeskSP/LlenaCorreoSP.jsp?strSQL=st_ObtenCorreoSP ";
                pstrCadena = pstrCadena + "&Correo= " + document.all.Correo.value;
                window.open(pstrCadena,'newWin','scrollbars=yes,status=yes,width=1,height=1,top=1,left=1');
            }
        }

        function fnLlenaCorreo(Correo){
            if (Correo!=''){
                document.all.Correo.value=Correo;
                //document.all.Correo.disabled=true;
                //alert(Correo);
            }
        }

        function validaCorreo()
        {
            var Cadena
            var PosArroba
            var usuario
            var dominio
            if (document.all.Correo.value!='')
            {
                if(document.all.Correo.value.indexOf('@', 0) == -1)
                {
                    alert("La dirección de correo no es valida.");
                }
                else
                {
                    PosArroba = document.all.Correo.value.lastIndexOf('@')
                    usuario=document.all.Correo.value.substring(0,PosArroba)
                    dominio=document.all.Correo.value.substring(PosArroba+1,Cadena)

                    if (usuario == '' || dominio=='')
                    {
                        alert("La dirección de correo no es valida.");
                    }

                    //Valida el nombre de usuario y verifica que no existan dos @
                    if(usuario.indexOf('@', 0) != -1)
                    {
                        alert("La dirección de correo no es valida.");
                    }

                    //valida el dominio
                    if(dominio.indexOf('.', 0) == -1 || dominio.indexOf('@', 0) != -1)
                    {
                        alert("La dirección de correo no es valida.");
                    }

                    //alert(usuario + "," + dominio)
                }
            }
        }

        
    function fnUsrSP(){
            if (document.all.Action.value=="1"){
                    document.all.clUsrAppSP.value='';document.all.clUsrAppSP.value=0;
                    window.open('../HelpDeskSP/UsuarioSP.jsp?Nombre='+ document.all.clUsrAppSP.value,'WinUsuarioSP','scrollbars=yes,status=yes,width=565,height=220');
            }
    }

    function fnLlenaDespuesdeGuardar(clUsrAppSP,Nombre,Correo){

        //alert(""+clUsrAppSP+ " "+Nombre+" "+Correo );
            document.all.clUsrAppSP.value=clUsrAppSP;
            document.all.NombreSP.value=Nombre;
            document.all.Correo.value=Correo;
    }





        </script>
    </body>
</html>