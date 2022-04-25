<%-- 
    Document   : UpLoadLogosEncConcierge
    Created on : 17/10/2011, 05:18:25 PM
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
        <%
        String StrclUsrApp="0";
        String StrclPaginaWeb="0";                
        String StrclCuenta="0";
        String StrRutaArchivo = "";

        if (session.getAttribute("clUsrApp")!= null) {
            StrclUsrApp = session.getAttribute("clUsrApp").toString();
        }
        
        if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true)  {
            %>Fuera de Horario<%
            StrclUsrApp=null;
            StrclPaginaWeb = null;
            StrclCuenta = null;
            StrRutaArchivo = null; 
            return;
        }

        if (request.getParameter("clCuenta")!=null){
            StrclCuenta = request.getParameter("clCuenta").toString();
            session.setAttribute("clCuenta",StrclCuenta);
        }else{
            if (session.getAttribute("clCuenta")!= null) {
                StrclCuenta = session.getAttribute("clCuenta").toString();
            }
        }

        ResultSet rs = null;
        rs = UtileriasBDF.rsSQLNP("st_GetImgEncConcierge "+StrclCuenta);

        if (rs.next()){
            if (rs.getString("RutaArchivo") != null){
                StrRutaArchivo = rs.getString("RutaArchivo");
                //session.setAttribute("RutaArchivo",StrRutaArchivo);
            }else{
                StrRutaArchivo = "..\\Imagenes\\EncabezadosConcierge\\Encabezados\\no_disponible.jpg";
            }
        }        

        StrclPaginaWeb = "1423";
        MyUtil.InicializaParametrosC(1423,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
        session.setAttribute("clPaginaWebP",StrclPaginaWeb);

        %>
        <form ACTION="../servlet/Utilerias.UpLoadLogosProv" name="gestionafichero" target="Contenido" id="gestionafichero" enctype="multipart/form-data" METHOD="post">
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

        <iframe  src='<%=StrRutaArchivo%>' width=1200 height=200 style=' margin-right: 0px; margin-bottom: 0px; margin-top:200px; margin-left: 0px' scrolling="yes"  frameborder="yes">

        </iframe>

        <%
        //<<<<<<<<<<<<< Limpiar variables >>>>>>>>>>>>
        StrclUsrApp = null;
        StrclPaginaWeb = null;
        rs.close();
        rs = null;
        StrclCuenta = null;
        StrRutaArchivo = null;
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

