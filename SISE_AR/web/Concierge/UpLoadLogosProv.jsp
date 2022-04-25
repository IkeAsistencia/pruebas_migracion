<%-- 
    Document   : UpLoadLogosProv
    Created on : 17/10/2011, 01:07:49 PM
    Author     : atorres
--%>

<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="Seguridad.SeguridadC,java.sql.ResultSet,Utilerias.UtileriasBDF"  errorPage="" %>

<html>
    <head>
        <title>Carga Archivos de Imagen de los Encabezados de Cuentas</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody" >
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
        <script src='../Utilerias/Util.js' ></script>
        <%
        String StrclUsrApp="0";
        String StrclPaginaWeb="0";
        String strclSolContrato = "";
        String StrPuedeModificar = "";

        if (session.getAttribute("clUsrApp")!= null) {
            StrclUsrApp = session.getAttribute("clUsrApp").toString();
        }

      
        if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true)  {
            %>Fuera de Horario<%
            StrclUsrApp=null;
            return;
        }

        if (request.getParameter("Reload")!=null){
            %><script> top.frames['Contenido'].location.reload();</script><%
        }

        StrclPaginaWeb = "41";
        MyUtil.InicializaParametrosC(41,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
        //session.setAttribute("clPaginaWebP",StrclPaginaWeb);

        %>
        <form ACTION="../servlet/Utilerias.UpLoadLogosProv" name="gestionafichero" target="Contenido" id="gestionafichero" enctype="multipart/form-data" METHOD="post">
            <input id="TipoFile" name="TipoFile" type="hidden" value="">


            <%--
            <%=MyUtil.ObjComboC("Tipo Archivo","clTipoArchivo","",false,false,30,40,"1","sp_GetEstatusContratoxSol "+strclSolContrato+","+StrPuedeModificar,"","",50,true,true)%>
            --%>
            
            <div class='VTable' style='position:absolute; z-index:3; left:30px; top:80px;'>
                <p class='FTable'>Selecciona el Archivo<br>
                <input type="file" name="fichero" class="VTable" size="65" onblur="fnVerificaFile(this);"  >
            </div>

            <div  class='VTable' style='position:absolute; z-index:4; left:340px; top:50px;'>
                <input type="button" value="Subir Archivo" class="cBtn" onclick='fnProcesoFile();'  id="btnUpload">
            </div>

            <div id="ResBlock1" name="ResBlock1" class='cssBGDet' style='position:absolute; z-index:1; left:10px; top:10px; width:450px; height:130px;'>
                 <p class='cssTitDet'> Carga Archivos de Imagen de los Encabezados de Cuentas </p>
            </div>
        </form>

        <div style='position:absolute; left: 500px; z-index:500' id="DivUpload" >
            <iframe src="../CargaBD/UploadFile.html" width=105 height=115 style=' margin-right: 0px; margin-bottom: 0px; margin-top:-15px; margin-left: -10px' scrolling="no"  frameborder="no">
            </iframe>
        </div>

        <script>document.all.DivUpload.style.visibility='hidden';</script>
        <%
        //<<<<<<<<<<<<< Limpiar variables >>>>>>>>>>>>
        StrclUsrApp = null;
        StrclPaginaWeb = null;
        strclSolContrato = null;
        %>
        <script>



           //document.all.clTipoArchivoC.disabled = false;
           //document.all.clTipoArchivoC.readOnly = false;

            function fnProcesoFile(){

                var MSG = "Falta informar: ";

                /*
                if (document.all.clTipoArchivo.value=='') {
                    MSG = MSG + "Tipo de Archivo. ";
                }
                */

                if (document.all.fichero.value==''){
                    MSG = MSG + "Archivo. ";
                }

                if (MSG!='Falta informar: '){
                    alert(MSG);
                }else{
                    fnProcesoUpload(1);
                    fnOpenWindow();
                    document.all.gestionafichero.target="WinSave";
                    document.all.gestionafichero.submit();
                }
            }

            function fnVerificaFile (file){

                if(file.value!="") {
                    fail=file.value.substring(file.value.length-4)
                    if(fail==".jpg" || fail==".JPG"  || fail==".png" || fail==".PNG")  {
                        document.all.TipoFile.value=fail;
                        return true
                    }else{
                        alert("Sólo puedes elegir los archivos: JPG ó PNG")
                        file.focus()
                        return false
                    }
                }
            }

            function fnProcesoUpload(Proceso){
                if (Proceso==1){
                  document.all.ResBlock1.style.filter='gray';
                  document.all.btnUpload.disabled=true;
                  document.all.DivUpload.style.visibility='visible';
                }else{
                  document.all.ResBlock1.style.filter='';
                  document.all.btnUpload.disabled=false;
                  document.all.DivUpload.style.visibility='hidden';
                }
            }
        </script>
   </body>
</html>

