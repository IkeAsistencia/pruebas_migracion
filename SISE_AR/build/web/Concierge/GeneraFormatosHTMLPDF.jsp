<%--
    Document   : GeneraFormatosHTMLPDF
    Created on : 15/06/2011, 05:13:47 PM
    Author     : atorres
--%>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%@page import="java.io.File,java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>


<html>
    <head><title>Encabezados Concierge</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody" >
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" />
        <script src='../Utilerias/Util.js' ></script>
        <script src='../Utilerias/UtilStore.js' ></script>
        <%

        System.out.println("Entre a GeneraFormatosHTMLPDF");

        String StrclUsrApp = "0";
        String StrclFormato= "0";
        String StrRutaImg="";
        String StrclCuenta="0";
        String StrTipoImagen ="EncabezadoF";
        int Px = 0, Py = 0;
        //
        if (session.getAttribute("clUsrApp")!=null){
            StrclUsrApp = session.getAttribute("clUsrApp").toString();
        }

        session.setAttribute("TipoImagen",StrTipoImagen);
        
        if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true){
            %><b>Fuera de Horario</b><%
            StrclUsrApp = null;
            StrclFormato = null;
            return;
        }

        if ( request.getParameter("clFormato")!= null )  {
             StrclFormato = request.getParameter("clFormato").toString();
             session.setAttribute("clFormato",StrclFormato);
        }

        ResultSet rs= null;        
        rs = UtileriasBDF.rsSQLNP("st_GetDatosFormatosConcierge "+StrclFormato);

        String StrclPaginaWeb = "1385";
        session.setAttribute("clPaginaWebP",StrclPaginaWeb);

        
        %>

        
        
        <%MyUtil.InicializaParametrosC(Integer.parseInt(StrclPaginaWeb),Integer.parseInt(StrclUsrApp));%>       
        <%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion","fnAlta();","","")%>

        
        <%if (rs.next()){ Py = 250; %>
            <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%>GeneraFormatosHTMLPDF.jsp?'>
            <input id="clFormato"  name="clFormato" type="hidden" value="<%=rs.getString("clFormato")%>">
            <input id="clCuenta"  name="clCuenta" type="hidden" value="<%=rs.getString("clCuenta")%>">
            
            <%
                StrclCuenta = rs.getString("clCuenta");
                session.setAttribute("clCuenta",StrclCuenta);
                
                StrRutaImg = rs.getString("RutaImg");
                if (StrRutaImg.indexOf("Imagenes")!=-1 ){
                    StrRutaImg = StrRutaImg.substring(StrRutaImg.indexOf("Imagenes"),StrRutaImg.length());
                }
            %>

            <div  style='position:absolute; z-index:1; left:20px; top:60px; width:610px; height:120px;' >
            <iframe src="Imagen.jsp?srcImg=<%=StrRutaImg%>&Nota=La imagen aplica para todos los formatos de la misma cuenta.&Width=575&Height=60&Top=130" scrolling="no"  frameborder="no" width=810 height=250></iframe>
            </div>              


            <div id="DivFormatos" style='position:absolute; z-index:2000; left:0px; top:0px; width:810px;' >
                
                <%=MyUtil.ObjInput("Nombre Formato","dsFormato",rs.getString("dsFormato") != null ? rs.getString("dsFormato"): "",true,true,30,50+Py,"",true,true,40)%>
                <%=MyUtil.ObjInput("Nombre Cuenta", "Nombre", rs.getString("Nombre") != null ? rs.getString("Nombre"): "", true, true, 370, 50+Py, "", false, false, 40, "if(this.readOnly==false){fnBuscaCuenta();}")%>
                
                <div class='VTable' style='position:absolute; z-index:25; left:595px; top:<%=63+Py%>px;'>
                    <IMG SRC='../Imagenes/Lupa.gif' onClick='fnBuscaCuenta();' WIDTH=20 HEIGHT=20>
                </div>
                
                <%=MyUtil.ObjComboC("SubServicio","clSubServicio",rs.getString("dsSubServicio") != null ? rs.getString("dsSubServicio"): "",true,true,30,90+Py,"","SELECT clSubServicio, dsSubServicio FROM CScSubServicio WHERE clsubservicio NOT IN(18,19,14) ","","",30,false,false)%>
                <%=MyUtil.ObjComboC("Tipo Documento","clTipoDocumento",rs.getString("dsTipoDocumento") != null ? rs.getString("dsTipoDocumento"): "",true,true,370,90+Py,"","SELECT clTipoDocumento, dsTipoDocumento FROM CScTipoDocumento","","",30,false,false)%>        
                
                <%//MyUtil.ObjInput("Correo Electronico (Salida)","CorreoSalida",rs.getString("CorreoSalida") != null ? rs.getString("CorreoSalida"): "",true,true,30,130+Py,"",true,true,50)%>
                <%=MyUtil.ObjComboC("Correo","clTipoEnvioMail",rs.getString("Correo") != null ? rs.getString("Correo"): "",true,true,30,130+Py,"","st_CSCorreosFormatos","","",60,false,false)%>        
                
                <%=MyUtil.ObjTextArea("Texto Antes de Datos","TxtAD", rs.getString("TxtAD") != null ? rs.getString("TxtAD") : "","113","6",true,true,30,180+Py,"",false,false)%>
                <%=MyUtil.ObjTextArea("Condiciones","Cond", rs.getString("Cond") != null ? rs.getString("Cond"): "","113","6",true,true,30,270+Py,"",false,false)%>
                <%=MyUtil.ObjTextArea("Texto Despues de Datos","TxtDD", rs.getString("TxtDD") != null ? rs.getString("TxtDD"): "","113","6",true,true,30,360+Py,"",false,false)%>
                <%=MyUtil.ObjTextArea("Firma","Firma",  rs.getString("Firma") != null ? rs.getString("Firma"): "","113","6",true,true,30,450+Py,"",false,false)%>
                <%=MyUtil.ObjTextArea("Pie de Página","PP", rs.getString("PP") != null ? rs.getString("PP"): "","113","6",true,true,30,540+Py,"",false,false)%>
                
               <%=MyUtil.DoBlock("Detalle de Formato",70,60)%>
            </div>
        <%}else{ Py = 250; %>

        <div id="DivFormatos" style='position:absolute; z-index:2000; left:0px; top:-225px; width:800px;' >
            <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%>GeneraFormatosHTMLPDF.jsp?'>
            <input id="clFormato"  name="clFormato" type="hidden" value="">
            <input id="clCuenta"  name="clCuenta" type="hidden" value="">          
            
            
            
            <%=MyUtil.ObjInput("Nombre Formato","dsFormato","",true,true,30,50+Py,"",true,true,40)%>
            <%=MyUtil.ObjInput("Nombre Cuenta", "Nombre", "", true, true, 370, 50+Py, "", false, false, 40, "if(this.readOnly==false){fnBuscaCuenta();}")%>
            
            <div class='VTable' style='position:absolute; z-index:25; left:595px; top:<%=63+Py%>px;'>
                <IMG SRC='../Imagenes/Lupa.gif' onClick='fnBuscaCuenta();' WIDTH=20 HEIGHT=20>
            </div>
            
            <%=MyUtil.ObjComboC("SubServicio","clSubServicio","",true,true,30,90+Py,"","SELECT clSubServicio, dsSubServicio FROM CScSubServicio WHERE clsubservicio NOT IN(18,19,14) ","","",30,false,false)%>
            <%=MyUtil.ObjComboC("Tipo Documento","clTipoDocumento","",true,true,370,90+Py,"","SELECT clTipoDocumento, dsTipoDocumento FROM CScTipoDocumento","","",30,false,false)%>        
            
            <%//MyUtil.ObjInput("Correo Electronico (Salida)","CorreoSalida","",true,true,30,130+Py,"",true,true,50)%>
            <%=MyUtil.ObjComboC("Correo","clTipoEnvioMail","",true,true,30,130+Py,"","st_CSCorreosFormatos","","",60,false,false)%>        
            
            <%=MyUtil.ObjTextArea("Texto Antes de Datos","TxtAD", "","113","6",true,true,30,180+Py,"",false,false)%>
            <%=MyUtil.ObjTextArea("Condiciones","Cond", "","113","6",true,true,30,270+Py,"",false,false)%>
            <%=MyUtil.ObjTextArea("Texto Despues de Datos","TxtDD","","113","6",true,true,30,360+Py,"",false,false)%>
            <%=MyUtil.ObjTextArea("Firma","Firma", "","113","6",true,true,30,450+Py,"",false,false)%>
            <%=MyUtil.ObjTextArea("Pie de Página","PP","","113","6",true,true,30,540+Py,"",false,false)%>
            <%=MyUtil.DoBlock("Detalle de Formato",70,60)%>
        </div>
        <%}%>

        <%=MyUtil.GeneraScripts()%>

    
        
        <%
        StrclUsrApp = null;
        %>


        <script>

            function fnAlta(){
                     DivFormatos.style.top="-225px";
            }

            function fnAsignaAVarFile(){
                //alert(document.all.RutaNueva.value.length);
                if (document.all.RutaNueva.value.length!=0){
                    document.all.RutaImg.value = document.all.RutaNueva.value
                }
            }

            function fnBuscaCuenta(){
                if (document.all.Nombre.value!=''){
                    //if (document.all.Action.value==1){
                        var pstrCadena = "../Utilerias/FiltrosCuenta.jsp?strSQL=sp_WebBuscaCuenta ";
                        pstrCadena = pstrCadena + "&Cuenta= " + document.all.Nombre.value;
                        document.all.clCuenta.value='';
                        window.open(pstrCadena,'newWin','scrollbars=yes,status=yes,width=700,height=500');
                    //}
                }
            }

            function fnActualizaDatosCuenta(dsCuenta,clCuenta,clTipoVal, Msk, MskUsr, Agentes){
                document.all.Nombre.value = dsCuenta;
                document.all.clCuenta.value = clCuenta;
                //document.all.ClaveMsk.value = Msk;
                //document.all.ClaveMskUsr.innerHTML = MskUsr;
                //strclTipoVal=clTipoVal;
            }

            function fnAntesGuardar(){
                if (document.all.RutaImg.value!=''){
                    var bc = 0, len=0;
                    var strRst = ''
                    strAux = document.all.RutaImg.value;
                    bc= strAux.indexOf('Imagenes');
                    //alert('Posicion de Imagenes'+bc);
                    len= strAux.length;
                    //alert('Len='+len);
                    strRst = strAux.substring(bc,len);
                    strRst = "../" + strRst.replace(/\\/ig,"/");
                    //alert('strRst='+strRst);
                    document.all.RutaURL.value = strRst;
                }
            }

            function fnValRutaNueva(){
                fnAsignaAVarFile();
                fnAntesGuardar();

            }


        </script>
        
    </body>
</html>