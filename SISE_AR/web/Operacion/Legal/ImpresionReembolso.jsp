<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head><title>JSP Page</title>
        <style type="text/css">
            .style1 {font-family: Arial, Helvetica, sans-serif; font-size: 13px; }
            .style2 {font-family: Arial, Helvetica, sans-serif; font-weight: bold; }
            .style3 {font-family: Arial, Helvetica, sans-serif; font-weight: bold; font-size: 36px; }
        </style>
    </head>
    <body bgcolor='white'
        onload='hide("boton");'
        >
        <%             
            String StrclExpediente = "0";
            String StrSolicitud = "";
            String StrFolioReem = "";
            String StrEstatus="";
            String StrSiniestro="";
            String StrCuenta="";
            String StrFecha="";
            String StrNombre="";
            String StrdsEntFed="";
            String StrdsMunDel="";
            String StrMontoReemb="";
            String StrMotivoReem="";
            String StrOperador="";
            String StrFormaPago="";
            String StrclFormaPago="";
            String StrCuentaPago="";
            String StrDias="";
            String StrPlaza="";
            
            if (session.getAttribute("clExpediente")!= null) {
                StrclExpediente = session.getAttribute("clExpediente").toString();
            }

            if (request.getParameter("Solicitud")!= null) {
                StrSolicitud= request.getParameter("Solicitud").toString();
            }
            
            if (request.getParameter("dias")!= null) {
                StrDias= request.getParameter("dias").toString();
            }
            

            
            StringBuffer StrSql = new StringBuffer();

            StrSql.append(" Select R.Folio, EST.dsEstatus,E.clExpediente,C.dsCuenta,REPLACE ( convert(varchar(10),E.FechaSiniestro,120),'-','/') 'FechaSiniestro',R.Nombre,ENT.dsEntFed,MD.dsMunDel,coalesce(cast(R.MontoReemb as varchar),'0.00') 'MontoReemb',MR.dsMotivoReemb, ");
            StrSql.append(" P.NombreOpe,FP.clFormaPago,FP.dsFormaPago,coalesce(R.Cuenta,'') 'Cuenta',coalesce(R.Plaza,'') 'Plaza' ");
            StrSql.append(" from Expediente E ");
            StrSql.append(" inner join Reembolsos R on(R.clExpediente = E.clExpediente) ");
            StrSql.append(" inner join ProveedorxExpediente PE on((PE.clExpediente = E.clExpediente) And PE.Titular = 1) ");
            StrSql.append(" inner join cEstatus EST on (EST.clEstatus = E.clEstatus) ");
            StrSql.append(" inner join cCuenta C on (C.clCuenta = E.clCuenta) ");
            StrSql.append(" inner join cEntFed ENT on (ENT.CodEnt = E.CodEnt) ");
            StrSql.append(" inner join cMunDel MD on (MD.CodEnt = E.CodEnt And MD.CodMD= E.CodMD) ");
            StrSql.append(" inner join cProveedor P on (P.clProveedor = PE.clProveedor) ");
            StrSql.append(" inner join cFormaPago FP on (FP.clFormaPago = R.clFormaPago) ");
            StrSql.append(" inner join cMotivoReembolso MR on (MR.clMotivoReemb = R.clMotivoReemb) ");
            StrSql.append(" Where E.clExpediente = ").append(StrclExpediente);


            ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
            StrSql.delete(0,StrSql.length());

            if (rs.next()) {

                StrFolioReem=rs.getString("Folio");
                StrEstatus=rs.getString("dsEstatus");
                StrSiniestro=rs.getString("clExpediente");
                StrCuenta=rs.getString("dsCuenta");
                StrFecha=rs.getString("FechaSiniestro");
                StrNombre=rs.getString("Nombre");
                StrdsEntFed=rs.getString("dsEntFed");
                StrdsMunDel=rs.getString("dsMunDel");
                StrMontoReemb=rs.getString("MontoReemb");
                StrMotivoReem=rs.getString("dsMotivoReemb");
                StrOperador=rs.getString("NombreOpe");
                StrFormaPago=rs.getString("dsFormaPago");
                StrclFormaPago=rs.getString("clFormaPago");
                StrCuentaPago=rs.getString("Cuenta");
                StrPlaza=rs.getString("Plaza");
                


                if (request.getParameter("folio")!= null) {
                    StrFolioReem= request.getParameter("folio").toString();
                }
            %>
        <div id="boton" style="position:absolute;width:250px;left:600;top:10;visibility:visible">
            <input type='button' name='btnPrint' value='Imprimir' onclick='hide("CON");hide("boton");print();show("boton");'>
        </div>
            
        <table width="650"  border="0" cellspacing="0" cellpadding="0" align="center">                                  
            <tr>
                <td><p><span class="style1">M&eacute;xico D.F. a </span><span class="style1">
                    <script>
                        var mydate=new Date();
                        var year=mydate.getYear();
                        if (year < 1000)
                        year+=1900;
                        var day=mydate.getDay();
                        var month=mydate.getMonth();
                        var daym=mydate.getDate();
                        if (daym<10)
                        daym="0"+daym;
                        var dayarray=new Array("Domingo","Lunes","Martes","Miércoles","Jueves","Viernes","Sábado");
                        var montharray=new Array("Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre");
                        document.write("<font color='000000' face='Arial'>"+ dayarray[day] + ", " + daym + " de " + montharray[month] + " de " + year + "</font>");
                    </script>                      
                </span></p>
                <!--<p align="center" class="style3">C</p>-->
                <p align="right" class="style2">FOLIO DE REEMBOLSO No. 
                <% if (request.getParameter("folio")!= null) { 
                %>
                <font size="6"><%=StrFolioReem%></font>
                <% } else { %>
                <form name='solicitud' action='ImpresionReembolso.jsp?' id='solicitud'>
                    <input name='folio' id='folio' type='text' maxlength="4" size="4" value='<%=StrFolioReem%>'  onKeyPress='return acceptNum(event);'></input>
                    <% } %>
                    <script>
                        var mydate=new Date();
                        var year=mydate.getYear();
                        if (year-2000<10)
                        {
                        year=year-2000;
                        document.write ("<font size='6'>/0" + year + "</font>");}
                        else { document.write ("<font size='6'>/" + year + "</font>"); }
                    </script> 
                    <br><br>
                    <br><%=StrEstatus.toUpperCase()%> </p><br>
                    <p class="style2">C.P. ELVIRA ZARCO<br>
                    Departamento de Tesorer&iacute;a<BR>
                    P R E S E N T E</p><br>
                  
                    <p class=style1 style='text-align:justify;line-height:150%;mso-outline-level:2' >Por este conducto me permito informar a usted en el SINIESTRO No. <%="<b>"+StrSiniestro+"</b>"%> de la cuenta <%="<b>"+StrCuenta+"</b>"%> de fecha <%="<b>"+StrFecha+"</b>"%> del conductor y/o usuario de nombre <%="<b>"+StrNombre+"</b>"%> del estado de <%="<b>"+StrdsEntFed+"</b>"%> en la localidad de <%="<b>"+StrdsMunDel+"</b>"%> le reembolsar&aacute; la cantidad de <%="<b>$"+StrMontoReemb+"</b>"%> por concepto de pago de <%="<b>"+StrMotivoReem+"</b>"%> por <% if (request.getParameter("dias")!= null){%> <%=StrDias%><%}else{ %><input name='dias' id='dias' type='text' value='' size="2" onKeyPress='return acceptNumD(event);'></input><%}%> d&iacute;as, atendido por el LIC. <%="<b>"+StrOperador.trim()+".</b>"%>
                    </p><br><br>
                    <p class=style1 style='text-align:justify;line-height:150%;mso-outline-level:1'>Por lo anterior solicito se pague con: 
                        <br><br> <%="<b>"+StrFormaPago+"</b>"%>&nbsp;&nbsp;<% if (StrclFormaPago.equalsIgnoreCase("1")){ %><%="<b>"+StrNombre+"</b>"%><%}else{ if (StrclFormaPago.equalsIgnoreCase("2")){%><%="<b>"+StrCuentaPago+"</b>"%><%}else{%><%="<b>"+StrPlaza+"</b>"%><%}}%><br><br>
                        <%
                        if (StrSolicitud!=""){
                        %>
                        <%=StrSolicitud%>
                        <br>
                        <div name='CON' ID='CON'>
                            <input type='button' value='Corregir' onClick="fnregresar();">
                            <input type='button' value='Aceptar' onClick="hide('CON');show('boton');">
                        </div>
                    </p>
                    <%
                            } else {
                    %>
                    </p>
                    <div name='CON' ID='CON'>                    
                    <input name='Solicitud' id='Solicitud' type="text" maxlength="300" SIZE="70" class="VTable" value="Sin otro particular de momento."></input>                    
                    <input type="Button" value="Vista Previa" onClick="fntexto(document.solicitud.Solicitud.value);return Enviar(this.form);"></input>
                </form>  
                </div>
                <%
                                }
                %>
                <br>
                <p align="center" class="style2">A T E N T A M E N T E</p>
                <p align="center" class="style1">&nbsp;</p>
                <p align="center" class="style1">&nbsp;</p>
                <p align="center" class="style1">________________________________<BR>
                <strong>Lic. Sergio A. P&eacute;rez Guill&eacute;n <BR>
                Director Operaci&oacute;n Jur&iacute;dica </strong></p>
                <p class="style1">&nbsp;</p>
                <table width="80%" border="0" align="center" cellpadding="0" cellspacing="5">
                    <tr>
                        <td width="50%" class="style1"><p align="center">___________________________<BR>
                        <strong>NOMBRE Y FIRMA <BR>
                        AREA LOCAL </strong></p></td>
                        <td width="50%" class="style1"><p align="center">___________________________<BR>
                        <strong>NOMBRE Y FIRMA <BR>
                        AREA FOR&Aacute;NEA </strong></p></td>
                    </tr>
                </table>
                <p></p></td>
            </tr>
        </table>
          
        <%

            } else {
        %> El Expediente no Tiene Reembolso
        <%          
                }
            rs.close();
            rs=null;
            StrSql=null;
        %> 
        <script> 
            function hide(i) {
            if (document.all) {
            var ourhelp = eval ("document.all."+ i)
            ourhelp.style.visibility="hidden";
            }
            }

            function show(i) {
            if (document.all) {
            var ourhelp = eval ("document.all."+ i)
            ourhelp.style.visibility="visible";
            }
            }

            function fnregresar()
            {
            location.href = ('ImpresionReembolso.jsp?');
            }            

            function Enviar(form) {
            for (i = 0; i < form.elements.length; i++) {
            if (form.elements[i].type == "text" && form.elements[i].value == "") { 
            alert("Por favor, complete los campos del formulario"); form.elements[i].focus(); 
            return false; }
            }
            form.submit();
            }

            var nav4 = window.Event ? true : false;
            function acceptNum(evt){ 
            // NOTE: Backspace = 8, Enter = 13, '0' = 48, '9' = 57 
            var key = nav4 ? evt.which : evt.keyCode; 
            return (key <= 13 || (key >= 48 && key <= 57));
            }
            
            var nav5 = window.Event ? true : false;
            function acceptNumD(evt){ 
            // NOTE: Backspace = 8, Enter = 13, '0' = 48, '9' = 57 
            var key = nav5 ? evt.which : evt.keyCode; 
            return (key <= 13 || (key >= 48 && key <= 57));
            }


            function fntexto(i){
            var str= i;

            for (j=1;j<i.length;j++) {
            str= str.replace(/á/,"&aacute;");
            str= str.replace(/é/,"&eacute;");
            str= str.replace(/í/,"&iacute;");
            str=str.replace(/ó/,"&oacute;");
            str=str.replace(/ú/,"&uacute;");
            str= str.replace(/Á/,"&Aacute;");
            str= str.replace(/É/,"&Eacute;");
            str= str.replace(/Í/,"&Iacute;");
            str=str.replace(/Ó/,"&Oacute;");
            str=str.replace(/Ú/,"&Uacute;");
            str= str.replace(/ñ/,"&ntilde;");
            str= str.replace(/Ñ/,"&Ntilde;");
            str= str.replace(/ë/,"&euml;");
            str=str.replace(/ü/,"&uuml;");
            str=str.replace(/Ü/,"&Uuml;");
            str=str.replace(/Ë/,"&Euml;");
            }
            document.solicitud.Solicitud.value=str;

            //return Enviar(this.form);
            }
        </script>
    </body>
</html>