<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
<head><title>JSP Page</title>
<style type="text/css">
.style1 {font-family: Arial, Helvetica, sans-serif}
.style2 {font-family: Arial, Helvetica, sans-serif; font-weight: bold; }
.style3 {font-family: Arial, Helvetica, sans-serif; font-weight: bold; font-size: 36px; }
</style>
</head>
<body bgcolor='white'
onload='hide("boton");'
>
<%  
    String StrCaucion = "0";
    String StrSolicitud = "";

    if (request.getParameter("clCaucion")!= null)
    {
        StrCaucion= request.getParameter("clCaucion").toString(); 
    } 

    if (request.getParameter("Solicitud")!= null)
    {
        StrSolicitud= request.getParameter("Solicitud").toString(); 
    } 

    StringBuffer StrSql = new StringBuffer ();
    
    StrSql.append(" Select E.clExpediente 'Siniestro',C.FolioCaucion 'FolioCaucion',UPPER(CC.Nombre) 'Cuenta',convert(varchar(16),E.FechaRegistro,103) as FechaRegistro,UPPER(VN.Conductor) 'Conductor',EF.dsEntFed,MD.dsMunDel,");
    StrSql.append(" case when (len(convert(varchar,(convert(int,(C.MontoObProc+C.MontoSusAct+C.MontoRepDan+C.MontoSanPec)))))/3)*3/2=0 and len(convert(varchar,(convert(int,(C.MontoObProc+C.MontoSusAct+C.MontoRepDan+C.MontoSanPec)))))%3>0  then convert(varchar,(convert(int,(C.MontoObProc+C.MontoSusAct+C.MontoRepDan+C.MontoSanPec))))+'.00'  ");
    StrSql.append(" when (len(convert(varchar,(convert(int,(C.MontoObProc+C.MontoSusAct+C.MontoRepDan+C.MontoSanPec)))))/3)*3/2=1 and len(convert(varchar,(convert(int,(C.MontoObProc+C.MontoSusAct+C.MontoRepDan+C.MontoSanPec)))))%3=0  then      convert(varchar,(convert(int,(C.MontoObProc+C.MontoSusAct+C.MontoRepDan+C.MontoSanPec))))+'.00' ");
    StrSql.append(" when (len(convert(varchar,(convert(int,(C.MontoObProc+C.MontoSusAct+C.MontoRepDan+C.MontoSanPec)))))/3)*3/2=1 and len(convert(varchar,(convert(int,(C.MontoObProc+C.MontoSusAct+C.MontoRepDan+C.MontoSanPec)))))%3>0  then left(convert(varchar,(convert(int,(C.MontoObProc+C.MontoSusAct+C.MontoRepDan+C.MontoSanPec)))),len(convert(varchar,(convert(int,(C.MontoObProc+C.MontoSusAct+C.MontoRepDan+C.MontoSanPec)))))-3)+ ','+    right((convert(varchar,(convert(int,(C.MontoObProc+C.MontoSusAct+C.MontoRepDan+C.MontoSanPec))))),3)+'.00' ");
    StrSql.append(" when (len(convert(varchar,(convert(int,(C.MontoObProc+C.MontoSusAct+C.MontoRepDan+C.MontoSanPec)))))/3)*3/2>2 and len(convert(varchar,(convert(int,(C.MontoObProc+C.MontoSusAct+C.MontoRepDan+C.MontoSanPec)))))%3=0  then left(convert(varchar,(convert(int,(C.MontoObProc+C.MontoSusAct+C.MontoRepDan+C.MontoSanPec)))),len(convert(varchar,(convert(int,(C.MontoObProc+C.MontoSusAct+C.MontoRepDan+C.MontoSanPec)))))-3)+ ','+    right((convert(varchar,(convert(int,(C.MontoObProc+C.MontoSusAct+C.MontoRepDan+C.MontoSanPec))))),3)+'.00' ");
    StrSql.append(" when (len(convert(varchar,(convert(int,(C.MontoObProc+C.MontoSusAct+C.MontoRepDan+C.MontoSanPec)))))/3)*3/2=3 and len(convert(varchar,(convert(int,(C.MontoObProc+C.MontoSusAct+C.MontoRepDan+C.MontoSanPec)))))%3>=0 then left(convert(varchar,(convert(int,(C.MontoObProc+C.MontoSusAct+C.MontoRepDan+C.MontoSanPec)))),len(convert(varchar,(convert(int,(C.MontoObProc+C.MontoSusAct+C.MontoRepDan+C.MontoSanPec)))))-6)+','+ substring(convert(varchar,(convert(int,(C.MontoObProc+C.MontoSusAct+C.MontoRepDan+C.MontoSanPec)))),len(convert(varchar,(convert(int,(C.MontoObProc+C.MontoSusAct+C.MontoRepDan+C.MontoSanPec)))))-5,3)+ ','+ right(convert(varchar,(convert(int,(C.MontoObProc+C.MontoSusAct+C.MontoRepDan+C.MontoSanPec)))),3)+'.00'  ");
    StrSql.append(" end MontoTotal, P.NombreOpe,D.dsDelito 'Delito',C.MontoObProc,C.MontoSusAct,C.MontoRepDan,C.MontoSanPec,UPPER(TL.dsTipoLibera) 'Liberacion' ");
    StrSql.append(" from Caucion C");
    StrSql.append(" inner join Expediente E on (E.clExpediente=C.clExpediente)");
    StrSql.append(" inner join cCuenta CC on (CC.clCuenta=E.clCuenta)");
    StrSql.append(" inner join VehiculoInvNU VN on (VN.clExpediente=C.clExpediente)");
    StrSql.append(" inner join cEntFed EF on (EF.CodEnt=E.CodEnt)");
    StrSql.append(" inner join cMunDel MD on (MD.CodEnt=E.CodEnt and MD.CodMD=E.CodMD)");
    StrSql.append(" inner join cProveedor P on (P.clProveedor=C.clProveedorExhibe)");
    StrSql.append(" inner join DelitoEvento DE on (DE.clDelitoEvento=C.clDelitoEvento)");
    StrSql.append(" inner join cDelito D on (D.clDelito=DE.clDelito) ");
    StrSql.append(" inner join cTipoLibera TL on (TL.clTipoLibera=C.clTipoLibera) "); 
    StrSql.append(" Where C.clCaucion=").append(StrCaucion);
    
        
      ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
      StrSql.delete(0,StrSql.length());
         
       if (rs.next()) {
           
           String StrFolioCaucion=rs.getString("FolioCaucion");
           String StrExpediente=rs.getString("Siniestro");
           String StrCuenta=rs.getString("Cuenta");
           String StrFecha=rs.getString("Fecharegistro");
           String StrConductor=rs.getString("Conductor");
           String StrdsEntFed=rs.getString("dsEntFed");
           String StrdsMunDel=rs.getString("dsMunDel");
           String StrOperador=rs.getString("NombreOpe");
           String StrDelito=rs.getString("Delito");
           String StrLiberacion=rs.getString("Liberacion");
           String StrMonto=rs.getString("MontoTotal");

           
    if (request.getParameter("folio")!= null)
    {
        StrFolioCaucion= request.getParameter("folio").toString(); 
    } 
            %>
            <div id="boton" style="position:absolute;width:250px;left:600;top:10;visibility:visible">
            <input type='button' name='btnPrint' value='Imprimir' onclick='hide("CON");hide("boton");print();show("boton");'>
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
                  <p align="center" class="style3">C</p>
                  <p align="right" class="style2">FOLIO DE CAUCI&Oacute;N No. 
                  <% if (request.getParameter("folio")!= null) { 
                  %>
                  <%=StrFolioCaucion%>
                  <% } else { %>
                    <form name='solicitud' action='ImpresionCaucion.jsp?' id='solicitud'>
                    <input name='folio' id='folio' type='text' maxlength="4" size="4" value='<%=StrFolioCaucion%>'  onKeyPress='return acceptNum(event);'></input>
                    <% } %>
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
                    <br>FOR&Aacute;NEO </p>
                  <p class="style2">C.P. CARLOS E. RIOS ARIAS<br>
                    DIRECTOR ADMINISTRATIVO Y FINANZAS<BR>
                    P R E S E N T E</p>
                  
                  <p class=style2 style='text-align:justify;line-height:150%;mso-outline-level:2'>Por este conducto me permito hacer de su conocimiento, que se requiere (ri&oacute;) una CAUCIÓN en el SINIESTRO No. <%=StrExpediente%> de la cuenta <%=StrCuenta%> de fecha <%=StrFecha%> del conductor de nombre <%=StrConductor%> del estado de <%=StrdsEntFed%> en la localidad de <%=StrdsMunDel%> por la cantidad de $<%=StrMonto%> por el LIC. <%=StrOperador%> por el delito de <%=StrDelito%> a efecto de garantizar REPARACI&Oacute;N DE DA&Ntilde;O. <BR>
                    LIBERACI&Oacute;N DE <%=StrLiberacion%>.</p>
                  <p class=style2 style='text-align:justify;line-height:150%;mso-outline-level:1'>Por lo anterior solicito: 
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
                   }
                    else { 
                    %>
                    </p>
                    <div name='CON' ID='CON'>
                    
                    <input name='Solicitud' id='Solicitud' type="text" maxlength="300" SIZE="70" class="VTable"></input>
                    <input type='hidden' id='clCaucion' name='clCaucion' value='<%=StrCaucion%>'>
                    <input type="Button" value="Vista Previa" onClick="fntexto(document.solicitud.Solicitud.value);return Enviar(this.form);"></input>
                    </form>  
                    </div>
                    <%
                    }
                    %>
                  <p align="center" class="style2">A T E N T A M E N T E</p>
                  <p align="center" class="style1">&nbsp;</p>
                  <p align="center" class="style1">&nbsp;</p>
                  <p align="center" class="style1">________________________<BR>
                    <strong>Lic. Sergio A. P&eacute;rez Guill&eacute;n <BR>
                  Director de Operaci&oacute;n Jur&iacute;dica</strong></p>
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
              
        }
       else {
            %> El Expediente no Tiene Caución
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
    location.href = ('ImpresionCaucion.jsp?clCaucion='+ <%=StrCaucion%>);

}

<%       StrCaucion = null;%>

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