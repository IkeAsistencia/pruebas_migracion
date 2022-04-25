
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC,com.ike.helpdesk.DAOHelpdesk,com.ike.operacion.to.CircuitoReclamos;" errorPage="" %>
<html>
    <head>
        <title>Seguimeinto Reclamos</title>
    </head>
    <body class="cssBody" onload="">
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj"/>
        <script src='../Utilerias/Util.js'></script>
        <script src='../Utilerias/UtilStore.js'></script>
        <%
            String StrclReclamo = "0";
            String strclUsrApp = "0";
            String StrclPaginaWeb = "6080";

            if (session.getAttribute("clUsrApp") != null) {
                strclUsrApp = session.getAttribute("clUsrApp").toString();
            }

            if (session.getAttribute("clReclamo") != null) {
                StrclReclamo = session.getAttribute("clReclamo").toString();
            }

            if (SeguridadC.verificaHorarioC(Integer.parseInt(strclUsrApp)) != true) {
        %>
        Fuera de Horario
        <%
                return;
            }

            session.setAttribute("clPaginaWebP", StrclPaginaWeb);
            MyUtil.InicializaParametrosC(Integer.parseInt(StrclPaginaWeb), Integer.parseInt(strclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta 

            String Store = "";
            Store = "sp_GuardaArchiSegReclamoP,sp_";
            session.setAttribute("sp_Stores", Store);
            String Commit = "";
            Commit = "seguimientoReclamos";
            session.setAttribute("Commit", Commit);
            String StrLineCaptura = "";
        %>
        <SCRIPT>fnOpenLinks()</script>   
            <%=MyUtil.doMenuAct("../servlet/com.ike.guarda.EjecutaSP", "", "fnAGuarda();fnsp_Guarda();")%>
            <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="SeguimienitoReclamo.jsp?'>"%>        

        <INPUT id='clPaginaWeb' name='clPaginaWeb' type='hidden' value='<%=StrclPaginaWeb%>'/>
        <INPUT id='Secuencia' name='Secuencia' type='hidden' value=''/>
        <INPUT id='SecuenciaG' name='SecuenciaG' type='hidden' value='clReclamo,clUsrApp,Observaciones,LineaCaptura'/>
        <INPUT id='SecuenciaA' name='SecuenciaA' type='hidden' value=''/>

        <INPUT id='clReclamo' name='clReclamo' type='hidden' value='<%=StrclReclamo%>'> 
        <INPUT id='clUsrApp' name='clUsrApp' type='hidden' value='<%=strclUsrApp%>'>       
        <INPUT ID="LineaCaptura" NAME="LineaCaptura" VALUE="<%=StrLineCaptura%>" TYPE="HIDDEN">


        <%=MyUtil.ObjComboC("Estatus", "clEstatus", "", true, true, 30, 70, "", "select clEstatus, dsEstatus from cEstatusSP where clestatus in (6,7)", "fnValidaEstatus(this.value)", "", 50, true, false)%>        
        <%=MyUtil.ObjTextArea("Observaciones", "Observaciones", "", "100", "7", true, true, 30, 140, "", true, false)%>
        <%=MyUtil.DoBlock("Seguimiento de Reclamo", 340, 70)%>


        <%=MyUtil.GeneraScripts()%>

        <div id="Adjunto" class='VTable' style='position:absolute; z-index:3; left:30px; top:105px; visibility:hidden'>
            <form ACTION="UploadReclamo.jsp" name="gestionafichero" id="gestionafichero" enctype="multipart/form-data" method="post">
                <input id="TipoFile" name="TipoFile" type="hidden" value="">
                <input id="Obs" name="Obs" type="hidden" value="">
                <p class='FTable'>Seleccionar Archivo<br>
                    <input type="file" name="fichero" class="VTable" onblur="fnVerificaFile(this);">
            </form>
        </div>

    <center>
        <img src="../Imagenes/UploadFile.gif" id="UploadFile">
        <script>
            document.all.UploadFile.style.visibility = 'hidden';
        </script>
    </center>

    <script>

        function fnVerificaFile(file) {
            if (file.value != "") {
                fail = file.value.substring(file.value.indexOf('.'), file.value.length);
                document.all.TipoFile.value = fail;
            }
        }

        function fnValidaEstatus(Estatus) {
            alert(1);
            if (Estatus == 7) {
                document.all.Adjunto.style.visibility = "visible";
            } else {
                document.all.Adjunto.style.visibility = "hidden";
            }
        }

        function fnAGuarda() {
            if (document.all.clEstatus.value == '7') {
                document.all.forma.action = '';
                document.all.Obs.value = document.all.Observaciones.value;
                document.all.btnGuarda.disabled = false;
                document.all.btnCancela.disabled = false;
                fnOpenWindow();
                document.all.gestionafichero.target = "WinSave";
                document.all.gestionafichero.submit();
                document.all.gestionafichero.close();
                //document.all.gestionafichero.
            }
            else {
                document.all.forma.action = '../servlet/com.ike.guarda.EjecutaSP';
            }
        }
    </script>
</body>
<%
    StrclReclamo = null;
    strclUsrApp = null;
    StrclPaginaWeb = null;
%>
</html>