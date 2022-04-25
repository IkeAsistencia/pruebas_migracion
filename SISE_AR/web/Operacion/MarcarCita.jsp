<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="Utilerias.UtileriasBDF" errorPage="" %>
<html>
<head>
<title></title>
</head>
<body class="cssBody">
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
<script src='../Utilerias/Util.js'></script>
<script src='../Utilerias/UtilMask.js'></script> 
<%  
    	String StrclExpediente = "0";
        String StrclUsrApp = "0";
        
      	if (session.getAttribute("clExpediente")!= null)
      	{
            StrclExpediente= session.getAttribute("clExpediente").toString(); 
       	} 
        
      	if (session.getAttribute("clUsrApp")!= null)
      	{
            StrclUsrApp= session.getAttribute("clUsrApp").toString(); 
       	}
%>                
        
       	
       	<form id='Forma' name ='Forma' action='../servlet/Utilerias.GuardaCita' method='get'>
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
        <input id='clUsrApp' name='clUsrApp' type='hidden' value='<%=StrclUsrApp%>'>
        
        <table><tr>
        <td class='VTable'>USUARIO: </td>
        <td><INPUT id='cUsrApp' name='cUsrApp' type='text' value=''></td>
        </tr>
        <tr>
        <td class='VTable'>PASSWORD: </td>
        <td><INPUT id='Password' name='Password' type='password' value=''></td>
        </tr>
        <tr>
        <td><input type="button" value="Guardar" onClick="this.disabled=true;document.all.Forma.submit();" ></input></td>
        </tr>
        </table>
        
        <div id='D11' Name='D11' class='VTable' style='position:absolute; z-index:11; left:30px; top:130px;'><p class='FTable'><INPUT type='hidden' value=0 id='Cita' name='Cita' ><INPUT class='VTable' type='checkbox' id='CitaC' name='CitaC' onClick="if (this.checked){Cita.value=1;} else{Cita.value=0;}fnFechaCita()" checked></INPUT>Cita Programada</P></div>
        <div id='D16' Name='D16' class='VTable' style='position:absolute; z-index:16; left:200px; top:130px;'><p class='FTable'>Fecha Programada<br>(aaaa/mm/dd hh:mm)<br><INPUT class='VTable' label='Fecha Programada<br>(aaaa/mm/dd hh:mm)'  onBlur='if(this.readOnly==false){fnValMask(this,document.all.FechaCitaMsk.value,this.name)};'  size=20 id='FechaCita' name='FechaCita' value=''></INPUT></p></div>
        <div class='cssBGDetSw' style='background-color:#052145; position:absolute; z-index:1; left:30px; top:120px; width:470px; height:70px;'><p class='cssTitDet'></p></div><div class='cssBGDet' style='position:absolute; z-index:2; left:20px; top:110px; width:470px; height:70px;'><p class='cssTitDet'>Cita</p></div>
        
<%
      StrclExpediente = null;
      StrclUsrApp=null;
%>
<input name='FechaCitaMsk' id='FechaCitaMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
       	</form>

<script>

function fnFechaCita(){
    if (document.all.Cita.value==1){
        document.all.FechaCita.disabled=false;
        }else{ 
        if (document.all.Cita.value==0){
            document.all.FechaCita.disabled=true;
            document.all.FechaCita.value="";
            
                }
            }
}

</script>
</body>
</html>

