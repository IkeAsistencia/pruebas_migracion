<%-- 
    Document   : UsuarioSP
    Created on : 16/07/2009, 03:48:55 PM
    Author     : rfernandez
--%>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%@ page  import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC,javax.servlet.http.HttpSession,com.ike.helpdeskSP.DAOUsuarioSP,com.ike.helpdeskSP.UsuarioSP;" %>

<html>
    <head>
        <title>UsuarioSP</title>
    </head>
    <body class="cssBody" onload="">
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj"/>
        <script src='../Utilerias/UtilStore.js'></script>
        <script src='../Utilerias/Util.js'></script>
        
        
        <%
        String strclUsr = "0";
        String strclUsrAppSP ="0";
        
        if (session.getAttribute("clUsrApp")!= null) {
            strclUsr = session.getAttribute("clUsrApp").toString();
        }
        
        if (SeguridadC.verificaHorarioC(Integer.parseInt(strclUsr)) != true) {%>Fuera de Horario<%
        strclUsr=null;
        return;}
        
        if (request.getParameter("clUsrAppSP")!=null){
            strclUsrAppSP=request.getParameter("clUsrAppSP").toString();
        }
        
        DAOUsuarioSP daoUsuarioSP = null;
        UsuarioSP USP = null;
        
        daoUsuarioSP = new DAOUsuarioSP();
        USP = daoUsuarioSP.getUsuarioSP(strclUsrAppSP.toString());
        
        String StrclPaginaWeb = "1017";
        session.setAttribute("clPaginaWebP",StrclPaginaWeb);
        %>
        
        
        
        <%MyUtil.InicializaParametrosC(1017,Integer.parseInt(strclUsr));%>
        <%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion","")%>
        
        <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="UsuarioSP.jsp?'>"%>
        <%  int iY = 40; %>
        
        <input id="Secuencia" name="Secuencia" type="hidden" value="">
        <input id="SecuenciaG" name="SecuenciaG" type="hidden"  VALUE="Nombre,Correo">
        <input id="SecuenciaA" name="SecuenciaA" type="hidden">
        
        <INPUT id='clUsrAppSP' name='clUsrAppSP' type='HIDDEN' value='<%=USP != null ? USP.getclUsrAppSP(): "0"%>'>
        
        <%=MyUtil.ObjInput("Nombre","Nombre",USP != null ? USP.getNombre(): "",true,true,30,80,"",true,false,45)%>
        <%=MyUtil.ObjInput("Correo","Correo",USP != null ? USP.getCorreo(): "",true,true,300,80,"",false,false,40,"validaCorreo();")%>
        
        <%=MyUtil.DoBlock("Nuevo Usuario Help Desk",40,30)%>
        <%=MyUtil.GeneraScripts()%>
        
        
        <%
        if (USP!=null){
        %><script>

                top.opener.fnLlenaDespuesdeGuardar(document.all.clUsrAppSP.value, document.all.Nombre.value, document.all.Correo.value);
                window.close();
        </script><%
        }
        %>
    </body>
    
    <%
    StrclPaginaWeb=null;
    strclUsr=null;
    strclUsrAppSP=null;
    
    daoUsuarioSP=null;
    USP=null;
    %>
    
    <script>

    function validaCorreo(){
            var Cadena
            var PosArroba
            var usuario
            var dominio
            if (document.all.Correo.value!='')
            {
                if(document.all.Correo.value.indexOf('@', 0) == -1)
                {
                    alert("La dirección de correo no es valida.");
                }
                else
                {
                    PosArroba = document.all.Correo.value.lastIndexOf('@')
                    usuario=document.all.Correo.value.substring(0,PosArroba)
                    dominio=document.all.Correo.value.substring(PosArroba+1,Cadena)

                    if (usuario == '' || dominio=='')
                    {
                        alert("La dirección de correo no es valida.");
                    }
                    //Valida el nombre de usuario y verifica que no existan dos @
                    if(usuario.indexOf('@', 0) != -1)
                    {
                        alert("La dirección de correo no es valida.");
                    }
                    //valida el dominio
                    if(dominio.indexOf('.', 0) == -1 || dominio.indexOf('@', 0) != -1)
                    {
                        alert("La dirección de correo no es valida.");
                    }
                    //alert(usuario + "," + dominio)
                }
            }
        }
    </script>
</html>
