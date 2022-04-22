<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<html>
<head>
<title></title>
</head>
<body class="cssBody" onload="" >
<link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
<link href="../../StyleClasses/Calendario.css" rel="stylesheet" type="text/css"> 
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
<script src='../../Utilerias/Util.js' ></script>
<script src='../../Utilerias/UtilAuto.js' ></script>
<script src="../../Utilerias/UtilCalendario.js"></script>
<script src='../../Utilerias/UtilMask.js'></script>
<script src='../Utilerias/UtilDireccion.js'></script>

<script type="text/javascript" src="../../Geolocalizacion/modernizr-custom.js"></script>
<script type="text/javascript" src="../../Geolocalizacion/js/jquery.js"></script>
<script type="text/javascript" src="../../Geolocalizacion/js/mapUtils.js"></script>

<%             
            String StrclExpediente = "0";
    	    String strclUsr = "0";
            String StrclPais = "10";
            String StrdsPais = "";
            String StrdsEntFed = "";
            String StrCodEnt = "";
            String StrdsMunDel = "";
            String StrCodMD = "";
            String StrCalleNum = "";
            String StrclCuenta = "0";
            String StrClave = "";
            String StrdsSubServicio = "";
            String StrLimiteMonto = "";
            String StrclSubServicio = "0";
            String StrclUbFallaH = "0";
        


      	if (session.getAttribute("clUsrApp")!= null)
      	{
       		strclUsr = session.getAttribute("clUsrApp").toString(); 
        }
        
        if (SeguridadC.verificaHorarioC(Integer.parseInt(strclUsr)) != true) {
                %>Fuera de Horario<%
                return;
            }

     	if (session.getAttribute("clExpediente")!= null)
      	{
            StrclExpediente= session.getAttribute("clExpediente").toString(); 
       	}

        ResultSet cdr = UtileriasBDF.rsSQLNP( "sp_DetalleExpediente " + StrclExpediente );
            if (cdr.next()) {
                StrCodEnt   = cdr.getString("CodEnt");
                StrdsEntFed = cdr.getString("dsEntFed");
                StrCodMD    = cdr.getString("CodMD");
                StrdsMunDel = cdr.getString("dsMunDel");
            }
            else {
                out.println("ERROR NO SE PUEDE OBTENER DATOS DEL EXPEDIENTE");
                return;
            }
 
        StringBuffer StrSql = new StringBuffer();
        StrSql.append(" Select exped.TieneAsistencia, ");
        StrSql.append(" EXPED.CodEnt, E.dsEntFed, EXPED.CodMD, D.dsMunDel, EXPED.clCuenta");
        StrSql.append(" From Expediente EXPED");
        StrSql.append(" LEFT JOIN cEntFed E ON(E.CodEnt = EXPED.CodEnt) ");
        StrSql.append(" LEFT JOIN cMunDel D ON(E.CodEnt = D.CodEnt and D.CodMD=EXPED.CodMD) ");
        StrSql.append(" Where clExpediente=").append(StrclExpediente);

        ResultSet rs2 = UtileriasBDF.rsSQLNP( StrSql.toString());   
        StrSql.delete(0,StrSql.length());
      
         if (rs2.next())  
         { 
            StrSql.append(" select clExpediente, ");
            StrSql.append(" coalesce(convert(varchar(16),FechaSiniestro,120),'') FechaSiniestro, ");
            StrSql.append(" coalesce(Hora,'') Hora, ");
            StrSql.append(" coalesce(Observaciones,'') Observaciones,");
            StrSql.append(" coalesce(ObservAjustador,'') ObservAjustador,");
            StrSql.append(" PeatonOP,");
            StrSql.append(" CiclistaOP,");
            StrSql.append(" AutomovilOP,");
            StrSql.append(" MotovehiculoOP,");          
            StrSql.append(" CamionOP,");
            StrSql.append(" TransporteOP,");
            StrSql.append(" OtroOP ");
            StrSql.append(" FROM AsistenciaSiniestro");
            StrSql.append(" Where clExpediente= ").append(StrclExpediente);

         }else{

             %><%="El expediente no existe"%><%
               rs2.close();
               rs2=null;    
               return;
         }
       	String StrclPaginaWeb = "6172";
	session.setAttribute("clPaginaWebP",StrclPaginaWeb);
int iRowPx = 80;
%> 
        <SCRIPT>fnOpenLinks()</script> 
<% MyUtil.InicializaParametrosC(611,Integer.parseInt(strclUsr)); 
   %>
<%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist","")%>
<%
        if(rs2.getString("TieneAsistencia").compareToIgnoreCase("1")==0){
            %><script>document.all.btnAlta.disabled=true;</script><%
        }else{
            %><script>document.all.btnCambio.disabled=true</script><%
        }
            ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
            StrSql.delete(0,StrSql.length());
            StrSql=null;

  %>
