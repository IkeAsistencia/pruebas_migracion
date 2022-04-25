<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
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
            String strclUsr = "0";
            if (session.getAttribute("clUsrApp") != null) {
                strclUsr = session.getAttribute("clUsrApp").toString();     }    
            if (SeguridadC.verificaHorarioC((Integer.parseInt(strclUsr))) != true) { 
                %>Fuera de Horario<%
                strclUsr = null;
                return;
            } 
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
            String strStrCuenta = "";
            if (request.getParameter("clGrupoCuenta") != null) {
                strclGrupoCuenta = request.getParameter("clGrupoCuenta").toString().trim();            }
            if (request.getParameter("clCuenta") != null) {
                strclCuenta = request.getParameter("clCuenta").toString().trim();            }
            if (request.getParameter("NU") != null) {
                strNU = request.getParameter("NU").toString().trim();            }
            if (request.getParameter("Clave") != null) {
                strClave = request.getParameter("Clave").toString().trim();            }
            if (request.getParameter("DNI") != null) {
                strDNI = request.getParameter("DNI").toString().trim();            }
            if (request.getParameter("Placas") != null) {
                strPlacas = request.getParameter("Placas").toString().trim();            }            
            if (request.getParameter("Correo") != null) {
                strCorreo = request.getParameter("Correo").toString().trim();            }
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
            MyUtil.InicializaParametrosC(169, Integer.parseInt(strclUsr)); %>
            <form id='Forma' name ='Forma' action='FiltrosNuestroUsrDE.jsp' method='get'>
                <input id='strSQL' name='strSQL' type='hidden' value="sp_WebBuscaNuestroUsrnvoDE 4, "/>
                <input id='NomGpoCuenta' name='NomGpoCuenta' type='hidden' value='<%=strStrGpoCuenta%>'/>
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
                    <input type='button' value='BUSCAR...' onClick='document.all.Forma.submit();this.disabled = true' class='cBtn'/>
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
                <%strSql.delete(0, strSql.length());
                if (request.getParameter("strSQL") != null) {
                    strSql.append(request.getParameter("strSQL").toString().trim());
                    strSql.append(" '").append(strclGrupoCuenta).append("','").append(strclCuenta).append("','");
                    strSql.append(strNU).append("','").append(strClave).append("','").append(strDNI).append("','").append(strPlacas).append("'");
                    }
                if (strSql.length() > 0) {
                    StringBuffer strSalida = new StringBuffer();
                    UtileriasBDF.rsTableNP(strSql.toString(), strSalida);
                    %><%=strSalida.toString()%><%
                    strSalida.delete(0, strSalida.length());
                    }
                strSql.delete(0, strSql.length()); %>
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
        <script>
//------------------------------------------------------------------------------            
            window.resizeTo(1200, 500);
            document.all.clGrupoCuentaC.disabled = false;
            document.all.clCuentaC.disabled = false;
            document.all.NU.readOnly = false;
            document.all.Clave.readOnly = false;
            document.all.DNI.readOnly = false;
            document.all.Placas.readOnly = false;
            document.all.Correo.readOnly = false;
//------------------------------------------------------------------------------            
            function  fnBenefic(dir) {
                window.open(dir, 'newBEN', 'scrollbars=yes,status=yes,width=400,height=300');
            }
//------------------------------------------------------------------------------            
            function fnActualizaDatosNuestroUsrDE(dsNU, Clave, pclCuenta, pNomCuenta, Compania, DatosLUP,Msk, MskUsr, DatosNUsr, ClaveBeneficiario,VIP,DNI,Placas, Correo) {
                top.opener.fnActualizaDatosNuestroUsrDE(dsNU, Clave, pclCuenta, pNomCuenta, Compania, DatosLUP,Msk, MskUsr, DatosNUsr, ClaveBeneficiario,VIP,DNI,Placas, Correo);
                window.close();
            }
//------------------------------------------------------------------------------            
        </script>
    </body>
</html>