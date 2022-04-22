<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC,com.ike.asistencias.DAODetalleClienteVIP,com.ike.asistencias.to.DetalleClienteVIP"%>
<html>
    <head>
        <title>Detalle del Cliente VIP</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" />
        <script src='../Utilerias/Util.js' ></script>
        <script src='../Utilerias/UtilMask.js'></script>
        <%
        String StrclUsrApp = "0";
        if (session.getAttribute("clUsrApp") != null) {
            StrclUsrApp = session.getAttribute("clUsrApp").toString();        }        
        if (SeguridadC.verificaHorarioC((Integer.parseInt(StrclUsrApp))) != true) { 
            %>Fuera de Horario<%
            StrclUsrApp = null;
            return;
        }        
        String StrclClienteVIP = "";
        String StrFechaAlta = "";
        String StrConsecutivo = "";
        String StrclPaginaWeb = "883";
        DAODetalleClienteVIP daoDCV = null;
        DetalleClienteVIP DCV = null;
        if (request.getParameter("clClienteVIP") != null) {
            StrclClienteVIP = request.getParameter("clClienteVIP");        }
        if (StrclClienteVIP.compareToIgnoreCase("0") != 0) {
            daoDCV = new DAODetalleClienteVIP();
            DCV = daoDCV.getDetalleClienteVIP(StrclClienteVIP);
        } else {
        %> No Existe el cliente <%
            daoDCV = null;
            DCV = null;
            StrclUsrApp = null;
            StrclClienteVIP = null;
            StrFechaAlta = null;
            StrConsecutivo = null;
            }
        ResultSet rs = UtileriasBDF.rsSQLNP("Select convert(varchar(10),getdate(),120) FechaAlta ");
        if (rs.next()) { StrFechaAlta = rs.getString("FechaAlta");        }
        session.setAttribute("clPaginaWebP", StrclPaginaWeb);
        MyUtil.InicializaParametrosC(883, Integer.parseInt(StrclUsrApp));
        %><%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion", "")%><% 
        if (DCV != null) {
            StrConsecutivo = DCV.getConsecutivo(); %>
            <script>document.all.btnElimina.disabled=true;</script>
        <% } else {%>
            <script>
                document.all.btnCambio.disabled=true;
                document.all.btnElimina.disabled=true;
            </script>
        <% } %>
        <input id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="DetalleClienteVIP.jsp?"%>'/>
        <input id='clPaginaWeb' name='clPaginaWeb' type='hidden' value='<%=StrclPaginaWeb%>'/>
        <input id='clClienteVIP' name='clClienteVIP' type='hidden' value='<%=StrclClienteVIP%>'/>
        <input id='Consecutivo' name='Consecutivo' type='hidden' value='<%=StrConsecutivo%>'/>
        <input id='Fecha' name='Fecha' type='hidden' value='<%=StrFechaAlta%>'/>
        <input id='FechaMsk' name='FechaMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09'/>
        <%=MyUtil.ObjComboC("Cuenta", "clCuenta", DCV != null ? DCV.getDsCuenta() : "", true, false, 30, 70, "", "select clCuenta, Nombre from cCuenta where Activo=1 order by dsCuenta", "fnCreaClave()", "", 40, true, true)%>
        <%=MyUtil.ObjInput("Clave", "clave", DCV != null ? DCV.getClaveCuentaVIP() : "", false, false, 430, 70, "", true, true, 11)%>
        <%=MyUtil.ObjInput("Cliente VIP", "Nombre", DCV != null ? DCV.getNombreClienteVIP() : "", true, true, 30, 120, "", true, true, 50)%>
        <%=MyUtil.ObjInput("DNI", "DNI", DCV != null ? DCV.getDNI() : "", true, true, 305, 120, "", true, false, 20)%>
        <%=MyUtil.ObjInput("Patente", "Patente", DCV != null ? DCV.getPatente() : "", true, true, 438, 120, "", false, false, 20)%>
        <%=MyUtil.ObjChkBox("Activo", "Activo", DCV != null ? DCV.getActivo() : "", true, true, 560, 118, "1", "SI", "NO", "fnBajaClienteVIP();")%>
        <%=MyUtil.ObjInput("Fecha Alta <br> (AAAA/MM/DD)", "FechaAlta", DCV != null ? DCV.getFechaAlta() : "", false, false, 30, 170, StrFechaAlta, false, false, 13, "if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("Fecha Baja <br> (AAAA/MM/DD)", "FechaBaja", DCV != null ? DCV.getFechaBaja() : "", false, false, 140, 170, "", false, false, 13, "if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("Fecha Inicial <br> (AAAA/MM/DD)", "FechaIni", DCV != null ? DCV.getFechaIni() : "", true, true, 270, 170, "", true, true, 13, "if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("Fecha Final <br> (AAAA/MM/DD)", "FechaFin", DCV != null ? DCV.getFechaFin() : "", true, true, 373, 170, "", true, true, 13, "if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)}")%>
        <%=MyUtil.ObjComboC("Responsable", "clResponsableVIP", DCV != null ? DCV.getDsResponsableVIP() : "", true, true, 30, 230, "", "select clResponsableVIP, dsResponsableVIP from cResponsableVIP where Activo=1 order by dsResponsableVIP", "", "", 80, true, true)%>
        <%=MyUtil.ObjComboC("Categoria VIP", "clCategoriaVIP", DCV != null ? DCV.getDsCategoriaVIP() : "", true, true, 270, 230, "", "st_getTipoCategoriasVIP", "", "", 10, false, false)%>
        <%=MyUtil.DoBlock("Cliente VIP", -115, -5)%>
        <%=MyUtil.GeneraScripts()%>
        <%
        daoDCV = null;
        DCV = null;
        StrclUsrApp = null;
        StrclClienteVIP = null;
        StrFechaAlta = null;
        StrConsecutivo = null;
        StrclPaginaWeb = null;
        %>
        <script>
//------------------------------------------------------------------------------            
            //Regresa CLAVE
            function fnCreaClave(){
                if (document.all.clCuenta.value=='0'){        document.all.Clave.value = '';
                }else{
                    var pstrCadena = "RegresaClaveVIP.jsp?clCuenta=" + document.all.clCuenta.value;
                    window.open(pstrCadena,'newWin','scrollbars=yes,status=yes,width=700,height=500');
                    }
                }
//------------------------------------------------------------------------------
            function fnActualizaDatosClave(pClave,pConsecutivo){
                document.all.clave.value = pClave;
                document.all.Consecutivo.value = pConsecutivo;
                }
//------------------------------------------------------------------------------
            function fnBajaClienteVIP(){
                var fecha = document.all.Fecha.value;
                if(document.all.Activo.value==1){
                    if(document.all.FechaBaja.value!=''){   document.all.FechaBaja.value="";     }
                    }
                if(document.all.Activo.value==0){
                    if(document.all.FechaBaja.value==''){      document.all.FechaBaja.value=fecha;            }
                    }
                }
//------------------------------------------------------------------------------            
        </script>
    </body>
</html>