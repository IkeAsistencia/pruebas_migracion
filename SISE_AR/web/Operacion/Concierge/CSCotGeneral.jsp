<%-- 
    Document   : CSCotGeneral
    Created on : 12/07/2011, 09:21:51 AM
    Author     : atorres
--%>


<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%@ page import="java.io.File,Utilerias.UtileriasBDF,Seguridad.SeguridadC,java.sql.ResultSet" %>

<html>
    <head><title>Datos Cotizaciones / Confirmaciones</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>

    <body class="cssBody" onload="ExitCheck();" >
        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj"/>
        <script src='../../Utilerias/Util.js' ></script>
        <script src='../../Utilerias/UtilStore.js' ></script>
        <script src='../../Utilerias/UtilCalendario.js' ></script>
        <link href='../../StyleClasses/Calendario.css' rel='stylesheet' type='text/css'>

        <%
        String StrclUsrApp = "0";
        String StrclPaginaWeb = "0";        
        String StrclAsistencia = "0";
        String StrclReferencia = "0";
        String StrRutaLogo="";
        String StrRutaURL="";
        String StrclCotizacion = "0";
        String StrDatCot= "";
        String StrclTipoDocumento = "0";
        String StrTituloDocumento = "";
        String StrEstatusConf="0";
        String StrAdRutaURL="";

        if (session.getAttribute("clUsrApp")!= null){
            StrclUsrApp = session.getAttribute("clUsrApp").toString();           
        }

        if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true){
            %>Fuera de Horario<%
            StrclUsrApp = null;
            StrclPaginaWeb = null;
            StrclAsistencia = null;
            StrclReferencia = null;
            StrRutaLogo = null;
            StrRutaURL = null;
            StrclCotizacion = null;
            StrDatCot = null;
            StrclTipoDocumento = null;
            StrTituloDocumento = null;
            StrEstatusConf=null;
            StrAdRutaURL=null;
            return;
        }

        System.out.println("Estatus......"+StrclUsrApp+" Entrando a Pagina: CSCotGeneral....");

        if (request.getParameter("clAsistencia")!=null){
            StrclAsistencia = request.getParameter("clAsistencia").toString();
            session.setAttribute("cAsistencia",StrclAsistencia);            
        }else{
            if (session.getAttribute("clAsistencia")!= null){
                StrclAsistencia = session.getAttribute("clAsistencia").toString();                
            }
        }

        if (request.getParameter("clTipoDocumento")!=null){
            StrclTipoDocumento = request.getParameter("clTipoDocumento").toString();
            session.setAttribute("clTipoDocumento",StrclTipoDocumento);                        
        }else{
            if (session.getAttribute("clTipoDocumento")!= null){
                StrclTipoDocumento = session.getAttribute("clTipoDocumento").toString();                
            }
        }
        if (StrclTipoDocumento.equalsIgnoreCase("1")){
                StrTituloDocumento = "Cotización";
        }else{
                StrTituloDocumento = "Confirmación";
        }
      
        if (request.getParameter("clReferencia")!=null){
            StrclReferencia = request.getParameter("clReferencia").toString();
            session.setAttribute("clReferencia",StrclReferencia);            
        }else{
            if (session.getAttribute("clReferencia")!= null){
                StrclReferencia = session.getAttribute("clReferencia").toString();               
            }
        }

        ResultSet rs = null;
        System.out.println("CSCotGeneral........................="+"st_GetImgRefConcierge "+StrclAsistencia+","+StrclReferencia+","+StrclTipoDocumento);
        rs = UtileriasBDF.rsSQLNP("st_GetImgRefConcierge "+StrclAsistencia+","+StrclReferencia+","+StrclTipoDocumento);  //Aqui se actualiza el campo datcot con los datos de CScReferencia

        if (rs.next()){
          if (rs.getString("ErrorCot").equalsIgnoreCase("0")){
            if (rs.getString("RutaArchivo") != null){                
                StrRutaURL ="../"+ rs.getString("RutaArchivo");
                if (rs.getString("AdRutaArchivo") != null){
                    StrAdRutaURL ="../"+ rs.getString("AdRutaArchivo");
                }else{
                    StrAdRutaURL = "..\\..\\Imagenes\\EncabezadosConcierge\\Encabezados\\no_disponible.jpg";
                }
            }else{
                StrRutaURL = "..\\..\\Imagenes\\EncabezadosConcierge\\Encabezados\\no_disponible.jpg";
                %><script>alert('!!Atención!!\n Debe subir primero la imagen del LOGO del Proveedor'); window.close();</script><%
            }
          }else{
                %><script>alert('!!Atención!!\n No ha dado de Alta la Cotización correspondiente'); window.close()</script><%
          }
        }

        ResultSet rs1 = UtileriasBDF.rsSQLNP("SELECT  clCotizacion, DatCot ,EstatusConf FROM CSCotizacionRef WHERE clReferencia = "+StrclReferencia+" AND clAsistencia="+StrclAsistencia+" AND clTipoDocumento="+StrclTipoDocumento);

        if (rs1.next()){            
            StrclCotizacion = rs1.getString("clCotizacion").toString();
            StrDatCot       = rs1.getString("DatCot");
            StrEstatusConf  = rs1.getString("EstatusConf") != null ? rs1.getString("EstatusConf"):"0";
        }

        //<<<<<<<<<<<< Servlet Generico >>>>>>>>>>>
        String Store = "";
        Store="st_GuardaDatCot, st_ActDatCot ";
        session.setAttribute("sp_Stores",Store);

        String Commit = "";
        Commit = "clCotizacion";
        session.setAttribute("Commit",Commit);


        StrclPaginaWeb = "1384";
        session.setAttribute("clPaginaWebP",StrclPaginaWeb);

        %>

        <%MyUtil.InicializaParametrosC(Integer.parseInt(StrclPaginaWeb),Integer.parseInt(StrclUsrApp));%>
        <%=MyUtil.doMenuAct("../../servlet/com.ike.guarda.EjecutaSP","","fnsp_Guarda();")%>

        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%>CSCotGeneral.jsp?'>

        <input id="Secuencia" name="Secuencia" type="hidden" value="">
        <input id="SecuenciaG" name="SecuenciaG" type="hidden" value="clReferencia,clAsistencia,clTipoDocumento,DatCot,EstatusConf">
        <input id="SecuenciaA" name="SecuenciaA" type="hidden" value="clCotizacion,clReferencia,clAsistencia,clTipoDocumento,DatCot,EstatusConf">
        <input id='clUsrApp' name='clUsrApp' type='hidden' value='<%=StrclUsrApp%>'>


        <input id="clPaginaWeb"  name="clPaginaWeb"  type="hidden" value="<%=StrclPaginaWeb%>" >
        <input id="clCotizacion" name="clCotizacion" type="hidden" value="<%=StrclCotizacion%>" >
        <input id="clReferencia" name="clReferencia" type="hidden" value="<%=StrclReferencia%>" >
        <input id="clAsistencia" name="clAsistencia" type="hidden" value="<%=StrclAsistencia%>" >
        <input id="clTipoDocumento" name="clTipoDocumento" type="hidden" value="<%=StrclTipoDocumento%>" >        


        <%
        if (!StrclCotizacion.equalsIgnoreCase("0")) {           
            %>
            <script>document.all.btnAlta.disabled= true;</script>

            <div class='VTable' style='position:absolute; z-index:5; left:500px; top:20px;'>
                <input type="button" onClick="fnUpLoadImagen();" class="cBtn" value="Agregar Imagen Adicional">
            </div>


            <%=MyUtil.ObjTextArea("Datos1 "+StrTituloDocumento,"DatCot",StrDatCot ,"100","10",true, true,30, 80,"",false,false)%>

            <%
            if(StrclTipoDocumento.equalsIgnoreCase("2")){
               %><%=MyUtil.ObjChkBox("Seleccionar", "EstatusConf",StrEstatusConf, true, true, 30, 240, "0", "SI", "NO", "")%><%
            }else{
               %><input id="EstatusConf" name="EstatusConf" type="hidden" value="<%=StrEstatusConf%>" ><%
            }%>

            <div id="ImgRef" style="position:absolute; z-index:5; left: 20px;  top:320px;">
                <iframe  src="<%=StrRutaURL%>"
                         width="300" height="180"
                         scrolling="yes"
                         frameborder="yes">
                </iframe>
            </div>

            <div id="ImgRefAd" style="position:absolute; z-index:5;  left: 350px; top:320px;">
                <iframe  src="<%=StrAdRutaURL%>"
                         width="300" height="180"
                         scrolling="yes"
                         frameborder="yes">
                </iframe>
            </div>


            <%
        }

        
        if(StrclTipoDocumento.equalsIgnoreCase("2")){
           %><%=MyUtil.DoBlock("Datos "+StrTituloDocumento,350,0)%><%
        }else{
           %><%=MyUtil.DoBlock("Datos "+StrTituloDocumento,350,100)%><%
        }%>

        <%=MyUtil.GeneraScripts()%>
        <%
        StrclUsrApp = null;
        StrclPaginaWeb = null;
        StrclReferencia = null;
        StrclAsistencia = null;
        StrRutaLogo = null;
        StrRutaURL = null;
        StrclCotizacion = null;
        StrDatCot = null;
        StrclTipoDocumento = null;
        StrTituloDocumento = null;
        rs.close();
        rs1.close();
        rs = null;
        rs1 = null;

        System.out.println("Estatus......Saliendo de Pagina: CSCotGeneral....");
        %>
        <script>

            ClosingVar =true
            window.onbeforeunload = ExitCheck;
            function ExitCheck(){
            ///control de cerrar la ventana///
                if(ClosingVar == true){
                    fnCerrarVentana()
                    ExitCheck = false
                    //return "Si decide continuar,abandonará la página pudiendo perder los cambios si no ha GRABADO ¡¡¡\n Para SALIR de click en el botón CERRAR";
                }
            }

            function fnRevisaSiConf(){
                if(document.all.clTipoDocumento.value=="2"){
                    alert("Es confirmacion");
                    document.all.EstatusConf.value="1";
                }
            }

            function fnCerrarVentana(){

                top.opener.location.reload();
                //window.close();
            }


            function fnUpLoadImagen(){
                 window.open('../../Concierge/CSSubirImagenCot.jsp?clReferencia'+document.all.clReferencia,'WinCiudad','scrollbars=yes,status=yes,width=500,height=500');
            }




        </script>
    </body>
</html>





