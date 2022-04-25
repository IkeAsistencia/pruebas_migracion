<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Seguridad.SeguridadC,Utilerias.UtileriasBDF" errorPage="" %>
<html>
    <head><title>Desasignar Expedientes de Supervisión</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody" topmargin=150>
        <%-- <jsp:useBean id="beanInstanceName" scope="session" class="beanPackage.BeanClassName" /> --%>
        <%-- <jsp:getProperty name="beanInstanceName"  property="propertyName" /> --%>
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
        <script src='../Utilerias/Util.js' ></script>
        <script src='../Utilerias/UtilMask.js'></script>
        <script type="text/javascript" src="http://ajax.microsoft.com/ajax/jquery/jquery-1.4.2.min.js"></script>  
        <%
        String StrclUsrApp="0";
        String StrclUsrAppAs="0"; // Usuario asignado
        String StrExpedElegidos="";
        String StrclAsistencia="0";
        String StrFechaAsignacionIni="";
        String StrFechaAsignacionFin="";
        String StrclPaginaWeb="6119";
        
        int iCont =0;
        
        if (session.getAttribute("clUsrApp")!= null) {
            StrclUsrApp = session.getAttribute("clUsrApp").toString();
        }
        
        if (request.getParameter("clUsrAppAs")!= null) {
            StrclUsrAppAs = request.getParameter("clUsrAppAs").toString();
        }
        if (StrclUsrAppAs.compareToIgnoreCase("")==0){
            StrclUsrAppAs = "0";
        }
        
        if (request.getParameter("clAsistenciaF")!= null) {
            StrclAsistencia = request.getParameter("clAsistenciaF").toString();
        }
        if (StrclAsistencia.compareToIgnoreCase("")==0){
            StrclAsistencia = "0";
        }
        
        if (request.getParameter("FechaAsignacionIni")!= null) {
            StrFechaAsignacionIni = request.getParameter("FechaAsignacionIni").toString();
        }
        
        if (request.getParameter("FechaAsignacionFin")!= null) {
            StrFechaAsignacionFin = request.getParameter("FechaAsignacionFin").toString();
        }
        
        if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {%>
        Fuera de Horario 
        <% return;
        }
        
        MyUtil.InicializaParametrosC(6119,Integer.parseInt(StrclUsrApp));%>   
        
        <div style='position:absolute; z-index:303; left:30px; top:10px'>
            <b><font face="arial" SIZE=2 COLOR=#423A9E><b >DESASIGNACIÓN DE ASISTENCIAS CONCIERGE</b></font></b>
        </div> 
        
        <form method='get' action='DesasignarAsist.jsp'>
            <%=MyUtil.ObjComboC("Supervisor Asignado","clUsrAppAs","",true,true,30,70,"","Select clUsrApp, Nombre from cUsrApp where Activo = 1 and clPerfilOperativo = 5 order by Nombre","","",20,true,true)%>
            <%=MyUtil.ObjInput("No. Asistencia","clAsistenciaF","",true,true,370,70,"",false,false,15)%>
            <%=MyUtil.ObjInput("Fecha Asignación Inicial<BR>AAAA/MM/DD HH:MM","FechaAsignacionIni","",true,false,30,110,"",true,true,22,"if(this.readOnly==false){fnValMask(this,FechaMsk.value,this.name)}")%>
            <%=MyUtil.ObjInput("Fecha Asignación Final<BR>AAAA/MM/DD HH:MM","FechaAsignacionFin","",true,false,200,110,"",true,true,22,"if(this.readOnly==false){fnValMask(this,FechaMsk.value,this.name)}")%>
            <div style="visibility:hidden" id="check">
                <%=MyUtil.ObjChkBox("Todos","chkSeleccionar","0",false,true,370,120,"0","SI","NO","fnSelecc(this.checked)")%>    
            </div>
            
            
            <div class='VTable' style='position:absolute; z-index:25; left:30px; top:170px;'>
                <input class='cBtn' type='submit' value='Buscar...'></input>
            </div>
            <%=MyUtil.DoBlock("Criterios",30,30)%>
            <script>
                document.all.clUsrAppAsC.disabled= false;
                document.all.clUsrAppAsC.readOnly= false;
                document.all.clAsistenciaF.readOnly= false;
                document.all.clAsistenciaF.disabled= false;
                document.all.chkSeleccionarC.readOnly= false;
                document.all.chkSeleccionarC.disabled= false;
                document.all.FechaAsignacionIni.readOnly= false;
                document.all.FechaAsignacionIni.disabled= false;
                document.all.FechaAsignacionFin.readOnly= false;
                document.all.FechaAsignacionFin.disabled= false;
            </script>
        </form>
        <input name='FechaMsk' id='FechaMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09'>
        <%  StringBuffer StrSql = new StringBuffer();
        StrSql.append(" st_SCSBuscaAsistxSuperv ").append(StrclUsrAppAs).append(",").append(StrclAsistencia);
        StrSql.append(",'" ).append(StrFechaAsignacionIni).append("','").append(StrFechaAsignacionFin).append("'");
        ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
        
        rs.next();
        
        if(rs.getString(1).equalsIgnoreCase("0")){
            System.out.println("Debe elegir un criterio de búsqueda");
        %>
        <div class='VTable' style='position:absolute; z-index:25; left:230px; top:230px;'>
            <b><font face="arial" SIZE=2 COLOR=#423A9E><b >Debe elegir un criterio de búsqueda</b></font></b>
        </div>
        <%
        return;
        }
        if(rs.getString(1).equalsIgnoreCase("1")){
            System.out.println("La búsqueda no regreso Asistencias");
        %>
        <div class='VTable' style='position:absolute; z-index:25; left:230px; top:230px;'>
            <b><font face="arial" SIZE=2 COLOR=#423A9E><b >La búsqueda no regresó asistencias</b></font></b>
        </div>
        <%
        return;
        }
        
        rs.beforeFirst();
        %>
        <script>
            document.all.check.style.visibility='visible';
        </script>
        <form target='WinSave' method='post' action='DesasignaAsist.jsp'>
            <br>
            <table>
                <tr class='cssTitDet'>
                    <td>Seleccionado</td>
                    <td>Grupo de Cuenta</td>
                    <td>Cuenta</td>
                    <td>Servicio</td>
                    <td>Asistencia</td>
                    <td>Supervisor</td>
                    <td>Fecha de Asignación</td>
                </tr>
                <%
                while(rs.next()) {
                %>
                <tr>
                    <td><input id='Expedientes<%=iCont%>' name='Expedientes' type='checkbox'></input></td>
                    <td><INPUT disabled='true' id='GpoCuenta' name='GpoCuenta' type='text' value='<%=rs.getString("GrupoCuenta")%>'></td>
                    <td><INPUT disabled='true' id='Cuenta' name='Cuenta' type='text' value='<%=rs.getString("Cuenta") %>'></td>
                    <td><INPUT disabled='true' id='Servicio' name='Servicio' type='text' value='<%=rs.getString("dsSubservicio") %>'></td>
                    <td><INPUT disabled='true' id='clAsistencia' name='clAsistencia' value='<%=rs.getString("clAsistencia") %>'></td>
                    <td><INPUT disabled='true' id='Supervisor' name='Supervisor' type='text' value='<%=rs.getString("Supervisor") %>'></td>
                    <td><INPUT disabled='true' id='FechaAsig' name='Fecha de Asignación' type='text' value='<%=rs.getString("FechaAsig")%>'></td>
                </tr>
                <%       
                iCont=iCont+1;
                }; // fin while
                %>
                <textarea name='Resultados' id='Resultados' cols='80' rows='3' <!--style="visibility:hidden"-->></textarea>
                <input type='hidden' name='Total' id='Total' value ='<%=iCont%>'></input><tr><td></tr></td>
                <tr><td></tr></td><tr><td><center><input type='submit' name='submit' value='Desasignar' onclick='fnConcatena()'></input></center></td></tr>
            </table>
        </form>
        <%
        rs.close();
        rs = null;
        StrSql = null;
        StrclUsrApp = null;
        StrclUsrAppAs = null;
        StrExpedElegidos = null;
        StrclAsistencia = null;
        StrFechaAsignacionIni = null;
        StrFechaAsignacionFin = null;
        StrclPaginaWeb = null;
        %>
        <script>
            //document.all.Resultados.style.visibility='hidden';

            function fnSelecc(ActionSelect){
                // ActionSelect:   0: No seleccionar, 1:Seleccionar
                i=0;
                while (i<=document.all.Total.value-1){
                    if(document.all.Total.value==1){
                        document.all.Expedientes.checked=ActionSelect;
                        i++;
                    }
                    else{
                        document.all.Expedientes(i).checked=ActionSelect;
                        i++;
                    }
                }
            }

            function fnConcatena(){
                i=0;
                document.all.Resultados.value='';
                fnOpenWindow();
                while (i<=document.all.Total.value-1){
                    if(document.all.Total.value==1){
                        if (document.all.Expedientes.checked){
                            if (document.all.Resultados.value==''){
                                document.all.Resultados.value = document.all.clAsistencia.value;
                            }
                            else{
                                document.all.Resultados.value = document.all.Resultados.value + ',' + document.all.clAsistencia.value;
                            } 
                        } 
                        i++;
                    }
                    else{
                        if (document.all.Expedientes(i).checked){
                            if (document.all.Resultados.value==''){
                                document.all.Resultados.value = document.all.clAsistencia(i).value;
                            }
                            else{
                                document.all.Resultados.value = document.all.Resultados.value + ',' + document.all.clAsistencia(i).value;
                            } 
                        } 
                        i++;
                    }
                }
            }

            function fnMuestra () {
                document.getElementById('divi').style.visibility='visible';
            }
        </script>
    </body>
</html>
