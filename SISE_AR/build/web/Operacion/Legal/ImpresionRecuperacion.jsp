<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC,java.text.*" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
<head><title>JSP Page</title>
<style type="text/css">
.style1 {font-family: Arial, Helvetica, sans-serif}
.style2 {font-family: Arial, Helvetica, sans-serif; font-weight: bold; }
.style3 {font-family: Arial, Helvetica, sans-serif; font-weight: bold; font-size: 36px; }
</style>
</head>
<body bgcolor='white' onload='hide("boton");'>
<%  

    String StrRecuperacion = "0";
    String StrRecuperacion2 = "0";
    if (request.getParameter("clRecuperacion")!= null)
    {
        StrRecuperacion= request.getParameter("clRecuperacion").toString();
        StrRecuperacion2=request.getParameter("clRecuperacion").toString();
    } 
    StringBuffer StrSql = new StringBuffer ();              
    
    StrSql.append(" Select case when (len(convert(varchar,R.MontoRecuperado))/3)*3/2=0 and len(convert(varchar,R.MontoRecuperado))%3>0  then convert(varchar,R.MontoRecuperado)+'.00' when (len(convert(varchar,R.MontoRecuperado))/3)*3/2=1 and len(convert(varchar,R.MontoRecuperado))%3=0  then convert(varchar,R.MontoRecuperado)+'.00'when (((len(convert(varchar,R.MontoRecuperado))/3)*3/2)=1 and len(convert(varchar,R.MontoRecuperado))%3>0) then left(convert(varchar,R.MontoRecuperado),len(convert(varchar,R.MontoRecuperado))-3)+ ','+ right(convert(varchar,R.MontoRecuperado),3)+'.00' when (((len(convert(varchar,R.MontoRecuperado))/3)*3/2)>2 and len(convert(varchar,R.MontoRecuperado))%3=0) then left(convert(varchar,R.MontoRecuperado),len(convert(varchar,R.MontoRecuperado))-3)+ ','+ right(convert(varchar,R.MontoRecuperado),3)+'.00'when (((len(convert(varchar,R.MontoRecuperado))/3)*3/2)=3 and len(convert(varchar,R.MontoRecuperado))%3>=0) then left(convert(varchar,R.MontoRecuperado),len(convert(varchar,R.MontoRecuperado))-6)+','+ substring(convert(varchar,R.MontoRecuperado),len(convert(varchar,R.MontoRecuperado))-5,3)+ ','+ right(convert(varchar,R.MontoRecuperado),3)+'.00' end 'MRecuperado',");
    StrSql.append(" P.NombreOpe 'Proveedor',");
    StrSql.append(" EM.dsEmpresaSEA,CA.FolioCaucion 'FCaucion', convert(varchar,E.FechaRegistro,106) 'FechaExpediente',");
    StrSql.append(" E.clExpediente 'Siniestro',CC.Nombre 'Cuenta',");
    StrSql.append(" convert(varchar,CA.FechaExped,106) 'FechaCaucion',");
    StrSql.append(" UPPER(VN.Conductor) 'Conductor',EF.dsEntFed 'Estado',MD.dsMunDel 'Municipio',D.dsDelito 'Delito',R.FolioRecuperacion");
    StrSql.append(" from Recuperacion R ");
    StrSql.append(" inner join Caucion CA on (R.clCaucion=CA.clCaucion)");
    StrSql.append(" inner join Expediente E on (E.clExpediente=CA.clExpediente)");
    StrSql.append(" inner join cCuenta CC on (CC.clCuenta=E.clCuenta)");
    StrSql.append(" inner join VehiculoInvNU VN on (VN.clExpediente=CA.clExpediente)");
    StrSql.append(" inner join cEntFed EF on (EF.CodEnt=E.CodEnt)");
    StrSql.append(" inner join cMunDel MD on (MD.CodEnt=E.CodEnt and MD.CodMD=E.CodMD)");
    StrSql.append(" inner join cProveedor P on (P.clProveedor=R.clProveedorRecupera)");
    StrSql.append(" inner join DelitoEvento DE on (DE.clDelitoEvento=CA.clDelitoEvento)");
    StrSql.append(" inner join cDelito D on (D.clDelito=DE.clDelito)"); 
    StrSql.append(" inner join cEmpresaSEA EM on (EM.clEmpresaSEA=CC.clEmpresaSEA)"); 
    StrSql.append(" inner join ProveedorxExpediente PE on (PE.clExpediente=E.clExpediente)");
    StrSql.append(" where R.clRecuperacion=").append(StrRecuperacion);
    StrSql.append(" and PE.Titular=1");
    
      ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
      StrSql.delete(0,StrSql.length());
      
       if (rs.next()) {
           
           String StrFolioCaucion=rs.getString("FCaucion");
           String StrExpediente=rs.getString("Siniestro");
           String StrCuenta=rs.getString("Cuenta");
           String StrFechaCaucion=rs.getString("FechaExpediente");
           String StrConductor=rs.getString("Conductor");
           String StrdsEntFed=rs.getString("Estado");
           String StrdsMunDel=rs.getString("Municipio");
           String StrOperador=rs.getString("Proveedor");
           String StrDelito=rs.getString("Delito");
           String StrMontoRecuperado=rs.getString("MRecuperado");
           String StrFechaRecuperacion=rs.getString("FechaCaucion");
           String StrEmpresaSEA=rs.getString("dsEmpresaSEA");
           String strFolioRecuperacion = rs.getString("FolioRecuperacion");
          
               if (request.getParameter("folio")!= null)
    {
        StrRecuperacion= request.getParameter("folio").toString(); 
    } 
           if (request.getParameter("foliocaucion")!= null)
    {
        StrFolioCaucion= request.getParameter("foliocaucion").toString(); 
     }
           %>
            <div id="boton" style="position:absolute;width:250px;left:600;top:10;visibility:visible">
            <input type='button' name='btnPrint' value='Imprimir' onclick='hide("boton");print();show("boton");'>
            </div>
            
            <table width="650"  border="0" cellspacing="0" cellpadding="0" align="center">                                  
            <tr>
                <td><p><span class="style2">M&eacute;xico D.F. a </span><span class="style1">
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
                    document.write("<small><font color='000000' face='Arial'>"+ dayarray[day] + ", " + daym + " de " + montharray[month] + " de " + year + "</font></small>");
                    </script>                      
                </span></p>
                  <p align="center" class="style3">R</p>
                  <p align="right" class="style2">FOLIO DE RECUPERACI&Oacute;N DE CAUCI&Oacute;N No. 
                  <%
                        if (request.getParameter("folio")!= null){
                        %>
                        <%=StrRecuperacion%>  
                    <script>
                    var mydate=new Date();
                    var year=mydate.getYear();
                    if (year-2000<10)
                    {
                    year=year-2000;
                    document.write ("/0" + year);}
                    else { document.write ("/" + year); }
                    </script> 
                    <br>
                    <br>FOR&Aacute;NEO 
                  </p><div name='CON' id='CON'><input type="button" value="Corregir" onclick="fnregresar();"><input type='button' value='Aceptar' onclick="hide('CON');show('boton');"></div>
                 
                        <% } else { %>
                    <form name='CON' id='CON' action='ImpresionRecuperacion.jsp?' >
                    <input type='text' value='<%=strFolioRecuperacion%>' maxlength="4" size="4" name="folio" id="folio" onKeyPress='return acceptNum(event);'></input>
                    <input type='hidden' value='<%=StrRecuperacion2%>' name='clRecuperacion' id='clRecuperacion'></input>
                    <input type='submit' value='Vista Previa' onClick="return Enviar(this.form)">
                    
                    <script>
                    var mydate=new Date();
                    var year=mydate.getYear();
                    if (year-2000<10)
                    {
                    year=year-2000;
                    document.write ("/0" + year);}
                    else { document.write ("/" + year); }
                    </script> 
                    <br>
                    <br>FOR&Aacute;NEO 
                  </p>
                    <% } %>                   
                  <p class="style2">C.P. CARLOS E. R&Iacute;OS ARIAS<br>
                    DIRECTOR ADMINISTRATIVO Y FINANZAS<BR>
                    P R E S E N T E</p>
                  
                  <p class=style2 style='text-align:justify;line-height:150%;mso-outline-level:2'>Por este conducto me permito hacer de su conocimiento, que fue  recuperada la cantidad de $<%=StrMontoRecuperado%> por el Lic. <%=StrOperador%>, quién reintegró a favor de <%=StrEmpresaSEA%>, según comprobante anexo. <BR>
                    <span style='mso-spacerun:yes'>    </span>FICHA DE DEPOSITO ___________<span style='mso-spacerun:yes'>      </span>RECUPERACION TOTAL: $<%=StrMontoRecuperado%><br>
                    <span style='mso-spacerun:yes'>    </span>EFECTIVO ______________ <br>
                    Lo anterior, con respecto a la caución solicitada con el Folio No. 
                    <%  if (request.getParameter("foliocaucion")!= null){ %>
                    <%=StrFolioCaucion%>
                    <% } else { %>
                     <input type='text' value='<%=StrFolioCaucion%>' maxlength="4" size="5" name='foliocaucion' id='foliocaucion' onKeyPress='return acceptNum(event);'></input>
                    <% } %>
                    de fecha <%=StrFechaRecuperacion%> en el SINIESTRO No. <%=StrExpediente%>  de la cuenta <%=StrCuenta%> de fecha <%=StrFechaCaucion%> del conductor de nombre <%=StrConductor%> del estado de <%=StrdsEntFed%> en la localidad <%=StrdsMunDel%> otorgada por la cantidad de $<%=StrMontoRecuperado%> por el Lic. <%=StrOperador%>  por el delito de <%=StrDelito%>.
                    </form></p>
                  <p class=style2 style='text-align:justify;line-height:150%;mso-outline-level:1'>Sin otro particular por el momento. </p>
                  <p align="center" class="style2">A T E N T A M E N T E</p>
                  <p align="center" class="style1">&nbsp;</p>
                  <p align="center" class="style1">&nbsp;</p>
                  <p align="center" class="style1">____________________________<BR><BR>
                    <strong>LIC. SERGIO A. P&Eacute;REZ GUILL&Eacute;N <BR>
                  DIRECTOR DE OPERACI&Oacute;N JUR&Iacute;DICA</strong></p>
                  </td>
              </tr>
            </table>
          
            <%
              
        }
       else {
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
    location.href = ('ImpresionRecuperacion.jsp?clRecuperacion='+ <%=StrRecuperacion2%>);

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
</script>

</body>
</html>