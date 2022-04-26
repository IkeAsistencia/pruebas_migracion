<%-- 
    Document   : CSSubirImagenCot
    Created on : 24/10/2011, 04:37:36 PM
    Author     : atorres
--%>

<%--
    Document   : UpLoadLogosRefConcierge
    Created on : 20/10/2011, 04:48:07 PM
    Author     : atorres
--%>

<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="Seguridad.SeguridadC,java.sql.ResultSet,Utilerias.UtileriasBDF"  errorPage="" %>

<html>
    <head>
        <title>Carga Archivos de Imagen de los Encabezados por Cuentas</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody" >
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
        <script src='../Utilerias/Util.js' ></script>
        <script src='../Utilerias/UtilReferencia.js' ></script>
        <%
        String StrclUsrApp="0";
        String StrclPaginaWeb="0";
        String StrclReferencia="0";
        String StrRutaArchivo = "";
        String StrAdRutaURL="";

        if (session.getAttribute("clUsrApp")!= null) {
            StrclUsrApp = session.getAttribute("clUsrApp").toString();
        }

        if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true)  {
            %>Fuera de Horario<%
            StrclUsrApp=null;
            StrclPaginaWeb = null;
            StrclReferencia = null;
            StrRutaArchivo = null;
            return;
        }

        if (request.getParameter("clReferencia")!=null){
            StrclReferencia = request.getParameter("clReferencia").toString();
            session.setAttribute("clReferencia",StrclReferencia);
        }else{
            if (session.getAttribute("clReferencia")!= null) {
                StrclReferencia = session.getAttribute("clReferencia").toString();
            }
        }


        ResultSet rs = null;
        rs = UtileriasBDF.rsSQLNP("st_GetImgRefConcierge "+StrclReferencia);

        if (rs.next()){
            if (rs.getString("AdRutaArchivo") != null){
                StrAdRutaURL =rs.getString("AdRutaArchivo");
            }else{
                StrAdRutaURL = "..\\Imagenes\\EncabezadosConcierge\\Encabezados\\no_disponible.jpg";
            }
        }
              
        StrclPaginaWeb = "1426";
        MyUtil.InicializaParametrosC(1426,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
        session.setAttribute("clPaginaWebP",StrclPaginaWeb);

        %>
        <form ACTION="../servlet/Utilerias.CSSubirImagenCot" name="gestionafichero" target="Contenido" id="gestionafichero" enctype="multipart/form-data" METHOD="post">
            <input id="TipoFile" name="TipoFile" type="hidden" value="">

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

        <div id="DivUpload" style='position:absolute; left: 500px; z-index:500; visibility: hidden'  >
                <iframe src="../CargaBD/UploadFile.html" width=300 height=115 style=' margin-right: 0px; margin-bottom: 0px; margin-top:-15px; margin-left: -10px' scrolling="no"  frameborder="no">
                </iframe>
        </div>

        <iframe  src='<%=StrAdRutaURL%>' width=1200 height=200 style=' margin-right: 0px; margin-bottom: 0px; margin-top:200px; margin-left: 0px' scrolling="yes"  frameborder="yes">

        </iframe>

        <%
        //<<<<<<<<<<<<< Limpiar variables >>>>>>>>>>>>
        StrclUsrApp = null;
        StrclPaginaWeb = null;
        rs.close();
        rs = null;
        StrclReferencia = null;
        StrAdRutaURL = null;
        %>

        <script>

            function fnProcesoFile(){

                var MSG = "Falta informar: ";

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


