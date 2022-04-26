<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,java.sql.ResultSetMetaData,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<html>
<head>
    <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    <title>USUARIO SP</title>
</head>
<script src='Util.js'></script>
<jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj" /> 
<%

    String StrUsuario="";
    String StrclUsrApp="0";

     if (request.getParameter("Usuario")!= null){
       StrUsuario = request.getParameter("Usuario").toString(); 
        }

     if (session.getAttribute("clUsrApp")!= null){
       StrclUsrApp = session.getAttribute("clUsrApp").toString(); 
        }

    if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true){
        %>Fuera de Horario<%

        return; 
       }%>
 <body class='cssBody' topmargin='10'>
         <form id='Forma' name ='Forma' action='FiltroUsrSP.jsp' method='get'>
             <p class='cssTitDet'>Usuario SP</p>
             <div class='VTable' style='position:absolute; z-index:25; left:250px; top:50px;'>
             <INPUT ID="Buscar" type='button' VALUE='Buscar...' onClick='document.all.Forma.submit()' class='cBtn'></div>
             <%=MyUtil.ObjInput("Nombre de Usuario","Usuario","",true,true,10,40,"",true,true,40)%>
         
             <p></p> <br><br><br>
         </form>
         <SCRIPT>
             document.all.Usuario.readOnly=false;             
         </SCRIPT>
           
        <%StringBuffer strSalida = new StringBuffer();
         System.out.println("sp_BuscaUsrSP '" + StrUsuario + "'");
          UtileriasBDF.rsTableNP("sp_BuscaUsrSP '" + StrUsuario + "'", strSalida);

        %><%=strSalida.toString()%>
        <%strSalida.delete(0,strSalida.length());
          strSalida =null;
          StrclUsrApp=null;
          StrUsuario=null;
            %>
</body>
</html>