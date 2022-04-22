<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,java.sql.ResultSetMetaData,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<html>
<head>
      <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    <title>Busca Equipo</title>
</head>
<script src='../Util.js'></script>
<jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj" />
<%

    String StrclUsrApp="0";
    String StrNomEquipo="";  
    String StrNumSerie="";

    if (request.getParameter("NomEquipo")!= null){
       StrNomEquipo = request.getParameter("NomEquipo").toString();     }
    if (request.getParameter("NumSerie")!= null){
       StrNumSerie = request.getParameter("NumSerie").toString();   }   
     if (session.getAttribute("clUsrApp")!= null){
       StrclUsrApp = session.getAttribute("clUsrApp").toString();   }

    if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true){
        %>Fuera de Horario<%
        StrclUsrApp=null;
        StrNomEquipo=null;      
        StrNumSerie=null;  
        return;
       }%>
 <body class='cssBody' topmargin='10'>
         <form id='Forma' name ='Forma' action='BuscaPerifericoSP.jsp' method='get'>
             <p class='cssTitDet'>EQUIPO</p>
             <div class='VTable' style='position:absolute; z-index:25; left:250px; top:50px;'>
             <INPUT ID="Buscar" type='button' VALUE='Buscar...' onClick='document.all.Forma.submit()' class='cBtn'></div>            
             <%=MyUtil.ObjInput("Nombre de Equipo","NomEquipo","",true,true,10,50,"",true,true,40)%>
             <%=MyUtil.ObjInput("Numero de Serie","NumSerie","",true,true,10,90,"",true,true,10)%>            
             <p></p> <br><br><br><br><br>
         </form>
         <script>
              document.all.NomEquipo.readOnly=false;            
              document.all.NumSerie.readOnly=false;
         </script>
        <%
            StringBuffer strSalida = new StringBuffer();
            //System.out.println("sp_AsignaTaxi '" +StrclProveedor+"','"+ StrNomEquipo+"','"+StrPlacas+"','"+StrNumSerie+"'");
         //   UtileriasBDF.rsTableNP("sp_BuscaAsignaProveedor '" +StrclProveedor+"','"+ StrNomEquipo+"','"+StrPlacas+"','"+StrNumSerie+"'",strSalida);
               UtileriasBDF.rsTableNP("sp_ListadoPerifericosAsigna '"+StrNomEquipo+"','"+StrNumSerie +"'" ,strSalida);
            %><%=strSalida.toString()%>
            <%strSalida.delete(0,strSalida.length());
            strSalida =null;
            StrclUsrApp=null;
            StrNomEquipo=null;           
            StrNumSerie=null;                 
            %>
</body>
</html>

