<%@page contentType="text/html"%>
<%@page pageEncoding="ISO-8859-1" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC"%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
        <title>Vista PDF</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <script type="text/javascript" src='../Utilerias/Util.js'></script>
    </head>
    <body  class="cssBody">

        <%
                    String strclUsr = "0";

                    if (session.getAttribute("clUsrApp") != null) {
                        strclUsr = session.getAttribute("clUsrApp").toString();
                    }
                    if (SeguridadC.verificaHorarioC(Integer.parseInt(strclUsr)) != true) {
        %>Fuera de Horario<%
                        strclUsr = null;
                        return;
                    }

                    String StrStoreProcedure = "",
                            StrParametros = "",
                            StrCorreo = "",
                            StrclPDFxPaginaWeb = "",
                            StrRequestLlave = "",
                            StrStoreCuerpoMail = "",
                            StrRuta = "",
                            StrCampoLlave = "",
                            StrdsPDF = "",
                            StrParametrosPDF = "",
                            StrEditaAsunto = "0",
                            StrLlaveBitacora = "";

                    if (request.getParameter("clPDFxPaginaWeb") != null) {
                        StrclPDFxPaginaWeb = request.getParameter("clPDFxPaginaWeb").toString();
                    }


                    ResultSet rsPDF = null;
                    //System.out.println("sp_GetPDFxPaginaWeb '"+StrclPDFxPaginaWeb+"','0'");
                    rsPDF = UtileriasBDF.rsSQLNP("sp_GetPDFxPaginaWeb '" + StrclPDFxPaginaWeb + "','0'");

                    if (rsPDF.next()) {
                        StrStoreProcedure = rsPDF.getString("StoreProcedure");
                        StrParametros = session.getAttribute(rsPDF.getString("Parametro")) != null ? session.getAttribute(rsPDF.getString("Parametro")).toString() : "";
                        StrRequestLlave = session.getAttribute(rsPDF.getString("ColumnaLlave")) != null ? session.getAttribute(rsPDF.getString("ColumnaLlave")).toString() : "";
                        StrStoreCuerpoMail = rsPDF.getString("StoreCuerpoMail");
                        StrRuta = rsPDF.getString("Ruta");
                        StrCampoLlave = rsPDF.getString("Parametro");
                        StrdsPDF = rsPDF.getString("dsPDF");
                        StrParametrosPDF = rsPDF.getString("ParametrosPDF");
                        StrEditaAsunto = rsPDF.getString("EditaAsunto");
                        StrLlaveBitacora = rsPDF.getString("LlaveBitacora");
                    }

                    rsPDF.close();
                    rsPDF = null;

                    //System.out.println("sp_GetPDFxPaginaWeb '"+StrclPDFxPaginaWeb+"','"+StrRequestLlave+"'");
                    rsPDF = UtileriasBDF.rsSQLNP("sp_GetPDFxPaginaWeb '" + StrclPDFxPaginaWeb + "','" + StrRequestLlave + "'");

                    if (rsPDF.next()) {
                        StrCorreo = rsPDF.getString("Correo");
                    }

                    rsPDF.close();
                    rsPDF = null;

                    if (!StrStoreProcedure.equalsIgnoreCase("")) {%>
        <p class="VTable">
            <input type="hidden" name="EditaAsunto" id="EditaAsunto" value="<%=StrEditaAsunto%>">
            <!--
                        <if (StrEditaAsunto.equalsIgnoreCase("1")) {%>
                        Asunto: <INPUT ID="Asunto" NAME="Asunto" TYPE="TEXT" VALUE="<%=StrCorreo%>" class='VTable' SIZE="32" >
                        <} else {%>
                        <input type="hidden" name="Asunto" id="Asunto" value="">
                        <}%>
                        &nbsp;Correo: <INPUT ID="Correo" NAME="Correo" TYPE="TEXT" VALUE="<%=StrCorreo%>" class='VTable' SIZE="50" >&nbsp;&nbsp; <button class="cBtn" onclick="fn_EnviaPDF();"> Enviar PDF</button></p>
            -->
            <iframe  src="PDF.jsp?StoreProcedure=<%=StrStoreProcedure%>&Parametros=<%=StrParametros%>&ParametrosPDF=<%=StrParametrosPDF%>"  frameborder="0" width=100% height=100%></iframe>

            <% } else {
            %>PDF NO C0NFIGURADO.
            <%}%>

    </body>
    <script>
        function fnClose(){
            window.close();
        }
        
        function fn_EnviaPDF(){
            var pstrCadena = "EnviaPDF.jsp?";
            var pAsunto = document.all.Asunto.value;
            var pEditaAsunto = document.all.EditaAsunto.value;
          
            if (document.all.EditaAsunto.value == 0 ) {
                if (document.all.Correo.value!=''){
                    pstrCadena = pstrCadena + "EditaAsunto="+pEditaAsunto+"&Asunto="+pAsunto+"&StoreProcedure=<%=StrStoreProcedure%>&Parametros=<%=StrParametros%>&ParametrosPDF=<%=StrParametrosPDF%>&StoreCuerpoMail=<%=StrStoreCuerpoMail%>&Ruta=<%=StrRuta%>&CampoLlave=<%=StrCampoLlave%>&LlaveBitacora=<%=StrLlaveBitacora%>&dsPDF=<%=StrdsPDF%>&Correo="+ document.all.Correo.value;
                    window.open(pstrCadena,'EnviaPDF','scrollbars=no,status=no,width=10,height=10');
                }
                else {
                    alert('Debe informar Correo.');
                }
            } else {
                if (document.all.Correo.value!='' && document.all.Asunto.value != ''){
                    pstrCadena = pstrCadena + "EditaAsunto="+pEditaAsunto+"&Asunto="+pAsunto+"&StoreProcedure=<%=StrStoreProcedure%>&Parametros=<%=StrParametros%>&ParametrosPDF=<%=StrParametrosPDF%>&StoreCuerpoMail=<%=StrStoreCuerpoMail%>&Ruta=<%=StrRuta%>&CampoLlave=<%=StrCampoLlave%>&LlaveBitacora=<%=StrLlaveBitacora%>&dsPDF=<%=StrdsPDF%>&Correo="+ document.all.Correo.value;
                    window.open(pstrCadena,'EnviaPDF','scrollbars=no,status=no,width=10,height=10');
                }
                else {  alert('Debe informar Asunto y/o Correo.'); }
            }
 
        }
    </script>
</html>
