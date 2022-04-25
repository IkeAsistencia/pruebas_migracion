<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="com.ike.helpdesk.DAOHelpdesk,com.ike.helpdesk.HDSolicitud,java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head>
        <title>Registro de Copia</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj" /> 
        <script src='../Utilerias/Util.js' ></script>
        <script src='../Utilerias/UtilMask.js'></script>
        
        <%
        
        //DECLARACION DE VARIABLES
        
        String strNombreBusca = "";
        String strNombreCC = "";
        String strclUsrAppCC = "0";
        String strclGrupo = "0";
        String strclUsrApp = "0";
        String strclSolicitud = "0";
        
        //Recolección de valores de Session o Request
        
        if (request.getParameter("NombreBusca")!=null) {
            strNombreBusca = request.getParameter("NombreBusca").toString();
        }
        
        if (request.getParameter("clGrupo")!=null) {
            strclGrupo = request.getParameter("clGrupo").toString();
        }
        if (request.getParameter("NombreCC")!=null) {
            strNombreCC = request.getParameter("NombreCC").toString();
        }
        
        if (request.getParameter("clUsrAppCC")!=null) {
            strclUsrAppCC = request.getParameter("clUsrAppCC").toString();
        }
        
        if (session.getAttribute("clUsrApp")!=null) {
            strclUsrApp = session.getAttribute("clUsrApp").toString();
        }
        
        
        if (SeguridadC.verificaHorarioC((Integer.parseInt(strclUsrApp))) != true) {
        %>  Fuera de Horario <%
        return;
        }
        
        if (session.getAttribute("clSolicitud")!=null) {
            strclSolicitud = session.getAttribute("clSolicitud").toString();
        }
        
        String StrclPaginaWeb = "605";
        session.setAttribute("clPaginaWebP",StrclPaginaWeb);
        MyUtil.InicializaParametrosC(605,Integer.parseInt(strclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
        
        %>
        <script>fnOpenLinks()</script>
        <form id='Buscar' name ='Buscar' action='RegistraCopia.jsp' method='get'>
            <%=MyUtil.ObjComboC("Grupo de búsqueda","clGrupo",strclGrupo,true,true,20,20,"","select clHDGpoUsr,dsHDGpoUsr from cHDGpoUsr order by dsHDGpoUsr","","",50,true,false)%>
            <%=MyUtil.ObjInput("Nombre usuario Busca","NombreBusca",strNombreBusca,true,true,20,60,"",true,true,60,"")%>
            <div class='VTable' style='position:absolute; z-index:40; left:30px; top:100px;'>
                <P align='left'><input type='button' value='BUSCAR...' onClick='document.all.Buscar.submit()' class='cBtn'></input></p>
            </div>
        </form>
        <script>
         document.all.NombreBusca.readOnly=false;
         document.all.clGrupoC.disabled=false;

        </script>
        <%
        
        StringBuffer strSql= new StringBuffer();
        int iCont =0;    
        
        %>
        <form method='post' action='AsignarCC.jsp'>    
        
        <div style='position:absolute; z-index:303; left:30px; top:150px'>
            <input type='reset' value='Limpiar' onclick=''></input>
            <input type='submit' value='Asignar' onclick='fnConcatena()'></input>
        </div>
        
        <textarea name='UsuariosSeleccionados' id='UsuariosSeleccionados' cols='80' rows='3' ></textarea>
        <input size=10 id='clSolicitud' name='clSolicitud' type='hidden' value='<%=strclSolicitud%>'>
        <div style='position:absolute; z-index:304; left:30px; top:150px'><br><br><br>
            <table><tr><td class='cssTitDet' colspan=2>Usuarios:</td></tr><tr class='TTable'><td>Seleccionado</td><td class='TTable'>Usuario</td></tr>
                
                <%
                ResultSet rs = null;
                if (strNombreBusca.compareToIgnoreCase("")!=0 || strclUsrApp.compareToIgnoreCase("")!=0) {
                    strSql.delete(0,strSql.length());
                    strSql.append("sp_HDFiltroBuscaNombre ");
                    strSql.append("'").append(strclUsrApp).append("','").append(strclGrupo).append("','").append(strNombreBusca).append("','").append(strclSolicitud).append("'");
                    
                    rs = UtileriasBDF.rsSQLNP(strSql.toString());
                    strSql.delete(0,strSql.length());
                    
                    while(rs.next()) {
                %>        
                <tr><td><input id='Usuarios' name='Usuarios' type='checkbox'></input></td>
                    <td><INPUT size=60 disabled='true' id='Nombre' name='Nombre' type='text' value='<%=rs.getString("Nombre")%>'></td>
                    <td><INPUT  disabled='true' id='clUsrApp' name='clUsrApp' type='hidden' value='<%=rs.getString("clUsrApp")%>'></td>
                </tr>
                <%        iCont=iCont+1;
                    }
                    
                } %>
                <input type='hidden' name='Total' id='Total' value ='<%=iCont%>'></input>
            </table>
        </div>
        <%
        
        strNombreBusca = null;
        strNombreCC = null;
        strclUsrAppCC = null;
        strclGrupo = null;
        strclUsrApp = null;
        strclSolicitud = null;
        StrclPaginaWeb=null;
        
        strSql=null;
        
        if(rs!=null){
            rs.close();
            rs=null;
        } 
        %>
        <script>
    document.all.UsuariosSeleccionados.style.visibility='hidden';
    
    function fnConcatena(){
        i=0;
        document.all.UsuariosSeleccionados.value='';        
        if (document.all.Total.value>1){
            while (i < document.all.Total.value){
                        //document.all.Usuarios(i).checked;
                   if (document.all.Usuarios(i).checked){

                        if (document.all.UsuariosSeleccionados.value==''){
                            document.all.UsuariosSeleccionados.value = document.all.clUsrApp(i).value;
                        }
                        else{
                            document.all.UsuariosSeleccionados.value = document.all.UsuariosSeleccionados.value + ',' + document.all.clUsrApp(i).value;
                        } 
                    } 
                    i++;
            } 
        }else{
               if (document.all.Usuarios.checked){

                    if (document.all.UsuariosSeleccionados.value==''){
                        document.all.UsuariosSeleccionados.value = document.all.clUsrApp.value;
                    }
                    else{
                        document.all.UsuariosSeleccionados.value = document.all.UsuariosSeleccionados.value + ',' + document.all.clUsrApp.value;
                    } 
                } 
        }
    }

        </script>
    </body>
</html>