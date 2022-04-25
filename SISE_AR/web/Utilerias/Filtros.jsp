<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="Combos.cbPais,Combos.cbEstatusExped,Combos.cbServicio,Combos.cbEntidad,UtlHash.Pagina,UtlHash.Filtro,java.util.List,UtlHash.LoadPagina,java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<html>
    <head>
        <title></title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>


    <body background="../Imagenes/bgMenu.jpg">

        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj"/>

        <script src='Util.js'></script>
        <script src='UtilServicio.js'></script>
        <script src='UtilDireccion.js'></script>
        <script src='UtilMask.js'></script>
        <script src='UtilRefLlamadas.js'></script>
        <script src='UtilEspecialidad.js'></script>
        <script src='UtilCuenta.js'></script>
        <script src='../Utilerias/UtilAjax.js'></script>

        <%
            String clPaginaWeb = "0";
            String strclUsr = "0";

            if (session.getAttribute("clUsrApp") != null) {
                strclUsr = session.getAttribute("clUsrApp").toString();
            }

            if (SeguridadC.verificaHorarioC(Integer.parseInt(strclUsr)) != true) {
        %>Fuera de Horario<%  return;
            }

            MyUtil.InicializaParametrosC(3, Integer.parseInt(strclUsr));

            if (session.getAttribute("clPaginaWeb") == null) {
                return;
            } else {
                clPaginaWeb = session.getAttribute("clPaginaWeb").toString();
            }
            StringBuffer strScript = new StringBuffer();
            StringBuffer strSentenciaArm = new StringBuffer();
            Pagina PaginaI = LoadPagina.getPagina(clPaginaWeb);

            int iX = 90;

        %>
        <form name='Form1' action='../<%=PaginaI.getStrNombrePaginaWeb()%>' target='<%=PaginaI.getStrTarget()%>' method='post'>
            <input name='Filtros' value='N' type='hidden'>
            <input name='P' value='<%=clPaginaWeb%>' type='hidden'>
            <%
                if (PaginaI.getStrNombrePaginaWeb().compareToIgnoreCase("") != 0) {
                    if (PaginaI.getStrNombrePaginaWebCSV().compareToIgnoreCase("") != 0) {
            %>
            <table class='cssBGDet'><tr>
                    <td><table><tr>
                                <td class=''>Formato de Salida</td>
                            </tr><tr>
                                <td>
                                    <select onchange="if (this.value == '1') {
                                                Form1.action = '<%=PaginaI.getStrNombrePaginaWeb()%>';
                                            }
                                            if (this.value == '2') {
                                                Form1.action = '../<%=PaginaI.getStrNombrePaginaWebCSV()%>';
                                            }
                                            if (this.value == '3') {
                                                Form1.action = '../<%=PaginaI.getStrNombrePaginaWebMail()%>'
                                            }" name='Formato' id ='Formato'>
                                        <option value="1">Normal (limitado a 100)</option>
                                        <option value="2">Excel (limitado a 100)</option>
                                        <%
                                            if (PaginaI.getStrNombrePaginaWebMail().compareToIgnoreCase("") != 0) {
                                        %>
                                        <option value="3">Por Correo (No limitado)</option>
                                        <%}%>
                                    </select>
                                </td></tr></table></td><td>
                                <%
                                        }
                                    }%>
                        <p align='right'><input type='submit' value='BUSCAR' onClick='window.close()' class='cBtn'></p>
                            <%//el boton de arriba se cambia a submit :)%>
                    </td></tr></table>
                    <%
                        List lstFiltros = null;

                        lstFiltros = PaginaI.getLstFiltros();

                        StringBuffer strParam = new StringBuffer();
                        StringBuffer strCmp = new StringBuffer();
                        String strValorDefault = "";
                        int iPosIni = 0;
                        int iPosEnd = 0;
                        int iC = 0;
                        int x = 0;
                        int xR = 1;

                        if (lstFiltros != null) {
                            for (x = 0; x < lstFiltros.size(); x++, xR++) {
                                Filtro FiltroI = (Filtro) lstFiltros.get(x);
                                strCmp.delete(0, strCmp.length());
                                strParam.delete(0, strParam.length());
                                strCmp.append(FiltroI.getStrParametros());

                                iPosIni = 0;
                                iPosEnd = 0;
                                if (strCmp.toString().equalsIgnoreCase("") == false) {
                                    iC = 0;
                                    iPosIni = strCmp.indexOf("$", iPosIni);
                                    iPosEnd = strCmp.indexOf(",", iPosIni);

                                    //Máximo número de filtros es 10, se hace por protección de que no se vaya a generar
                                    //algún problema de variable y resulte que el valor de iPosIni se pierda y se ejecute
                                    //el while infinitamente causando que se pasme el equipo.
                                    while (iPosIni >= 0 && iC < 10) {
                                        if (iPosEnd < 0) {
                                            iPosEnd = strCmp.length();
                                        }

                                        if (iPosIni >= 0) {
                                            if (strParam.length() > 0) {
                                                strParam.append("','");
                                            } else {
                                                strParam.append("'");
                                            }
                                            if (session.getAttribute(strCmp.substring(iPosIni + 1, iPosEnd)) != null) {
                                                if (session.getAttribute(strCmp.substring(iPosIni + 1, iPosEnd)).toString() == null) {
                                                    strParam.append("0");
                                                } else {
                                                    strParam.append(session.getAttribute(strCmp.substring(iPosIni + 1, iPosEnd)).toString());
                                                }
                                            } else {
                                                strParam.append("0");
                                            }
                                            if (iPosEnd == strCmp.length()) {
                                                strCmp.delete(0, strCmp.length());
                                            } else {
                                                strCmp.delete(0, strCmp.length()).append(strCmp.substring(iPosEnd + 1, strCmp.length()));
                                            }
                                            strParam.append("'");
                                        } else {
                                            iPosIni = iPosEnd;
                                        }
                                        iPosIni = strCmp.indexOf("$", iPosIni);
                                        iPosEnd = strCmp.indexOf(",", iPosIni);
                                        iC++;
                                    }
                                }
                                strCmp.delete(0, strCmp.length());

                                if (FiltroI.getStrTipoFiltro().equalsIgnoreCase("InputText")) {
                                    if (FiltroI.getStrBusquedaRef().compareTo("") == 0) {
                                        strScript.append("document.all.").append(FiltroI.getStrVarVal()).append(".readOnly=false;\n");
                                        if (FiltroI.getStrValorDefault().compareToIgnoreCase("") != 0) {
                                            if (session.getAttribute(FiltroI.getStrValorDefault()) != null) {
                                                strValorDefault = session.getAttribute(FiltroI.getStrValorDefault()).toString();
                                            } else {
                                                strValorDefault = "";
                                            }
                                        } else {
                                            strValorDefault = "";
                                        }

                                        if (FiltroI.getStrMask().compareToIgnoreCase("") == 0) {
                    %>
                    <%=MyUtil.ObjInput(FiltroI.getStrdsFiltroWeb(), FiltroI.getStrVarVal(), strValorDefault, true, true, 20, iX, "", true, true, 35)%>
                    <%
                    } else {
                    %>
                    <%=MyUtil.ObjInput(FiltroI.getStrdsFiltroWeb(), FiltroI.getStrVarVal(), strValorDefault, true, true, 20, iX, "", true, true, 35, "if(this.readOnly==false){fnValMask(this,document.all." + FiltroI.getStrVarVal() + "Msk.value,this.name)}")%>
            <input name='<%=FiltroI.getStrVarVal()%>Msk' id='<%=FiltroI.getStrVarVal()%>Msk' type='hidden' value='<%=FiltroI.getStrMask()%>'>
            <%
                }
            } else {
                //strScript.append("document.all.").append(strCampoValor).append("V.readOnly=false;\n");

                if (strValorDefault != null) {
                    if (session.getAttribute(strValorDefault) != null) {
                        strValorDefault = session.getAttribute(FiltroI.getStrValorDefault()).toString();
                    } else {
                        strValorDefault = "";
                    }
                } else {
                    strValorDefault = "";
                }
            %>
            <input type='hidden' id='<%=FiltroI.getStrVarVal()%>' name='<%=FiltroI.getStrVarVal()%>'>
            <%
                if (FiltroI.getStrMask().compareToIgnoreCase("") == 0) {
            %>
            <%=MyUtil.ObjInput(FiltroI.getStrdsFiltroWeb(), FiltroI.getStrVarVal() + "V", strValorDefault, true, true, 20, iX, "", true, true, 35)%>
            <%
            } else {
            %>
            <%=MyUtil.ObjInput(FiltroI.getStrdsFiltroWeb(), FiltroI.getStrVarVal() + "V", strValorDefault, true, true, 20, iX, "", true, true, 35, "if(this.readOnly==false){fnValMask(this,document.all." + FiltroI.getStrVarVal() + "Msk.value,this.name)}")%>
            <input name='<%=FiltroI.getStrVarVal()%>Msk' id='<%=FiltroI.getStrVarVal()%>Msk' type='hidden' value='<%=FiltroI.getStrMask()%>'>
            <%
                }
            %><div class='VTable' style='position:absolute; z-index:25; left:200px; top:<%=iX + 15%>px;'>
                <img alt=""  WIDTH=20 HEIGHT=20 src='../Imagenes/Lupa.gif' class='handM' onClick="fnBuscaGral('<%=FiltroI.getStrBusquedaRef()%>')">
            </div>
            <%
                    }
                }

                if (FiltroI.getStrTipoFiltro().equalsIgnoreCase("Combo")) {
                    strScript.append("document.all.").append(FiltroI.getStrVarVal()).append("C.disabled=false;\n");
                    if (FiltroI.getStrValorDefault().compareToIgnoreCase("") != 0) {
                        if (session.getAttribute(strValorDefault) != null) {
                            strValorDefault = session.getAttribute(FiltroI.getStrValorDefault()).toString();
                        } else {
                            strValorDefault = FiltroI.getStrVarVal();
                        }
                    } else {
                        strValorDefault = FiltroI.getStrVarVal();
                    }

                    strSentenciaArm.delete(0, strSentenciaArm.length());
                    strSentenciaArm.append(FiltroI.getStrSentencia() + strParam);

            %><%=MyUtil.ObjComboC(FiltroI.getStrdsFiltroWeb(), FiltroI.getStrVarVal(), strValorDefault, true, true, 20, iX, "", strSentenciaArm.toString(), FiltroI.getStrfnOnChange(), "", 30, true, true)%>
            <%
                }

                if (FiltroI.getStrTipoFiltro().equalsIgnoreCase("ComboMem")) {
                    strScript.append("document.all.").append(FiltroI.getStrVarVal()).append("C.disabled=false;\n");
                    if (FiltroI.getStrValorDefault().compareToIgnoreCase("") != 0) {
                        if (session.getAttribute(FiltroI.getStrValorDefault()) != null) {
                            strValorDefault = session.getAttribute(FiltroI.getStrValorDefault()).toString();
                        } else {
                            strValorDefault = FiltroI.getStrVarVal();
                        }
                    } else {
                        strValorDefault = FiltroI.getStrVarVal();
                    }
                    if (FiltroI.getStrClass().compareToIgnoreCase("cbEntidad") == 0) {
            %>
            <%=MyUtil.ObjComboMem(FiltroI.getStrdsFiltroWeb(), FiltroI.getStrVarVal(), "", "", cbEntidad.GeneraHTML(30, "", 10), true, true, 20, iX, "", FiltroI.getStrfnOnChange(), "", 30, false, false)%>
            <%
                }
                if (FiltroI.getStrClass().compareToIgnoreCase("cbServicio") == 0) {
            %>
            <%=MyUtil.ObjComboMem(FiltroI.getStrdsFiltroWeb(), FiltroI.getStrVarVal(), "", "", cbServicio.GeneraHTML(30, ""), true, true, 20, iX, "", FiltroI.getStrfnOnChange(), "", 30, false, false)%>
            <%
                }
                if (FiltroI.getStrClass().compareToIgnoreCase("cbSubServicioVTR") == 0) {
            %>
            <%=MyUtil.ObjComboMem(FiltroI.getStrdsFiltroWeb(), FiltroI.getStrVarVal(), "", "", cbServicio.GeneraHTMLSub(30, "", ""), true, true, 20, iX, "", FiltroI.getStrfnOnChange(), "", 30, false, false)%>
            <%
                }
                if (FiltroI.getStrClass().compareToIgnoreCase("cbEstatusExped") == 0) {
            %>
            <%=MyUtil.ObjComboMem(FiltroI.getStrdsFiltroWeb(), FiltroI.getStrVarVal(), "", "", cbEstatusExped.GeneraHTML(30, ""), true, true, 20, iX, "", FiltroI.getStrfnOnChange(), "", 30, false, false)%>
            <%
                }
                if (FiltroI.getStrClass().equalsIgnoreCase("cbPais")) {
            %>
            <%=MyUtil.ObjComboMem(FiltroI.getStrdsFiltroWeb(), FiltroI.getStrVarVal(), "", "", cbPais.GeneraHTML(20, ""), true, true, 20, iX, "", FiltroI.getStrfnOnChange(), "", 30, false, false)%>
            <%
                    }
                }

                if (FiltroI.getStrTipoFiltro().equalsIgnoreCase("ComboMemDiv")) {
                    strScript.append("document.all.").append(FiltroI.getStrVarVal()).append("C.disabled=false;\n");

                    if (FiltroI.getStrValorDefault().compareToIgnoreCase("") != 0) {
                        if (session.getAttribute(FiltroI.getStrValorDefault()) != null) {
                            strValorDefault = session.getAttribute(FiltroI.getStrValorDefault()).toString();
                        } else {
                            strValorDefault = FiltroI.getStrVarVal();
                        }
                    } else {
                        strValorDefault = FiltroI.getStrVarVal();
                    }

                    if (FiltroI.getStrClass().equalsIgnoreCase("cbEntidad")) {
            %>
            <%=MyUtil.ObjComboMemDiv(FiltroI.getStrdsFiltroWeb(), FiltroI.getStrVarVal(), "", "", cbEntidad.GeneraHTML(30, "", 10), true, true, 20, iX, "", FiltroI.getStrfnOnChange(), "", 30, false, false, FiltroI.getStrDivID())%>
            <%
                }
                if (FiltroI.getStrClass().equalsIgnoreCase("cbEntidad.GeneraHTMLMD")) {
            %>
            <%=MyUtil.ObjComboMemDiv(FiltroI.getStrdsFiltroWeb(), FiltroI.getStrVarVal(), "", "", cbEntidad.GeneraHTMLMD(30, "", ""), true, true, 20, iX, "", FiltroI.getStrfnOnChange(), "", 30, false, false, FiltroI.getStrDivID())%>
            <% }
                    }

                    if (FiltroI.getStrTipoFiltro().compareToIgnoreCase("") != 0) {
                        iX += 40;
                    }
                }
                strValorDefault = null;

            %><%=MyUtil.DoBlock("Filtros de B&uacute;squeda", 60, 0)%>
        </form>
        <%
            }
            iX += 100;
        %><script type="" ><%=strScript.toString()%>;window.resizeTo(300,<%=iX%>);</script>
        <script>
            /*function funcionEnter(evento) {
             if (window.event) {
             if (window.event.keyCode == 13) {
             submit();
             window.close();
             }
             }
             }*/
        </script>
        <%
            strScript.delete(0, strScript.length());
            try {
            } catch (Exception e) {
            }
        %>

    </body>
</html>