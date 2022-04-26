<%@page import="com.ike.ws.nrm.WSClientsNrm"%>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>

<html> 
    <head>
        <title>Filtro Nuestro Usuario</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <link href="../StyleClasses/AlertaNRM.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
        <script src='../Utilerias/Util.js' ></script>      
        <script src='../Utilerias/UtilMask.js'></script>
        <%
            String strclUsr = "";
            int iX = 100;
            ResultSet rs = null;
            StringBuffer strSql = new StringBuffer();

            String strclGrupoCuenta = "";
            String strclCuenta = "0";
            String strNU = "";
            String strClave = "";
            String strDNI = "";
            String strPlacas = "";
            String strCorreo = "";
            String strStrGpoCuenta = "";
            String strclGrupoCuentaC = "0";
            String strStrCuenta = "";


            if (session.getAttribute("clUsrApp") != null) {
                strclUsr = session.getAttribute("clUsrApp").toString();
            }

            if (request.getParameter("clGrupoCuenta") != null) {
                strclGrupoCuenta = request.getParameter("clGrupoCuenta").toString().trim();
            }

            if (request.getParameter("clCuenta") != null) {
                strclCuenta = request.getParameter("clCuenta").toString().trim();
            }

            if (request.getParameter("NU") != null) {
                strNU = request.getParameter("NU").toString().trim();
            }

            if (request.getParameter("Clave") != null) {
                strClave = request.getParameter("Clave").toString().trim();
            }

            if (request.getParameter("DNI") != null) {
                strDNI = request.getParameter("DNI").toString().trim();
            }

            if (request.getParameter("Placas") != null) {
                strPlacas = request.getParameter("Placas").toString().trim();
            }
            
            if (request.getParameter("Correo") != null) {
                strCorreo = request.getParameter("Correo").toString().trim();
            }

            if ((request.getParameter("clCuenta").toString().compareToIgnoreCase("") != 0) && (request.getParameter("clCuenta").toString().compareToIgnoreCase("0") != 0)) {
                strclCuenta = request.getParameter("clCuenta").toString().trim();
                rs = UtileriasBDF.rsSQLNP("st_getDatosCuenta " + strclCuenta);
                if (rs.next()) {
                    strStrGpoCuenta = rs.getString("dsGrupoCuenta");
                    strStrCuenta = rs.getString("Nombre");
                } else {
                    strStrGpoCuenta = "";
                    strStrCuenta = "";
                }
                rs.close();
                rs = null;
            }
            
            if(request.getParameter("clGrupoCuentaC") != null){
            strclGrupoCuentaC = request.getParameter("clGrupoCuentaC").toString().trim();
            
        }

            MyUtil.InicializaParametrosC(169, Integer.parseInt(strclUsr));

        %>
        <form id='Forma' name ='Forma' action='FiltrosNuestroUsr.jsp' method='get'>

            <input type='hidden' id='strSQL' name='strSQL' value="sp_WebBuscaNuestroUsrnvo 4, ">
            <INPUT id='NomGpoCuenta' name='NomGpoCuenta' type='hidden' value='<%=strStrGpoCuenta%>'>

            <%=MyUtil.ObjComboC("Grupo Cuenta", "clGrupoCuenta", strStrGpoCuenta, true, true, 25, iX, "", "Select clGrupoCuenta, dsGrupoCuenta from cGrupoCuenta order by dsGrupoCuenta", "document.all.NomGpoCuenta.value=document.all.clGrupoCuentaC[document.all.clGrupoCuentaC.selectedIndex].text", "", 50, false, false)%>
            <% iX += 40;%>
            <%=MyUtil.ObjComboC("Cuenta", "clCuenta", strStrCuenta, true, true, 25, iX, "", "Select clCuenta, Nombre from cCuenta where Activo=1 order by 2 asc", "", "", 50, false, false)%>
            <% iX += 40;%>
            <%=MyUtil.ObjInput("Nuestro Usuario", "NU", strNU, true, true, 25, iX, "", false, false, 50)%>
            <% iX += 50;%>
            <%=MyUtil.ObjInput("Clave", "Clave", strClave, true, true, 25, iX, "", false, false, 50)%>
            <% iX += 40;%>
            <%=MyUtil.ObjInput("DNI", "DNI", strDNI, true, true, 25, iX, "", false, false, 50)%>
            <% iX += 40;%>
            <%=MyUtil.ObjInput("Patente", "Placas", strPlacas, true, true, 25, iX, "", false, false, 50)%>
            <%iX+=40;%>
            <%=MyUtil.ObjInput("Correo Electronico","Correo",strCorreo,true,true,25,iX,"",false,false,50)%>

            <div class='VTable' style='position:absolute; z-index:300; left:30px; top:40px;'>
                <input type='button' value='BUSCAR...' onClick='document.all.Forma.submit();this.disabled = true' class='cBtn'>
            </div>

            <div style='position:absolute; z-index:300; left:30px; top:-10px;'>
                <p style="color: red">
                    Favor de tomar en cuenta que la búsqueda por nombre solo permite primer nombre y dos apellidos.
                </p>
            </div>

        </form>

        <%=MyUtil.GeneraScripts()%>
        <br><br><br><br><br>
        <div class='VTable' style='position:absolute; z-index:301; left:350px; top:40px;'>
            <input name='CSNumberMsk' id='CSNumberMsk' type='hidden' value='VN09VN09VN09VN09F---VN09VN09VN09VN09'>
            <%
                strSql.delete(0, strSql.length());

                if (request.getParameter("strSQL") != null) {
                    strSql.append(request.getParameter("strSQL").toString().trim());
                    strSql.append(" '").append(strclGrupoCuenta).append("','").append(strclCuenta).append("','");
                    strSql.append(strNU).append("','").append(strClave).append("','").append(strDNI).append("','").append(strPlacas).append("'");
                }

                if (strSql.length() > 0) {
                    StringBuffer strSalida = new StringBuffer();
                    //System.out.println("Pagina: FiltroNU " + strSql);
		    System.out.println(strSql);
                    UtileriasBDF.rsTableNP(strSql.toString(), strSalida);
                              
                    
                if(strclGrupoCuentaC!=null&&"89".equals(strclGrupoCuentaC)){
                    System.out.println("Este es un NRM");

                    //Se crea la instancia a la clase que procesa los criterios de busqueda
                    WSClientsNrm clientsNrm = new WSClientsNrm();
                    String result = "";
                    if(strNU != ""){
                        System.out.println("Busqueda por nombre: " + strNU);
                        //si la varia strNU no viene vacia se busca por el nombre
                        result = clientsNrm.getClientByName(strNU);
                    }else if(strClave != ""){
                        System.out.println("Busqueda por clave: " + strClave);
                        //si la strClave strNU no viene vacia se busca por el vin o clave
                        result = clientsNrm.getClientByVin(strClave);
                    }else if(strCorreo != ""){
                        System.out.println("Busqueda por correo: " + strCorreo);
                        //si la variable strCorreo no viene vacia se busca por el correo electronico
                        result = clientsNrm.getClientByEmail(strCorreo);
                    }
                    //Se imprime la lista construida con los usuarios que cumplen el criterio de busqueda
                    %><%=result%><%
            }else {
           %>
            <%=strSalida.toString()%>
            <%
                }
                    strSalida.delete(0, strSalida.length());
                }

                strSql.delete(0, strSql.length());
            %>
        </div>

        <%
            strNU = null;
            strclUsr = null;
            strSql = null;
            strclCuenta = null;
            strClave = null;
            strDNI = null;
            strPlacas = null;
            strclGrupoCuenta = null;
        %>
        <!-- Alerta Process NRM -->
        <div id="process" class="alerta" style="z-index: 1000;">
            <!-- Modal content -->
            <div style="text-align: center; margin: auto;">
                <img src="../Imagenes/Loading.gif" style="position: static;">
                <p style="color: white; font-size: x-large;">Se esta procesando la visualizacion del vin...</p>
            </div>
        </div>
        <script src='v1/Ajax.js'></script> 
        <script src='../Operacion/NRM/js/ControlPanelNRM.js'></script> 
        <script src='../Operacion/NRM/js/AditionaEventsNRM.js'></script> 
        <script>

            window.resizeTo(1200, 500);

            document.all.clGrupoCuentaC.disabled = false;
            document.all.clCuentaC.disabled = false;
            document.all.NU.readOnly = false;
            document.all.Clave.readOnly = false;
            document.all.DNI.readOnly = false;
            document.all.Placas.readOnly = false;
            document.all.Correo.readOnly = false;

            function  fnBenefic(dir) {
                window.open(dir, 'newBEN', 'scrollbars=yes,status=yes,width=400,height=300');
            }

            function fnActualizaDatosNuestroUsr(dsNU, Clave, pclCuenta, pNomCuenta, Msk, MskUsr, DatosNUsr, ClaveBeneficiario, Correo) {
                top.opener.fnActualizaDatosNuestroUsr(dsNU, Clave, pclCuenta, pNomCuenta, Msk, MskUsr, DatosNUsr, ClaveBeneficiario, Correo);
                window.close();
            }
            
            function validarPreguntasRespuestasNRM(clVinTspPseudo){
                window.open('../Operacion/NRM/InfoPreAfiliadoNRM.jsp?clTspPseudoVin=' + clVinTspPseudo + '&validar=1','Validar Preguntas y Respuestas Secretas','resizable=no,scrollbars=no,status=yes,width=1100,height=450');
            }
            
            function fn_nrm_ShowVin(vinTspPseudo){
                if(document.getElementById(vinTspPseudo).innerHTML.length < 25){
                    document.getElementById(vinTspPseudo).innerHTML = vinTspPseudo;
                }else{
                    fn_nrm_ProcessDecrypt(vinTspPseudo);
                }
            }
            
            function fnActualizaDatosNuestroUsrNrm(dsNU, Clave, pclCuenta, pNomCuenta, Msk, MskUsr, DatosNUsr, ClaveBeneficiario, Email, Telefono){
                console.dir('Filtros');
                top.opener.fnActualizaDatosNuestroUsrNrm(dsNU, Clave, pclCuenta, pNomCuenta, Msk, MskUsr, DatosNUsr, ClaveBeneficiario, Email, Telefono);
                window.close();
            }
            
        </script>
    </body>
</html>