<%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="Lesionados.jsp?'>"%>

        <%if (rs.next()) {
            %>
            
              <%
                    StringBuffer StrSql2 = new StringBuffer();
                    StrSql2.append(" Select convert(varchar(16),getdate(),120) 'FechaActual' ");
                    ResultSet rs3 = UtileriasBDF.rsSQLNP( StrSql2.toString());   
                    StrSql2.delete(0,StrSql2.length());

                     if (rs3.next())  {
                %>
                <INPUT id='FechaActualVTR' name='FechaActualVTR' type='hidden' value='<%=rs3.getString("FechaActual")%>'>
                <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
                <INPUT id='clAjustador' name='clAjustador' type='hidden' value='0'>
                <% } 
                            rs3.close();
                            rs3=null;  %>
              <%=MyUtil.ObjInputF("Fecha del Siniestro (AAAA-MM-DD HH:MM)", "FechaSiniestro",rs.getString("FechaSiniestro"), true, true, 30, 70, "", false, false,20, 2, "if(this.readOnly==false){fnValMask(this,document.all.FechaSiniestraMsk.value,this.name)};")%>
              <%=MyUtil.ObjInput("Hora (24 hrs.)","Hora",rs.getString("Hora"),true,true,400,70,"",false,false,6,"fnHrsD(this);")%>             
              <%=MyUtil.ObjTextArea("Lugar Exacto (Ubicación Siniestro)","Observaciones",rs.getString("Observaciones"),"60","4",true,true,30,110,"",false,false)%>
              <%=MyUtil.ObjTextArea("¿Qué ocurrio?","ObservAjustador",rs.getString("ObservAjustador"),"60","4",true,true,400,110,"",false,false)%>                                        
              <%=MyUtil.DoBlock("Datos Generales",200,50)%>  
              

              
        <%
        String sTmpDirA = new String( StrdsEntFed + ", " + StrdsMunDel + ", " + (rs.getString("Calle")) );
        %>

        <input type="hidden" name="calle" id="DireccionA" value="<%=sTmpDirA%>" >
        <div class='VTable' style='position:absolute; z-index:20; left:510px; top:<%=iRowPx+16%>px; '>
            <INPUT id="MapaOrig" type='button' VALUE='Mapa' onClick='openMap("DireccionA", "LatLong","Calle","dsMunDel","dsEntFed","CodMD","CodEnt");return false;' class='cBtn'>
        </div>
        <%=MyUtil.ObjInput("Provincia", "dsEntFed", StrdsEntFed, false, false, 30, iRowPx, StrdsEntFed, false, false, 45)%>
        <%=MyUtil.ObjInput("Localidad", "dsMunDel", StrdsMunDel, false, false, 280, iRowPx, StrdsEntFed, false, false, 45)%>
        <input type="hidden" id="CodMD" name="CodMD" value="<%=StrCodMD%>">
        <input type="hidden" id="CodEnt" name="CodEnt" value="<%=StrCodEnt%>">
        <%
        iRowPx = iRowPx + 30;
        %>
        <%=MyUtil.ObjInput("Calle", "Calle",rs.getString("Calle"), true, true, 30, iRowPx, "", false, false, 58)%>
        <%=MyUtil.ObjInput("Latitud y Longitud", "LatLong", rs.getString("LatLong"), true, true, 330, iRowPx, "", false, false, 34)%>

        <%
        iRowPx = iRowPx + 30;
        %>
        <%=MyUtil.ObjTextArea("Referencias Visuales", "Referencias", rs.getString("Referencias"), "75", "5", true, true, 30, iRowPx, "", false, false)%>
        <%=MyUtil.DoBlock("Domicilio", 80, 40)%>

        <%
        iRowPx = iRowPx + 130;
        %>
              
              
<%
        }
	    else{
                    StringBuffer StrSql2 = new StringBuffer();
                    StrSql2.append(" Select convert(varchar(16),getdate(),120) 'FechaActual' ");
                    ResultSet rs3 = UtileriasBDF.rsSQLNP( StrSql2.toString());   
                    StrSql2.delete(0,StrSql2.length());

                     if (rs3.next())  {
                %>
                <INPUT id='FechaActualVTR' name='FechaActualVTR' type='hidden' value='<%=rs3.getString("FechaActual")%>'>
                <% } 

                            rs3.close();
                            rs3=null;  %>
              
              <%=MyUtil.ObjInput("Motivo","Motivo","",true,true,30,82,"",false,false,25,"")%>
              <%=MyUtil.ObjInput("Cantidad de <br> Personas","CantPersonas","",true,true,210,70,"",false,false,3,"")%>            
              <%=MyUtil.ObjInputF("Fecha de Traslado", "FechaTraslado","", true, true, 340, 82, "", false, false,20, 2, "if(this.readOnly==false){fnValMask(this,document.all.FechaSiniestraMsk.value,this.name)};")%>              
              <%=MyUtil.ObjInput("Hora (24 hrs.)","Hora","",true,true,500,82,"",false,false,6,"fnHrsD(this);")%>            
              
              
        

    
        <div class='VTable' style='position:absolute; z-index:20; left:510px; top:<%=iRowPx+16%>px; '>
            <INPUT id="MapaOrig" type='button' VALUE='Mapa' onClick='openMap("DireccionA", "LatLong","Calle","dsMunDel","dsEntFed","CodMD","CodEnt");return false;' class='cBtn'>
        </div>
        <%=MyUtil.ObjInput("Provincia", "dsEntFed", StrdsEntFed, false, false, 30, iRowPx, StrdsEntFed, false, false, 45)%>
        <%=MyUtil.ObjInput("Localidad", "dsMunDel", StrdsMunDel, false, false, 280, iRowPx, StrdsEntFed, false, false, 45)%>
        <input type="hidden" id="CodMD" name="CodMD" value="<%=StrCodMD%>">
        <input type="hidden" id="CodEnt" name="CodEnt" value="<%=StrCodEnt%>">
              
              
              <%=MyUtil.ObjTextArea("Observaciones","Observaciones","","60","4",true,true,30,150,"",false,false)%> 
              <%=MyUtil.ObjInput("Costo","Costo","",true,true,400,150,"",false,false,8,"")%>
                            
              <%=MyUtil.DoBlock("Datos Generales de Traslado",150,50)%> 
                <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
                                                               
              
              
        <% } %>	
        
       
