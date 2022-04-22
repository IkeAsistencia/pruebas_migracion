<%@ page contentType="text/html;charset=windows-1252"%>
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
<body topmargin=0 leftmargin=0 class="cssBody"  background="../Imagenes/EncabezadoLogoIke.jpg">
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
    <title>Actualiza Centro de Comando Piso 3</title>
  </head>
  <center><table width="800">
    <tr valign="center">
      <td height="70" align="center" class="cssTituloPlasma" id="LabelMon" name="LabelMon" >Asistencia Legal</td>
    </tr>
  </table>
  </center>
  <INPUT type="hidden" size="5" name='Counter' id='Counter' value=''></input>
<script>
var gWindowCloseWait=10;
var gTipoInfo=4;

function SetupWindowClose(){
    window.setTimeout("window.CloseW()",1000);
}
function CloseW(){
    document.all.Counter.value=gWindowCloseWait;

    if (gWindowCloseWait>0){
        gWindowCloseWait--;
        window.setTimeout("window.CloseW()",1000);
    }
    else{
      top.frames[1].document.location.href="CentrodeComando.jsp?Tipo="+gTipoInfo;
      switch(gTipoInfo){
        case 2 : document.all.LabelMon.innerHTML="Asistencia Médica"; gWindowCloseWait = 10; break;
        case 3 : document.all.LabelMon.innerHTML="Asistencia en Viajes";gWindowCloseWait = 5;  break;
        case 4 : document.all.LabelMon.innerHTML="Asistencia Legal"; gWindowCloseWait = 30; break;
        case 5 : document.all.LabelMon.innerHTML="Asistencia Hogar"; gWindowCloseWait = 10; break;
        case 6 : document.all.LabelMon.innerHTML="Grúas por Colisión"; gWindowCloseWait = 15; break;
        case 7 : document.all.LabelMon.innerHTML="Ajustadores"; gWindowCloseWait = 15; break;
        default: document.all.LabelMon.innerHTML="Asistencia Legal"; gWindowCloseWait = 30; break;
      }
      gTipoInfo++;
      
      
      if (gTipoInfo==8){gTipoInfo=2}
      SetupWindowClose();
    }
}

var gSafeOnload = new Array();
function SafeAddOnload(f)
{
	isMac = (navigator.appVersion.indexOf("Mac")!=-1) ? true : false;
	IEmac = ((document.all)&&(isMac)) ? true : false;
	IE4 = ((document.all)&&(navigator.appVersion.indexOf("MSIE 4.")!=-1)) ? true : false;
	if (IEmac && IE4)  // IE 4.5 blows out on testing window.onload
	{
		window.onload = SafeOnload;
		gSafeOnload[gSafeOnload.length] = f;
	}
	else if  (window.onload)
	{
		if (window.onload != SafeOnload)
		{
			gSafeOnload[0] = window.onload;
			window.onload = SafeOnload;
		}		
		gSafeOnload[gSafeOnload.length] = f;
	}
	else
		window.onload = f;

}
function SafeOnload()
{
	for (var i=0;i<gSafeOnload.length;i++)
		gSafeOnload[i]();
}

// Call the following with your function as the argument
SafeAddOnload(SetupWindowClose);
</script> 

  </body>
</html>
