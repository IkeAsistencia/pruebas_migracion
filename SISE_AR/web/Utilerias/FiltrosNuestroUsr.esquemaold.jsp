<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<html> 
    <head>
        <title>Filtro Nuestro Usuario</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
        <script src='../Utilerias/Util.js' ></script>      
        <script src='../Utilerias/UtilMask.js'></script>
        <%
            String strNU = "";
            String strclUsr = "";
            StringBuffer strSql = new StringBuffer();
            String strclCuenta = "0";
            String strStrGpoCuenta = "";
            String strStrCuenta = "";
            String strClave = "";
            String strDNI = "";
            String strSerie = "";
            String strPlacas = "";
            String strChasis = "";
            String strCSNumber = "";
            String strTelMonit = "";
            String strFolio = "";
            String strExacto = "1";
            String strTarjeta = "";
            String strclGrupoCuenta = "0";
            String strBuscaGpoCta = "0";
            String strdsTipoBusqueda = "Exacta";
            String strBuscaGlobal = "0";

            ResultSet rs = null;
            boolean blnGrupo = false;

            int iX = 100;

            if (session.getAttribute("clUsrApp") != null) {
                strclUsr = session.getAttribute("clUsrApp").toString();
            }

            if (request.getParameter("NU") != null) {
                strNU = request.getParameter("NU").toString().trim();
            }

            if (request.getParameter("clCuenta") != null) {
                if ((request.getParameter("clCuenta").toString().compareToIgnoreCase("") != 0) && (request.getParameter("clCuenta").toString().compareToIgnoreCase("0") != 0)) {
                    strclCuenta = request.getParameter("clCuenta").toString().trim();
                    rs = UtileriasBDF.rsSQLNP("Select dsGrupoCuenta,Nombre from cCuenta C inner join cGrupoCuenta G on (C.clGrupoCuenta = G.clGrupoCuenta) where C.clCuenta = " + strclCuenta);
                    if (rs.next()) {
                        strStrGpoCuenta = rs.getString("dsGrupoCuenta");
                        strStrCuenta = rs.getString("Nombre");
                    } else {
                        strStrGpoCuenta = "";
                        strStrCuenta = "";
                    }
                    rs.close();
                    rs = null;
                } else {
                    blnGrupo = true;
                }
            } else {
                blnGrupo = true;
                if (request.getParameter("NomGpoCuenta") != null) {
                    strStrGpoCuenta = request.getParameter("NomGpoCuenta").toString().trim();
                }
            }

            if (request.getParameter("Clave") != null) {
                strClave = request.getParameter("Clave").toString().trim();
            }

            if (request.getParameter("DNI") != null) {
                strDNI = request.getParameter("DNI").toString().trim();
            }

            if (request.getParameter("Serie") != null) {
                strSerie = request.getParameter("Serie").toString().trim();
            }

            if (request.getParameter("Placas") != null) {
                strPlacas = request.getParameter("Placas").toString().trim();
            }

            if (request.getParameter("Chasis") != null) {
                strChasis = request.getParameter("Chasis").toString().trim();
            }

            if (request.getParameter("CSNumber") != null) {
                strCSNumber = request.getParameter("CSNumber").toString().trim();
            }

            if (request.getParameter("TelMonit") != null) {
                strTelMonit = request.getParameter("TelMonit").toString().trim();
            }

            if (request.getParameter("Tarjeta") != null) {
                strTarjeta = request.getParameter("Tarjeta").toString().trim();
            }

            if (request.getParameter("Folio") != null) {
                strFolio = request.getParameter("Folio").toString().trim();
            }

            if (request.getParameter("Exacto") != null) {
                strExacto = request.getParameter("Exacto").toString().trim();
            }

            if (request.getParameter("clGrupoCuenta") != null) {
                strclGrupoCuenta = request.getParameter("clGrupoCuenta").toString().trim();
            }

            if (request.getParameter("BuscaGpoCta") != null) {
                strBuscaGpoCta = request.getParameter("BuscaGpoCta").toString().trim();
            }

            if (request.getParameter("BuscaGlobal") != null) {
                strBuscaGlobal = request.getParameter("BuscaGlobal").toString().trim();
            }

            MyUtil.InicializaParametrosC(169, Integer.parseInt(strclUsr));

        %>
        <form id='Forma' name ='Forma' action='FiltrosNuestroUsr.jsp' method='get'>
            <input type='hidden' id='BuscaGpoCta' name='BuscaGpoCta' value='<%=strBuscaGpoCta%>'>
            <input type='hidden' id='strSQL' name='strSQL' value="sp_WebBuscaNuestroUsr ">
            <input type='hidden' id='BuscaGlobal' name='BuscaGlobal' value="<%=strBuscaGlobal%>">

            <!--input id='clCuenta' name='clCuenta' type='hidden' value='<%=strclCuenta%>'-->

            <%=MyUtil.ObjComboC("Tipo búsqueda", "Exacto", strdsTipoBusqueda, true, true, 25, iX, "", "select clTipoBusqueda, dsTipoBusqueda from cTipoBusqueda ", "fnExacto()", "", 50, false, false)%>

            <div id='Exactamente' class='VTable' style='position:absolute; z-index:11; left:210px; top:<%=iX%>px;'><p class='Rojo'>Los valores informados<br> deberan coincidir<br> exactamente con datos<br> de NU</p> </div>
            <div id='Empieza' class='VTable' style='position:absolute; z-index:11; left:210px; top:<%=iX%>px;'><p class='Amarillo'>Búsqueda por los primeros digitos.<br> Los valores informados no necesariamente deben<br> ser exactos a los datos de<br> NU. (La busqueda tarda mas)</p> </div>
            <div id='Termina' class='VTable' style='position:absolute; z-index:11; left:210px; top:<%=iX%>px;'><p class='Verde'>Búsqueda por los ultimos digitos.<br>Los valores informados no necesariamente deben<br> ser exactos a los datos de<br> NU.(La busqueda tarda mas)</p> </div>
            <div id='Contiene' class='VTable' style='position:absolute; z-index:11; left:210px; top:<%=iX%>px;'><p class='Verde'>Búsqueda por cualquier digito.<br>Los valores informados no deben<br> ser exactos a los datos de<br> NU. <br><br> ¡¡Atencion: La busqueda puede tardar varios minutos.!! </p> </div>
                    <% iX += 40;%>
                    <%=MyUtil.ObjComboC("Grupo Cuenta", "clGrupoCuenta", strStrGpoCuenta, true, true, 25, iX, "", "Select clGrupoCuenta, dsGrupoCuenta from cGrupoCuenta order by dsGrupoCuenta", "document.all.NomGpoCuenta.value=document.all.clGrupoCuentaC[document.all.clGrupoCuentaC.selectedIndex].text", "", 50, false, false)%>
                    <% iX += 40;%>
            <!--%=MyUtil.ObjInput("Cuenta", "Cuenta", strStrCuenta, true, true, 25, iX, "", false, false, 50)%-->
            <!--%=MyUtil.ObjComboC("Cuenta", "clCuenta", strStrGpoCuenta, true, true, 25, iX, "", "Select clCuenta, Nombre from cCuenta order by 2 asc", "", "", 50, false, false)%-->
            <%=MyUtil.ObjComboC("Cuenta", "clCuenta", strStrCuenta, true, true, 25, iX, "", "Select clCuenta, Nombre from cCuenta order by 2 asc", "", "", 50, false, false)%>
            
            <% iX += 40;%>
            <%=MyUtil.ObjInput("Nuestro Usuario (No aplica Busqueda Exacta)<br> <b>APLICA PARA BUSQUEDA GLOBAL</b>", "NU", strNU, true, true, 25, iX, "", false, false, 50)%>
            <INPUT id='NomGpoCuenta' name='NomGpoCuenta' type='hidden' value='<%=strStrGpoCuenta%>'>
                   <% if (strclCuenta.equals("1302")) { %>
                   <% iX += 40;%>
                   <%=MyUtil.ObjInput("Tarjeta", "Tarjeta", strTarjeta, true, true, 25, iX, "", false, false, 50)%>
                    <script>
                        document.all.Tarjeta.readOnly = false;
                    </script>
            <% } else { %>
            <input type='hidden' name='Tarjeta' id='Tarjeta' value=''>
            <% } %>
            <% iX += 50;%>
            <%=MyUtil.ObjInput("Clave", "Clave", strClave, true, true, 25, iX, "", false, false, 50)%>
            <% if (!strclCuenta.equals("1303")) {%>
            <% iX += 40;%>
            <%=MyUtil.ObjInput("DNI", "DNI", strDNI, true, true, 25, iX, "", false, false, 50)%>
            <% } else { %>
            <input type='hidden' name='DNI' id='DNI' value=''>
            <% } %>
            <% iX += 40;%>
            <%=MyUtil.ObjInput("Serie", "Serie", strSerie, true, true, 25, iX, "", false, false, 50)%>          
            <% iX += 40;%>
            <%=MyUtil.ObjInput("Patente (No aplica Busqueda Exacta)<br> <b>APLICA PARA BUSQUEDA GLOBAL</b>", "Placas", strPlacas, true, true, 25, iX, "", false, false, 50)%>
            <% iX += 40;%>
            <%=MyUtil.ObjInput("Chasis", "Chasis", strChasis, true, true, 25, iX, "", false, false, 50)%>
            <%

                strSql.delete(0, strSql.length());
                strSql.append("select CampoBusqueda from campobusqxcuenta where clcuenta =").append(strclCuenta).append(" order by Orden asc");
                ResultSet rs2 = UtileriasBDF.rsSQLNP(strSql.toString());
                strSql.delete(0, strSql.length());

                while (rs2.next()) {

                    String strCampo = rs2.getString("CampoBusqueda");
                    iX += 40;
                    if (strCampo.equalsIgnoreCase("CSNumber")) {
            %>
            <%=MyUtil.ObjInput(strCampo, strCampo, strCSNumber, true, true, 25, iX, "", false, false, 50, "if(this.readOnly==false){fnValMask(this,document.all.CSNumberMsk.value,this.name);}")%>
            <script> document.all.<%=strCampo%>.readOnly = false</script>
            <% } else {%>
            <%=MyUtil.ObjInput(strCampo, strCampo, "", true, true, 25, iX, "", false, false, 50)%>
            <script> document.all.<%=strCampo%>.readOnly = false</script>
            <% } %>
            <% }%>

            <div class='VTable' style='position:absolute; z-index:300; left:50px; top:40px;'>
                <input type='button' value='BUSCAR...' onClick='document.all.BuscaGlobal.value = 0;
                                document.all.BuscaGpoCta.value = 0;
                                document.all.Forma.submit();
                                this.disabled = true' class='cBtn'>
                <input type='button' value='POR GRUPO DE CUENTA...' onClick='document.all.BuscaGlobal.value = 0;
                        document.all.BuscaGpoCta.value = 1;
                        document.all.Forma.submit();
                        this.disabled = true' class='cBtn'><br>
                <input type='button' value='GLOBAL (TARDA MAS)...' onClick='document.all.BuscaGlobal.value = 1;
                        document.all.Forma.submit();
                        this.disabled = true' class='cBtn'>
            </div>
        </form>

        <%=MyUtil.GeneraScripts()%>
        <br><br><br><br><br>
        <div class='VTable' style='position:absolute; z-index:301; left:350px; top:40px;'>
            <input name='CSNumberMsk' id='CSNumberMsk' type='hidden' value='VN09VN09VN09VN09F---VN09VN09VN09VN09'>
            <%
                strSql.delete(0, strSql.length());

                if (strBuscaGpoCta.equalsIgnoreCase("1")) {
                    strclCuenta = "0";
                }

                if (request.getParameter("strSQL") != null) {
                    strSql.append(request.getParameter("strSQL").toString().trim());
                    strSql.append(" '").append(strclGrupoCuenta).append("','").append(strclCuenta).append("','");
                    strSql.append(strNU).append("','").append(strClave).append("','").append(strDNI).append("','").append(strSerie).append("','");
                    strSql.append(strPlacas).append("','").append(strChasis);
                    strSql.append("','").append(strCSNumber).append("','").append(strTelMonit);
                    strSql.append("','").append(strTarjeta).append("','").append(strFolio);
                    strSql.append("','").append(strExacto).append("','").append(strBuscaGlobal).append("'");
                }

                if (strSql.length() > 0) {
                    StringBuffer strSalida = new StringBuffer();
                    System.out.println("Pagina: FiltroNU " + strSql);
                    UtileriasBDF.rsTableNP(strSql.toString(), strSalida);
            %>
            <%=strSalida.toString()%>
            <%
                    strSalida.delete(0, strSalida.length());
                }
                strSql.delete(0, strSql.length());
            %>
        </div>
        <% if (blnGrupo == true) { %>
        <script>
            document.all.clGrupoCuentaC.disabled = false;
            document.all.clGrupoCuentaC.readOnly = false;
        </script>
        <% }
            strSql.delete(0, strSql.length());
            try {
            } catch (Exception ee) {
            }
            strSql.delete(0, strSql.length());
            try {
                if (rs2 != null) {
                    rs2.close();
                    rs2 = null;
                }
            } catch (Exception ee) {
                ee.printStackTrace();
            }
        %>

        <%
            strNU = null;
            strclUsr = null;
            strSql = null;
            strclCuenta = null;
            strStrGpoCuenta = null;
            strStrCuenta = null;
            strClave = null;
            strDNI = null;
            strSerie = null;
            strPlacas = null;
            strChasis = null;
            strCSNumber = null;
            strTelMonit = null;
            strFolio = null;
            strExacto = null;
            strTarjeta = null;
            strclGrupoCuenta = null;
            strBuscaGpoCta = null;
            strdsTipoBusqueda = null;
            strBuscaGlobal = null;
        %>

        <script>
            document.all.ExactoC.disabled = false;
            document.all.NU.readOnly = false;
            window.resizeTo(1200, 500);
            document.all.Clave.readOnly = false;
            document.all.DNI.readOnly = false;
            document.all.Serie.readOnly = false;
            document.all.Placas.readOnly = false;
            document.all.Chasis.readOnly = false;
            document.all.Empieza.style.visibility = 'hidden';
            document.all.Termina.style.visibility = 'hidden';
            document.all.Contiene.style.visibility = 'hidden';
            document.all.clCuentaC.disabled = false;

            function fnExacto() {
                if (document.all.ExactoC.value == 1) {
                    document.all.Exactamente.style.visibility = 'visible';
                    document.all.Empieza.style.visibility = 'hidden';
                    document.all.Termina.style.visibility = 'hidden';
                    document.all.Contiene.style.visibility = 'hidden';
                }

                if (document.all.ExactoC.value == 2) {
                    document.all.Exactamente.style.visibility = 'hidden';
                    document.all.Empieza.style.visibility = 'visible';
                    document.all.Termina.style.visibility = 'hidden';
                    document.all.Contiene.style.visibility = 'hidden';
                    strdsTipoBusqueda = "Empieza con"
                }

                if (document.all.ExactoC.value == 3) {
                    document.all.Exactamente.style.visibility = 'hidden';
                    document.all.Empieza.style.visibility = 'hidden';
                    document.all.Termina.style.visibility = 'visible';
                    document.all.Contiene.style.visibility = 'hidden';
                    strdsTipoBusqueda = "Termina con"
                }
                if (document.all.ExactoC.value == 4) {
                    document.all.Exactamente.style.visibility = 'hidden';
                    document.all.Empieza.style.visibility = 'hidden';
                    document.all.Termina.style.visibility = 'hidden';
                    document.all.Contiene.style.visibility = 'visible';
                    strdsTipoBusqueda = "Contiene"
                }
            }

            function  fnBenefic(dir) {
                window.open(dir, 'newBEN', 'scrollbars=yes,status=yes,width=400,height=300');
            }

            function fnActualizaDatosNuestroUsr(dsNU, Clave, pclCuenta, pNomCuenta, Msk, MskUsr, DatosNUsr, ClaveBeneficiario, Correo) {
                top.opener.fnActualizaDatosNuestroUsr(dsNU, Clave, pclCuenta, pNomCuenta, Msk, MskUsr, DatosNUsr, ClaveBeneficiario, Correo);
                window.close();
            }
        </script>
    </body>
</html>