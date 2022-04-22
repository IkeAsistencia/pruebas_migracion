<%@page contentType="text/html; charset=iso-8859-1" import="Utilerias.UtileriasBDF,Seguridad.SeguridadC"%>
<html>
    <head><title></title></head>
    <link href="StyleClasses/Global.css" rel="stylesheet" type="text/css">

    <body topmargin="2" leftmargin="4" background="Imagenes/bgMenu.jpg" bgproperties="fixed">
        <table class="Table" width='100%' cellspacing="0" cellpadding="0">
            <tr ><td class="TTable" colspan="2" >Datos Generales del Usuario</td></tr>

            <%
                    String strclUsr = "0";
                    if (session.getAttribute("clUsrApp") != null) {
                        strclUsr = session.getAttribute("clUsrApp").toString();
                    }

                    if (SeguridadC.verificaHorarioC(Integer.parseInt(strclUsr)) != true) {
            %>Fuera de Horario<% return;
                    }

            %><tr><td class='FTable' colspan='2'><b>Usuario:</b>&nbsp<%=session.getAttribute("NombreUsuario").toString()%></td>
            <tr><td class='FTable' colspan='2'><b>Inicio:</b>&nbsp<%=session.getAttribute("FechaInicio").toString()%></td></tr>

            <input type='hidden' id='clUsrApp' name='clUsrApp' value='<%=session.getAttribute("clUsrApp").toString()%>'>
            <tr><td align="left"><input class='cBtn' type='button' value='Contraseña' onClick='fnCambiaPwd();'></td>
                <td align="right"><input class='cBtn' type='button' value='Salir Sistema' onClick='fnSalir();'></td></tr>
            <tr><td colspan="2" align="right"><input class='cBtn' type='button' value='Correo' onClick='fnCorreo();'></td></tr>
        </table>   
    </body>
</html>

<script>
    function fnSalir() {
        top.document.body.style.filter='gray';
        if (confirm('¿Estas seguro de finalizar tu sesión?')){
            top.location.href='FinSesion.jsp';
            return true;
        }else{
            top.document.body.style.filter='';
            return false;
        }
    }
    
    function fnCambiaPwd() {
        WSave=window.open('Seguridad/CambiaPwd.jsp?clUsrApp=' + document.all.clUsrApp.value,'WSave','resizable=yes,menubar=0,status=1,toolbar=0,height=270,width=370,screenX=1,screenY=1');
        if (WSave != null) {
            if (WSave.opener == null)
                WSave.opener = self;
        }		
        //WSave.opener.focus();
    }

   function fnCorreo(){
        
        strUsuario=document.getElementById("clUsrApp").value;
        
        if(strUsuario == '4330'){
                    WSave=window.open('IngresaCorreoBG.jsp?clUsrApp=' + document.all.clUsrApp.value,'WSave','resizable=yes,menubar=0,status=1,toolbar=0,height=270,width=370,screenX=1,screenY=1');
                         if (WSave != null) {
                            if (WSave.opener == null)
                             WSave.opener = self;
                          }	           
        }
        else{
        
        WSave=window.open('IngresaCorreo.jsp?clUsrApp=' + document.all.clUsrApp.value,'WSave','resizable=yes,menubar=0,status=1,toolbar=0,height=270,width=370,screenX=1,screenY=1');
        if (WSave != null) {
            if (WSave.opener == null)
                WSave.opener = self;
        }
    }
        
        
        
    }
</script>
