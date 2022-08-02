<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<html>
    <head>
        <title>Seguimiento</title>
    </head>
    <body class="cssBody" onload="fnValidaEstatus();">
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj"/>
        <script src='../Utilerias/Util.js'></script>
        <script src='../Utilerias/UtilProveedor.js'></script>
        <link href="../StyleClasses/Calendario.css" rel="stylesheet" type="text/css">
        <script type="text/javascript" src='../Utilerias/UtilMask.js'></script>
        <script type="text/javascript" src='../Utilerias/UtilCalendario.js'></script>
        <%
            String strclUsrApp = "0";
            if (session.getAttribute("clUsrApp") != null) {
                strclUsrApp = session.getAttribute("clUsrApp").toString();                }
            if(SeguridadC.verificaHorarioC(Integer.parseInt(strclUsrApp)) != true){
                %><font color="white"  style="font-family:Verdana,Arial,Helvetica,sans-serif; background-color:red;" size=3>LA SESION EXPIRO</font><%  
                strclUsrApp=null;
                return;
                }
            String StrclExpediente = "0";
            StringBuffer StrSql = new StringBuffer();
            String StrclServicio = "0";
            String StrclProveedorC = "0";
            String StrdsProveedorC = "0";
            String StrclCuenta = "0";
            if (session.getAttribute("clServicio") != null) {
                StrclServicio = session.getAttribute("clServicio").toString();           }
            if (session.getAttribute("clExpediente") != null) {
                StrclExpediente = session.getAttribute("clExpediente").toString();            }
            MyUtil.InicializaParametrosC(195, Integer.parseInt(strclUsrApp));
            ResultSet cdr = UtileriasBDF.rsSQLNP("st_getSegProveedoresCita "+ StrclExpediente);
            if (cdr.next()) { 
                StrclProveedorC = cdr.getString("clProveedor");
                StrdsProveedorC = cdr.getString("NombreOpe");
                }
            cdr.close();
            cdr = null;
            cdr = UtileriasBDF.rsSQLNP(" st_getProveedorxCita "+ StrclExpediente);
            int Strtotalprove=0;
            if (cdr.next()) {      Strtotalprove = Integer.parseInt(cdr.getString("totalprove"));     }
            cdr.close();
            cdr = null;
            //Obtener si es un  expediente hogar con cita y fue por GeoHogar
            cdr = UtileriasBDF.rsSQLNP("st_GetCitaGeoDirectaXExp " + StrclExpediente  );
            String parmsGeo = "";
            if (cdr.next()) { 
                session.setAttribute("MODO","GEOHOGAR");
                if (cdr.getBoolean("DIRECTA")) {       parmsGeo = "AUTO=1";
                }else {      parmsGeo = "AUTO=0";    }
            }
            cdr.close();
            cdr = null;                
            cdr = UtileriasBDF.rsSQLNP("sp_DetalleExpediente "+ StrclExpediente);
            if (cdr.next()) {     StrclCuenta = cdr.getString("clCuenta");   }
            cdr.close();
            cdr = null;            
            // checar si ya existe asistencia para el expediente, si existe, ya no procede la alta
            StrSql.append(" Select TieneAsistencia From Expediente Where clExpediente = ").append(StrclExpediente);
            ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
            StrSql.delete(0, StrSql.length());
            StrSql = null;
            if (rs.next()) { %>
                <form id='frmExp' name='frmExp' method='get' action='../servlet/Utilerias.GuardaSeguimiento'>
                    <%=MyUtil.ObjComboC("Estatus", "clEstatus0", "", true, true, 30, 30, "", "sp_GetEstatusOp '" + StrclExpediente + "'", "fnValidaEstatus(this.value);fnLlenaComboMotivo(this.value);", "", 50, false, false)%>
                    <div id="MotivoDIV" name="MotivoDIV" style="visibility:'hidden'">
                        <%=MyUtil.ObjComboC("Motivo", "clMotivo0", "", true, true, 230, 30, "", "st_MotivoxEstatusSeg 0, " + StrclCuenta, "fnValidaMotivo(this.value)", "", 50, false, false)%>
                    </div>
                    <div id="RecordatorioDIV" name="RecordatorioDIV" style="visibility:'hidden'" >
                        <%=MyUtil.ObjInputFNAC("Fecha Recordatorio (AAAA-MM-DD)", "FechaReco", "", true, true, 430, 30, "", true, true, 15, 1, "fnValidaFechaActual(this);")%>                
                        <%=MyUtil.ObjInput("Hora (HH:MM)", "HoraReco", "", true, true, 650, 30, "", true, true, 5,"fnHrs(this);")%>
                    </div>
                    <%if( Strtotalprove>1){%>
                        <div id="ComboProveedorDiv" style="visibility:visible"></div>
                    <%}else{%>
                        <div id="ComboProveedorDiv" style="visibility:hidden">
                            <input id='clProveedor0' name='clProveedor0' type='visibility' value='<%=StrclProveedorC%>'/>   
                        </div>
                             <%}%>
                    <%=MyUtil.ObjComboC("Proveedor", "clProveedor0", "", true, true, 30, 70, "", "st_getSegProveedoresCita " + StrclExpediente, "", "", 30,false, false)%>
                    <%=MyUtil.ObjTextArea("Observaciones", "Observaciones0", "", "100", "7", true, true, 30, 110, "", false, false)%>
                    <input id='URLBACK0' name='URLBACK0' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%>BitacoraExpediente.jsp?clExpediente=<%=StrclExpediente%>'></input>
                    <input id='clExpediente0' name='clExpediente0' type='hidden' value='<%=StrclExpediente%>'/>
                    <input id='clProveedorAS' name='clProveedorAS' type='hidden' value='<%=StrclProveedorC%>'/>
                    <input id='dsProveedorAS' name='dsProveedorAS' type='hidden' value='<%=StrdsProveedorC%>'/>
                    <input id='TipoSeg0' name='TipoSeg0' type='hidden' value='0'>        
                    <%=MyUtil.DoBlock("Seguimiento al Servicio", 147, 90)%>
                    <div class='VTable' style='position:absolute; z-index:20; left:30px; top:220px;'>
                        <input id="btnGuarda0" name="btnGuarda0" type='button' VALUE='Guardar...' onClick='fnValidacionesDeServicio(this)' class='cBtn'/>
                    </div>
                </form>

            <form name='frmProv' id='frmExp' method='get' action='../servlet/Utilerias.GuardaSeguimiento'>
                <%=MyUtil.ObjComboC("Proveedor", "clProveedor1", "", true, true, 30, 290, "", "st_getSegProveedores " + StrclExpediente, "fnLlenaEstatusProv()", "", 30, false, false)%>
                <%=MyUtil.ObjComboC("Estatus", "clEstatus1", "", true, true, 30, 340, "", "sp_GetEstatusOp '0'", "", "", 50, false, false)%>
                <%=MyUtil.ObjTextArea("Observaciones", "Observaciones1", "", "100", "7", true, true, 30, 380, "", false, false)%>
                <input id='URLBACK1' name='URLBACK1' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%>Seguimiento.jsp?clExpediente=<%=StrclExpediente%>'></input>
                <input id='clExpediente1' name='clExpediente1' type='hidden' value='<%=StrclExpediente%>'>
                <input id='TipoSeg1' name='TipoSeg1' type='hidden' value='1'/>
                <input id="FechaProgMomAux" name="FechaProgMomAux" value="FechaProgMom" type="hidden"/>       
                <input id='FechaProgMomMsk' name='FechaProgMomMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F'/>
                <%=MyUtil.DoBlock("Seguimiento al Proveedor", 360,100)%>
                <div class='VTable' style='position:absolute; z-index:20; left:30px; top:500px;'>
                    <input type='button' VALUE='Guardar...' onClick='this.disabled=true; this.form.submit();' class='cBtn'/>
                </div>
            </form>
        <% } else { %> 
            El expediente no existe 
            <%
            }
            rs.close();
            rs = null;
            StrclExpediente = null;
            strclUsrApp = null;
        %>
    </body>
    <script>
