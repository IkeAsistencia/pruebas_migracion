<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,java.sql.ResultSetMetaData,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<html>
    <head>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <title>Busca Cliente VIP</title>
    </head>
    <script src='Util.js'></script>
    <%
    String StrclUsrApp="0";
    if (session.getAttribute("clUsrApp")!= null){
        StrclUsrApp = session.getAttribute("clUsrApp").toString();     } 
    if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true){
        %>Fuera de Horario<%
        StrclUsrApp=null;
        return; 
        } 
    String StrNombre="";       
    if (request.getParameter("Nombre")!= null){
        StrNombre = request.getParameter("Nombre").toString();      }     
    %><body class='cssBody' topmargin='10'>
        <BGSOUND SRC="../Music/UTOPIA.WAV">
        <p class='cssTitDet'>Clientes VIP</p>
        <%
        ResultSet rs =null;
        boolean blnRegistro = true;
        try{
            rs = UtileriasBDF.rsSQLNP( "sp_BuscaClienteVIP '" + StrNombre + "'");        
            if (rs.next()){               
               ResultSetMetaData rsMetaDato = rs.getMetaData();
               int i;
               %><table class='Table' border='0' cellpadding='0'>
                    <tr class = 'TTable'>
                        <% for ( i=1; i<=rsMetaDato.getColumnCount(); i++){%>
                            <th><%=rsMetaDato.getColumnLabel(i)%></th>
                            <% }%>
                    </tr>
                <% do{
                    // Checa que si el registro es par o non
                    if (blnRegistro){
                       %><tr class='R1Table'><%
                       blnRegistro = false;
                    } else {
                       %><tr class='R2Table'><%
                       blnRegistro = true;
                        }
                    for ( i=1; i<=rsMetaDato.getColumnCount(); i++){
                       %><td><%=rs.getObject(i)%></td><%
                        }
                    %></tr><%
                }while (rs.next());
            }else{ %><script>window.close()</script><%   }
        }catch(Exception e){
            rs.close();
            rs=null;
            StrclUsrApp=null;
            StrNombre=null;
            e.getMessage();
            }
    rs.close();
    rs=null;
    StrclUsrApp=null;
    StrNombre=null;
%>
</table>
</body>
</html>