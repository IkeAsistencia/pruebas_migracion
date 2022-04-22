<%-- 
    Document   : VistaCotRefConcierge
    Created on : 20/06/2011, 03:28:30 PM
    Author     : atorres


<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%@ page import="com.ike.concierge.GeneraPDFCotRefConcierge, Seguridad.SeguridadC,java.sql.ResultSet,Utilerias.UtileriasBDF" %>
<html>
    <head><title>Impresión Cotizacion Referencia Concierge</title>
            <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody" onload=''>
    <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj" />
    <script src='../Utilerias/Util.js' ></script>
    <%
        String StrclUsrApp = "0";
        String StrclConcierge = "0";
        String StrclCuenta = "0";
        String StrRutaArchivoEncabezado = "";
        String StrclPaginaWeb="";
        String StrRutaPDF="";
        String StrNomFile="";
        String StrclAsistencia="0";
        String StrclReferencia="0";
        String StrclTipoDocumento="1";
        String StrclSubservicio="0";

        if ( session.getAttribute("clUsrApp") != null) {
            StrclUsrApp = session.getAttribute("clUsrApp").toString();
        }

        if ( SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp) ) != true ) {
            %>Fuera de Horario <%
            StrclUsrApp = null;
            StrclConcierge=null;
            StrclCuenta=null;
            StrRutaArchivoEncabezado = null;
            StrclPaginaWeb=null;
            StrRutaPDF=null;
            StrNomFile=null;
            StrclAsistencia=null;
            StrclReferencia=null;
            StrclTipoDocumento=null;
            return;
        }

        if (session.getAttribute("clConcierge") != null){
            StrclConcierge = session.getAttribute("clConcierge").toString();          
        }

        if  (session.getAttribute("clCuenta") != null) {
            StrclCuenta = session.getAttribute("clCuenta").toString();
        }

        if (session.getAttribute("clSubservicio")!= null) {
            StrclSubservicio= session.getAttribute("clSubservicio").toString();
        }

        System.out.println("VistaCotRefConcierge.StrclSubservicio="+StrclSubservicio);


        System.out.println("VistaCotRefConcierge.StrclCuenta="+StrclCuenta);

        if (request.getParameter("clAsistencia")!= null) {
            StrclAsistencia= request.getParameter("clAsistencia").toString();
            System.out.println("VistaContRefConcierge.clAsistencia.Request="+StrclAsistencia);
        } else{
            if (session.getAttribute("clAsistencia")!= null) {
                StrclAsistencia= session.getAttribute("clAsistencia").toString();
                System.out.println("VistaCotRefConcierge.clAsistencia.Session="+StrclAsistencia);
            }
        }

        if (request.getParameter("clReferencia")!= null) {
            StrclReferencia= request.getParameter("clReferencia").toString();
            System.out.println("VistaContRefConcierge.StrclReferencia.Request="+StrclReferencia);
        }else{
            if (session.getAttribute("clReferencia") != null){
                StrclReferencia = session.getAttribute("clReferencia").toString();
                System.out.println("VistaContRefConcierge.StrclReferenciaSession="+StrclReferencia);
            }
        }


        GeneraPDFCotRefConcierge PDF = null;
        PDF = new GeneraPDFCotRefConcierge();

        ResultSet rs = null;

        System.out.println("st_GetEncabezadoConcierge "+StrclCuenta+","+StrclTipoDocumento+","+StrclSubservicio);
        rs = UtileriasBDF.rsSQLNP("st_GetEncabezadoConcierge "+StrclCuenta+","+StrclTipoDocumento+","+StrclSubservicio);

        try{
            if(rs.next()){
                StrRutaArchivoEncabezado = rs.getString("RutaArchivo");
                StrRutaPDF = "C:\\Proyectos\\Sise\\build\\web\\Operacion\\Concierge\\Files\\";
                StrNomFile="CT-"+StrclSubservicio+StrclAsistencia+StrclConcierge;
                session.setAttribute("RutaPDF",StrRutaPDF);
                session.setAttribute("NomFile",StrNomFile);
                PDF.GeneraPDFCotRefConcierge(StrRutaArchivoEncabezado,StrRutaPDF,StrclConcierge,StrclAsistencia,StrclCuenta,StrclReferencia,StrclTipoDocumento,StrclSubservicio);
                StrclPaginaWeb = "1377";
                MyUtil.InicializaParametrosC(1377,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
                session.setAttribute("clPaginaWebP",StrclPaginaWeb);
                %>
                <div class='VTable'  id="btnEnvia" style="position:absolute; z-index:25; left:800px; top:45px;">
                    <input class='cBtn' type='button' value='Enviar Documento' onClick="fnEnviaMail(<%=StrclReferencia%>);">
                </div>

                <iframe src="Files/CT-<%=StrclSubservicio+StrclAsistencia+StrclConcierge%>.PDF" width=1000 height=620 style=' margin-right: 0px; margin-bottom: 0px; margin-top:65px; margin-left: 0px' scrolling="yes"  frameborder="yes">

                </iframe>
                              
                <%                
            }else{
                %>
                <script>
                    alert('                            !!Atencion!!\n NO EXISTE Encabezado de Cotizacion para este SubServicio');
                </script><%
           }
        }catch(Exception e){
            System.out.println("Error="+e);
        }

        StrclUsrApp  = null;
        StrclPaginaWeb  = null;
        StrRutaPDF = null;
        PDF = null;
        StrclConcierge= null;
        StrRutaArchivoEncabezado = null;
        StrclPaginaWeb=null;
        StrRutaPDF=null;
        StrNomFile=null;
        StrclAsistencia=null;
        StrclReferencia=null;
        StrclTipoDocumento=null;

        %>

        <script>
            function fnEnviaMail(rf){
                alert("rf="+rf);
                var pstrCadena = "EnviaPDFConcierge.jsp?";
                pstrCadena = pstrCadena + "clEnvio=1&clReferencia="+rf;
                window.open(pstrCadena,'newWin','scrollbars=yes,status=yes,width=1,height=1');
            }

        </script>
    </body>
</html>
--%>