//------------------------------------------------------------------------------
        document.all.clEstatus0C.disabled = false;
        document.all.Observaciones0.readOnly = false;
        document.all.clMotivo0C.disabled = false;
        document.all.clProveedor1C.disabled = false;
        document.all.clEstatus1C.disabled = false;
        document.all.Observaciones1.readOnly = false;
        document.all.HoraReco.readOnly=false;
        document.all.clProveedor0C.disabled = false;
//------------------------------------------------------------------------------
        function fnValidaEstatus(clEstatus) {           
            var clCuenta = <%=StrclCuenta %>;
            if(clEstatus != '56'){
                document.all.RecordatorioDIV.style.visibility = 'hidden';
                document.all.btnGuarda0.disabled = false;
                if(clEstatus == '30' && (clCuenta == '1894' || clCuenta == '1839')){
                    document.all.MotivoDIV.style.visibility = 'visible';
                    document.all.btnGuarda0.disabled = true;
                }else if((clEstatus=='46')||(clEstatus=='7')||(clEstatus=='8')||(clEstatus=='48')||(clEstatus=='49')||(clEstatus=='52')
                        ||(clEstatus=='56')||(clEstatus=='10'&&<%=StrclServicio%>=='19')){
                    document.all.MotivoDIV.style.visibility = 'visible';
                    document.all.btnGuarda0.disabled = true;
                } else {
                    document.all.clMotivo0.value = '0';    
                    document.all.MotivoDIV.style.visibility = 'hidden';
                    document.all.btnGuarda0.disabled = false;
                    }
            } else {
                    document.all.MotivoDIV.style.visibility = 'visible';
                    document.all.RecordatorioDIV.style.visibility = 'visible';
                    document.all.btnGuarda0.disabled = true;                      
                }
            }
