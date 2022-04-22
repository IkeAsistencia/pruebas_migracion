<%@ page contentType="text/html;charset=windows-1252"%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
        <title>Actualiza Centro de Comando General</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body topmargin=0 leftmargin=0 class="cssBody" background="../Imagenes/EncabezadoLogoIke.jpg">
        <center>
            <table width="800">
                <tr valign="center">
                    <td height="70" align="center" class="cssTituloPlasma" id="LabelMon" name="LabelMon" >Asistencia Vial</td>
                </tr>
            </table>
        </center>
        <input type="hidden" size="5" name='Counter' id='Counter' value=''>
        <script type="text/javascript" >
            var gWindowCloseWait = 15;
            var gTipoInfo = 2;

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
                    top.frames[1].document.location.href="CentroComandoAll.jsp?Tipo="+gTipoInfo;
                    switch(gTipoInfo){
                        case 1 : document.all.LabelMon.innerHTML="Asistencia Médico - Ambulancia"; break;
                        case 2 : document.all.LabelMon.innerHTML="Vial Asignación"; break;
                        case 3 : document.all.LabelMon.innerHTML="Hogar Asignación"; break;
                        case 4 : document.all.LabelMon.innerHTML="Vial 1er. Contacto"; break;
                        case 5 : document.all.LabelMon.innerHTML="Hogar Citas"; break;
                        case 6 : document.all.LabelMon.innerHTML="Vial Contacto"; break;
                        case 7 : document.all.LabelMon.innerHTML="Expedientes sin Contacto"; break;
                        
                        default: document.all.LabelMon.innerHTML="Asistencia Médico - Ambulancia"; break;
                    }
                    gTipoInfo++;
                    gWindowCloseWait = 15;
                    if (gTipoInfo==8){gTipoInfo=1}
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

            function fnAlert(){
                //alert("Cambió");
            }
        </script>

    </body>
</html>
