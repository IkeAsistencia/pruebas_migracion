<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Seguridad.SeguridadC,Utilerias.UtileriasBDF" errorPage="" %>
<html>
    <head><title>Asignación de </title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody" topmargin=150>
        <%-- <jsp:useBean id="beanInstanceName" scope="session" class="beanPackage.BeanClassName" /> --%>
        <%-- <jsp:getProperty name="beanInstanceName"  property="propertyName" /> --%>
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
        <script src='../Utilerias/Util.js' ></script>
        <script src='../Utilerias/UtilMask.js'></script>
        <!--script src='../Utilerias/jquery-1.4.2.min.js'</script-->  
        <%
        String StrclUsrApp="0";
        String StrclUsrAppSP="0"; //Usuario Soporte Tecnico
        String StrclAreaOperativa="0"; // AreaOperativa
        
        int iCont =0;
        
        if (session.getAttribute("clUsrApp")!= null) {
            StrclUsrApp = session.getAttribute("clUsrApp").toString();
        }
        
        if (session.getAttribute("clUsrAppSP")!= null) {
            StrclUsrAppSP = session.getAttribute("clUsrAppSP").toString();
        }
        
        if (request.getParameter("clAreaOperativa")!= null) {
            StrclAreaOperativa = request.getParameter("clAreaOperativa").toString();
        }
        if (StrclAreaOperativa.compareToIgnoreCase("")==0){
            StrclAreaOperativa = "0";
        }
                
        if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {%>
        Fuera de Horario 
        <% return;
        }
        
        MyUtil.InicializaParametrosC(1221,Integer.parseInt(StrclUsrApp));%>   
        
        <!--div style='position:absolute; z-index:303; left:30px; top:10px'>
            <b><font color="#423A9E"><b>EQUIPOS PARA RESPONSIVA MASIVA </b></b>
        </div> 
        
        <form method='get' action='ListaAsignacionMasivaSP.jsp'>
            <%=MyUtil.ObjComboC("Area Operativa ","clAreaOperativa","",true,true,30,70,"","Select * from cAreaoperativaSP","","",20,true,true)%>          
            <!--div style="visibility:hidden" id="check">
                <%=MyUtil.ObjChkBox("Todos","chkSeleccionar","0",false,true,370,120,"0","SI","NO","fnSelecc(this.checked)")%>    
            </div>
            
            
            <div class='VTable' style='position:absolute; z-index:25; left:30px; top:170px;'>
                <input class='cBtn' type='submit' value='Buscar...'></input>
            </div>
            <%=MyUtil.DoBlock("Criterios",30,30)%>
            <script>
                document.all.clAreaOperativaC.disabled= false;
                document.all.clAreaOperativaC.readOnly= false;          
                document.all.chkSeleccionarC.readOnly= false;
                document.all.chkSeleccionarC.disabled= false;            
            </script>
        </form>
        <input name='FechaMsk' id='FechaMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09'>
        <%  StringBuffer StrSql = new StringBuffer();
        StrSql.append("sp_ListPerifericosAsignamasiva ").append("''").append(",").append("''").append(",").append("''").append(",").append("''").append(", '").append(StrclUsrAppSP).append("', '").append(StrclAreaOperativa).append("'");
        // StrSql.append(",'" ).append(StrFechaAsignacionIni).append("','").append(StrFechaAsignacionFin).append("'");
        ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
        
        System.out.println("SP " +StrSql.toString());
        rs.next();
        
        if(rs.getString(1).equalsIgnoreCase("0")){
            System.out.println("Debe elegir un criterio de búsqueda");
        %>
        <div class='VTable' style='position:absolute; z-index:25; left:230px; top:230px;'>
            <p style="font-family:arial;color:#000066;font-size:20px;">Debe elegir un criterio de búsqueda</p>
        </div>
        <%
        return;
        }
        if(rs.getString(1).equalsIgnoreCase("1")){
        
        %>
        <div class='VTable' style='position:absolute; z-index:25; left:230px; top:230px;'>
            <p style="font-family:arial;color:#000066;font-size:20px;">La búsqueda no regresó Equipos</p>
        </div>
        <%
        return;
        }
        
        rs.beforeFirst();
        %>        
        
        
        
        <script>
            document.all.check.style.visibility='visible';
        </script>
        <div id="divi">
            <form target='WinSave' method='post' action='AsignacionMasivaSP.jsp'>
                <br><table><tr class='cssTitDet'><td>Seleccionado</td><td>Area Operativa</td><td>Asignado a</td><td>Equipo</td><td>Marca</td><td>No. de Serie</td><td>No.</td></tr>
                <%
                while(rs.next()) {
                %>
                <tr><td><input id='Perifericos' name='Perifericos' type='checkbox'></input></td>
                    <td><INPUT disabled='true' id='AreaOperativa' name='AreaOperativa' type='text' value='<%=rs.getString("Area Operativa")%>'></td>
                    <td><INPUT disabled='true' id='Asignado' name='Asignado' type='text' value='<%=rs.getString("Asignado a") %>'></td>
                    <td><INPUT disabled='true' id='Periferico' name='Periferico' type='text' value='<%=rs.getString("Periferico") %>'></td>
                    <td><INPUT disabled='true' id='Marca' name='Marca' type='text' value='<%=rs.getString("Marca") %>'></td>
                    <td><INPUT disabled='true' id='Serie' name='Serie' type='text' value='<%=rs.getString("No. de Serie")%>'></td>
                    <td><INPUT disabled='true' id='clPeriferico' name='clPeriferico' value='<%=rs.getString("clPeriferico") %>'></td>                                       
                </tr>
                <%       
                iCont=iCont+1;
                }; // fin while
                %>
                <textarea name='Resultados' id='Resultados' cols='80' rows='3' style="visibility:hidden"></textarea>
                <input type='hidden' name='Total' id='Total' value ='<%=iCont%>'></input><tr><td></tr></td>
                <tr><td></tr></td><tr><td><center><input type='submit' name='submit' value='Asignar' onclick='fnConcatena()'></input></center></td></tr>
            </form>
        </div>
        <%
        rs.close();
        rs = null;
        StrSql = null;
        StrclUsrApp = null;
        StrclAreaOperativa = null;
        StrclUsrAppSP = null;
        %>
        <script>
            document.all.Resultados.style.visibility='hidden';

            function fnSelecc(ActionSelect){
                // ActionSelect:   0: No seleccionar, 1:Seleccionar
                i=0;
                while (i<=document.all.Total.value-1){
                    document.all.Perifericos(i).checked=ActionSelect;
                    i+=1;
                }
            }

            function fnConcatena(){
                i=0;
                document.all.Resultados.value='';
                fnOpenWindow();
                  document.all.clPeriferico(0).checked=1;
                while (i<=document.all.Total.value-1){   
                          if(document.all.Total.value-1==0)
                              {
                              document.all.Resultados.value=document.all.clPeriferico.value;                            
                              }
                       if (document.all.Perifericos(i).checked){
                        
                            if (document.all.Resultados.value ==''){
                               document.all.Resultados.value = document.all.clPeriferico(i).value;
                              
                            }
                            else{
                                document.all.Resultados.value = document.all.Resultados.value + ',' + document.all.clPeriferico(i).value;
                            } 
                        } 
                        i++;
                }
            }
    
        </script>
        <SCRIPT>
 
            document.getElementById('divi').style.visibility='hidden';
            jQuery(window).load(function () {   
                alert("Página cargada");
                fnMuestra();
            }); 
        </SCRIPT>
        
        <script>
        function fnMuestra () {
            document.getElementById('divi').style.visibility='visible';
        }
        </script>
    </body>
</html>