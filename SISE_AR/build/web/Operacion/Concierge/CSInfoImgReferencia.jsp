<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<html>
<head>
<title></title>
</head>
<body class="cssBody">
<link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
<script src='../../Utilerias/Util.js'></script>
<%

    String StrclReferencia="0";

     if (request.getParameter("clReferencia")!= null){
            StrclReferencia= request.getParameter("clReferencia").toString();
             session.setAttribute("clReferencia",StrclReferencia);
     }
     


    session.setAttribute("TipoImagen","ImgxR");
    
   %>
            <iframe src="../../Concierge/Imagen.jsp?Width=100&Height=80&Left=640&ListaImg=1&AsignaImg=1" scrolling="no"  frameborder="no" width=810 height='900'></iframe>
   
            <script>
                   function fnCloseImg(){
                    top.opener.location.reload();
                    window.close();
                   }
            
            </script>
</body>
</html>

   