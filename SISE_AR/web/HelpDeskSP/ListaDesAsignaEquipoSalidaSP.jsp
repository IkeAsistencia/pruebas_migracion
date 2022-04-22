<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%@ page import="java.sql.ResultSet,Seguridad.SeguridadC,Utilerias.UtileriasBDF" errorPage="" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Desasignación Equipo de Salida</title>  
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody" topmargin=150>      
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
        <script src='../Utilerias/Util.js' ></script>
        <script src='../Utilerias/UtilMask.js'></script>
        <!--script src='../Utilerias/jquery-1.4.2.min.js'></script-->  
        <%
            int iCont = 0;
            ResultSet rs = null;
            String StrclUsrApp = "0";
            String StrclFolio = "0";
            String StrclPaginaWeb = "0";

            if (session.getAttribute("clUsrApp") != null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();
            }

            if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {%>
        Fuera de Horario 
        <%
                StrclUsrApp = null;
                StrclFolio = null;
                iCont = 0;
                StrclPaginaWeb = null;
                return;
            }

            if (session.getAttribute("clEquipoSalidaSP") != null) {
                StrclFolio = session.getAttribute("clEquipoSalidaSP").toString();
            }

            rs = UtileriasBDF.rsSQLNP("st_GetEquipoxFolioSalidaDes  '" + StrclFolio + "'");

        %>

        <div style='position:absolute; z-index:303; left:30px; top:10px'>
            <b><font color="#423A9E"><b>EQUIPOS X HOJA DE SALIDA </b></b>
        </div> 

        <%    StrclPaginaWeb = "1355";
    session.setAttribute("clPaginaWebP", StrclPaginaWeb); %>
        <%MyUtil.InicializaParametrosC(1355, Integer.parseInt(StrclUsrApp));%>
        <script>fnOpenLinks()</script>

        <%=MyUtil.ObjInput("Folio", "clFolio", StrclFolio, false, false, 30, 70, "", false, false, 25)%>
        <%=MyUtil.DoBlock("Folio Equipo de Salida", 150, 15)%> 
        <%=MyUtil.GeneraScripts()%> 

        <div style="visibility:hidden" id="check">
            <%=MyUtil.ObjChkBox("Seleccionar Todos", "chkSeleccionar", "0", false, true, 250, 70, "0", "SI", "NO", "fnSelecc(this.checked)")%>    
        </div>     
        <script>

            document.all.chkSeleccionarC.readOnly = false;
            document.all.chkSeleccionarC.disabled = false;

        </script>

        <div id="divi" style='position:absolute; z-index:25; left:20px; top:120px;'>
            <form target='WinSave' method='post' action='DesAsignaEquipoSalidaSP.jsp'>
                <table   id='ObjTable' class='Table' border='0' cellpadding='0' ><tr class = 'TTable'><td >Seleccionado</td><td>Periferico</td><td>Marca/Modelo</td><td>No. Serie</td></tr>
                    <%
                        while (rs.next()) {
                    %>
                    <script>
                        document.all.check.style.visibility = 'visible';
                    </script>
                    <tr class='R1Table'>
                        <td><input id='Equipos' name='Equipos' type='checkbox'></input></td>
                        <td ><font size="1"><%=rs.getString("Periferico")%></td></font>                                                            
                        <td ><font size="1"><%=rs.getString("Marca")%></td></font> 
                        <td ><font size="1"><%=rs.getString("Serie")%></td></font>                     
                        <td><INPUT TYPE="hidden" id='clPeriferico' name='clPeriferico' value='<%=rs.getString(1)%>'></td>          
                    </tr>
                    <%
                            iCont = iCont + 1;
                        }; // fin while
                    %>
                    <textarea name='Resultados' id='Resultados' cols='80' rows='3' style="visibility:hidden"></textarea>
                    <input type='hidden' name='Total' id='Total' value ='<%=iCont%>'></input><tr><td></tr></td>
                    <tr><td></tr></td><tr><td><center><input type='submit' name='submit' value='Desasignar' onclick='fnConcatena()'></input></center></td></tr>
            </form>
        </div>

        <%
        //Limpia Variables
            StrclUsrApp = null;
            StrclFolio = null;
            iCont = 0;
            StrclPaginaWeb = null;
            rs.close();
            rs = null;
        %>
        <script>

            function fnSelecc(ActionSelect) {
                // ActionSelect:   0: No seleccionar, 1:Seleccionar
                i = 0;
                while (i <= document.all.Total.value - 1) {
                    document.all.Equipos(i).checked = ActionSelect;
                    i += 1;
                }
            }

            function fnConcatena() {
                i = 0;
                document.all.Resultados.value = '';
                fnOpenWindow();
                while (i <= document.all.Total.value - 1) {
                    if (document.all.Total.value - 1 == 0)
                    {
                        document.all.Resultados.value = document.all.clPeriferico.value;
                    }

                    if (document.all.Equipos(i).checked) {
                        if (document.all.Resultados.value == '') {
                            document.all.Resultados.value = document.all.clPeriferico(i).value;
                        }
                        else {
                            document.all.Resultados.value = document.all.Resultados.value + ',' + document.all.clPeriferico(i).value;
                        }
                    }
                    i++;
                }
            }


            document.getElementById('divi').style.visibility = 'hidden';
            jQuery(window).load(function () {
                fnMuestra();
            });


            function fnMuestra() {
                document.getElementById('divi').style.visibility = 'visible';
            }
        </script>    
    </body>
</html>
