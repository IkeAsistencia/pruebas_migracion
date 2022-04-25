<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="Seguridad.SeguridadC,java.sql.ResultSet,Utilerias.UtileriasBDF"  errorPage="" %>

<html>
    <head>     
        <title>Carga de Archivos</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
       
    </head>
    
    <body class="cssBody">
         <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
        <script src='../Utilerias/Util.js' ></script>
        
         <%
            String StrclUsrApp="0";
            String StrclPaginaWeb="0";
            String StrclCuenta = "0";
            String StrUploadFiles = "0";
            
            if (session.getAttribute("clUsrApp")!= null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();
            }
            
            if (session.getAttribute("clCuenta")!=null) {
                StrclCuenta = session.getAttribute("clCuenta").toString();
            }
            
           if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true)  {
                %>Fuera de Horario<%
                StrclUsrApp=null;
                return;
           }   
            
            StrclPaginaWeb = "1005";
            MyUtil.InicializaParametrosC(1005,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
            session.setAttribute("clPaginaWebP",StrclPaginaWeb);
            
            ResultSet rsValidaCta = null;
            rsValidaCta = UtileriasBDF.rsSQLNP(" sp_ValidaCtaUploadFiles "+StrclCuenta.toString());
            
            if (rsValidaCta.next()){
                StrUploadFiles = rsValidaCta.getString("UploadFiles");
            }
            
        %>
 
    <% if (StrUploadFiles.equalsIgnoreCase("1")) { %>
        
        <form ACTION="../servlet/Utilerias.UploadFiles" name="gestionafichero" id="gestionafichero" enctype="multipart/form-data" METHOD="post">                

             <input id="TipoFile" name="TipoFile" type="hidden" value="">

            <div id='D2' Name='D2' class='VTable' style='position:absolute; z-index:3; left:25px; top:55px;'>
                <p class='FTable'>Codigo de Acceso<br>
                </p>
            </div>

              <div id='D3' Name='D3' class='VTable' style='position:absolute; z-index:3; left:34px; top:100px;'>
                    <INPUT TYPE="Codigo" class='VTable' label='Codigo' size=13  id='Codigo' name='Codigo' value='' ></INPUT>
                </p>
            </div>

            <div class='VTable' style='position:absolute; z-index:3; left:35px; top:140px;'>
                <p class='FTable'>Selecciona el Archivo<br>
                <input type="file" name="fichero" class="VTable" size="50" onblur="fnVerificaFile(this);"  >
            </div>

            <div  class='VTable' style='position:absolute; z-index:4; left:280px; top:70px;'>
                <input type="button" value="Subir Archivo" class="cBtn" onclick='fnProcesoFile();'  id="btnUpload">
            </div>  

             <div id="ResBlock1" name="ResBlock1" class='cssBGDet' style='position:absolute; z-index:1; left:10px; top:20px; width:400px; height:170px;'>
             <p class='cssTitDet'> Carga de Archivo </p></div>


        </form> 
            <div id="Upload" class='VTable' style='position:absolute; z-index:3; left:35px; top:70px;'>
               <img src='../servlet/Utilerias.Captcha'>
            </div>

             <div style='position:absolute; z-index:1000; left:30%; top:20%' id="DivUpload">
                <iframe src="../CargaBD/UploadFile.html" width=320 height=190 scrolling="no" frameborder="no">
                </iframe>
            </div>

             <script>document.all.DivUpload.style.visibility='hidden';</script>

        </body>
    <% } else {%>
            <BR>
            <p align="center">
                <font color="navy" face="Arial" size="3" >
                    <b>
                       LA CUENTA DEL EXPEDIENTE NO TIENE ACCESO A ESTE MODULO.
                    </b>  
            </p>
    <% }%>
    
    <%
        //<<<<<<<<<<<<< Limpiar variables >>>>>>>>>>>>
        StrclUsrApp = null;
        StrclPaginaWeb = null;
        StrUploadFiles  = null;
        StrclCuenta = null;
        rsValidaCta.close();
        rsValidaCta = null;
    %>
    <script>
        function fnProcesoFile(){
        
            var MSG = "Falta informar: ";
            
             if (document.all.fichero.value==''){
                MSG = MSG + "Archivo, ";
            }
            
            if (document.all.Codigo.value==''){
                MSG = MSG + "Codigo de Acceso, ";
            }

            if (MSG!='Falta informar: '){
                alert(MSG);
            }
            else{
                fnProcesoUpload(1);
                fnOpenWindow();
                document.all.gestionafichero.target="WinSave";
                document.all.gestionafichero.submit();
            }
        }
        
        function fnVerificaFile (file){

            if(file.value!="")  { 
                fail=file.value.substring(file.value.length-4) 
                   // if(fail==".jpg" || fail==".JPG" || fail==".pdf" || fail==".PDF" || fail==".gif" || fail==".GIF" || fail==".tif" || fail==".TIF" )  { 
                    if(fail==".xls" || fail=="xlsx" )  { 
                   
                        document.all.TipoFile.value=fail;
                        return true 
                        
                    } 
                    else  { 
                        alert("Sólo puedes elegir los archivos: XLS o XLSX.") 
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
            }
            else{
              document.all.ResBlock1.style.filter='';
              document.all.btnUpload.disabled=false;
              document.all.DivUpload.style.visibility='hidden';
            }
        }
        
        
    </script>
    
</html>
