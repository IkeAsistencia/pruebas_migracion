<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="com.ike.helpdeskSP.DAOInventarioSP,com.ike.helpdeskSP.InventarioSP,java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>

<html>
    <head>
        <title>INVENTARIO SOPORTE</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <link href='../StyleClasses/Calendario.css' rel='stylesheet' type='text/css'>
    </head>
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
        <script type="text/javascript" src='../Utilerias/Util.js' ></script>
        <script type="text/javascript" src='../Utilerias/UtilDireccion.js'></script>
        <script type="text/javascript" src='../Utilerias/UtilStore.js'></script>
        <script type="text/javascript" src='../Utilerias/UtilCalendario.js' ></script>
        <%
                    String StrclUsrApp = "0";
                    String StrclUsrAppSP = "0";
                    String StrclEstatus = "0";

                    if (session.getAttribute("clUsrApp") != null) {
                        StrclUsrApp = session.getAttribute("clUsrApp").toString();
                    }

                    if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {
        %>Fuera de Horario <%

                        StrclUsrApp = null;
                        return;
                    }

                    if (session.getAttribute("clUsrAppSP") != null) {
                        StrclUsrAppSP = session.getAttribute("clUsrAppSP").toString();
                    }

                    if (request.getParameter("clUsrAppSP") != null) {
                        StrclUsrAppSP = request.getParameter("clUsrAppSP").toString();
                    }

                    DAOInventarioSP daoInventarioSP = null;
                    InventarioSP ISP = null;

                    if (Integer.parseInt(StrclUsrAppSP) > 0) {

                        session.setAttribute("clUsrAppSP", StrclUsrAppSP);
                        daoInventarioSP = new DAOInventarioSP();
                        ISP = daoInventarioSP.getCalificacionSP(StrclUsrAppSP.toString());

                        StrclEstatus = ISP.getestatus(); //para validar si el usuario esta activo  y se puede asignar equipo
                    }

                    String StrclPaginaWeb = "1185";
                    session.setAttribute("clPaginaWebP", StrclPaginaWeb);
        %>
        <%//servlet generico
                    String Store = "";
                    Store = "st_GuardaUsuarioInventarioSP,st_ActualizaUsuarioInventarioSP";
                    session.setAttribute("sp_Stores", Store);

                    String Commit = "";
                    Commit = "clUsrAppSP";

                    session.setAttribute("Commit", Commit);
        %>
        <script type="text/javascript">fnOpenLinks()</script>

        <%MyUtil.InicializaParametrosC(1185, Integer.parseInt(StrclUsrApp));%>
        <%=MyUtil.doMenuAct("../servlet/com.ike.guarda.EjecutaSP", "", "fnsp_Guarda();")%>

        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="InventarioSP.jsp?"%>'>

        <input id="Secuencia" name="Secuencia" type="hidden" value="">
        <input id="SecuenciaG" name="SecuenciaG" type="hidden"  VALUE="clAreaOperativa,clPiso,Nombre,NoEmpleado,Extension,Correo,Estatus,clEmpresa">
        <input id="SecuenciaA" name="SecuenciaA" type="hidden"  VALUE="clUsrAppSP,clAreaOperativa,clPiso,Nombre,NoEmpleado,Extension,Correo,Estatus,clEmpresa">
        <INPUT id='clPaginaWeb' name='clPaginaWeb' type='HIDDEN' value='<%=StrclPaginaWeb%>'>
        <INPUT id='clUsrAppSP' name='clUsrAppSP' type='HIDDEN' value='<%=StrclUsrAppSP%>' >

        <%=MyUtil.ObjInput("Usuario", "Nombre", ISP != null ? ISP.getUsuario() : "", true, true, 20, 80, "", true, true, 50, "")%>
        <%=MyUtil.ObjInput("Numero de empleado", "NoEmpleado", ISP != null ? ISP.getNoEmpleado() : "", true, true, 340, 80, "", true, true, 10, "")%>
        <%=MyUtil.ObjComboC("Empresa", "clEmpresa", ISP != null ? ISP.getDsEmpresa() : "", true, true, 530, 120, "", "Select * from cEmpresaUsrSP ", "", "", 30, true, true)%>
        <%=MyUtil.ObjComboC("Area", "clAreaOperativa", ISP != null ? ISP.getdsAreaOperativa() : "", true, true, 20, 120, "", "select * from cAreaOperativaSP ", "", "", 30, true, true)%>
        <%=MyUtil.ObjComboC("PISO", "clPiso", ISP != null ? ISP.getdsPiso() : "", true, true, 340, 120, "", "select * from cPisoSP ", "", "", 10, true, true)%>
        <%=MyUtil.ObjInput("EXTENSION", "Extension", ISP != null ? ISP.getextension() : "", true, true, 20, 160, "", false, false, 10, "")%>
        <%=MyUtil.ObjInput("Correo", "Correo", ISP != null ? ISP.getcorreo() : "", true, true, 530, 80, "", false, false, 40, "validaCorreo();")%>
        <%=MyUtil.ObjChkBox("Activo", "Estatus", ISP != null ? ISP.getestatus() : "", true, true, 340, 160, "1", "SI", "NO", "")%>
        <%=MyUtil.DoBlock("USUARIO DE INVENTARIO", 40, 40)%>
        <%=MyUtil.GeneraScripts()%>

        <div  id="asigna" name="asigna" class='VTable' style='position:absolute; z-index:25; left:530px; top:210px;'>
            <INPUT ID="Asignar" name="Asignar" type='button' VALUE='Asignar Equipo...' onClick="location.href='../servlet/Utilerias.Lista?P=1212&Apartado=S'" class='cBtn'></div>
            <%
                        if (StrclEstatus.equalsIgnoreCase("1")) {%>
        <script type="text/javascript"> document.all.asigna.visibility="visible"; </script>
        <% } else {%>
        <script type="text/javascript"> document.all.asigna.style.visibility="hidden"; </script>
        <%  }%>

        <%
                    //Limpiar Variables
                    ISP = null;
                    daoInventarioSP = null;
                    StrclUsrApp = null;
                    StrclUsrAppSP = null;
                    StrclEstatus = null;

        %>
        <script>
            function fnBuscaUsrSP(){
                if (document.all.Action.value==1){
                    var pstrCadena = "../Utilerias/FiltroUsrSP.jsp?strSQL=sp_BuscaUsrSP ";
                    pstrCadena = pstrCadena + "&Usuario= " + document.all.Usuario.value;
                    window.open(pstrCadena,'newWin','scrollbars=yes,status=yes,width=700,height=500,top=200,left=50');
                }
            }

            function fnActualizaUsrSP(NombreSP,clUsrAppSP,Correo){
                if (document.all.Action.value ==1 || document.all.Action.value==2){
                    document.all.Usuario.value = NombreSP;
                    document.all.clUsrAppSP.value = clUsrAppSP;
                    document.all.Correo.value=Correo;
                }
            }

            function validaCorreo(){
                var Cadena
                var PosArroba
                var usuario
                var dominio
                if (document.all.Correo.value!=''){
                    if(document.all.Correo.value.indexOf('@', 0) == -1){
                        alert("La dirección de correo no es valida.");
                    } else {
                        PosArroba = document.all.Correo.value.lastIndexOf('@')
                        usuario=document.all.Correo.value.substring(0,PosArroba)
                        dominio=document.all.Correo.value.substring(PosArroba+1,Cadena)

                        if (usuario == '' || dominio==''){
                            alert("La dirección de correo no es valida.");
                        }
                        //Valida el nombre de usuario y verifica que no existan dos @
                        if(usuario.indexOf('@', 0) != -1){
                            alert("La dirección de correo no es valida.");
                        }
                        //valida el dominio
                        if(dominio.indexOf('.', 0) == -1 || dominio.indexOf('@', 0) != -1){
                            alert("La dirección de correo no es valida.");
                        }
                        //alert(usuario + "," + dominio)
                    }
                }
            }
        </script>
    </body>
</html>
