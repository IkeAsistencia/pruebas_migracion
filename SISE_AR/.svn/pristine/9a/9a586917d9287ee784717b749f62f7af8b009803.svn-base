<%@page contentType="text/html; charset=iso-8859-1"%>

<html>
    <head><title>JSP Page</title>
        <link href="StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">

        <%-- <jsp:useBean id="beanInstanceName" scope="session" class="beanPackage.BeanClassName" /> --%>
        <%-- <jsp:getProperty name="beanInstanceName"  property="propertyName" /> --%>


        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
        <table class="Table"><tr><td class="TTable" colspan="9">Genera Input Text</td></tr>
            <tr><td class="FTable" width="80">Tipo de Objeto</td>
                <td class="FTable" width="80">Nombre del Objeto</td>
                <td class="FTable" width="80">T&iacute;tulo</td>	
                <td class="FTable" width="80">Valor Inicial</td>
                <td class="FTable">Editable <br> en Alta</td>
                <td class="FTable">Editable <br> en Cambio</td>
                <td class="FTable">X</td>
                <td class="FTable">Y</td>
                <td class="FTable" width="80" id="lblValDefault">Valor Default</td>	
            </tr>
            <tr>
                <td class="VTable"><select id="TipoObj" name="TipoObj" onChange=fnHabilita()>
                        <option value="0">Seleccione</option>
                        <option value="1">Input Text</option>
                        <option value="2">Combo</option>						
                        <option value="3">Check Box</option>						
                    </select></td>	
                <td class="VTable"><input size="12" id="Nombre"></td>
                <td class="VTable"><input size="12" id="Titulo"></td>	
                <td class="VTable"><input size="12" id="ValInicial"></td>
                <td class="VTable"><input id="EditAlta" type="checkbox"></td>
                <td class="VTable"><input id="EditCambio" type="checkbox"></td>	
                <td class="VTable"><input maxlength="4" size="4" id="XPos"></td>	
                <td class="VTable"><input maxlength="4" size="4" id="YPos"></td>		
                <td class="VTable"><input size="12" id="ValDefault"></td>	
            </tr>
            <tr>
                <td class="FTable" width="80" id="lblSQL">Sentencia SQL</td>
                <td class="FTable" id="lblEvOnChange">onChange</td>
                <td class="FTable" id="lblEvOnClick" >onClick</td>
                <td class="FTable" id="lblSizeT" >Tama&ntilde;o de <br>
                    Vista</td>	
                <td class="FTable" id="lbltxtChecked">Etiqueta <br> Checked</td>
                <td class="FTable" id="lbltxtUnChecked">Etiqueta <br> UnChecked</td>
                <td class="FTable" id="lblReqAlta">Requerido <br> Alta</td>
                <td class="FTable" id="lblReqCambio">Requerido <br> Cambio</td>		
            </tr>
            <tr>

                <td><input size="12" id="SQL"></td>
                <td><input size="20" id="EvOnChange"></td>
                <td><input size="20" id="EvOnClick"></td>	
                <td><input size="2"  id="SizeT"></td>		
                <td><input size="12" id="txtChecked"></td>
                <td><input size="12" id="txtUnChecked"></td>
                <td class="VTable"><input id="ReqAlta" type="checkbox"></td>
                <td class="VTable"><input id="ReqCambio" type="checkbox"></td>	

            </tr>

            <tr><td colspan="6"><input type="button" value='Genera C&oacute;digo' onClick="fnGeneraCodigo()">
                    <input type="button" value="VistaPrevia" onClick="fnGeneraVP()">
                    <input type="button" value="Agregar Campo" onClick="fnAdd()">
                </td>
            </tr>
            <tr><td colspan="6"><textarea style="visibility:visible" cols="80" rows="1" id="TA"></textarea></td></tr>
        </table>
        <table>
            <tr><td class="TTable" colspan="11">Vista de Campos Agregados</td></tr>
            <tr><td colspan="11"><table id='ITab'><tr><td></td></tr></table></td></tr>
        </table>

        <script>

            var arrInput = new Array("Titulo", "Nombre", "ValInicial", "EditAlta", "EditCambio", "XPos", "YPos", "ValDefault", "ReqAlta", "ReqCambio");
            var arrCombo = new Array("Titulo", "Nombre", "ValInicial", "EditAlta", "EditCambio", "XPos", "YPos", "ValDefault", "SQL", "EvOnChange", "EvOnClick", "SizeT", "ReqAlta", "ReqCambio");
            var arrChk = new Array("Titulo", "Nombre", "ValInicial", "EditAlta", "EditCambio", "XPos", "YPos", "ValDefault", "txtChecked", "txtUnChecked", "EvOnClick");

            function fnAdd() {
                switch (document.all.TipoObj.options[document.all.TipoObj.selectedIndex].value) {
                    case '1':
                        fnAddInput();
                        break;
                    case '2':
                        fnAddCombo();
                        break;
                    case '3':
                        fnAddChk();
                        break;
                    default:
                        break;
                }
            }

            function fnHabilita(pTipoObj) {

                switch (document.all.TipoObj.options[document.all.TipoObj.selectedIndex].value) {

                    case '1':
                        document.all.SQL.style.visibility = 'hidden';
                        document.all.EvOnChange.style.visibility = 'hidden';
                        document.all.EvOnClick.style.visibility = 'hidden';
                        document.all.SizeT.style.visibility = 'hidden';
                        document.all.txtChecked.style.visibility = 'hidden';
                        document.all.txtUnChecked.style.visibility = 'hidden';
                        document.all.ReqAlta.style.visibility = 'visible';
                        document.all.ReqCambio.style.visibility = 'visible';

                        document.all.lblSQL.style.visibility = 'hidden';
                        document.all.lblEvOnChange.style.visibility = 'hidden';
                        document.all.lblEvOnClick.style.visibility = 'hidden';
                        document.all.lblSizeT.style.visibility = 'hidden';
                        document.all.lbltxtChecked.style.visibility = 'hidden';
                        document.all.lbltxtUnChecked.style.visibility = 'hidden';
                        document.all.lblReqAlta.style.visibility = 'visible';
                        document.all.lblReqCambio.style.visibility = 'visible';

                        break;

                    case '2':
                        document.all.SQL.style.visibility = 'visible';
                        document.all.EvOnChange.style.visibility = 'visible';
                        document.all.EvOnClick.style.visibility = 'visible';
                        document.all.SizeT.style.visibility = 'visible';
                        document.all.txtChecked.style.visibility = 'hidden';
                        document.all.txtUnChecked.style.visibility = 'hidden';
                        document.all.ReqAlta.style.visibility = 'visible';
                        document.all.ReqCambio.style.visibility = 'visible';

                        document.all.lblSQL.style.visibility = 'visible';
                        document.all.lblEvOnChange.style.visibility = 'visible';
                        document.all.lblEvOnClick.style.visibility = 'visible';
                        document.all.lblSizeT.style.visibility = 'visible';
                        document.all.lbltxtChecked.style.visibility = 'hidden';
                        document.all.lbltxtUnChecked.style.visibility = 'hidden';
                        document.all.lblReqAlta.style.visibility = 'visible';
                        document.all.lblReqCambio.style.visibility = 'visible';

                        break;

                    case '3':
                        document.all.SQL.style.visibility = 'hidden';
                        document.all.EvOnChange.style.visibility = 'hidden';
                        document.all.EvOnClick.style.visibility = 'visible';
                        document.all.SizeT.style.visibility = 'hidden';
                        document.all.txtChecked.style.visibility = 'visible';
                        document.all.txtUnChecked.style.visibility = 'visible';
                        document.all.ReqAlta.style.visibility = 'hidden';
                        document.all.ReqCambio.style.visibility = 'hidden';

                        document.all.lblSQL.style.visibility = 'hidden';
                        document.all.lblEvOnChange.style.visibility = 'hidden';
                        document.all.lblEvOnClick.style.visibility = 'visible';
                        document.all.lblSizeT.style.visibility = 'hidden';
                        document.all.lbltxtChecked.style.visibility = 'visible';
                        document.all.lbltxtUnChecked.style.visibility = 'visible';
                        document.all.lblReqAlta.style.visibility = 'hidden';
                        document.all.lblReqCambio.style.visibility = 'hidden';

                        break;

                    default:
                        document.all.SQL.style.visibility = 'visible';
                        document.all.EvOnChange.style.visibility = 'visible';
                        document.all.EvOnClick.style.visibility = 'visible';
                        document.all.SizeT.style.visibility = 'hidden';
                        document.all.txtChecked.style.visibility = 'visible';
                        document.all.txtUnChecked.style.visibility = 'visible';

                        document.all.lblSQL.style.visibility = 'visible';
                        document.all.lblEvOnChange.style.visibility = 'visible';
                        document.all.lblEvOnClick.style.visibility = 'visible';
                        document.all.lblSizeT.style.visibility = 'hidden';
                        document.all.lbltxtChecked.style.visibility = 'visible';
                        document.all.lbltxtUnChecked.style.visibility = 'visible';

                        break;
                }
            }
            function fnGeneraCodigo() {
                fnGeneraAll();
                document.all.FRVP.src = "servlet/Utilerias.TestUtilDemo?TipoSalida=1&Code=" + document.all.TA.value;
            }

            function fnGeneraAll() {
                $ObjI = document.all.TA;
                $ObjI.value = "";
                fnGeneraInput();
                fnGeneraCombo();
                fnGeneraChk();
            }

            function fnGeneraInput() {
                if ((document.all.XPos.value == "") || (document.all.YPos.value == "")) {
                    alert("Debe informar posiciones en X,Y del Input a generar");
                    return;
                }

                var IT = document.getElementById('ITab');

                for (iR = 1; iR < IT.rows.length; iR++) {
                    if (IT.rows(iR).cells(1).title == "InputText") {
                        $ObjI.value = $ObjI.value + "out.println(MyUtil.ObjInput(";
                        $ObjI.value = $ObjI.value + "\"" + IT.rows(iR).cells(2).title + "\"";
                        $ObjI.value = $ObjI.value + ",\"" + IT.rows(iR).cells(3).title + "\"";
                        $ObjI.value = $ObjI.value + ",\"" + IT.rows(iR).cells(4).title + "\"";
                        $ObjI.value = $ObjI.value + "," + IT.rows(iR).cells(5).title;
                        $ObjI.value = $ObjI.value + "," + IT.rows(iR).cells(6).title;
                        $ObjI.value = $ObjI.value + "," + IT.rows(iR).cells(7).title;
                        $ObjI.value = $ObjI.value + "," + IT.rows(iR).cells(8).title;
                        $ObjI.value = $ObjI.value + ",\"" + IT.rows(iR).cells(9).title + "\"";
                        $ObjI.value = $ObjI.value + "," + IT.rows(iR).cells(10).title;
                        $ObjI.value = $ObjI.value + "," + IT.rows(iR).cells(11).title;
                        $ObjI.value = $ObjI.value + "));";
                    }
                }
            }

            function fnGeneraChk() {
                var IT = document.getElementById('ITab');

                for (iR = 1; iR < IT.rows.length; iR++) {
                    if (IT.rows(iR).cells(1).title == "CheckBox") {
                        $ObjI.value = $ObjI.value + "out.println(MyUtil.ObjChkBox(";
                        $ObjI.value = $ObjI.value + "\"" + IT.rows(iR).cells(2).title + "\"";
                        $ObjI.value = $ObjI.value + ",\"" + IT.rows(iR).cells(3).title + "\"";
                        $ObjI.value = $ObjI.value + ",\"" + IT.rows(iR).cells(4).title + "\"";
                        $ObjI.value = $ObjI.value + "," + IT.rows(iR).cells(5).title;
                        $ObjI.value = $ObjI.value + "," + IT.rows(iR).cells(6).title;
                        $ObjI.value = $ObjI.value + "," + IT.rows(iR).cells(7).title;
                        $ObjI.value = $ObjI.value + "," + IT.rows(iR).cells(8).title;
                        $ObjI.value = $ObjI.value + ",\"" + IT.rows(iR).cells(9).title + "\"";
                        $ObjI.value = $ObjI.value + ",\"" + IT.rows(iR).cells(10).title + "\"";
                        $ObjI.value = $ObjI.value + ",\"" + IT.rows(iR).cells(11).title + "\"";
                        $ObjI.value = $ObjI.value + ",\"" + IT.rows(iR).cells(12).title + "\"";
                        $ObjI.value = $ObjI.value + "));";
                    }
                }
            }

            function fnGeneraCombo() {

                var IT = document.getElementById('ITab');

                for (iR = 1; iR < IT.rows.length; iR++) {
                    if (IT.rows(iR).cells(1).title == "Combo") {
                        $ObjI.value = $ObjI.value + "out.println(MyUtil.ObjComboC(con,";
                        $ObjI.value = $ObjI.value + "\"" + IT.rows(iR).cells(2).title + "\"";
                        $ObjI.value = $ObjI.value + ",\"" + IT.rows(iR).cells(3).title + "\"";
                        $ObjI.value = $ObjI.value + ",\"" + IT.rows(iR).cells(4).title + "\"";
                        $ObjI.value = $ObjI.value + "," + IT.rows(iR).cells(5).title;
                        $ObjI.value = $ObjI.value + "," + IT.rows(iR).cells(6).title;
                        $ObjI.value = $ObjI.value + "," + IT.rows(iR).cells(7).title;
                        $ObjI.value = $ObjI.value + "," + IT.rows(iR).cells(8).title;
                        $ObjI.value = $ObjI.value + ",\"" + IT.rows(iR).cells(9).title + "\"";
                        $ObjI.value = $ObjI.value + ",\"" + IT.rows(iR).cells(10).title + "\"";
                        $ObjI.value = $ObjI.value + ",\"" + IT.rows(iR).cells(11).title + "\"";
                        $ObjI.value = $ObjI.value + ",\"" + IT.rows(iR).cells(12).title + "\"";
                        $ObjI.value = $ObjI.value + "," + IT.rows(iR).cells(13).title;
                        $ObjI.value = $ObjI.value + "," + IT.rows(iR).cells(14).title;
                        $ObjI.value = $ObjI.value + "," + IT.rows(iR).cells(15).title;
                        $ObjI.value = $ObjI.value + "));";
                    }
                }
            }

            function fnAddCombo() {
                var IT = document.getElementById('ITab');

                var NewTR = IT.insertRow();

                CurrentRow = NewTR.rowIndex;

                NewTD = NewTR.insertCell();
                NewInp = document.createElement("<input type='button' value='Quitar' onClick='document.all.ITab.deleteRow(" + CurrentRow + ")'>");
                NewTD.appendChild(NewInp);

                NewTD = NewTR.insertCell();
                NewInp = document.createElement("<input type='text' value='Combo'>");
                NewTD.title = "Combo";
                NewTD.appendChild(NewInp);

                Fields = 14;

                for (i = 0; i < Fields; i++) {
                    NewTD = NewTR.insertCell();
                    switch (document.all[arrCombo[i]].type) {
                        case 'text':
                            valueCell = document.all[arrCombo[i]].value;
                            break;

                        case 'checkbox':
                            if (document.all[arrCombo[i]].checked) {
                                valueCell = "true";
                            } else {
                                valueCell = "false";
                            }
                            break;

                        default:
                            valueCell = "Pendiente";
                            break;
                    }

                    NewInp = document.createElement("<input onChange='document.all.ITab.rows(" + CurrentRow + ").cells(" + eval(i + 2) + ").title=this.value' type='textbox' value=" + valueCell + ">");
                    NewTD.title = valueCell;
                    NewTD.appendChild(NewInp);
                }
            }

            function fnAddInput() {
                var IT = document.getElementById('ITab');

                var NewTR = IT.insertRow();

                CurrentRow = NewTR.rowIndex;

                NewTD = NewTR.insertCell();
                NewInp = document.createElement("<input type='button' value='Quitar' onClick='document.all.ITab.deleteRow(" + CurrentRow + ")'>");
                NewTD.appendChild(NewInp);

                NewTD = NewTR.insertCell();
                NewInp = document.createElement("<input  type='text' value='InputText'>InputText</Input>");
                NewTD.title = "InputText";
                NewTD.appendChild(NewInp);

                Fields = 10;

                for (i = 0; i < Fields; i++) {
                    NewTD = NewTR.insertCell();
                    switch (document.all[arrInput[i]].type) {
                        case 'text':
                            valueCell = document.all[arrInput[i]].value;
                            break;

                        case 'checkbox':
                            if (document.all[arrInput[i]].checked) {
                                valueCell = "true";
                            } else {
                                valueCell = "false";
                            }
                            break;

                        default:
                            valueCell = "Pendiente";
                            break;
                    }

                    NewInp = document.createElement("<input onChange='document.all.ITab.rows(" + CurrentRow + ").cells(" + eval(i + 2) + ").title=this.value' type='textbox' value=" + valueCell + ">");
                    NewTD.title = valueCell;
                    NewTD.appendChild(NewInp);
                }

            }

            function fnAddChk() {
                var IT = document.getElementById('ITab');

                var NewTR = IT.insertRow();

                CurrentRow = NewTR.rowIndex;

                NewTD = NewTR.insertCell();
                NewInp = document.createElement("<input type='button' value='Quitar' onClick='document.all.ITab.deleteRow(" + CurrentRow + ")'>");
                NewTD.appendChild(NewInp);

                NewTD = NewTR.insertCell();
                NewInp = document.createElement("<input  type='text' value='CheckBox'>CheckBox</Input>");
                NewTD.title = "CheckBox";
                NewTD.appendChild(NewInp);

                Fields = 11;

                for (i = 0; i < Fields; i++) {
                    NewTD = NewTR.insertCell();
                    switch (document.all[arrChk[i]].type) {
                        case 'text':
                            valueCell = document.all[arrChk[i]].value;
                            break;

                        case 'checkbox':
                            if (document.all[arrChk[i]].checked) {
                                valueCell = "true";
                            } else {
                                valueCell = "false";
                            }
                            break;

                        default:
                            valueCell = "Pendiente";
                            break;
                    }

                    NewInp = document.createElement("<input onChange='document.all.ITab.rows(" + CurrentRow + ").cells(" + eval(i + 2) + ").title=this.value' type='textbox' value=" + valueCell + ">");
                    NewTD.title = valueCell;
                    NewTD.appendChild(NewInp);
                }

            }

            function fnGeneraVP() {
                fnGeneraAll();
                document.all.FRVP.src = "servlet/Utilerias.TestUtilDemo?TipoSalida=0&Code=" + document.all.TA.value;
            }
        </script>

        <%
        //    MyUtil.InicializaParametrosC(con,6,1);
            //out.println(MyUtil.GeneraScripts());
        %>
        <iframe id="FRVP" height="400" width="600">
        </iframe>

        <!--<form action="servlet/Ike.cnIke?strQuery='Select Top 500 * From t_PlantillaServBase'" method="post">-->

        <%
        //response.sendRedirect("servlet/Ike.cnIke?strQuery=Select * From t_PlantillaServBase");
%>

        <!--</form>-->


    </body>
</html>
