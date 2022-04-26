<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Seguridad.SeguridadC,Utilerias.UtileriasBDF,Combos.cbServicio" errorPage="" %>
<html>
    <head><title>JSP Page</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body topmargin=470 leftmargin=30 class="cssBody">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
        <script src='../Utilerias/Util.js' ></script>
        <script src='../Utilerias/UtilMask.js'></script>
        <script src='../Utilerias/UtilServicio.js'></script>
        
        <%
        String StrSql = "";
        String StrclUsrApp="0";
        String StrclPaginaWeb="1177";
        String StrWhere="";
        int iCont =0;
        
        if (session.getAttribute("clUsrApp")!= null) {
            StrclUsrApp = session.getAttribute("clUsrApp").toString();
        }
        
        if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {%>       
        Fuera de Horario 
        <% return;
        }
        
        MyUtil.InicializaParametrosC(1177,Integer.parseInt(StrclUsrApp));
        
        StrSql = "Select clUsrApp, Nombre from cUsrApp where Activo = 1 and clPerfilOperativo = 5 order by Nombre";
        ResultSet rs = UtileriasBDF.rsSQLNP( StrSql);
        System.out.println("StrSql:      "+StrSql);
        %>   

        <form target='VistaPrevia' method='post' action='AsignarAsistencias.jsp'>    
            <div style='position:absolute; z-index:303; left:30px; top:270px'>
                <input type='reset' value='Limpiar'</input>
                <input type='submit' value='Asignar' name="Asig" onclick='document.all.Control.value=0;fnConcatena()'></input>
                <input type='submit' value='Vista Previa' name="Vtp" onclick='document.all.Control.value=1;fnConcatena()'></input>
            </div>   
            <div style='position:absolute; z-index:303; left:30px; top:10px'>
                <b><font face="arial" SIZE=2 COLOR=#423A9E><b >ASIGNACIÓN DE ASISTENCIAS CONCIERGE</b></font></b>
            </div> 
            
            <%=MyUtil.ObjComboC("Grupo de Cuenta","clGrupoCuenta","",true,true,30,70,"","Select clGrupoCuenta, dsGrupoCuenta from cGrupoCuenta order by dsGrupoCuenta","","",40,false,false)%>
            <%=MyUtil.ObjInput("Cuenta","Cuenta","",true,true,30,110,"",false,false,40,"if(this.readOnly==false){fnBuscaCuenta();}")%>
            <%=MyUtil.ObjInput("Asistencia","clAsistencia","",true,true,260,190,"",false,false,20,"")%>
            <%=MyUtil.ObjInput("Fecha Inicio (aaaa-mm-dd)","FechaIni","",true,true,30,150,"",false,false,20,"if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)}")%>
            <%=MyUtil.ObjInput("Fecha Fin (aaaa-mm-dd)","FechaFin","",true,true,260,150,"",false,false,20,"if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)}")%>
            <%=MyUtil.ObjComboC("Estatus","clEstatus","",true,true,30,230,"","st_SCSLlenaestatus","","",40,false,false)%>
            <%=MyUtil.ObjComboC("SubServicio","clSubServicio","",true,true,30,190,"","select clSubservicio,dsSubservicio from CScSubservicio order by 2 asc","","",40,false,false)%>
            <%//=MyUtil.ObjComboC("Evento","clSubServicio","",true,true,30,160,"","","",40,false,false)%>
            <input name='FechaMsk' id='FechaMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09'>
            <INPUT id='clCuenta' name='clCuenta' type='hidden' value='0'>
            <INPUT id='Control' name='Control' type='hidden' value='0'>
            <div class='VTable' style='position:absolute; z-index:25; left:250px; top:95px;'>
            <IMG SRC='../Imagenes/Lupa.gif' onClick='fnBuscaCuenta();' WIDTH=20 HEIGHT=20></div>
            <%=MyUtil.DoBlock("Criterios de Selección",0,30)%>
            
            <%=MyUtil.ObjComboC("Área a Supervisar","clAreaSupervisada","",true,true,30,345,"","st_SMSgetAreaSupervision","","",40,false,false)%>
            <%=MyUtil.ObjInput("Porcentaje a Repartir","Porcentaje","",true,true,30,385,"",false,false,15,"")%>
            <%=MyUtil.DoBlock("Atributos para Asignación",60,0)%>
            <textarea name='UsuariosSeleccionados' id='UsuariosSeleccionados' cols='80' rows='3' style="visibility:hidden"></textarea>                
            <table><tr><td class='cssTitDet' colspan=2>Supervisores Activos</td></tr><tr class='TTable'><td>Seleccionado</td><td class='TTable'>Usuario</td></tr>
            
            <%
            while(rs.next()) {
            %>               
            <tr><td><input id='Usuarios' name='Usuarios' type='checkbox'></input></td>
                <td><INPUT disabled='true' id='Nombre' name='Nombre' type='text' value='<%=rs.getString("Nombre")%>'></td>
                <td><INPUT disabled='true' id='clUsrApp' name='clUsrApp' type='hidden' value='<%=rs.getString("clUsrApp")%>'></td>
            </tr>
            <%        iCont=iCont+1;
            }; // fin while
            rs.close();
            rs=null;
            %>
            <input type='hidden' name='Total' id='Total' value ='<%=iCont%>'></input>
        </form>
        
        <%
        StrSql = null;
        StrclUsrApp = null;
        StrclPaginaWeb = null;
        StrWhere = null;
        %>
        
        <script>

            document.all.clGrupoCuentaC.disabled=false;
            document.all.clCuenta.disabled=false;
            document.all.FechaIni.readOnly=false;
            document.all.FechaFin.readOnly=false;
            document.all.clAsistencia.readOnly=false;
            document.all.clSubServicioC.disabled=false;
            document.all.clEstatusC.disabled=false;
            document.all.clAreaSupervisadaC.disabled=false;
            document.all.Porcentaje.readOnly=false;

            function fnConcatena(){
                i=0;
                document.all.UsuariosSeleccionados.value='';        
                if (document.all.Total.value>1){
                    while (i<document.all.Total.value){
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

            function fnBuscaCuenta(){
                if (document.all.Nombre.value!=''){
                     var pstrCadena = "../Utilerias/FiltrosCuenta.jsp?strSQL=sp_WebBuscaCuenta ";
                     pstrCadena = pstrCadena + "&Cuenta= " ;
                     document.all.clCuenta.value='';
                     window.open(pstrCadena,'newWin','scrollbars=yes,status=yes,width=700,height=500');
                }
            }

            function fnActualizaDatosCuenta(dsCuenta,clCuenta,clTipoVal, Msk, MskUsr, Agentes){
                document.all.Cuenta.value = dsCuenta;			
                document.all.clCuenta.value = clCuenta;
            }

           /* function fnSegundaSupervision(){
                if (document.all.Supervision.value=="1"){ 
                    document.all.clServicioC.disabled=true;     
                    document.all.clServicioC.value=8;
                    document.all.clServicio.value=8;
                    fnLlenaSubServicios();
                }
                else{
                    document.all.clServicioC.disabled=false;
                }
            }*/
        </script>
    </body>
</html>
