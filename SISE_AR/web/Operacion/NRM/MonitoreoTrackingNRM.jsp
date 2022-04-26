<%-- 
    Document   : MonitoreoTracking
    Created on : 4/02/2020, 11:26:29 AM
    Author     : lleyva
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="Utilerias.ResultList"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="Utilerias.UtileriasBDF"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.Calendar"%>
<%@page contentType="text/html"%>
<%@page pageEncoding="ISO-8859-1" %>
<% String tiempo =request.getParameter("tiempo");
 if(tiempo.equals("")){
     tiempo="30";
 }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="refresh" content="<%=tiempo%>">
        <title>Monitoreo Tracking</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <% 

Date fecha = new Date();
SimpleDateFormat ft = new SimpleDateFormat("dd MMMM yyyy HH:mm:ss  zzzz");
String fechaactual=ft.format(fecha);
      %>
    </head>
    <body onload="submitData()">
        <p>         <b class="caja" style="margin-left: 5%">    FECHA DE ULTIMA ACTUALIZACION : <%=fechaactual%></b></p>
        <div>
        <iframe  id="urlmT"   style="height: 94%; width:97%; position: absolute; " frameborder="0" >
            <button class="btn btn-primary" onclick="location.reload();">Actualizar</button>
        </iframe>
            </div>
        
          
        
        <%
            
            StringBuffer StrSql = new StringBuffer();
            String salida = "";
            String clexp="0";
            clexp=request.getParameter("clexpediente");
             ResultSet strSalida = null;

            
                StrSql.append("st_nrm_Json_TrackingMP "+clexp);
             strSalida=UtileriasBDF.rsSQLNP(StrSql.toString());
            while(strSalida.next()){
                salida =strSalida.getString(1);
              }
           
                strSalida.close();
                StrSql.delete(0, StrSql.length());
               %>
        
 
        <script>
            function submitData(){
                var payload = JSON.parse('<%=salida%>');
var iframe = document.getElementById('urlmT');
$.ajax({
  type: 'POST',
  //Liga para DEV
  url: 'https://siamdev.ikeasistencia.com/map_service_DEV/api/tracking/map',
  
   //Liga para QA
//  url: 'https://siamdev.ikeasistencia.com/map_service/api/tracking/map',
  contentType: 'application/json',
  dataType: 'html',
  data: JSON.stringify(payload),
  success: function(data) {
                                         
iframe.contentWindow.document.open();
iframe.contentWindow.document.write(data);
        },
        error: function() {
            console.error("No es posible completar la operacion");
        }
});
}



</script>
<style type="text/css">
   .boton_personalizado{
    text-decoration: none;
    padding: 8px;
    font-weight: 600;
    font-size: 20px;
    color: #ffffff;
    background-color: #1883ba;
    border-radius: 6px;
    border: 1px solid #0016b0;
    padding-top: 1px;
    margin-left: 5%;
    
  }

  .caja { 
font-family: sans-serif; 
font-size: 18px; 
font-weight: 400; 
color: #ffffff; 
background:#1883ba }
  
</style>
    </body>
    
</html>

       