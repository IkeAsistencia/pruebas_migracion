<%-- 
    Document   : VistaConfRefConcierge
    Created on : 13/07/2011, 01:15:39 PM
    Author     : atorres


<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%@ page import="com.ike.concierge.GeneraPDFConfRefConcierge,Seguridad.SeguridadC,java.sql.ResultSet,Utilerias.UtileriasBDF" %>
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
        String StrConfirmacion="0";
        String StrclReferencia="0";
        String StrclTipoDocumento="2";
        String StrclSubServicio="0";

        if ( session.getAttribute("clUsrApp") != null) {
            StrclUsrApp = session.getAttribute("clUsrApp").toString();
        }

        if ( SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp) ) != true ) {
            %>Fuera de Horario <%
             StrclUsrApp = null;
             StrclConcierge=null;
             StrclCuenta=null;
             return;
        }

        if (session.getAttribute("clConcierge") != null){
            StrclConcierge = session.getAttribute("clConcierge").toString();
        }

        if  (session.getAttribute("clCuenta") != null) {
            StrclCuenta = session.getAttribute("clCuenta").toString();
        }

        if (request.getParameter("clAsistencia")!= null) {
            StrclAsistencia= request.getParameter("clAsistencia").toString();
            
        } else{
            if (session.getAttribute("clAsistencia")!= null) {
                StrclAsistencia= session.getAttribute("clAsistencia").toString();
                //System.out.println("VistaConfRefConcierge.clAsistencia.Session="+StrclAsistencia);
            }
        }

        if (session.getAttribute("clSubservicio")!= null) {
            StrclSubServicio= session.getAttribute("clSubservicio").toString();
        }

        

        if (request.getParameter("clTipoDocumento")!= null) {
            StrclTipoDocumento= request.getParameter("clTipoDocumento").toString();
        }

        if (request.getParameter("clReferencia")!= null) {
            StrclReferencia= request.getParameter("clReferencia").toString();
           
        }else{
            if (session.getAttribute("clReferencia") != null){
                StrclReferencia = session.getAttribute("clReferencia").toString();
                
            }
        }


        System.out.println("VistaConfRefConcierge.clAsistencia.Request="+StrclAsistencia);
        System.out.println("VistaConfRefConcierge.StrclSubservicio="+StrclSubServicio);
        System.out.println("VistaConfRefConcierge.StrclReferencia.Request="+StrclReferencia);
        System.out.println("VistaConfRefConcierge.StrclReferenciaSession="+StrclReferencia);

        GeneraPDFConfRefConcierge PDF = null;
        PDF = new GeneraPDFConfRefConcierge();

        ResultSet rs = null;

        System.out.println("VistaConfRefConcierge.st_GetEncabezadoConcierge "+StrclCuenta+","+StrclTipoDocumento+","+StrclSubServicio);
        rs = UtileriasBDF.rsSQLNP("st_GetEncabezadoConcierge "+StrclCuenta+","+StrclTipoDocumento+","+StrclSubServicio);

        try{
            if(rs.next()){
                StrRutaArchivoEncabezado = rs.getString("RutaArchivo");
                System.out.println("VistaConfRefConcierge.StrRutaArchivoEncabezado="+ rs.getString("RutaArchivo"));

                StrRutaPDF = "C:\\Proyectos\\Sise\\build\\web\\Operacion\\Concierge\\Files\\";                
                StrNomFile="CF-"+StrclSubServicio+StrclAsistencia+StrclReferencia+StrclConcierge;
                session.setAttribute("RutaPDF",StrRutaPDF);
                session.setAttribute("NomFile",StrNomFile);
                PDF.GeneraPDFConfRefConcierge(StrRutaArchivoEncabezado,StrRutaPDF,StrclConcierge,StrclAsistencia,StrclCuenta,StrclReferencia,StrclTipoDocumento,StrclSubServicio);
                StrclPaginaWeb = "1421";
                MyUtil.InicializaParametrosC(1421,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
                session.setAttribute("clPaginaWebP",StrclPaginaWeb);
                %>
                <div class='VTable'  id="btnEnvia" style="position:absolute; z-index:25; left:800px; top:45px;">
                    <input class='cBtn' type='button' value='Enviar Documento' onClick="fnEnviaMail(<%=StrclReferencia%>);">
                </div>

                <iframe src="Files/CF-<%=StrclSubServicio+StrclAsistencia+StrclReferencia+StrclConcierge%>.PDF" width=1000 height=620 style=' margin-right: 0px; margin-bottom: 0px; margin-top:65px; margin-left: 0px' scrolling="yes"  frameborder="yes">

                </iframe>

                <script>fnOpenLinks()</script>

                <%

                StrclUsrApp  = null;
                StrclPaginaWeb  = null;
                StrRutaPDF = null;
                PDF = null;
                StrclConcierge= null;
            }else{
                %>
                <script>
                    alert('                            !!Atencion!!\n NO EXISTE Encabezado de Confirmacion para este SubServicio');
                </script><%
           }
        }catch(Exception e){
            System.out.println("Error="+e);
        }
        %>

        <script>
            function fnEnviaMail(rf){
                alert("rf="+rf);
                var pstrCadena = "EnviaPDFConcierge.jsp?";
                pstrCadena = pstrCadena + "clEnvio=2&clReferencia="+rf;
                window.open(pstrCadena,'newWin','scrollbars=yes,status=yes,width=1,height=1');
            }

        </script>
    </body>
</html>
--%>