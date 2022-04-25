<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC,java.text.*" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head><title>JSP Page</title>
        <style type="text/css">
            .style1 {font-family: Arial, Helvetica, sans-serif; font-size: 13px;}
            .style2 {font-family: Arial, Helvetica, sans-serif; font-weight: bold; }
            .style3 {font-family: Arial, Helvetica, sans-serif; font-weight: bold; font-size: 36px; }
        </style>
    </head>
    <body bgcolor='white' onload='hide("boton");'>    
        <%  

            String StrRecuperacion = "0";
            String StrRecuperacion2 = "0";
            String StrCoordinador = "";
            String StrEjecutivo = "";
            String StrExterno = "0";
            String StrRegional = "0";
            
            if (request.getParameter("clRecuperaDanos")!= null) {
                StrRecuperacion= request.getParameter("clRecuperaDanos").toString();
                StrRecuperacion2=request.getParameter("clRecuperaDanos").toString();
            }
            StringBuffer StrSql = new StringBuffer();

            StrSql.append(" Select RD.Folio,ES.dsEstatus,RD.clExpediente,C.dsCuenta,VI.NoSiniestro,VI.Conductor,");
            StrSql.append(" (RD.MontoCheque + RD.MontoPagare + RD.MontoGaran + RD.MontoEfectivo + RD.MontoPasMed + RD.MontoOrdRep) 'Monto',");
            StrSql.append(" Cast(Coalesce(Porcentaje,'0.0') as varchar) 'Porcentaje',ENT.dsEntFed,MD.dsMunDel,P.NombreOpe 'Titular',PR.NombreOpe 'Recupera'");
            StrSql.append(" from RecuperaDanos RD");
            StrSql.append(" inner join Expediente E on (E.clExpediente = RD.clExpediente)");
            StrSql.append(" inner join cEstatus ES on (ES.clEstatus = E.clEstatus)");            
            StrSql.append(" inner join cCuenta C on (C.clCuenta = E.clCuenta)");
            StrSql.append(" inner join VehiculoInvNU VI on(VI.clExpediente = RD.clExpediente)");
            StrSql.append(" inner join cEntFed ENT on (ENT.CodEnt = E.CodEnt)");
            StrSql.append(" inner join cMunDel MD on (MD.CodEnt = E.CodEnt And MD.CodMD= E.CodMD)");
            StrSql.append(" inner join ProveedorxExpediente PE on((PE.clExpediente = RD.clExpediente) And PE.Titular = 1)");
            StrSql.append(" inner join cProveedor P on (P.clProveedor = PE.clProveedor)");
            StrSql.append(" inner join cProveedor PR on (PR.clProveedor = RD.clProveedor)");
            StrSql.append(" Where RD.clRecuperaDanos =").append(StrRecuperacion);


            ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
            StrSql.delete(0,StrSql.length());

            if (rs.next()) {

                String StrFolioRecDan=rs.getString("Folio");
                String StrEstatus=rs.getString("dsEstatus");
                String StrExpediente=rs.getString("clExpediente");                
                String StrCuenta=rs.getString("dsCuenta");
                String StrNoSiniestro = rs.getString("NoSiniestro");
                String StrConductor=rs.getString("Conductor");
                String StrMontoRecuperado=rs.getString("Monto");
                String StrProcentaje = rs.getString("Porcentaje");
                String StrdsEntFed=rs.getString("dsEntFed");
                String StrdsMunDel=rs.getString("dsMunDel");
                String StrOperadorT=rs.getString("Titular");
                String StrOperadorR=rs.getString("Recupera");

                if (request.getParameter("folio")!= null) {
                    StrRecuperacion= request.getParameter("folio").toString();
                }
                
                if (request.getParameter("Coordinador")!= null) {
                    StrCoordinador= request.getParameter("Coordinador").toString();
                }
                
                if (request.getParameter("Ejecutivo")!= null) {
                    StrEjecutivo= request.getParameter("Ejecutivo").toString();
                }
                
                if (request.getParameter("ExternoVTR")!= null){
                    StrExterno = request.getParameter("ExternoVTR");
                }
                
                 if (request.getParameter("RegionalVTR")!= null){
                    StrRegional = request.getParameter("RegionalVTR");
                }
                

        %>
        <div id="boton" style="position:absolute;width:250px;left:600;top:10;visibility:visible">
            <input type='button' name='btnPrint' value='Imprimir' onclick='hide("boton");print();show("boton");'>
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
                </span></p><br><br>
                    <p align="right" class="style2">FOLIO DE RECUPERACI&Oacute;N DE DAÑOS No. 
                        <%
                            if (request.getParameter("folio")!= null){
                        %>
                        <font size="5"><%=StrRecuperacion%>  
                        <script>
                            var mydate=new Date();
                            var year=mydate.getYear();
                            if (year-2000<10)
                            {
                            year=year-2000;
                            document.write ("/0" + year);}
                            else { document.write ("/" + year); }
                        </script> </font>
                        <br>
                        <br><%=StrEstatus%>
                    </p><div name='CON' id='CON'><input type="button" value="Corregir" onclick="fnregresar();"><input type='button' value='Aceptar' onclick="hide('CON');show('boton');"></div>
                 
                    <% } else { %>
                        <form name='CON' id='CON' action='ImpresionRecuperacionDanos.jsp?' >                          
                        <input type='text' value='<%=StrRecuperacion%>' maxlength="4" size="4" name="folio" id="folio" onKeyPress='return acceptNum(event);'></input>
                        <input type='hidden' value='<%=StrRecuperacion2%>' name='clRecuperaDanos' id='clRecuperaDanos'></input>
                        
                        <font size="6">
                        <script>
                            var mydate=new Date();
                            var year=mydate.getYear();
                            if (year-2000<10)
                            {
                            year=year-2000;
                            document.write ("/0" + year);}
                            else { document.write ("/" + year); }
                        </script> </font>
                        <br>
                        <br><%=StrEstatus%> 
                        </p>
                        <% } %>                                          
                  
                        <p class=style1 style='text-align:justify;line-height:150%;mso-outline-level:2'>
                            EXPEDIENTE No.: <b><%=StrExpediente%></b><BR><BR>
                            CUENTA: <b><%=StrCuenta%></b><BR><BR>
                            SINIESTRO No.: <b><%=StrNoSiniestro%></b><BR><BR>
                            CONDUCTOR: <b><%=StrConductor%></b><BR><BR>
                            MONTO DE RECUPERACION: <b>$<%=StrMontoRecuperado%></b><BR><BR>
                            PORCENTAJE: <b><%=StrProcentaje%> %</b><BR><BR>
                            ESTADO: <b><%=StrdsEntFed%></b><BR><BR>
                            LOCALIDAD: <b><%=StrdsMunDel%></b><BR><BR>
                            ABOGADO TITULAR: <b><%=StrOperadorT%></b><BR><BR>
                            ABOGADO QUE RECUPERA: <b><%=StrOperadorR%></b><BR><BR>
                            EXTERNO (<%
                            if (request.getParameter("ExternoVTR")!= null){
                            %>
                            <%if(StrExterno.equalsIgnoreCase("1")){%><b>X</b><% } else { %>&nbsp;<% } %>
                            <% } else { %> 
                            <input type='hidden' name="ExternoVTR" id="ExternoVTR" value='0' >
                            <input type='checkbox' name="Externo" id="Externo" onclick="if(this.checked){document.all.Regional.checked = false;document.all.RegionalVTR.value=0;document.all.ExternoVTR.value=1;}else{document.all.ExternoVTR.value=0;}"></input>                            
                            <%}%>)&nbsp;&nbsp;&nbsp;
                            REGIONAL (<%
                            if (request.getParameter("RegionalVTR")!= null){
                            %>
                            <%if(StrRegional.equalsIgnoreCase("1")){%><b>X</b><% } else { %>&nbsp;<% } %>
                            <% } else { %> 
                            <input type='hidden' name="RegionalVTR" id="RegionalVTR" value='0' >
                            <input type='checkbox' name="Regional" id="Regional" onclick="if(this.checked){document.all.Externo.checked = false;document.all.ExternoVTR.value=0;document.all.RegionalVTR.value=1;}else{document.all.RegionalVTR.value=0;}"></input>                            
                            <%}%>)<BR><br>
                            COORDINADOR FORANEO O LOCAL: <%
                            if (request.getParameter("Coordinador")!= null){
                            %>
                            <b><%=StrCoordinador.toUpperCase()%></b><BR><BR>
                            <% } else { %>
                            <input type='text' maxlength="60" size="50" name="Coordinador" id="Coordinador"></input><BR><BR>
                            <% } %>
                            EJECUTIVO DE CUENTA: <%
                            if (request.getParameter("Ejecutivo")!= null){
                            %>
                            <b><%=StrEjecutivo.toUpperCase()%></b><BR><BR>
                            <% } else { %>
                            <input type='text' maxlength="60" size="50" name="Ejecutivo" id="Ejecutivo"></input><BR><BR>                            
                            <% } %>   
                            <%
                            if (request.getParameter("folio")== null){%><input type='submit' value='Vista Previa' onClick="return Enviar(this.form)"><%}%>
                        </form>
                        </p>                    
                    <p align="center" class="style1">&nbsp;</p>
                    <p align="center" class="style1">&nbsp;</p>
                    <p align="center" class="style1">&nbsp;</p>
                    <p align="center" class="style1">_______________________________<BR><BR>
                    <strong>SELLO DE RECIBIDO</strong></p>
                </td>
            </tr>
        </table>
          
        <%

            } else {
        %> El Expediente no Tiene Recuperación
        <%          
                }

                rs.close();
                rs=null;
                StrSql=null;
                StrRecuperacion = null;
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
            location.href = ('ImpresionRecuperacionDanos.jsp?clRecuperaDanos='+ <%=StrRecuperacion2%>);

            }

            function Enviar(form) {
            for (i = 0; i < form.elements.length; i++) {
            if (form.elements[i].type == "text" && form.elements[i].value == "" ) { 
            alert("Por favor, complete los campos del formulario"); form.elements[i].focus(); 
            return false; }                            
            }
            if (document.all.Regional.checked == false && document.all.Externo.checked == false) { 
            alert("Por favor, complete los campos del formulario"); 
            return false; 
            }            
            form.submit();
            }

            var nav4 = window.Event ? true : false;
            function acceptNum(evt){ 
            // NOTE: Backspace = 8, Enter = 13, '0' = 48, '9' = 57 
            var key = nav4 ? evt.which : evt.keyCode; 
            return (key <= 13 || (key >= 48 && key <= 57));
            }
        </script>
    </body>
</html>