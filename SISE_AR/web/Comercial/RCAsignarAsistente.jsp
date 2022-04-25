<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="com.ike.ReuComer.DAORCReunion,com.ike.ReuComer.to.RCReunion,java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head><title>Posibles Asistentes</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <link href="../StyleClasses/Calendario.css" rel="stylesheet" type="text/css"> 
    </head>
    <body class="cssBody" >
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
        <script src='../Utilerias/Util.js' ></script>
        <script src="../Utilerias/UtilCalendario.js"></script>
        <script src='../Utilerias/UtilMask.js'></script>
        <%
            String strclReunion = "0";
            String strAsignar = "";
            int iCont = 0;

            if (request.getParameter("clReunion")!= null) {
                strclReunion = request.getParameter("clReunion").toString();
            }

            if (request.getParameter("Asignar")!= null) {
                strAsignar = request.getParameter("Asignar").toString();
            }

            StringBuffer StrSql = new StringBuffer();
            StrSql.append("st_RCPosiblesAsistentes ").append(strAsignar)
            .append(",").append(strclReunion);
            ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
        %>
        
        <form name="Asignacion" id="Asignacion" method='post' action='RCAsignaAsistente.jsp'>
            
            <input type='hidden' name='Asignar' id='Asignar' value ='<%=strAsignar%>'></input>
            <input type='hidden' name='clReunion' id='clReunion' value ='<%=strclReunion%>'></input>
            <div class='VTable' style='position:absolute; z-index:25; left:30px; top:30px;'>
                <table>
                    <tr class='cssTitDet'>
                    <td colspan="2">Asistentes IKE</td></tr>
                    <%    
                        while(rs.next()) {

                        %>
                    <tr><td><input id='Elegido' name='Elegido' type='checkbox'></input></td>
                        <td><INPUT disabled='true' id='Nombre' name='Nombre' type='text' size="60" value='<%=rs.getString("Nombre")%>'></td>
                        <td><INPUT disabled='true' id='clUsrApp' name='clUsrApp' type='hidden' size="3" value='<%=rs.getString("clUsrApp")%>'></td>
                    </tr>
                    <%
                    iCont=iCont+1;
                            }
            %>
                    </table>
            </div>
            <textarea name='Resultados' id='Resultados' cols='10' rows='3' ></textarea>
            <input type='hidden' name='Total' id='Total' value ='<%=iCont%>'></input>

            <div class='VTable' style='position:absolute; z-index:40; left:450px; top:30px;'>
                <input class='cBtn' type='submit' name='Asigna' id='Asigna' value="Asignar a la reunion" onClick="fnConcatenaAsigna();"></input>
            </div>

        </form>
    
        <script>
            document.all.Resultados.style.visibility="hidden";
            
            function fnConcatenaAsigna()
            {
            i=0;
            document.all.Resultados.value='';
             
            if (document.all.Total.value == 1)
            {
            alert ("Debe haber al menos un participante de Ike")
            }
      
            else
            {
            while (i < document.all.Total.value)
            {
            if (document.all.Elegido(i).checked)
            {
            if (document.all.Resultados.value=='')
            {
            document.all.Resultados.value = document.all.clUsrApp(i).value;
            }
            else
            {
            document.all.Resultados.value = document.all.Resultados.value +',' + document.all.clUsrApp(i).value;
            }
            }
            i++;
            }}
            }//Funcion
    
    
        </script>
    </body>
</html>
