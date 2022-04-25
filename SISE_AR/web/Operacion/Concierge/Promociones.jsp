<%-- 
    Document   : Promociones
    Created on : 6/12/2010, 11:59:10 AM
    Author     : rfernandez
--%>

<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<html>
    <head>
        <title>Promociones</title>
    </head>
<body class="cssBody">
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
<script src='../Utilerias/Util.js'></script>

        <script type="text/javascript" src="../Utilerias/tinymce/jscripts/tiny_mce/tiny_mce.js"></script>
        
        <script type="text/javascript">
            tinyMCE.init({
                mode : "textareas",
                mode : "exact",
                elements: "dsPromosion",
                theme : "advanced",
                readonly : true,
                skin : "o2k7",
                plugins : "table,inlinepopups,print,paste",
                	// Theme options

                theme_advanced_buttons1 : "newdocument,|,bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,|,formatselect,fontselect,fontsizeselect",
                theme_advanced_buttons2 : "cut,copy,paste,pastetext,pasteword,|,search,|,bullist,numlist,|,outdent,indent,|,undo,redo,|,insertdate,inserttime,|,forecolor,backcolor,|,print",
                //theme_advanced_buttons3 : "",
                theme_advanced_buttons3 : "",
                theme_advanced_buttons4 : "",

                theme_advanced_toolbar_location : "top",
                theme_advanced_toolbar_align : "left",
                theme_advanced_statusbar_location : "bottom",
                theme_advanced_resizing : false,
                height : "400",
                width  : "520",

                theme_advanced_statusbar_location : "none",

                setup : function(ed) {
                    ed.makeReadOnly = function(ro) {
                        var t = this, s = t.settings, DOM = tinymce.DOM, d = t.getDoc();

                        if(!s.readonly && ro) {
                            if (!tinymce.isIE) {
                                try {
                                    d.designMode = 'Off';
                                } catch (ex) {

                                }
                            } else {
                                // It will not steal focus if we hide it while setting contentEditable
                                b = t.getBody();
                                DOM.hide(b);
                                b.contentEditable = false;
                                DOM.show(b);
                            }
                            s.readonly = true;
                        } else if(s.readonly && !ro) {
                            if (!tinymce.isIE) {
                                try {
                                    d.designMode = 'On';
                                } catch (ex) {

                                }
                            } else {
                                // It will not steal focus if we hide it while setting contentEditable
                                b = t.getBody();
                                DOM.hide(b);
                                b.contentEditable = true;
                                DOM.show(b);
                            }
                            s.readonly = false;
                        }
                        return s.readonly;
                    };

                    if(ed.settings.readonly) {
                        ed.settings.readonly = false;
                        ed.onInit.add(function(ed) {
                            toggleReadOnly(ed);
                        });
                    }
                }
            });

            function toggleReadOnly(ed) {
                //var btn = document.getElementById('btn1');
                 ed.makeReadOnly(!ed.settings.readonly) ;
            };

</script>

        <!--  NUEVO SCRIPT QUE PERMITE LA CARGA DEL EDITOR HTML :: FIN -->
