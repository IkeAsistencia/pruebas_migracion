<%-- 
    Document   : CSDatosConcierge
    Created on : 2/12/2010, 06:21:18 PM
    Author     : rfernandez
--%>

<%@page import="java.util.Set"%>
<%@page contentType="text/html; charset=iso-8859-1" import="java.sql.ResultSet,Seguridad.SeguridadC,Utilerias.UtileriasBDF"%>
<html>
    <head><title></title></head>
    <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    
    <body topmargin="5" leftmargin="5" bgcolor=000066 bgproperties="fixed">
        <table class="Table" width='900' cellspacing="0" cellpadding="0" border="0">
            
            <%
            String strclUsrApp = "0";
            String StrclPromocion = "0";
            String StrclCuenta = "0";
            String StrclSubservicio = "0";
            String strclConcierge = "0";
            String strclAsistencia = "0";

            if(session.getAttribute("clUsrApp") != null){
                strclUsrApp = session.getAttribute("clUsrApp").toString();
            }

            if(session.getAttribute("clConcierge") != null){
                strclConcierge = session.getAttribute("clConcierge").toString();
            }

            if(session.getAttribute("clAsistencia") != null){
                strclAsistencia = session.getAttribute("clAsistencia").toString();
            }

            if(SeguridadC.verificaHorarioC(Integer.parseInt(strclUsrApp)) != true) {
                %>Fuera de Horario<%
                return;
            }

            if(session.getAttribute("clSubservicio") != null){
                StrclSubservicio = session.getAttribute("clSubservicio").toString();
            }

            String StrclAsistenciaVTR = "";
            if(session.getAttribute("clAsistenciaVTR")!=null){
                StrclAsistenciaVTR = session.getAttribute("clAsistenciaVTR").toString();
            }

            session.setAttribute("clSubservicio", StrclSubservicio);

            if(strclConcierge.equalsIgnoreCase("0")){
            }else{
                try{
                    StringBuffer strSQL = new StringBuffer();
                    strSQL.append("st_CSDatosConciergeFrame ").append(strclConcierge).append(",").append(strclAsistencia);
                    ResultSet rs = UtileriasBDF.rsSQLNP(strSQL.toString());
                    strSQL.delete(0,strSQL.length());
                    if(rs.next()){
                        String StrclEstatus = rs.getString("clEstatus");
                        String StrTieneHija = rs.getString("TieneHija");
                        StrclCuenta = rs.getString("clCuenta");
                        if(StrclEstatus.equalsIgnoreCase("49") && StrTieneHija.equalsIgnoreCase("0")){
                            %><center><input type="button" value="Duplicar a asistencia <%=StrclAsistenciaVTR%>" class="cBtn" onClick="fnDuplicar();"></center></td><%
                        }
                        %>
                        <tr><td colspan="2">
                            <!--td class='TitResumen' >Assistência: </td><td class='FTable'><%=strclAsistencia%></td-->
                            <td class='TitResumen' >NU: </td><td class='FTable'><%=rs.getString("Nombre NU")%></td>
                            <td class='TitResumen' >Cuenta: </td><td class='FTable'><%=rs.getString("Cuenta")%></td>  
                        </tr>
                        <tr>
                            <td colspan="2" class="TitResumen"><center>Tiempo Contacto: <%=rs.getString("dsTiempoContacto")%></center></td>
                            <td class='TitResumen' >Clave: </td><td class='FTable'><%=rs.getString("Clave")%></td>
                            <td class='TitResumen' >SubServicio: </td><td class='FTable'><%=rs.getString("Subservicio")%></td>      
                        </tr>
                        <tr>
                            <td colspan="2" align="left"><input type="button" value="Promociones" class="cBtn" onClick="fnPromocion();"></td>
                            <td class='TitResumen' >Recepción de Solicitud: </td><td class='FTable'><%=rs.getString("Tipo de peticion")%></td>
                            <td class='TitResumen' >Destino: </td><td class='FTable'><%=rs.getString("Tipo de Envio")%></td>
                        </tr>
                    <%
                    session.setAttribute("clCuenta", StrclCuenta);
                    }
                    rs.close();
                    rs = null;
                }catch(Exception e){
                    e.printStackTrace();
                }
            }
            %>
        </table>
        <script>
            function fnPromocion(){
                var pstrCadena = "CSPromocionesConcierge.jsp?" ;
                window.open(pstrCadena,'newWinNA','scrollbars=yes,status=yes,width=535,height=400,top=200,left=250');
            }

            function fnDuplicar(){
                var pstrCadena = "CSDuplicaAsistencia.jsp?" ;
                window.open(pstrCadena,'newWinNA','scrollbars=yes,status=yes,width=100,height=100,top=200,left=250');
            }

            function fnActualizaAsist(clAsistencia, PaginaWeb){
                alert('Se duplico la Asistencia Correctamente.');
                top.frames['Contenido'].location.href('CSCamposExtraAs.jsp?clConcierge=<%=strclConcierge%>&clSubservicio=<%=StrclSubservicio%>&clAsistencia='+clAsistencia+'&URLASISTENCIA=https://sisear.ikeasistencia.com/Operacion/Concierge/'+PaginaWeb);
            }
        </script>
    </body>
</html>