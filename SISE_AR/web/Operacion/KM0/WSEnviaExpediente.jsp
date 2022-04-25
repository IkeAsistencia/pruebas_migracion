<%@ page contentType="text/html; charset=iso-8859-1" language="java" 
         import="Utilerias.UtileriasBDF,java.sql.ResultSet,WSC.EnviaExpediente" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head><title>WS Envia Expediente</title> 
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <script type="text/javascript">
         function sendMessageAndClose(texto){
            btnClose = "<br /><input type='button' value='Cerrar' onclick='javascript:window.close();'>";
	    document.getElementById("content").innerHTML = texto + btnClose ;
	    setTimeout(function(){ window.close() }, 30000);
         }
        </script>
    </head>
    <body>
        <div id="content" />
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
        <%
            String StrclUsrApp = "0";
            String StrclExpediente = "0";
            int Error = 0;

            if (session.getAttribute("clUsrApp") != null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();
            }

            if (request.getParameter("clExpediente") != null) {
                StrclExpediente = request.getParameter("clExpediente").toString();
            }

            String sAProgramar = (request.getParameter("AProgramar")!=null?request.getParameter("AProgramar"):"0");
            String sConExcedente=(request.getParameter("ConExcedente")!=null?request.getParameter("ConExcedente"):"0");

            ResultSet rsExpedienteWS = UtileriasBDF.rsSQLNP("st_ValidaExpWS " + StrclExpediente);

            if (rsExpedienteWS.next()) {
                if (rsExpedienteWS.getString("Existe").equalsIgnoreCase("0")) {
                    System.out.println("WS 1");
                    try{
                        EnviaExpediente EnvExp = new EnviaExpediente();
                        //COMENTADO EN DESARROLLO-
                        Error = EnvExp.EnviaExpediente(StrclExpediente, StrclUsrApp);
                        
                        //Enviar a BACK con STATUS de ASIGNACION AUTOMATICA
                        System.out.println("Expediente Enviado al A.A.");

                        ResultSet rsEx = UtileriasBDF.rsSQLNP("st_EnviaExpediente " + StrclExpediente + ", " + StrclUsrApp + ", 'AUTO'" + ", " + sAProgramar + ", " + sConExcedente );
                        if ( rsEx.next() ) {
                            int tmpRetValue = rsEx.getInt("insertado");
                            if ( tmpRetValue == 1 ) {
                                System.out.println("WSEnviaExpediente.jsp:Enviado a la bolsa: OK");
                            }
                            else {
                                System.out.println("WSEnviaExpediente.jsp:Enviado a la bolsa: ERROR:" + rsEx.getString("comentarios"));
                            }
                        }
                        else {
                            System.out.println("WSEnviaExpediente.jsp:Error sin registros de retorno");
                        }
                        rsEx.close();
                    } catch (Exception e) {
                        %>
                            <script>
                                sendMessageAndClose('Error al publicar, no hay conexion con AA, intente nuevamente');
                                //alert('Error al publicar, no hay conexion con AA, intente nuevamente');
                                //window.close();
                            </script>
                        <%
                    }
                    //EnviaExpediente = null;
                }
            } 
            rsExpedienteWS.close();
            rsExpedienteWS = null;
        %>
        <script>
            if(<%=Error%>==0){
                sendMessageAndClose('Expediente Publicado!');
                //alert('Expediente Publicado!');    
            }else{
                sendMessageAndClose('Falló la publicacion del expediente por favor intente mas tarde.');
                //alert('Falló la publicacion del expediente por favor intente mas tarde.');    
            }
            //window.close();                
        </script>
    </body>
</html>