<%
        rs2.close();
        rs.close();
        rs2=null;
        rs=null;
        StrSql=null;
        StrclExpediente = null;
 	strclUsr = null;
        StrclPaginaWeb=null;
%>
<%=MyUtil.GeneraScripts()%>
<input name='FechaSiniestraMsk' id='FechaSiniestraMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
<input name='FechaCartaRec3Msk' id='FechaCartaRec3Msk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
<input name='FechaCartaNaMsk' id='FechaCartaNaMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
<input name='FechaCopiaFotostaticaMsk' id='FechaCopiaFotostaticaMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
<input name='FechaFotografiasMsk' id='FechaFotografiasMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
<input name='FechaPresupRepMsk' id='FechaPresupRepMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
<input name='FechaFactOriginalNaMsk' id='FechaFactOriginalNaMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
<input name='FechaCopiaUltimoReciboMsk' id='FechaCopiaUltimoReciboMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>

 <script type="text/javascript">
  
           function fnHrsD(campo){
                var StrHoraDL=(document.getElementById("Hora").value.length);                
                    if(StrHoraDL <= 2){                   
                        var StrHoraDV=(document.getElementById("Hora").value);
                        var min=":00";
                        var res = StrHoraDV.concat(min);
                        campo.value=res;
                }
                validaHora(campo);
            }
  
           function validaHora(campo){
                var patt =/^\d{2}:\d{2}/g
                if(!patt.test(campo.value)){
                    campo.value="";
                    alert("Formato 24 Hrs (hh:mm)");
                }else{
                    var agr=campo.value.split(":");
                    if(parseInt(agr[0])>24||parseInt(agr[1])>59){
                        campo.value="";
                        alert("Formato 24 Hrs (hh:mm)");
                    }
                }
            }
            
            
              $(document).ready(function() {
                $("#btnCambio").click(function() {
                    document.getElementById("DireccionA").disabled = false; 
                });
                $("#btnAlta").click(function() {
                    document.getElementById("DireccionA").disabled = false; 
                });
                $("#CalleNum").change(function() {
                    document.getElementById("LatLong").value = "";
                })
            });

            function setupClickListener(id) {
              var button = document.getElementById(id);
              button.addEventListener('click', function() {
                fillInAddress();
              });
            }

            
            function fnBuscaGeo() {
                var pstrCadena = "/SISE_AR/Geolocalizacion/showMap.jsp";
                window.open(pstrCadena, 'newWin', 'scrollbars=yes,status=yes,width=900,height=800');
            }
            
            function openMap(campo, latLong, calle, localidad, provincia,codMD, codEnt) {
                direccion = document.getElementById(campo).value;
                geo = window.open('../../Geolocalizacion/gmap3.jsp?dire='+ direccion +'&dDir=' + campo + '&dLatLon=' + latLong
                + '&fCalle=' + calle + "&fLoc=" + localidad + "&fPro=" + provincia + "&fCodMD=" + codMD + "&fCodEnt=" + codEnt, 'GEO',
                'modal=yes,resizable=yes,menubar=0,status=0,toolbar=0,height=820,width=1200,screenX=1,screenY=1');
                geo.focus();
            }
    

    
</script>    
</body>
</html>
