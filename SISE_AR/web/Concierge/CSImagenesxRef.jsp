<%@page contentType="text/html"%>
<%@page pageEncoding="ISO-8859-1" import="Utilerias.UtileriasBDF"%>



<html>
    <%
      String StrclReferencia = "";
      
      if (session.getAttribute("clReferencia") != null) {
            StrclReferencia= session.getAttribute("clReferencia").toString();
      }
      
      session.setAttribute("TipoImagen","ImgxR");

    %>
    <head>
        <meta http-equiv="Content-Type" content="text/html;">
        <title>Imagenes x Referencia</title>
            <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">

           <div  style='position:absolute; z-index:1; left:20px; top:60px;' >
            <iframe src="Imagen.jsp?srcImg=&Width=120&Height=100&Left=640&ListaImg=1" scrolling="no"  frameborder="no" width=810 height='900'></iframe>
            </div>     
            

            
    </body>
</html>
