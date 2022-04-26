<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Seguridad.SeguridadC,Utilerias.UtileriasBDF" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>

<html>
    <head>
        <title>
            Quejas x supervision
        </title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody" onload="fn_ChecaDano();">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" />
        <script src='../Utilerias/Util.js' ></script>
        <script src='../Utilerias/UtilDireccion.js' ></script>
        <script src='../Utilerias/UtilMask.js'></script>
        <script src='../Utilerias/UtilCalendario.js' ></script>
        <link href='../StyleClasses/Calendario.css' rel='stylesheet' type='text/css'>

        <%
        String StrclAsistencia = "0";
        String StrclUsrApp = "0";
        String StrclPaginaWeb = "6124";
        String StrFecha = "";
        String strclSupervision = "0";
        String StrclQuejaxSupervision = "0";
        String StrclQuejaxSupervisionD = "0";
        String StrclQuejaxSupervisionG = "0";
        String strStatus = "0";
        String StrclQueja = "0";
        String StrclAceptaDano = "0";

        if (session.getAttribute("clUsrApp")!= null) {
            StrclUsrApp = session.getAttribute("clUsrApp").toString();
        }

        if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true){
        %>Fuera de Horario<%
        return;
        }

        if (session.getAttribute("clAsistencia")!= null) {
            StrclAsistencia = session.getAttribute("clAsistencia").toString();
        }

        if (StrclAsistencia.equalsIgnoreCase("0")){
        %>Falta informar Asistencia<%
        return;
        }

        if (session.getAttribute("clSupervision")!= null) {
            strclSupervision = session.getAttribute("clSupervision").toString();
        }

        StringBuffer StrSql = new StringBuffer();

        StrSql.append("st_SCSgetFechaEt");
        ResultSet rs2 = UtileriasBDF.rsSQLNP( StrSql.toString());
        StrSql.delete(0,StrSql.length());

        if (rs2.next()){
            StrFecha = rs2.getString("fechaEt");
        }

        rs2.close();
        rs2 = null;
        %>
        <INPUT id='clAsistencia2' name='clAsistencia2' type='hidden' value='<%=StrclAsistencia%>'>
        <%
        if (request.getParameter("clQuejaxSupervision")!= null) {
            StrclQuejaxSupervisionG = request.getParameter("clQuejaxSupervision").toString();
        }

        StrSql.append("st_SCSgetQuejaxSup ").append(StrclAsistencia).append(",").append(StrclQuejaxSupervisionG);
        ResultSet rs4 = UtileriasBDF.rsSQLNP( StrSql.toString());
        StrSql.delete(0,StrSql.length());

        if (rs4.next()){
            StrclQuejaxSupervisionD= rs4.getString("clQuejaxSupervision");
        } else {
            StrclQuejaxSupervisionD = null;
        }
        rs4.close();
        rs4 = null;
        %>
        <script>
            fnOpenLinks()
        </script>
        <%
        ResultSet rs = UtileriasBDF.rsSQLNP( "st_SCSBuscaQueja "+StrclQuejaxSupervisionG);
        StrSql.delete(0,StrSql.length());

        MyUtil.InicializaParametrosC(6124,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
        session.setAttribute("clPaginaWebP",StrclPaginaWeb);%>
        
        <%=MyUtil.doMenuActPost("../servlet/Utilerias.EjecutaAccion","fnLlenaQueja();","/*fnRequiere();*/")%>
        
        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1) + "QuejasxSupervisionAsist.jsp?"%>'>
        <%
        System.out.println("Hay registro...."+StrclQuejaxSupervisionG);
        StrSql.append("st_SCSgetEstatusQueja ").append(StrclQuejaxSupervisionG);
        ResultSet rs3 = UtileriasBDF.rsSQLNP( StrSql.toString());
        
        if(rs3.next()){
            System.out.println("Hay registro");
            strStatus=rs3.getString("clEstatusQueja");
            if (strStatus.equalsIgnoreCase("4") || strStatus.equalsIgnoreCase("5")  || strStatus.equalsIgnoreCase("6")){//se  otorgan permisos dependiendo del esatus
        %>
        <script>
            document.all.btnAlta.disabled=true;
            document.all.btnCambio.disabled=false;
            document.all.btnElimina.disabled=true;
            //document.all.Soluciono.style.visibility = "visible";
        </script>
        <% }else{ %>
        <script>
            document.all.btnAlta.disabled = false;
            document.all.btnCambio.disabled = false;
            document.all.btnElimina.disabled = false;
            //document.all.Soluciono.style.visibility = "visible";
        </script>
        <%
        }
        }
        System.out.println("strStatus = "+strStatus);
        rs3.close();
        rs3 = null;
        
        if (rs.next()) { //Alta.
            if (StrclQuejaxSupervisionG!= null &&  StrclQuejaxSupervisionD==null) {
                out.println("<script>  alert ('Necesita Ingresar una Deficiencia a la Queja'); </script>");
                StrclQuejaxSupervision= StrclQuejaxSupervisionG;
                out.println("<script> location.href='../Supervision/DetalleMarcaDeficienciasAsist.jsp?clQuejaxSupervision="+ StrclQuejaxSupervision +"';</script>");
            }else{
                StrclQuejaxSupervision=StrclQuejaxSupervisionG;
            }
        %>
        <div class='VTable' id ="Soluciono"  style='position:relative; z-index:200; left:0px; top:40px; width: 500px; visibility: hidden'>
            <%=MyUtil.ObjChkBox("Comercial","NSComercial",rs != null ? rs.getString("NSComercial"): "", true,true,30,430,"0","SI","NO","fnValidaa();")%>
            <%=MyUtil.ObjChkBox("Cliente","NSCliente",rs != null  ? rs.getString("NSCliente"): "", true,true,120,430,"0","SI","NO","fnValidaa();")%>
            <%=MyUtil.ObjChkBox("Usuario","NSUsuario",rs != null ? rs.getString("NSUsuario"): "", true,true,200,430,"0","SI","NO","fnValidaa();")%>
            <%=MyUtil.ObjChkBox("Jefe","NSJefe",rs != null ? rs.getString("NSJefe"): "", true,true,280,430,"0","SI","NO","fnValidaa();")%>
            <%=MyUtil.ObjChkBox("GCP","NSGCP",rs != null ? rs.getString("NSGCP"):"", true,true,360,430,"0","SI","NO","fnValidaa();")%>
            <%=MyUtil.ObjChkBox("Proveedor","NSProveedor",rs != null ? rs.getString("NSProveedor"):"", true,true,440,430,"0","SI","NO","fnValidaa();")%>
            <%=MyUtil.DoBlock("Notificacion de Solucion")%>                    
        </div>
        <%
        if (strStatus.equalsIgnoreCase("4") || strStatus.equalsIgnoreCase("5")  || strStatus.equalsIgnoreCase("6")){
                System.out.println("Entro a este if");
        %>
        <script>
            document.all.Soluciono.style.visibility = "visible";
        </script>
        <% } else { %>
        <script>
            document.all.Soluciono.style.visibility = "visible";
        </script>
        <% } %>
        <INPUT id='clQuejaxSupervision' name='clQuejaxSupervision' type='hidden' value='<%=StrclQuejaxSupervision%>'>
        <INPUT id='clSupervision' name='clSupervision' type='hidden' value='<%=strclSupervision %>'>
        <INPUT id='clAsistencia' name='clAsistencia' type='hidden' value='<%= StrclAsistencia%>'>
        <INPUT id='clUsrAppIngresa' name='clUsrAppIngresa' type='hidden' value='<%= StrclUsrApp %>'>
        <INPUT id='StrFecha' name='StrFecha' type='hidden' value='<%= StrFecha %>'>
        <INPUT id='FechaIngreso' name='FechaIngreso' type='hidden' value='<%= StrFecha %>'>

        <%=MyUtil.ObjComboC("Queja","clQueja",rs.getString("dsQueja"),true,true,30,130,"","Select clQueja, dsQueja from cQueja where Activo=1","","",140,true,true)%>
        <%=MyUtil.ObjComboC("Estatus  de la Queja","clEstatusQueja",rs.getString("dsEstatusQueja"),false,true,300,130,"1","Select clEstatusQueja,dsEstatusQueja from cEstatusQueja","fn_Soluciono(this.value); fnFechasolucion(); fnhabilita(); fnObligatorio();","", 140,true,true)%>
        <%=MyUtil.ObjChkBox("Queja o Inconformidad","EsQueja",rs.getString("EsQueja"), true,true,550,125,"0","Queja","Inconformidad","")%>
        <%=MyUtil.ObjTextArea("Observaciones de Supervisor","ObservacionesSup",rs.getString("ObservacionesSup"),"80","3",true,true,30,180,"",true,true)%>
        <%=MyUtil.ObjTextArea("Observaciones de �rea","ObservacionesArea",rs.getString("ObservacionesArea"),"80","3",false,true,30,250,"",false,false)%>
        <%=MyUtil.ObjTextArea("SOLUCI�N","Solucion",rs.getString("Solucion"),"80","3",false,true,30,320,"",false,false)%>
        <%=MyUtil.ObjComboC("Tipo de SOLUCI�N","clTipoSolQueja",rs.getString("dsTipoSolQueja"),true,true,500,320,"","Select clTipoSolQueja,dsTipoSolQueja from cTipoSolQueja","","",100,false,false)%>
        <%=MyUtil.ObjInput("Fecha de Ingreso<BR>AAAA/MM/DD HH:MM","FechaIngresoVTR",rs.getString("FechaIngreso"),false,false,30,390,StrFecha,true,true,22)%>
        <%=MyUtil.ObjInput("Fecha de SOLUCI�N<BR>AAAA/MM/DD HH:MM","FechaSolucion",rs.getString("FechaSolucion"),false,false,300,390,"",false,false,22,"")%>
        <%=MyUtil.DoBlock("M�dulo de Quejas",50,25)%>
        <% if (rs.getString("clQueja").equalsIgnoreCase("1")){ %>
        <div id="DetalleDanos">
            <%=MyUtil.ObjComboC("Tipo de Da�o","clDano",rs.getString("dsDano"),false,true,30,620,"0","Select clDano , dsDano  from cDanos","fn_LLenaSubDano();","",50,true,true)%>
            <%=MyUtil.ObjComboC("SubTipo de Da�o","clSubDano",rs.getString("dsSubDano"),false,true,200,620,"0","sp_TraeSubDano '"+rs.getString("clDano")+"'","","",50,true,true)%>
            <%=MyUtil.ObjChkBox("ACEPTACI�N","clAceptacionDano",rs.getString("clAceptacionDano"), true,true,370,620,"0","SI","NO","fn_AceptaDano(clAceptacionDano.value);")%>                
            <%=MyUtil.ObjComboC("Responsabilidad","clResponsabilidadDano",rs.getString("dsResponsabilidadDano"),false,true,30,670,"0","Select clResponsabilidadDano , dsResponsabilidadDano  from cResponsabilidadDano ","","",50,true,true)%>
            <%=MyUtil.ObjComboC("Modo Reparaci�n","clModoReparacionDano",rs.getString("dsModoReparacionDano"),false,true,250,670,"0","Select clModoReparacionDano , dsModoReparacionDano  from cModoReparacionDano ","","",50,false,false)%>                               
            <%=MyUtil.ObjComboC("Tipo de Pago","clTipoPagoDano",rs.getString("dsTipoPagoDano"),false,true,30,724,"0","Select clTipoPagoDano , dsTipoPagoDano  from cTipoPagoDano ","fn_HayPago(this.value);","",50,false,false)%>                
            <%=MyUtil.ObjInputF("Fecha Registro Tipo de Pago","FechaRegistroTipoPago",rs.getString("FechaRegistroTipoPago"),false,false,250,723,"",false,false,20,1,"")%>                
            <%=MyUtil.ObjInputF("Fecha Pago/Ingreso a Taller","FechaPagoIngreso",rs.getString("FechaPagoIngreso"),false,false,30,782,"",false,false,20,1,"")%>               
            <%=MyUtil.ObjComboC("Comprobante de REPARACI�N","clComprobanteRepDano",rs.getString("dsComprobanteRepDano"),false,true,250,783,"0","select clComprobanteRepDano,dsComprobanteRepDano from cComprobanteRepDano","","",50,false,false)%>
            <%=MyUtil.ObjInputF("Fecha Comprobante Reparacion","FechaRegistroComprob",rs.getString("FechaRegistroComprob"),false,false,470,783,"",false,false,20,1,"")%>
            <%=MyUtil.DoBlock("Detalle de Da�os")%>
        </div>
        
        <div class='VTable' id ="AceptaDano" style='position:relative; z-index:200; left:0px; top:0px; visibility: hidden '>
            <%=MyUtil.ObjInputF("Fecha Aceptaci�n","FechaAceptacionDano",rs.getString("FechaAceptacionDano"),false,false,470,580,"",false,false,20,1,"")%>
        </div>

        <div class='VTable' id ="HayPago" style='position:relative; z-index:200; left:0px; top:0px; visibility: hidden'>                    
            <%=MyUtil.ObjInput("Monto Pago","MontoPago",rs.getString("MontoPago"),true,true,460,680,"",false,false,25)%>
        </div>
        <%
        }
        } else { // Baja.
        %>
        <script>
            document.all.btnElimina.disabled=true;
            document.all.btnCambio.disabled=true;
        </script>
        <INPUT id='clQuejaxSupervision' name='clQuejaxSupervision' type='hidden' value='<%=StrclQuejaxSupervision %>'>
        <INPUT id='clSupervision' name='clSupervision' type='hidden' value='<%= strclSupervision %>'>
        <INPUT id='clAsistencia' name='clAsistencia' type='hidden' value='<%= StrclAsistencia %>'>
        <INPUT id='clUsrAppIngresa' name='clUsrAppIngresa' type='hidden' value='<%= StrclUsrApp %>'>
        <INPUT id='FechaIngreso' name='FechaIngreso' type='hidden' value='<%= StrFecha %>'>

        <%=MyUtil.ObjComboC("Queja","clQueja","",true,false,20,80,"","Select clQueja, dsQueja from cQueja where Activo=1","","",140,true,true)%>
        <%=MyUtil.ObjComboC("Estatus  de la Queja", "clEstatusQueja","",false,true,290,80,"1","Select clEstatusQueja,dsEstatusQueja from cEstatusQueja","","",140,true,true)%>
        <%=MyUtil.ObjChkBox("Queja o Inconformidad","EsQueja","", true,true,540,75,"0","Queja","Inconformidad","")%>
        <%=MyUtil.ObjTextArea("Observaciones de Supervisor","ObservacionesSup","","80","3",true,false,20,130,"",true,true)%>
        <%=MyUtil.ObjTextArea("Observaciones de �rea","ObservacionesArea","","80","3",false,true,20,200,"",false,true)%>
        <%=MyUtil.ObjTextArea("SOLUCI�N","Solucion","","80","3",false,true,20,270,"",false,true)%>
        <%=MyUtil.ObjComboC("Tipo de SOLUCI�N","clTipoSolQueja","",true,true,490,280,"","Select clTipoSolQueja,dsTipoSolQueja from cTipoSolQueja","","",100,false,false)%>
        <%=MyUtil.ObjInput("Fecha de Ingreso","FechaIngresoVTR","",false,false,20,350,StrFecha,true,true,22)%>
        <%=MyUtil.ObjInput("Fecha de SOLUCI�N<BR>AAAA/MM/DD HH:MM","FechaSolucion","",false,false,290,340,"",false,false,22,"")%>
        <%=MyUtil.DoBlock("M�dulo de Quejas",0,0)%>
        
        <div style="visibility:hidden">
            <%=MyUtil.ObjChkBox("Comercial","NSComercial","", true,true,30,500,"0","SI","NO","")%>
            <%=MyUtil.ObjChkBox("Cliente  ","NSCliente", "", true,true,120,500,"0","SI","NO","")%>
            <%=MyUtil.ObjChkBox("Usuario  ","NSUsuario", "", true,true,200,500,"0","SI","NO","")%>
            <%=MyUtil.ObjChkBox("Jefe     ","NSJefe", "", true,true,280,500,"0","SI","NO","")%>
            <%=MyUtil.ObjChkBox("GCP      ","NSGCP","", true,true,360,500,"0","SI","NO","")%>
            <%=MyUtil.ObjChkBox("Proveedor","NSProveedor","", true,true,440,500,"0","SI","NO","")%>
            <%=MyUtil.DoBlock("NOTIFICACI�N DE SOLUCI�N")%>                    

            <%=MyUtil.ObjComboC("Tipo de Da�o","clDano","",false,true,30,620,"0","Select clDano , dsDano  from cDanos","fn_LLenaSubDano();","",50,false,false)%>
            <%=MyUtil.ObjComboC("SubTipo de Da�o","clSubDano","",false,true,200,620,"0","sp_TraeSubDano","","",50,false,false)%>
            <%=MyUtil.ObjChkBox("Aceptaci�n","clAceptacionDano","", true,true,370,620,"0","SI","NO","fn_AceptaDano(clAceptacionDano.value);")%>                
            <%=MyUtil.ObjComboC("Responsabilidad","clResponsabilidadDano","",false,true,30,670,"0","Select clResponsabilidadDano , dsResponsabilidadDano  from cResponsabilidadDano ","","",50,false,false)%>
            <%=MyUtil.ObjComboC("Modo Reparaci�n","clModoReparacionDano","",false,true,250,670,"0","Select clModoReparacionDano , dsModoReparacionDano  from cModoReparacionDano ","","",50,false,false)%>                               
            <%=MyUtil.ObjComboC("Tipo de Pago","clTipoPagoDano","",false,true,30,724,"0","Select clTipoPagoDano , dsTipoPagoDano  from cTipoPagoDano ","fn_HayPago(this.value);","",50,false,false)%>                
            <%=MyUtil.ObjInputF("Fecha Registro Tipo de Pago","FechaRegistroTipoPago","",false,false,250,723,"",false,false,20,1,"")%>                
            <%=MyUtil.ObjInputF("Fecha Pago/Ingreso a Taller","FechaPagoIngreso","",false,false,30,782,"",false,false,20,1,"")%>               
            <%=MyUtil.ObjComboC("Comprobante de Reparaci�n","clComprobanteRepDano","",false,true,250,783,"0","select clComprobanteRepDano,dsComprobanteRepDano from cComprobanteRepDano","","",50,false,false)%>
            <%=MyUtil.ObjInputF("Fecha Comprobante REPARACI�N","FechaRegistroComprob","",false,false,470,783,"",false,false,20,1,"")%>
            <%=MyUtil.ObjInputF("Fecha Aceptaci�n","FechaAceptacionDano","",false,false,470,580,"",false,false,20,1,"")%>
            <%=MyUtil.ObjInput("Monto Pago","MontoPago","",true,true,460,680,"",false,false,25)%>
            <%=MyUtil.DoBlock("Detalle de Da�os")%>
        </div>
        <%
        }
        %>
        <%=MyUtil.GeneraScripts()%>
        <input name='FechaMask' id='FechaMask' id='FechaMask' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09'>
        <%
        rs.close();
        rs = null;
        StrclAsistencia = null;;
        StrclUsrApp = null;;
        StrclPaginaWeb = null;;
        StrFecha = null;
        strclSupervision = null;;
        StrclQuejaxSupervision = null;;
        StrclQuejaxSupervisionD = null;;
        StrclQuejaxSupervisionG = null;;
        strStatus = null;
        StrclQueja = null;
        %>
        <script>
            
            function fnObligatorio(){
                if(document.all.clEstatusQueja.value == 4){
                    alert('Seleccione una notificaci�n de soluci�n');
                    document.all.btnGuarda.disabled=true;
                }else{
                    document.all.btnGuarda.disabled=false;
                }
            }
            
            function fnValidaa(){
                if (document.all.NSComercial.value == 1 || document.all.NSCliente.value == 1 || document.all.NSUsuario.value == 1 || 
                document.all.NSJefe.value == 1 || document.all.NSGCP.value == 1 || document.all.NSProveedor.value == 1){
                    document.all.btnGuarda.disabled=false;
                }else{
                    document.all.btnGuarda.disabled=true;
                }
                
            }
            
            function fnFechasolucion()
            {
                if (document.all.clEstatusQueja.value==4 || document.all.clEstatusQueja.value==5 || document.all.clEstatusQueja.value==6){
                    document.all.FechaSolucion.value = document.all.StrFecha.value;
                }else{
                    document.all.FechaSolucion.value = "";
                }
            }

            function fnLlenaQueja(){
                var strConsulta = "sp_GetQueja '" + document.all.clAsistencia2.value + "'";
                var pstrCadena = "../servlet/Utilerias.LlenaCombos?strSQL=" + strConsulta;
                document.all.clQueja.value = '';
                pstrCadena = pstrCadena + "&strName=clQuejaC";
                fnOptionxDefault('clQuejaC',pstrCadena);
            }

            function fnhabilita(){
                if(document.all.clEstatusQueja.value==1 || document.all.clEstatusQueja.value==2 || document.all.clEstatusQueja.value==3){
                    document.all.Solucion.disabled= true;
                }else{
                    document.all.Solucion.disabled= false;
                }
            }

            function fnRequiere(){
                if(document.all.Action.value!=1){
                    if(document.all.clEstatusQueja.value==1 || document.all.clEstatusQueja.value==2 || document.all.clEstatusQueja.value==3){
                        if(document.all.ObservacionesArea.value==""){
                            msgVal= msgVal + ',' + document.all.ObservacionesArea.name
                            document.all.btnGuarda.disabled=false;
                            document.all.btnCancela.disabled=false;
                        }
                    }else{
                        if(document.all.clEstatusQueja.value==4 || document.all.clEstatusQueja.value==5 || document.all.clEstatusQueja.value==6){
                            if(document.all.ObservacionesSup.value==""){
                                msgVal= msgVal + ', ' + document.all.ObservacionesSup.name
                                document.all.btnGuarda.disabled=false;
                                document.all.btnCancela.disabled=false;
                            }
                            if(document.all.ObservacionesArea.value==""){
                                msgVal= msgVal + ', ' + document.all.ObservacionesArea.name
                                document.all.btnGuarda.disabled=false;
                                document.all.btnCancela.disabled=false;
                            }
                            if(document.all.Solucion.value==""){
                              msgVal= msgVal + ', ' + document.all.Solucion.name
                              document.all.btnGuarda.disabled=false;
                              document.all.btnCancela.disabled=false;
                            }
                    }
                }
            }else{}
                if(document.all.clTipoSolQueja.value=="" && (document.all.clEstatusQueja.value==4 || document.all.clEstatusQueja.value==6)){
                    msgVal= msgVal + ', Tipo de Solucion'
                    document.all.btnGuarda.disabled=false;
                    document.all.btnCancela.disabled=false;
                }
                    /*
                 if(document.all.clAceptacionDanoC.checked==1){
                              msgVal= msgVal + ' Fecha Aceptaci�n.';
                              document.all.btnGuarda.disabled=false;
                              document.all.btnCancela.disabled=false;
                 }*/
            }

            function fn_Soluciono(NSolucion){
                //alert(NSolucion);
                if (NSolucion > 3 ){
                    document.all.Soluciono.style.visibility = "visible";
                }else{
                    if (NSolucion < 4){
                        document.all.Soluciono.style.visibility = "hidden";
                    }
                }
            }

            function fn_MuestraDetalleDanos(MuestraDetalleDano){
                //alert(MuestraDetalleDano);
                if (MuestraDetalleDano == 1){
                    document.all.DetalleDanos.style.visibility = "visible";
                }else{
                    document.all.DetalleDanos.style.visibility = "hidden";
                }
            }


            function fn_LLenaSubDano(){
                //alert("clDano.."+document.all.clDanoC.value);
                var strConsulta = "sp_TraeSubDano '" + document.all.clDanoC.value + "'";
                //alert("strConsulta.."+strConsulta);
                //alert("Localizacion...."+document.location)
                var pstrCadena = "../servlet/Utilerias.LlenaCombos?strSQL=" + strConsulta;
                pstrCadena = pstrCadena + "&strName=clSubDanoC";//nombre variable de campo llave del segundo combo
                //alert("pstrCadena.."+pstrCadena);
                fnOptionxDefault('clSubDanoC',pstrCadena);      // nombre variable de campo llave del segundo combo
            }

            function fn_HayPago(pOpcionPago){                
                if (pOpcionPago != 4){
                    document.all.HayPago.style.visibility = "visible";
                }else{
                    document.all.HayPago.style.visibility = "hidden";
                }
            }

            function fn_AceptaDano(pAceptaDano){                               
                if (pAceptaDano == 1){
                    document.all.AceptaDano.style.visibility = "visible";
                }else{
                    document.all.AceptaDano.style.visibility = "hidden";
                }                
            }

            function fn_ChecaDano(){                
                if (document.all.clQueja.value == 1){
                    fn_HayPago(document.all.clTipoPagoDano.value);
                    fn_AceptaDano(document.all.clAceptacionDano.value);
                    fn_Soluciono(document.all.clEstatusQueja.value);
                }
            }
        </script>
    </body>
</html>