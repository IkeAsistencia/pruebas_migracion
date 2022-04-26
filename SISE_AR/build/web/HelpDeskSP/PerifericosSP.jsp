<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="com.ike.helpdeskSP.DAOPerifericosSP,com.ike.helpdeskSP.PerifericosSP,java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<html>
    <head>
        <title>PERIFERICOS</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <link href='../StyleClasses/Calendario.css' rel='stylesheet' type='text/css'>
    </head>

    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj"/>
        <script type="text/javascript" src='../Utilerias/Util.js' ></script>
        <script type="text/javascript" src='../Utilerias/UtilStore.js' ></script>
        <script type="text/javascript" src='../Utilerias/UtilCalendario.js' ></script>
        <%
                    String StrclPeriferico = "0";
                    String StrclInventarioSP = "0";
                    String StrclUsrApp = "0";
                    String StrclTipoPeriferico = "0";
                    String Strpropiedad = "0";

                    if (session.getAttribute("clUsrApp") != null) {
                        StrclUsrApp = session.getAttribute("clUsrApp").toString();
                    }
                    if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {
        %>Fuera de Horario <%
                        StrclPeriferico = null;
                        StrclInventarioSP = null;
                        StrclUsrApp = null;
                        StrclTipoPeriferico = null;
                        Strpropiedad = null;

                        return;
                    }

                    if (session.getAttribute("clPeriferico") != null) {
                        StrclPeriferico = session.getAttribute("clPeriferico").toString();

                    }
                    if (request.getParameter("clPeriferico") != null) {
                        StrclPeriferico = request.getParameter("clPeriferico").toString();
                        session.setAttribute("clPeriferico", StrclPeriferico);
                        //System.out.println(StrclPeriferico);
                    }

                    if (session.getAttribute("clInventarioSP") != null) {
                        StrclInventarioSP = session.getAttribute("clInventarioSP").toString();
                    }

                    if (request.getParameter("clInventarioSP") != null) {
                        StrclInventarioSP = request.getParameter("clInventarioSP").toString();
                    }

                    session.setAttribute("clPeriferico", StrclPeriferico);
                    //System.out.println(StrclPeriferico);

                    DAOPerifericosSP daoPerifericosSP = null;
                    PerifericosSP PSP = null;

                    if (Integer.parseInt(StrclPeriferico) > 0) {

                        daoPerifericosSP = new DAOPerifericosSP();
                        PSP = daoPerifericosSP.getPerifericoSP(StrclPeriferico.toString());

                        StrclTipoPeriferico = PSP.getclTipoPeriferico();

                        session.setAttribute("clTipoPeriferico", StrclTipoPeriferico);
                        Strpropiedad = PSP.getclPropiedad();

                        // System.out.println("tipoPeriferico" + StrclTipoPeriferico);
                    }

                    String StrclPaginaWeb = "1189";
                    session.setAttribute("clPaginaWebP", StrclPaginaWeb);

                    String Store = "";
                    Store = "st_GuardaPerifericosSP,st_ActualizaPerifericosSP";
                    session.setAttribute("sp_Stores", Store);

                    String Commit = "";
                    Commit = "clPeriferico";
                    session.setAttribute("Commit", Commit);
        %>
        <script type="text/javascript">fnOpenLinks()</script>
        <%MyUtil.InicializaParametrosC(1189, Integer.parseInt(StrclUsrApp));%>
        <%=MyUtil.doMenuAct("../servlet/com.ike.guarda.EjecutaSP", "", "fnsp_Guarda();")%>
        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="PerifericosSP.jsp?"%>'>

        <input id="Secuencia" name="Secuencia" type="hidden" value="">
        <input id="SecuenciaG" name="SecuenciaG" type="hidden"  VALUE="clInventarioSP,clTipoPeriferico,clMarca,Modelo,NoSerie,clPropiedad,clMemoriaRam,Procesador,clDiscoDuro,Observaciones,clEstatus,RefFactura,Anexo,clArrendadora,EtiquetaActivo,FechaFactura,clEmpresa,Mouse,Teclado">
        <input id="SecuenciaA" name="SecuenciaA" type="hidden"  VALUE="clPeriferico,clInventarioSP,clTipoPeriferico,clMarca,Modelo,NoSerie,clPropiedad,clMemoriaRam,Procesador,clDiscoDuro,Observaciones,clEstatus,RefFactura,Anexo,clArrendadora,EtiquetaActivo,FechaFactura,clEmpresa,Mouse,Teclado">
        <INPUT id='clPaginaWeb' name='clPaginaWeb' type='HIDDEN' value='<%=StrclPaginaWeb%>'>
        <INPUT id='clPeriferico' name='clPeriferico' type='HIDDEN' value='<%=StrclPeriferico%>'>
        <INPUT id='clInventarioSP' name='clInventarioSP' type='HIDDEN' value='<%=StrclInventarioSP%>'>

        <%=MyUtil.ObjComboC("PERIFERICO", "clTipoPeriferico", PSP != null ? PSP.getdsTipoPeriferico() : "", true, true, 20, 80, "", "select clTipoPeriferico,dsTipoPeriferico from cTipoPerifericoSP ", "fn_muestra(this.value);", "", 30, true, true)%>
        <%=MyUtil.ObjComboC("Propiedad", "clPropiedad", PSP != null ? PSP.getdsPropiedad() : "", true, true, 20, 120, "", "select clPropiedad, dsPropiedad from cPropiedadSP ", "fn_muestraRefFac(this.value);", "", 10, true, true)%>
        <%=MyUtil.ObjComboC("MARCA", "clMarca", PSP != null ? PSP.getdsMarca() : "", true, true, 260, 80, "", "select clMarca, dsMarca from cMarcaSP ", "", "", 10, true, true)%>
        <%=MyUtil.ObjInput("MODELO", "Modelo", PSP != null ? PSP.getModelo() : "", true, true, 485, 80, "", true, true, 30, "")%>
        <%=MyUtil.ObjInput("Número de SERIE", "NoSerie", PSP != null ? PSP.getNoSerie() : "", true, true, 740, 80, "", true, true, 30, "fn_validaNumSerie();")%>
        <div id="cpu" name="cpu" style="visibility:hidden" >
            <%=MyUtil.ObjComboC("MEMORIA RAM", "clMemoriaRam", PSP != null ? PSP.getdsMemoriaRam() : "", true, true, 260, 120, "", "select clMemoriaRam, dsMemoriaRam from cMemoriaRamSP ", "", "", 10, false, false)%>
            <%=MyUtil.ObjInput("PROCESADOR", "Procesador", PSP != null ? PSP.getProcesador() : "", true, true, 485, 120, "", false, false, 30, "")%>
            <%=MyUtil.ObjComboC("DISCO DURO", "clDiscoDuro", PSP != null ? PSP.getdsDiscoDuro() : "", true, true, 740, 120, "", "select clDiscoDuro, dsDiscoDuro from cDiscoDuroSP ", "", "", 10, false, false)%>
            <%=MyUtil.ObjChkBox("MOUSE", "Mouse", PSP != null ? PSP.getMouse() : "", true, true, 260, 260, "0", "SI", "NO", "")%>
            <%=MyUtil.ObjChkBox("TECLADO", "Teclado", PSP != null ? PSP.getTeclado() : "", true, true, 360, 260, "0", "SI", "NO", "")%>
        </div>
        <div id="factura" name="factura" style="visibility:hidden" >
            <%=MyUtil.ObjInput("REFERENCIA FACTURA", "RefFactura", PSP != null ? PSP.getFactura() : "", true, true, 20, 160, "", false, false, 30, "")%>
            <%=MyUtil.ObjInputF("FECHA FACTURA(AAAA/MM/DD) ", "FechaFactura", PSP != null ? PSP.getFechaFactura() : "", true, true, 260, 160, "", false, false, 20, 1, "")%>
            <%=MyUtil.ObjInput("ANEXO", "Anexo", PSP != null ? PSP.getAnexo() : "", true, true, 485, 160, "", false, false, 30, "")%>
            <%=MyUtil.ObjComboC("ARRENDADORA", "clArrendadora", PSP != null ? PSP.getDsArrendadora() : "", true, true, 740, 160, "", "select clArrendadora, dsArrendadora from cArrendadoraSP", "", "", 10, false, false)%>
        </div>
        <%=MyUtil.ObjInput("ETIQUETA ACTIVO", "EtiquetaActivo", PSP != null ? PSP.getEtiquetaActivo() : "", true, true, 20, 200, "", false, false, 30, "")%>
        <%=MyUtil.ObjComboC("Empresa", "clEmpresa", PSP != null ? PSP.getDsEmpresa() : "", true, true, 260, 200, "", "Select clEmpresa, dsEmpresa from cEmpresasSP ", "", "", 30, true, true)%>
        <%=MyUtil.ObjTextArea("Observaciones", "Observaciones", PSP != null ? PSP.getObservaciones() : "", "90", "9", true, true, 20, 360, "", false, false)%>
        <%=MyUtil.ObjComboC("Estatus", "clEstatus", PSP != null ? PSP.getDsEstatus() : "", false, true, 20, 260, "2", "Select clEstatus, dsEstatus from  cEstatusPerifericos ", "", "", 10, false, false)%>
        <%=MyUtil.DoBlock("PERIFERICOS", 120, 100)%>

        <% if (StrclTipoPeriferico.equalsIgnoreCase("5") || StrclTipoPeriferico.equalsIgnoreCase("1") || StrclTipoPeriferico.equalsIgnoreCase("17")) {%>
        <script type="text/javascript"> document.all.cpu.style.visibility="visible"; </script>
        <% } else {%>
        <script type="text/javascript">  document.all.cpu.style.visibility="hidden"; </script>
        <% }%>

        <% if (Strpropiedad.equalsIgnoreCase("2")) {%>
        <script type="text/javascript"> document.all.factura.style.visibility="visible"; </script>
        <% } else {%>
        <script type="text/javascript"> document.all.factura.style.visibility="hidden"; </script>
        <% }%>

        <%=MyUtil.GeneraScripts()%>
        <%
                    //Limpiar Variables
                    StrclPeriferico = null;
                    StrclInventarioSP = null;
                    StrclUsrApp = null;
                    daoPerifericosSP = null;
                    StrclTipoPeriferico = null;
                    Strpropiedad = null;
        %>
    </body>

    <script type="text/javascript" >
        function fn_validaNumSerie(){
            var pstrCadena = "ValidaNumSerie.jsp?strSQL=sp_ValidaNumSerie";
            pstrCadena = pstrCadena + "&NoSerie= " + document.all.NoSerie.value;
            window.open(pstrCadena,'newWin','scrollbars=yes,status=yes,width=10,height=10');
        }

        function fnExisteNoSerie(){
            alert('El Número de Serie ya Existe');
            document.all.NoSerie.focus();
        }

        function fn_muestra(periferico){
            if(periferico==5 || periferico==1 || periferico==17){
                document.all.cpu.style.visibility="visible";
            }else{
                document.all.cpu.style.visibility="hidden";

                document.all.clMemoriaRam.value="";
                document.all.Procesador.value="";
                document.all.clDiscoDuro.value="";
            }
        }

        function fn_muestraRefFac(propiedad){
            if(propiedad==2){
                document.all.factura.style.visibility="visible";
            }else{
                document.all.factura.style.visibility="hidden";

                document.all.RefFactura.value="";
                document.all.FechaFactura.value="";
                document.all.Anexo.value="";
                document.all.clArrendadora.value="";
            }
        }
    </script>
</html>