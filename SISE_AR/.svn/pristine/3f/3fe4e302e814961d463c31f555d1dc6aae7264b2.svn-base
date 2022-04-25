<%@ page contentType="text/html; charset=iso-8859-1" language="java"%>
<%@ page  import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC,com.ike.operacion.to.AltaNU,com.ike.operacion.DAOAltaNU2,Combos.cbAMIS,Combos.cbEntidad" errorPage=""  %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head><title>ALTA DE USUARIOS</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody" onload='LimpiaFechaNac();'>
        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj" /> 
        <script src='../Utilerias/Util.js' ></script>
        <script src='../Utilerias/UtilMask.js' ></script>
        <script src='../Utilerias/UtilAuto.js'></script>
        <script src='../Utilerias/UtilDireccion.js'></script>
        <%  
        
        com.ike.util.I18N i18n = com.ike.util.I18N.getInstance("es", "AR");
        
        String StrclExpediente = "0";
        StringBuffer StrSql = new StringBuffer();
        String StrclUsrApp="0";
        String StrclPaginaWeb="0";
        String StrclLlamaAltaNU="0";
        String StrCalle="";
        String StrColonia="";
        String StrclAfiliadoNU = "0";
        String StrclCuenta = "0";
        String StrCambio = "0";
        
        
        if (session.getAttribute("clUsrApp")!= null) {
            StrclUsrApp = session.getAttribute("clUsrApp").toString();
        }
        
        if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {
        %>Fuera de Horario<%
        return;
        }
        
        if (request.getParameter("clLlamaAltaNU")!= null) {
            StrclLlamaAltaNU= request.getParameter("clLlamaAltaNU").toString();
        }else{
            if(session.getAttribute("clLlamaAltaNU")!=null){
                StrclLlamaAltaNU = session.getAttribute("clLlamaAltaNU").toString();
            }
        }
        
        
        if(request.getParameter("Cambio")!=null){
            StrCambio= request.getParameter("Cambio").toString();
        }
        
        session.setAttribute("clLlamaAltaNU",StrclLlamaAltaNU);
        
        
        DAOAltaNU2 daoAlta= null;
        AltaNU alta =null;
        
        if (!StrclLlamaAltaNU.equalsIgnoreCase("0")){
            daoAlta=new DAOAltaNU2();
            alta= daoAlta.getAltaNU(StrclLlamaAltaNU);
        }  
        
        
        %><script>fnOpenLinks()</script><%
        
        StrclPaginaWeb = "552";
        MyUtil.InicializaParametrosC(552,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
        
        session.setAttribute("clPaginaWebP",StrclPaginaWeb);
        
        %>
        <%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaLlamAltaAfil","","")%>
        
        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%>LlamadaAltaNU.jsp?'>
        <%
        if(StrCambio.equalsIgnoreCase("1")){%>
        <script>document.all.btnAlta.disabled=true;document.all.btnCambio.disabled=false;</script>
        <%}else{%>
        <script>document.all.btnAlta.disabled=false;document.all.btnCambio.disabled=true;</script>
        <%}
        
        if (alta!=null){
        
        }
        
        
        StrclAfiliadoNU = alta != null ? alta.getClAfiliado() :  "0";
                   
        
        if (!StrclAfiliadoNU.equalsIgnoreCase("0")){
        session.setAttribute("clAfiliadoNU",StrclAfiliadoNU);
        }
        

        
        
        String LblClv="";
        if (StrclCuenta.equalsIgnoreCase("1020")){
        LblClv= "Num de Tarjeta";
        }
        else
        {
        LblClv= "Clave";
        }
        
        if(StrclCuenta.equalsIgnoreCase("1187")){%>
        <script>document.all.btnCambio.disabled=true;</script>
        <%
        }
        %>
        
        <INPUT id='clAfiliadoNU' name='clAfiliadoNU' type='hidden' value='<%=StrclAfiliadoNU%>'>
        
        
        <%=MyUtil.ObjInput("Folio","clLlamaAltaNU",alta != null ? alta.getClLlamada() : "" ,false,false,30,70,"",false,false,10)%>
        <%=MyUtil.ObjComboC("Cuenta", "clCuenta",alta != null ? alta.getNombrecta() : ""  ,true,false,180,70,"","Select clCuenta,Nombre from ccuenta where PermiteAltaNU =1","","",50,true,true)%>
        <%=MyUtil.ObjInput(LblClv,"Clave",alta != null ? alta.getClave() : "" ,true,false,30,120,"",true,true,20)%>
        <%=MyUtil.ObjInput("Nombre","Nombre",alta != null ? alta.getNombre(): "",true,false,180,120,"",true,true,45)%>
        <%=MyUtil.ObjInput("Fechade Nacimiento<br>(aaaa/mm/dd)","FechNac",alta != null ? alta.getFechaNac() : "",true,false,450,105,"",false,false,12,"if(this.readOnly==false){fnValMask(this,document.all.FechaNacMomMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("Telefono","Telefono",alta != null ? alta.getTelefono() : "",true,true,30,160,"",false,false,25)%>
        <%=MyUtil.ObjInput("Empresa","Empresa",alta != null ? alta.getEmpresa() : "",true,true,180,160,"",false,false,45)%>
        
        
        <%=MyUtil.ObjInput("ID Cliente","idCliente",alta != null ? alta.getIdCliente(): "",true,true,30,200,"",false,false,30)%>
        

        
        <%=MyUtil.ObjComboMem("Marca de Auto", "CodigoMarca", alta != null ? alta.getDsMarcaAuto() : "", alta != null ? alta.getCodigoMarca() : "", cbAMIS.GeneraHTML(50, alta != null ? alta.getDsMarcaAuto() : ""), true, true, 220, 200, "", "fnLlenaAMISAcumula()", "", 50, true, true)%>
        <%=MyUtil.ObjComboMem("Tipo de Auto", "ClaveAMIS", alta != null ? alta.getDsTipoAuto() : "", alta != null ? alta.getClaveAmis() : "", cbAMIS.GeneraHTMLTA(50, alta != null ? alta.getCodigoMarca() : "", alta != null ? alta.getClaveAmis() : ""), true, true, 400, 200, "", "", "", 50, true, true)%>        
        
        <INPUT id='ClaveAMISVTR' name='ClaveAMISVTR' type='hidden' value='<%=alta != null ? alta.getClaveAmis() : "" %>'>
        <INPUT id='Marca' name='Marca' type='hidden' value='<%=alta != null ? alta.getDsMarcaAuto()+" - "+alta.getDsTipoAuto() : "" %>'>
        
        <!--%=MyUtil.ObjInput("Marca/Modelo","Marca",alta != null ? alta.getDescAuto()  : "",true,true,220,200,"",false,false,50)%-->
        <%=MyUtil.ObjInput("Año","Modelo",alta != null ? alta.getAnio() : "",true,true,610,200,"",false,false,4)%>
        
        
        <%=MyUtil.DoBlock("Alta de Usuario",0,0)%>
        
        <%=MyUtil.ObjComboMem(i18n.getMessage("message.title.entidad"), "CodEnt", alta != null ? alta.getDsEntFed() : "", alta != null ? alta.getCodEnt() : "", cbEntidad.GeneraHTML(20, alta != null ? alta.getDsEntFed() : ""), true, true, 30, 285, "", "fnLlenaMunicipios()", "", 20, false, false)%>
        <%=MyUtil.ObjComboMem("Localidad", "CodMD", alta != null ? alta.getDsMunDel() : "", alta != null ? alta.getCodMD() : "", cbEntidad.GeneraHTMLMD(30, alta != null ? alta.getCodEnt() : "", alta != null ? alta.getDsMunDel() : ""), true, true, 380, 285, "", "", "", 20, false, false)%>
        
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.colonia"),"Colonia",alta != null ? alta.getColonia(): "",true,true,30,335,"",false,false,40)%>                
        <%=MyUtil.ObjInput("Calle y Número","Calle",alta != null ? alta.getCalle() : "",true,true,380,335,"",false,false,50)%>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.cp"),"CP",alta != null ? alta.getCP() : "",true,true,30,375,"",false,false,10)%>
        <div class='VTable' style='position:absolute; z-index:25; left:200px; top:388px;'>
        <!--INPUT type='button' VALUE='Buscar..' onClick='fnBuscaColoniaN2();' class='cBtn'></div>
        <%=MyUtil.DoBlock("domicilio IF",180,0)%>
        <%
        
        
        
        
        
        %><%=MyUtil.GeneraScripts()%><%
        
        
        StrclExpediente = null;
        StrclUsrApp=null;
        StrclPaginaWeb=null;
        StrclLlamaAltaNU=null;
        StrCalle=null;
        StrColonia=null;
        StrclAfiliadoNU = null;
        StrclCuenta = null;
        StrCambio = null;        
        
        %>
        <input name='FechaProgMomMsk' id='FechaNacMomMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09'>
        <script>

    document.all.btnElimina.disabled=true;            
            
    function LimpiaFechaNac(){
            if (document.all.FechNac.value=='1900-01-01 00:00:00.0') {document.all.FechNac.value=''}
    }
     
  /*  function fnBuscaColoniaN2(){
        if (document.all.btnGuarda.disabled==false){ 
        var pstrCadena = "../Utilerias/FiltrosDireccion.jsp?strSQL=sp_WebBuscaDir 1,'" + document.all.CP.value + "'";
        pstrCadena = pstrCadena + "&Colonia=&CodMd=&dsMunDel=&CodEnt=&dsEntFed=&Tipo=1";
        window.open(pstrCadena,'newWin','scrollbars=yes,status=yes,width=1,height=1');
        } 
    }*/

    function fnActualizaDatosCP(pCP, dsColonia, CodMD, dsMunDel, CodEnt, dsEntFed){
    document.all.CP.value = pCP;
    document.all.Colonia.value = dsColonia;			
    document.all.CodMD.value = CodMD;
    document.all.dsMunDel.value = dsMunDel;
    document.all.CodEnt.value = CodEnt;
    document.all.dsEntFed.value = dsEntFed;
    }
 
    function fnValidaResponse1(CodeResponse, Url){
		if (CodeResponse!=-1){
 			WSave.close(); 
			location.href=Url;
		}
		else{
			blnAceptar=0;
			document.all.btnGuarda.disabled=false;
			document.all.btnCancela.disabled=false;
			WSave.close();                     
		}
    }
        
/*
    function fnConcatena(){
    
    alert(document.all.CodigoMarcaC.options[document.all.CodigoMarcaC.selectedIndex].text);
    alert(document.all.ClaveAMISC.options[document.all.ClaveAMISC.selectedIndex].text);
    
    
   // alert(marcatext + "-"+ tipoautotext);
    //document.all.Marca.value = marcatext + "-"+ tipoautotext;
    
    }
 //document.all.Concepto.value=document.all.clConceptoC.options[document.all.clConceptoC.selectedIndex].text;
 alert(document.all.CodigoMarcaC.options[document.all.CodigoMarcaC.selectedIndex].text);
    */
     
        </script>
    </body>
</html>