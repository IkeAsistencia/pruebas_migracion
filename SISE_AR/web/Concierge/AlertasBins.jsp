<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<html>
<head>
<title></title>
</head>
<body class="cssBody">
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
<script src='../Utilerias/Util.js'></script>
 <!--  NUEVA LIBRERIAS PARA EL MÓDULO HTML  -->
        <script type="text/javascript" src="../Utilerias/tinymce/jscripts/tiny_mce/tiny_mce.js"></script>
        
        <!--  NUEVO SCRIPT QUE PERMITE LA CARGA DEL EDITOR HTML :: INICIO -->
        <script type="text/javascript">
            tinyMCE.init({
                mode : "textareas",
                mode : "exact",
                elements: "Mensaje",
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
        
    

      	if (session.getAttribute("clUsrApp")!= null){
       		strclUsr = session.getAttribute("clUsrApp").toString(); 
        }  
        
      	if (request.getParameter("clPaginaWeb")!= null){
            StrcvePaginaWeb= request.getParameter("clPaginaWeb").toString(); 
      	}  
        
        
        String StrclCSBin = "";
        
        

        if (request.getParameter("clCSBin")!= null){
            StrclCSBin= request.getParameter("clCSBin").toString(); 
      	}  
        
        StringBuffer StrSql = new StringBuffer();

        
        StrSql.append( " sp_DetalleBins ").append(StrclCSBin) ;

              
       	String StrclPaginaWeb = "1205";
	session.setAttribute("clPaginaWebP",StrclPaginaWeb);
       %>
        
       <%
       	MyUtil.InicializaParametrosC(1205,Integer.parseInt(strclUsr)); 
        ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
        %>
        
         
	<%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion","toggleReadOnly(tinyMCE.get('Mensaje'));","toggleReadOnly(tinyMCE.get('Mensaje'));","")%>
        

        
        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1) + "AlertasBins.jsp?"%>'>
        
       <% if (rs.next()) { %>
                <input type="hidden" value="0" id="Otorgar"  name="Otorgar">
                <input type="hidden" value="<%=rs.getString("clCSBin")%>" id="clCSBin"  name="clCSBin">
                
                
                <%=MyUtil.ObjInput("Numero Bin","NumeroBin",rs.getString("NumeroBin"),true,true,25,80,"",true,true,15)%>
                <%=MyUtil.ObjComboC("Nombre de Cuenta", "clCuenta", rs.getString("Nombre"), true, true, 150, 80, "", "sp_GetCuentaxBin", "", "", 100, true, true)%>
                <%=MyUtil.ObjInput("Banco","Banco",rs.getString("Banco"),true,true,25,130,"",true,true,45)%>
                <%=MyUtil.ObjInput("Tipo Tarjeta","TipoTarjeta",rs.getString("TipoTarjeta"),true,true,300,130,"",true,true,45)%>
                
                
                 <INPUT id='HTML' name='HTML' type='hidden' value='1'>
                    <div class='VTable' style='position:absolute; z-index:100; left:25px; top:200px;'>
                        <p class='VTable' style='position:absolute; z-index:103; left:0px; top:-12px; text-transform: uppercase'>Mensaje</p>
                        <textarea name="Mensaje" id="Mensaje"><%=rs.getString("Mensaje")%></textarea>
                    </div>
 
       <% }
	else{%>

                <input type="hidden" value="0" id="Otorgar"  name="Otorgar">
                <input type="hidden" value="" id="clCSBin"  name="clCSBin">
                <%=MyUtil.ObjInput("Numero Bin","NumeroBin","",true,false,25,80,"",false,false,15)%>
                <%=MyUtil.ObjComboC("Nombre de Cuenta", "clCuenta", "", true, true, 225, 80, "", "sp_GetCuentaxBin", "", "", 100, true, true)%>
                <%=MyUtil.ObjInput("Banco","Banco","",true,true,25,130,"",true,true,45)%>
                <%=MyUtil.ObjInput("Tipo Tarjeta","TipoTarjeta","",true,true,300,130,"",true,true,45)%>
                
                 <INPUT id='HTML' name='HTML' type='hidden' value='1'>
                    <div class='VTable' style='position:absolute; z-index:100; left:25px; top:200px;'>
                        <p class='VTable' style='position:absolute; z-index:103; left:0px; top:-12px; text-transform: uppercase'>Mensaje</p>
                        <textarea name="Mensaje"></textarea>
                    </div>
	
	<%}%>
			 
        <%=MyUtil.DoBlock("Alertas x Bins",70,440)%>
	<%=MyUtil.GeneraScripts()%>
	<% 
           rs.close();
           
           rs=null;
          
          %>
</body>

</html>