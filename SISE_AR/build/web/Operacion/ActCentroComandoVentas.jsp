<%@ page contentType="text/html;charset=windows-1252"%>
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
<body topmargin=0 leftmargin=0 class="cssBody" background="../Imagenes/EncabezadoLogoIke.jpg">
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
    <title>Actualiza Centro de Comando ARP</title>
  </head>
  <center><table width="800">
    <tr valign="center">
      <td height="70" align="center" class="cssTituloPlasma" id="LabelMon" name="LabelMon" >Asistencia Vial</td>
    </tr>
  </table>
  </center>
  <INPUT type="hidden" size="5" name='Counter' id='Counter' value=''></input>
<script>
var gWindowCloseWait = 20;
//var gTipoInfo = 2;

function SetupWindowClose(){
    window.setTimeout("window.CloseW()",20000);
}
function CloseW(){
    document.all.Counter.value=gWindowCloseWait;

    if (gWindowCloseWait>0){
        gWindowCloseWait--;
        window.setTimeout("window.CloseW()",1000);
    }
    else{
      top.ActualizaAR.document.location.href="CentrodeComandoVentas.jsp?";      //Tipo="+gTipoInfo;
    /*  switch(gTipoInfo){
            case 2 : document.all.LabelMon.innerHTML="Asistencia Médica ARP"; break;   
        default: document.all.LabelMon.innerHTML="Asistencia Médica ARP"; gWindowCloseWait = 0; break;
      }
      gTipoInfo++;
      
      if (gTipoInfo==2){gTipoInfo=8}
      else if (gTipoInfo==9){gTipoInfo=1}*/
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