<%
    	String StrcvePaginaWeb = "0";
    	String strclUsr = "";
        String StrclPromocion = "0";
        String StrclCuenta = "";
        String StrclSubservicio = "";


      	if (session.getAttribute("clUsrApp")!= null){
       		strclUsr = session.getAttribute("clUsrApp").toString();
        }

      	if (request.getParameter("clPaginaWeb")!= null){
            StrcvePaginaWeb= request.getParameter("clPaginaWeb").toString();
      	}
      
        if (request.getParameter("clPromocion")!= null){
            StrclPromocion= request.getParameter("clPromocion").toString();
      	}



        StringBuffer StrSql = new StringBuffer();
        StrSql.append( " sp_DetallePromocion ").append(StrclPromocion) ;

       	String StrclPaginaWeb = "1292";
	session.setAttribute("clPaginaWebP",StrclPaginaWeb);
       %>
      
       <%
       	MyUtil.InicializaParametrosC(1292,Integer.parseInt(strclUsr));
        ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());

        System.out.println("si entra"+StrSql.toString());
        %>

	<%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion","fnAccionesAlta();toggleReadOnly(tinyMCE.get('dsPromosion'));","toggleReadOnly(tinyMCE.get('dsPromosion'));","")%>

        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1) + "Promociones.jsp?"%>'>

       <% if (rs.next()) {%>
                <input id="clPromocion"  type="hidden" value="<%=rs.getString("clPromocion")%>"  name="clPromocion">
                <INPUT id='FechaRegistro' name='FechaRegistro' type='hidden' value=''>
                <INPUT id='clCuenta' name='clCuenta' type='hidden' value="<%=rs.getString("clCuenta")%>">

                <%=MyUtil.ObjComboC("Subservicio", "clSubservicio",rs.getString("dsSubservicio"), true, true, 25, 80, "", "select clSubservicio,dsSubservicio from CScSubservicio order by dsSubservicio asc", "", "", 30, false, false)%>
                <%=MyUtil.ObjInput("Cuenta","NombreVTR",rs.getString("NombreC"),true,true,25,130,"",true,true,35,"if(this.readOnly==false){fnBuscaCuenta();}")%>
                    <%if (MyUtil.blnAccess[4] == true) {
                    %><div class='VTable' style='position:absolute; z-index:25; left:225px; top:145px;'>
                    <IMG SRC='../Imagenes/Lupa.gif' onClick='fnBuscaCuenta();' WIDTH=20 HEIGHT=20></div>
                    <%}%>
                <%=MyUtil.ObjChkBox("Activo", "Activo",rs.getString("Activo"), true, true,280 ,140,"","")%>
               
                    <div class='VTable' style='position:absolute; z-index:100; left:25px; top:200px;'>
                        <p class='VTable' style='position:absolute; z-index:103; left:0px; top:-12px; text-transform: uppercase'>Promocion</p>
                        <textarea name="dsPromosion" id="dsPromosion"><%=rs.getString("dsPromosion")%></textarea>
                    </div>
       <% }else{%>
                <input id="clPromocion" type="hidden" value=""   name="clPromocion">
                <INPUT id='FechaRegistro' name='FechaRegistro' type='hidden' value=''>
                <INPUT id='clCuenta' name='clCuenta' type='hidden' value="<%=StrclCuenta%>">

                <%=MyUtil.ObjComboC("Subservicio", "clSubservicio","", true, true, 25, 80, "", "select clSubservicio,dsSubservicio from CScSubservicio order by dsSubservicio asc", "", "", 30, false, false)%>
                <%=MyUtil.ObjInput("Cuenta","NombreVTR","",true,true,25,130,"",true,true,35,"if(this.readOnly==false){fnBuscaCuenta();}")%>
                   <%if (MyUtil.blnAccess[4] == true) {
                    %><div class='VTable' style='position:absolute; z-index:25; left:225px; top:145px;'>
                        <IMG SRC='../Imagenes/Lupa.gif' onClick='fnBuscaCuenta();' WIDTH=20 HEIGHT=20></div>
                <%}%>
                <%=MyUtil.ObjChkBox("Activo", "Activo","", true, true,280 ,140,"","")%>

                    <div class='VTable' style='position:absolute; z-index:100; left:25px; top:200px;'>
                        <p class='VTable' style='position:absolute; z-index:103; left:0px; top:-12px; text-transform: uppercase'>Promocion</p>
                        <textarea name="dsPromosion" id="dsPromosion"></textarea>
                    </div>
	<%}%>
        <%=MyUtil.DoBlock("Promociones",100,440)%>
	<%=MyUtil.GeneraScripts()%>

	<%
           rs.close();
           rs=null;
          %>

 <script>

        function fnBuscaCuenta(){
            if (document.all.NombreVTR.value!=''){
                if (document.all.Action.value==1){
                    var pstrCadena = "../Utilerias/FiltrosCuenta.jsp?strSQL=sp_WebBuscaCuenta ";
                    pstrCadena = pstrCadena + "&Cuenta= " + document.all.NombreVTR.value;
                    document.all.clCuenta.value='';
                    window.open(pstrCadena,'newWin','scrollbars=yes,status=yes,width=700,height=500');
                }
            }
        }

        function fnActualizaDatosCuenta(dsCuenta,clCuenta){
            document.all.NombreVTR .value = dsCuenta;
            document.all.clCuenta.value = clCuenta;
           }

        function fnAccionesAlta(){
                if (document.all.Action.value==1){
                    var pstrCadena = "../Utilerias/RegresaFechaActual.jsp";
                    window.open(pstrCadena,'newWin','width=10,height=10,left=1500,top=2000');
                }
            }

        function fnActualizaFechaActual(pFecha){
                document.all.FechaRegistro.value = pFecha;
            }

          </script>
</body>
</html>