//------------------------------------------------------------------------------
        function fnValidaMotivo(clMotivo) {
            if (clMotivo != '') {            document.all.btnGuarda0.disabled = false;
            } else {            document.all.btnGuarda0.disabled = true;           }
            }
//------------------------------------------------------------------------------
        function fnLlenaComboMotivo(clEstatus) {
            var clCuenta = <%=StrclCuenta %>;
            if(clEstatus == '30' && (clCuenta == '1894' || clCuenta == '1839')){
                var strConsulta = "st_MotivoxEstatusSeg '" + document.all.clEstatus0.value + "', '" + clCuenta + "'";
                var pstrCadena = "../servlet/Utilerias.LlenaCombos?strSQL=" + strConsulta;
                pstrCadena = pstrCadena + "&strName=clMotivo0C";
                fnOptionxDefault('clMotivo0C', pstrCadena);
            }else if ((clEstatus == '46') || (clEstatus == '7') || (clEstatus == '8') || (clEstatus == '48')|| (clEstatus == '49') || (clEstatus == '52') || (clEstatus == '10') || (clEstatus == '56')) {
                var strConsulta = "st_MotivoxEstatusSeg '" + document.all.clEstatus0.value + "', '" + clCuenta + "'";
                var pstrCadena = "../servlet/Utilerias.LlenaCombos?strSQL=" + strConsulta;
                pstrCadena = pstrCadena + "&strName=clMotivo0C";
                fnOptionxDefault('clMotivo0C', pstrCadena);
            }
        }
//------------------------------------------------------------------------------
        function fnNuevaCita() {
            var clMotivo= document.getElementById("clMotivo0").value;          
            var clEstatus0=document.getElementById("clEstatus0").value;
            if (clMotivo == 23 || clMotivo == 25 || clMotivo == 27) {
                window.open("../Operacion/CreaCita.jsp?clProveedor="+document.getElementById("clProveedorAS").value+"&NombreOpe="+document.getElementById("dsProveedorAS").value+"&<%=parmsGeo%>" ,"winCita","resizable=no,menubar=0,status=yes,width=600,height=350");
            }           
        }
//------------------------------------------------------------------------------
        function fnValidaFechaActual(campo){  
            if(campo.value!=""){
                date=campo.value;
                Anio=date.substring(0,4);
                Mes=date.substring(5,7)-1;
                Mes=parseInt(Mes,10);
                Dia=date.substring(8,10);
                Dia=parseInt(Dia,10);
                var x=new Date();
                x.setFullYear(Anio,Mes,Dia);
                if(x.getFullYear()!=Anio){
                    alert("Fecha incorrecta");  
                    campo.value="";
                }else{
                Fecha=document.all.FechaProgMomAux.value;
                if(Fecha!=campo.value){
                    var today = new Date(); 
                        if (x<today){
                            campo.value="";
                            alert("La fecha no puede ser menor a hoy");
                            }
                        }
                    }
                }
                var FechaC1 = document.getElementById("FechaReco").value;
                var FechaC = FechaC1.substring(0, 10); 
                campo.value=FechaC;
            }
//------------------------------------------------------------------------------
            function fnHrs(campo){
                var StrHoraDL=(document.getElementById("HoraReco").value.length);                
                    if(StrHoraDL <= 2){                   
                        var StrHoraDV=(document.getElementById("HoraReco").value);
                        var min=":00";
                        var res = StrHoraDV.concat(min);
                        campo.value=res;
                }
                validaHora(campo);
            }
//------------------------------------------------------------------------------            
            function validaHora(campo){
                 var patt =/^\d{2}:\d{2}/g
                 if(!patt.test(campo.value)){
                     campo.value="";
                     alert("Formato 24 Hrs (hh:mm)");
                 }else{
                     var agr=campo.value.split(":");
                     if(parseInt(agr[0])>24||parseInt(agr[1])>59){
                          campo.value="";
                          alert("Formato 24 Hrs (hh:mm)");
                        } 
                    }
                }
//------------------------------------------------------------------------------
            function fnEsRecordatorio() {
                var combobox  = document.getElementById("clEstatus0C");
                var estatus = combobox.options[combobox.selectedIndex].text;
                return estatus.toString().toUpperCase() === 'RECORDATORIO';
            }
//------------------------------------------------------------------------------
            function fnEsFechaVacia() {
                var fecha = document.getElementById('FechaReco').value;
                return fecha === '';
            }
//------------------------------------------------------------------------------
            function fnEsHoraVacia() {
                var hora = document.getElementById('HoraReco').value;
                return hora === '';
            }
//------------------------------------------------------------------------------
            function fnValidacionesDeServicio(btn){
                if (fnEsRecordatorio() && (fnEsFechaVacia() || fnEsHoraVacia())) {
                    alert("Los campos fecha y hora no deben ser vacios.");
                    return;
                } 
                btn.disabled = true;
                fnNuevaCita();
                btn.form.submit();
            }
//------------------------------------------------------------------------------
    </script>
</html>