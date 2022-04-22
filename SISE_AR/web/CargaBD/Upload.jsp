<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Seguridad.SeguridadC,Utilerias.UtileriasBDF"  errorPage="" %>
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
            String StrclUsrApp            = "0";
            String StrclPaginaWeb         = "0";
            String StrclTipoArchivoUpload = "0";
            String StrSentenciaSQL        = "";
            String StrColumnas            = "0";
            String StrMaxRegistros        = "0";
            String StrdsTipoArchivoUpload = "";
                       
            ResultSet rs = null;

            if (session.getAttribute( "clUsrApp" ) !=  null) {
                StrclUsrApp = session.getAttribute( "clUsrApp" ).toString();
            }

            if ( SeguridadC.verificaHorarioC( Integer.parseInt( StrclUsrApp ) ) != true ){
                    %>Fuera de Horario<%
                    StrclUsrApp=null;
                    return;
            }

            //Este valor se utiliza para identificar el tipo de Stored Procedure a utilizar
            if (request.getParameter( "clTipoArchivoUpload" ) != null ) {
                StrclTipoArchivoUpload = request.getParameter( "clTipoArchivoUpload" ).toString();
            } 
            else {
                if (session.getAttribute( "clTipoArchivoUpload" ) != null ){
                    StrclTipoArchivoUpload = session.getAttribute( "clTipoArchivoUpload" ).toString();
                }
            }       
           
            rs = UtileriasBDF.rsSQLNP( "sp_UploadxTipoArchivo " + StrclTipoArchivoUpload );

            if ( rs.next() ){
                StrSentenciaSQL        = rs.getString( "SentenciaSQL" );
                StrColumnas            = rs.getString( "Columnas" );
                StrMaxRegistros        = rs.getString( "MaxRegistros" );
                StrdsTipoArchivoUpload = rs.getString( "dsTipoArchivoUpload" );
            }              

            session.setAttribute( "StoreUpload"  ,StrSentenciaSQL  );
            session.setAttribute( "Columnas"     ,StrColumnas );
            session.setAttribute( "MaxRegistros" ,StrMaxRegistros );

            StrclPaginaWeb = "986";
            MyUtil.InicializaParametrosC( 986,Integer.parseInt( StrclUsrApp ) );    // se checan permisos de alta,baja,cambio,consulta de esta pagina
            session.setAttribute( "clPaginaWebP"        ,StrclPaginaWeb );
            session.setAttribute( "clTipoArchivoUpload" ,StrclTipoArchivoUpload );
        %>       
    <b><center><table ><tr><td><font color='#423A9E'><b>Carga de Base(<%=StrdsTipoArchivoUpload%>)</b></font></td></tr></table></center></b>
    <form ACTION="../servlet/Utilerias.Upload" name="gestionafichero" id="gestionafichero" enctype="multipart/form-data" METHOD="post">                   
         <input id = "Columns"      name = "Columns"      type = "hidden" value = '<%=StrColumnas%>'    >
         <input id = "MaxRegistros" name = "MaxRegistros" type = "hidden" value = '<%=StrMaxRegistros%>'>
     
        <div id='D2' Name='D2' class='VTable' style='position:absolute; z-index:3; left:25px; top:75px;'>
            <p class='FTable'>Codigo de Acceso<br>
            </p>
        </div>

          <div id='D3' Name='D3' class='VTable' style='position:absolute; z-index:3; left:34px; top:120px;'>
                <INPUT TYPE="Codigo" class='VTable' label='Codigo' size=13  id='Codigo' name='Codigo' value='' ></INPUT>
            </p>
        </div>

        <div class='VTable' style='position:absolute; z-index:3; left:35px; top:160px;'>
            <p class='FTable'>Selecciona el Archivo<br>
            <input type="file" name="fichero" class="VTable" size="50" onblur="fnVerificaFile(this);"  >
        </div>

        <div  class='VTable' style='position:absolute; z-index:4; left:280px; top:70px;'>
            <input type="button" value="Subir Archivo" class="cBtn" onclick='fnProcesoFile();'  id="btnUpload">
        </div>  

         <div id="ResBlock1" name="ResBlock1" class='cssBGDet' style='position:absolute; z-index:1; left:10px; top:40px; width:400px; height:170px;'>
         <p class='cssTitDet'> Carga de Archivo (Máximo <%=StrMaxRegistros%> Registros) </p></div>
       <%
            rs.close();
            rs                     = null;
            StrclUsrApp            = null;
            StrclPaginaWeb         = null;
            StrclTipoArchivoUpload = null;
            StrSentenciaSQL        = null;
            StrColumnas            = null;
            StrMaxRegistros        = null;
            StrdsTipoArchivoUpload = null;
       %> 
    </form> 

        <div id="Upload" class='VTable' style='position:absolute; z-index:3; left:35px; top:90px;'>
           <!--iframe src="Captcha.jsp" width=75 height=25 scrolling="no" frameborder="no"></iframe-->
           <!--img src='Captcha.jsp'-->
           
           <img src='../servlet/Utilerias.Captcha'>
        </div>

         <div style='position:absolute; z-index:1000; left:30%; top:40%' id="DivUpload">
            <iframe src="UploadFile.html" width=320 height=190 scrolling="no" frameborder="no">
            </iframe>
        </div>
        
         <script>document.all.DivUpload.style.visibility='hidden';</script>       
    </body>  
    
    <script>
        function fnProcesoFile()
        {        
            var MSG = "Falta informar: ";
            
            if ( document.all.fichero.value == '' )
                MSG = MSG + "Archivo, ";
            
            if ( document.all.Codigo.value == '' )
                MSG = MSG + "Codigo de Acceso, ";

            if (MSG!='Falta informar: ')
                alert(MSG);

            else
            {
                fnProcesoUpload( 1 );
                fnOpenWindow();
                document.all.gestionafichero.target = "WinSave";
                document.all.gestionafichero.submit();
            }
        }
        
        function fnVerificaFile( file )
        {
            if( file.value != "" )  
            { 
                fail=file.value.substring( file.value.length - 4 ) 
                if( fail == ".xls" )   
                    return true 
                
                else  
                { 
                    alert( "Sólo puedes elegir archivos de Excel" ) 
                    file.focus() 
                    return false 
                } 
            } 
        }

        function fnProcesoUpload( Proceso )
        {
            if ( Proceso == 1 )
            {
              document.all.ResBlock1.style.filter = 'gray';
              document.all.btnUpload.disabled = true;
              document.all.DivUpload.style.visibility = 'visible';
            }
            
            else
            {
              document.all.ResBlock1.style.filter = '';
              document.all.btnUpload.disabled = false;
              document.all.DivUpload.style.visibility = 'hidden';
            }
        }               
    </script>  
</html>