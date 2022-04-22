<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head><title>Reembolsos</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <%-- <jsp:useBean id="beanInstanceName" scope="session" class="beanPackagAL.BeanClassName" /> --%>
        <%-- <jsp:getProperty name="beanInstanceName"  property="propertyName" /> --%>
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
        <script src='../../Utilerias/Util.js' ></script>
        <script src='../../Utilerias/UtilMask.js'></script>       
        
        <%  
            String StrclUsrApp="0";



            if (session.getAttribute("clUsrApp")!= null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();
            }

            if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {
            %>Fuera de Horario<%
                StrclUsrApp=null;
        return;
            }
            String StrclExpediente = "0";
            String StrclPaginaWeb="0";
            String strClReembolso = "0";
            String strImprime = "0";

            if (session.getAttribute("clExpediente")!= null) {
                StrclExpediente = session.getAttribute("clExpediente").toString();
            }


            StringBuffer StrSql = new StringBuffer();
            StrSql.append(" Select R.clReembolso, coalesce(R.Beneficiario,'') as Beneficiario, Folio, coalesce(R.Nombre,'') as Nombre, ");
            StrSql.append(" coalesce(R.Telefono,'') as Telefono,  coalesce(MR.dsMotivoReemb,'') as dsMotivoReemb,  coalesce(R.MontoReemb, 0) as MontoReemb, ");
            StrSql.append(" coalesce(FP.dsFormaPago,'') as dsFormaPago, ");
            StrSql.append(" coalesce(convert(varchar(16), R.FechaDeposito,120),'') as FechaDeposito, ");
            StrSql.append(" coalesce(convert(varchar(16), R.FechaCapReemb,120),'') as FechaCapReemb, ");
            StrSql.append(" coalesce(R.NoFactura,'') as NoFactura, ");
            StrSql.append(" coalesce(R.Plaza,'') as Plaza, ");
            StrSql.append(" coalesce(R.Cuenta,'') as Cuenta, ");
            StrSql.append(" coalesce(R.Observaciones,'') as Observaciones, ");
            StrSql.append(" coalesce(R.clMotivoReemb,'') as clMotivoReemb ");
            StrSql.append(" From Reembolsos R ");
            StrSql.append(" Left Join cFormaPago FP ON (FP.clFormaPago = R.clFormaPago) ");
            StrSql.append(" Left Join cMotivoReembolso MR ON (MR.clMotivoReemb=R.clMotivoReemb)");
            StrSql.append(" Where R.clExpediente = ").append(StrclExpediente);


            ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
            StrSql.delete(0,StrSql.length());


            //  out.println("<script>fnCloseFilters() </script>");
            %>
        <script>fnCloseLinks(window.parent.frames.InfoRelacionada.height) </script>
        <script>fnOpenLinks()</script>
        <%
            StrclPaginaWeb = "193";
            MyUtil.InicializaParametrosC(193,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina

            session.setAttribute("clPaginaWebP",StrclPaginaWeb);
        %>
        
        <input type='hidden' name='Imprimir' id='Imprimir'>        
  
            <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccion","")%>
            <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%>Reembolsos.jsp?'>
        <%
            if (rs.next()) { 
             strClReembolso = rs.getString("clReembolso");   
        %>
        <script>document.all.btnAlta.disabled=true;</script>
        <INPUT id='clReembolso' name='clReembolso' type='hidden' value='<%=strClReembolso%>'>
        
        <%=MyUtil.ObjInput("Nombre del Beneficiario","Nombre",rs.getString("Nombre"),true,true,30,70,"", false,false,90)%>
        <%=MyUtil.ObjInput("Folio Reembolso","FolioVTR",rs.getString("Folio"),false,false,500,70,"", false,false,15)%>
        <%=MyUtil.ObjInput("Teléfono","Telefono",rs.getString("Telefono"),true,true,30,110,"", false,false,15)%>
        <%=MyUtil.ObjComboC("Motivo Reembolso", "clMotivoReemb", rs.getString("dsMotivoReemb"),true,true,130,110,"","Select clMotivoReemb, dsMotivoReemb From cMotivoReembolso","","",50,true,true)%>
        <%=MyUtil.ObjInput("Monto Reembolsado","MontoReemb",rs.getString("MontoReemb"),true,true,350,110,"",false,false,15,"EsNumerico(document.all.MontoReemb)")%>
        <%=MyUtil.ObjComboC("Forma de Pago", "clFormaPago", rs.getString("dsFormaPago"),true,true,500,110,"","Select clFormaPago, dsFormaPago From cFormaPago","","",50,true,true)%>
        <%=MyUtil.ObjInput("Fecha de Depósito<br>(AAAA/MM/DD HH:MM)","FechaDeposito",rs.getString("FechaDeposito"),true,true,30,150,"",false,false,20,"if(this.readOnly==false){fnValMask(this,document.all.FechaDepositoMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("Fecha de Captura<br>(AAAA/MM/DD HH:MM)","FechaCapReemb",rs.getString("FechaCapReemb"),true,true,170,150,"",true,true,20,"if(this.readOnly==false){fnValMask(this,document.all.FechaCapturaMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("# Factura","NoFactura",rs.getString("NoFactura"),true,true,310,160,"",false,false,15)%>
        <%=MyUtil.ObjInput("Plaza","Plaza",rs.getString("Plaza"),true,true,410,160,"",false,false,15)%>
        <%=MyUtil.ObjInput("# Cuenta","Cuenta",rs.getString("Cuenta"),true,true,510,160,"",false,false,25)%>
        <%=MyUtil.ObjTextArea("Observaciones","Observaciones",rs.getString("Observaciones"),"100","4",true,true,30,200,"",false,false)%><%
            } else { %>

        <script>document.all.btnCambio.disabled=true;</script>
        <INPUT id='clReembolso' name='clReembolso' type='hidden' value='<%=strClReembolso%>'>
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>

        <%=MyUtil.ObjInput("Nombre del Beneficiario","Nombre","",true,true,30,70,"", false,false,90)%>
        <%=MyUtil.ObjInput("Folio Reembolso","FolioVTR","",false,false,500,70,"", false,false,15)%>
        <%=MyUtil.ObjInput("Teléfono","Telefono","",true,true,30,110,"", false,false,15)%>
        <%=MyUtil.ObjComboC("Motivo Reembolso", "clMotivoReemb","",true,true,130,110,"","Select clMotivoReemb, dsMotivoReemb From cMotivoReembolso","","",50,true,true)%>
        <%=MyUtil.ObjInput("Monto Reembolsado","MontoReemb","",true,true,350,110,"",false,false,15,"EsNumerico(document.all.MontoReemb)")%>
        <%=MyUtil.ObjComboC("Forma de Pago", "clFormaPago", "",true,true,500,110,"","Select clFormaPago, dsFormaPago From cFormaPago","","",50,true,true)%>
        <%=MyUtil.ObjInput("Fecha de Depósito<br>(AAAA/MM/DD HH:MM)","FechaDeposito","",true,true,30,150,"",false,false,20,"if(this.readOnly==false){fnValMask(this,document.all.FechaDepositoMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("Fecha de Captura<br>(AAAA/MM/DD HH:MM)","FechaCapReemb","",true,true,170,150,"",true,true,20,"if(this.readOnly==false){fnValMask(this,document.all.FechaCapturaMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("# Factura","NoFactura","",true,true,310,160,"",false,false,15)%>
        <%=MyUtil.ObjInput("Plaza","Plaza","",true,true,410,160,"",false,false,15)%>
        <%=MyUtil.ObjInput("# Cuenta","Cuenta","",true,true,510,160,"",false,false,25)%>
        <%=MyUtil.ObjTextArea("Observaciones","Observaciones","","100","4",true,true,30,200,"",false,false)%><%
 
                     }    %>
        <%=MyUtil.DoBlock("Reembolsos",0,30)%>    
            <div id="boton" style="position:absolute;width:250px;left:400;top:17;visibility:visible">                               
                <input type="button" value="Imprimir..." class="cBtn" onclick="location.href='ImpresionReembolso.jsp?clExpediente=<%=StrclExpediente%>'">            
            </div>
        <%=MyUtil.GeneraScripts()%>
    
        <%
        rs.close();  
            rs=null;
            StrclExpediente = null;
            StrSql = null;
            StrclPaginaWeb=null;
            StrclUsrApp=null;

            %>
        <input name='FechaDepositoMsk' id='FechaDepositoMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
        <input name='FechaCapturaMsk' id='FechaCapturaMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'> 
        <script>
            document.all.Observaciones.maxLength=500;           
            document.all.Nombre.maxLength=100;   
        
        </script>
    </body>
</html>



