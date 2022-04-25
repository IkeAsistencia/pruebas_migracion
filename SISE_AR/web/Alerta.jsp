<%-- 
    Document   : Alerta
    Created on : 7/02/2020, 02:52:53 PM
    Author     : vrayon
--%>

<%@page contentType="text/html; charset=iso-8859-1"%>
<!DOCTYPE html>
<html>
    <head>
         <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
         <link href="StyleClasses/AlertaNRM.css" rel="stylesheet" type="text/css">
    </head>
    <body style="background-color: #062f67;">

        <!-- The Modal -->
        <div id="myModal" class="alerta" style="text-align: center;">
          <!-- Modal content -->
          <div class="alerta-content" style="text-align: center;border: 16px solid #062f67;">
              <span id="alerta-close" class="alerta-close">&times;</span>
            <h3 style="text-align:center;color: red;">Alerta</h3>
            <p style="text-align:center;background-color: #afc3e0;color: #062f67;">NUEVOS USUARIOS DE NISSAN-RENAULT-MITSUBISHI ( <span id="total"> </span> ) </p>
            <div style="overflow-x:auto;">
                <table>
                  <tr>
                    <th>Informacion</th>
                    <th>Descripcion</th>
                    <th>Registros</th>
                  </tr>
                  <tr>
                    <td rowspan="4"> <a style="text-decoration: none; display: block">Subscripciones en proceso</a></td>
                    <td>Nuevos Usuarios</td>
                    <td id="pairing"></td>
                  </tr>
                  <tr>
                    <td>Solicitando Informacion</td>
                    <td id="userRequest"></td>
                  </tr>
                   <tr>
                    <td>Usuarios con Informacion</td>
                    <td id="userResponse"></td>
                  </tr>
                   <tr>
                    <td>Usuarios para Afiliar</td>
                    <td id="userSettings"></td>
                  </tr>
                </table>
            </div>  
            <br>
          </div>
        </div>
        <script src='Operacion/NRM/js/AlertaNRM.js'></script>
        <script src='Utilerias/v1/Ajax.js'></script>
    </body>
</html>
