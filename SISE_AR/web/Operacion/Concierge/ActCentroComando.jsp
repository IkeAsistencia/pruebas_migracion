<%@ page contentType="text/html;charset=windows-1252"%>
<link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
<body topmargin=0 leftmargin=0 class="cssBody"  background="../../Imagenes/EncabezadoLogoIke.jpg">
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
    <title>Centro de Comando Concierge</title>
  </head>
  <center><table width="800">
    <tr valign="center">
      <td height="70" align="center" class="cssTituloPlasma" id="LabelMon" name="LabelMon" >Grúas por Colisión</td>
    </tr>
  </table>
  </center>
  <INPUT type="hidden" size="5" name='Counter' id='Counter' value=''></input>
<script>
var gWindowCloseWait=1;
var gTipoInfo=1;

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
        
        case 1 : document.all.LabelMon.innerHTML="Citas"; gWindowCloseWait = 20; break; 
        case 2 : document.all.LabelMon.innerHTML="Monitoreo"; gWindowCloseWait = 20; break; 
        case 3 : document.all.LabelMon.innerHTML="Tiempo de Contacto"; gWindowCloseWait = 20; break; 
        default: document.all.LabelMon.innerHTML="Citas"; gWindowCloseWait = 20; break;
      }
      gTipoInfo++;
      
      
      if (gTipoInfo==4){gTipoInfo=1}
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
