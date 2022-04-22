<%--
 Document   : cBanner
 Create on  : 2010-10-04
 Author     : vsampablo
--%>

<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%@ page import="Utilerias.UtileriasBDF,Seguridad.SeguridadC,java.sql.ResultSet,com.ike.catalogos.DAOcBanner,com.ike.catalogos.to.cBanner" %>

<html>
    <head>
        <title>Administracion de Banner</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>

    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj"/>
        <script type="text/javascript" src='../Utilerias/Util.js'></script>
        <script type="text/javascript" src='../Utilerias/UtilStore.js'></script>
        <script type="text/javascript" src="../Utilerias/tinymce/jscripts/tiny_mce/tiny_mce.js"></script>
        <!--  NUEVO SCRIPT QUE PERMITE LA CARGA DEL EDITOR HTML :: INICIO -->
        <script type="text/javascript">
            //------------------------------------------------------------------------------
            tinyMCE.init({
                mode : "textareas",
                mode : "exact",
                elements: "dsBanner",
                theme : "advanced",
                readonly : true,
                skin : "o2k7",
                plugins : "table,inlinepopups,print,paste",
            
                onchange_callback : "OnChangeHandler",
            
                theme_advanced_buttons1 : "bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,|,forecolor,backcolor,|,cut,copy,pasteword,|,fontselect,fontsizeselect",
                theme_advanced_buttons2 : "",
                theme_advanced_buttons3 : "",
                theme_advanced_buttons4 : "",

                theme_advanced_toolbar_location : "top",
                theme_advanced_toolbar_align : "left",
                theme_advanced_statusbar_location : "bottom",
                theme_advanced_resizing : false,
                height : "40",
                width  : "500",
                theme_advanced_statusbar_location : "none",

                setup : function(ed) {
                    ed.makeReadOnly = function(ro) {
                        var t = this, s = t.settings, DOM = tinymce.DOM, d = t.getDoc();
                        if(!s.readonly && ro) {
                            if (!tinymce.isIE) {
                                try {
                                    d.designMode = 'Off';
                                } catch (ex) { }
                            } else {
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
                                } catch (ex) {}
                            } else {
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
                ed.makeReadOnly(!ed.settings.readonly) ;
            };
        </script>  <!--  NUEVO SCRIPT QUE PERMITE LA CARGA DEL EDITOR HTML :: FIN -->

        <%
                String StrclUsr = "0";
                String StrclPaginaWeb = "0";
                String StrclBanner = "0";

                if (session.getAttribute("clUsrApp") != null) {
                    StrclUsr = session.getAttribute("clUsrApp").toString();
                }

                if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsr)) != true) {
        %> Fuera de Horario <%
                    StrclUsr = null;
                    StrclPaginaWeb = null;
                    StrclBanner = null;
                    return;
                }

                if (request.getParameter("clBanner") != null) {
                    StrclBanner = request.getParameter("clBanner").toString();
                    session.setAttribute("clBanner", StrclBanner);
                } else {
                    if (session.getAttribute("clBanner") != null) {
                        StrclBanner = session.getAttribute("clBanner").toString();
                    }
                }

                DAOcBanner daocBanner = null;
                cBanner B = null;

                daocBanner = new DAOcBanner();
                B = daocBanner.getclBanner(StrclBanner.toString());

        %><script type="text/javascript" >fnOpenLinks()</script><%

                StrclPaginaWeb = "1775";
                session.setAttribute("clPaginaWebP", StrclPaginaWeb);

                //<<<<<<<<<<<< Servlet Generico >>>>>>>>>>>
                String Store = "";
                Store = "st_GuardacBanner,st_ActualizacBanner";
                session.setAttribute("sp_Stores", Store);

                String Commit = "";
                Commit = "clBanner";
                session.setAttribute("Commit", Commit);

        %>

        <%MyUtil.InicializaParametrosC(Integer.parseInt(StrclPaginaWeb), Integer.parseInt(StrclUsr));%>
        <%=MyUtil.doMenuAct("../servlet/com.ike.guarda.EjecutaSP", "toggleReadOnly(tinyMCE.get('dsBanner'));fnClearText();", "toggleReadOnly(tinyMCE.get('dsBanner'));", "fnsp_Guarda();")%>

        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="DetallecBanner.jsp?"%>'>
        <input id="clPaginaWeb" name="clPaginaWeb" type="hidden" value="<%=StrclPaginaWeb%>" >
        <input id="Secuencia" name="Secuencia" type="hidden" value="">
        <input id="SecuenciaG" name="SecuenciaG" type="hidden" value="BannerText,Tiempo,clGpoUsr,Activo,clUsrApp">
        <input id="SecuenciaA" name="SecuenciaA" type="hidden" value="clBanner,BannerText,Tiempo,clGpoUsr,Activo">
        <INPUT id='clUsrApp' name='clUsrApp' type='hidden' value='<%=StrclUsr%>'>
        <INPUT id='clBanner' name='clBanner' type='hidden' value='<%=B != null ? B.getclBanner() : ""%>'>
        <INPUT id='BannerText' name='BannerText' type='HIDDEN' SIZE="50" value='<%=B != null ? B.getdsBanner() : ""%>'>

        <div class='VTable' style='position:absolute; z-index:100; left:30px; top:82px;'>
            <p class='VTable' style='position:absolute; z-index:103; left:30px; top:-12px; text-transform: uppercase'>Descripcion del Banner</p>
            <textarea name="dsBanner" id="dsBanner"><%=B != null ? B.getdsBanner() : ""%></textarea>
        </div>

        <%=MyUtil.ObjChkBox("Activo", "Activo", B != null ? B.getActivo() : "", true, true, 610, 70, "1", "SI", "NO", "")%>
        <%=MyUtil.ObjInput("Tiempo (SEG)", "Tiempo", B != null ? B.getTiempo() : "", true, true, 30, 220, "", true, true, 15)%>
        <%=MyUtil.ObjComboC("Grupo", "clGpoUsr", B != null ? B.getdsGpoUsr() : "", true, true, 140, 220, "", "st_GetGpoxBanner '" + StrclUsr + "'", "", "", 60, true, true)%>
        <%=MyUtil.DoBlock("Detalle del Banner", -100, 0)%>

        <%=MyUtil.GeneraScripts()%>

        <%  //<<<<<<<<<<<<<<<< Limpiar Variables >>>>>>>>>
                StrclUsr = null;
                StrclPaginaWeb = null;
                daocBanner = null;
                B = null;
        %>

        <script>
            function fnClearText(){
                tinyMCE.get('dsBanner').setContent('');
            }
                
            function OnChangeHandler(inst) {
                document.all.BannerText.value = inst.getBody().innerHTML;
            }                
        </script>
    </body>
</html>
