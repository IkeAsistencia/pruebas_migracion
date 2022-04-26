<%@ page contentType="text/html; charset=iso-8859-1" language="java"  errorPage="" %>
<%@ page import = "java.sql.ResultSet,Utilerias.UtileriasBDF"%>
<html>
<head>
        <title>Información de Promoción</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <style>
            .cssVPromo {
                font-family: Verdana, Arial, Helvetica, sans-serif;
                color: #FFFFFF;
                background-color: #86D75E;
                font-size: 11px;
                font-weight: bold
            }
            
            .cssRPromo {
                font-family: Verdana, Arial, Helvetica, sans-serif;
                color: #FFFFFF;
                background-color: #D82C00;
                font-size: 11px;
                font-weight: bold
            }
        </style>
</head>

<script src='../Utilerias/Util.js'></script>

<%
       String StrclGolfProgram = "0";
       String StrclAsistencia = "";
       String StrclUsr = "0";
        
        if (session.getAttribute("clUsrApp")!= null){
       		StrclUsr = session.getAttribute("clUsrApp").toString();
        }
        
        
        if (session.getAttribute("clAsistencia")!= null){
                StrclAsistencia = session.getAttribute("clAsistencia").toString();
        }
                    
       if (request.getParameter("clGolfProgram")!= null){
            StrclGolfProgram= request.getParameter("clGolfProgram").toString();
      	}



        System.out.println(StrclGolfProgram);
        StringBuffer StrSql = new StringBuffer();
        StrSql.append( " st_CSDetalleCampoGolf ").append(StrclGolfProgram) ;
        
       ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
       
 %>

<body class="cssBody">
         
         <center>
             <%

if (rs.next()){
      %>
         <table border=1 cellpadding="1" cellspacing="1" class='FTable' width="600">
             <tr><td class='cssTitDet' colspan="4">Campo de Golf </td></tr>
             <tr><td class='TTable' colspan="1">Campo : </td><td colspan="3"><%=rs.getString("dsCamposGolf")%></td>
             <tr><td class='TTable'>Entidad : </td><td><%=rs.getString("ESTADO")%></td>
                 <td class='TTable'>Direccion : </td><td><%=rs.getString("DIRECCION")%></td>
             </tr>
             <tr><td class='TTable' colspan="4"><center>Beneficios : </center></td></tr>
             <tr><td colspan="4"><%=rs.getString("Beneficio")%></td></tr></tr>
             
             <tr><td class='TTable' colspan="4"><center>Descripcion  :<center> </td></tr>
             <tr><td colspan="4"><%=rs.getString("Descripcion")%></td></tr>
             <tr>
                <td class='TTable'>Costo de Green  : </td><td><%=rs.getString("CostoGreenFee")%></td>
                <td class='TTable'>Costo Caddie : </td><td><%=rs.getString("CostoCaddie")%></td>
             </tr>
             <tr>
                 <td class='TTable'>Costo Carrito  : </td><td><%=rs.getString("CostoCarrito")%></td>
                 <td class='TTable'>Costo Renta Bastones : </td><td><%=rs.getString("CostoRentaBastones")%></td>
             </tr>
             <tr>
                 <td class='TTable'>Contacto Primario : </td><td><%=rs.getString("CONTACTOPRIMARIO")%></td>
                 <td class='TTable'>Contacto Secundario : </td><td><%=rs.getString("CONTACTOSECUNDARIO")%></td>
             </tr>
             <tr>
                <td class='TTable'>Contacto Terciario : </td><td><%=rs.getString("CONTACTOTERCIARIO")%></td>
                <td class='TTable'>Telefono : </td><td><%=rs.getString("TELEFONO")%></td>
             </tr>
             <tr>
                 <td class='TTable'>Horarios : </td><td><%=rs.getString("Horarios")%></td>
                 <td class='TTable'>WEB : </td><td><%=rs.getString("WEB")%></td>
                 
             </tr>   
                
             <tr><td class='TTable'>Publico Privado : </td><td><%=rs.getString("PublicoPrivado")%></td>
             <td class='TTable'>Servicios : </td><td><%=rs.getString("Servicios")%></td></tr>

         </table>
         <%
           rs.close();
             rs = null;
             }
         %>
         
         </center>
</body>
</html>
