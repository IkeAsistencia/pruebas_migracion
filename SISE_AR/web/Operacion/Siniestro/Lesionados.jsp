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
<%             
        String StrclExpediente = "0";
    	String strclUsr = "0";
        


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
            StrSql.append(" FROM AsistenciaLesionados");
            StrSql.append(" Where clExpediente= ").append(StrclExpediente);

         }else{

             %><%="El expediente no existe"%><%
               rs2.close();
               rs2=null;    
               return;
         }
       	String StrclPaginaWeb = "6172";
	session.setAttribute("clPaginaWebP",StrclPaginaWeb);

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
               
                <% } 
                            rs3.close();
                            rs3=null;  %>
              <%=MyUtil.ObjInputF("Fecha del Siniestro (AAAA-MM-DD HH:MM)", "FechaSiniestro",rs.getString("FechaSiniestro"), true, true, 30, 70, "", true, false,20, 2, "if(this.readOnly==false){fnValMask(this,document.all.FechaSiniestraMsk.value,this.name)};")%>
              <%=MyUtil.ObjInput("Hora (24 hrs.)","Hora",rs.getString("Hora"),true,true,400,70,"",true,false,6,"fnHrsD(this);")%>             
              <%=MyUtil.ObjTextArea("Lugar Exacto (Ubicación Siniestro)","Observaciones",rs.getString("Observaciones"),"60","4",true,true,30,110,"",true,false)%>
              <%=MyUtil.ObjTextArea("¿Qué ocurrio?","ObservAjustador",rs.getString("ObservAjustador"),"60","4",true,true,400,110,"",true,false)%>                                        
              <%=MyUtil.DoBlock("Datos Generales",200,50)%>  
              
              <%=MyUtil.ObjChkBox("Peatón","PeatonOP",rs.getString("PeatonOP"), true,true,30,250,"0","SI","NO","")%>
              <%=MyUtil.ObjChkBox("Ciclista","CiclistaOP",rs.getString("CiclistaOP"), true,true,120,250,"0","SI","NO","")%>
              <%=MyUtil.ObjChkBox("Automóvil","AutomovilOP",rs.getString("AutomovilOP"), true,true,30,300,"0","SI","NO","")%>
              <%=MyUtil.ObjChkBox("Motovehículo","MotovehiculoOP",rs.getString("MotovehiculoOP"), true,true,120,300,"0","SI","NO","")%>
              <%=MyUtil.ObjChkBox("Camión","CamionOP",rs.getString("CamionOP"), true,true,30,350,"0","SI","NO","")%>
              <%=MyUtil.ObjChkBox("Colectivo/Transporte <br> publico pasajeros","TransporteOP",rs.getString("TransporteOP"), true,true,120,350,"0","SI","NO","")%>
              <%=MyUtil.ObjChkBox("Otro","OtroOP",rs.getString("OtroOP"), true,true,30,400,"0","SI","NO","")%>
              <%=MyUtil.DoBlock("¿QUIÉNES PARTICIPARÓN EN EL EVENTO?",0,30)%> 
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
              <%=MyUtil.ObjInputF("Fecha del Siniestro", "FechaSiniestro","", true, true, 30, 70, "", true, false,20, 2, "if(this.readOnly==false){fnValMask(this,document.all.FechaSiniestraMsk.value,this.name)};")%>
              <%=MyUtil.ObjInput("Hora (24 hrs.)","Hora","",true,true,400,70,"",true,false,6,"fnHrsD(this);")%>            
              <%=MyUtil.ObjTextArea("Lugar Exacto (Ubicación Siniestro)","Observaciones","","60","4",true,true,30,110,"",true,false)%>         
              <%=MyUtil.ObjTextArea("¿Qué ocurrio?","ObservAjustador","","60","4",true,true,400,110,"",true,false)%>              
              <%=MyUtil.DoBlock("Datos Generales",150,50)%> 
                <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
              <%=MyUtil.ObjChkBox("Peatón","PeatonOP","", true,true,30,250,"0","SI","NO","")%>
              <%=MyUtil.ObjChkBox("Ciclista","CiclistaOP","", true,true,120,250,"0","SI","NO","")%>
              <%=MyUtil.ObjChkBox("Automóvil","AutomovilOP","", true,true,30,300,"0","SI","NO","")%>
              <%=MyUtil.ObjChkBox("Motovehículo","MotovehiculoOP","", true,true,120,300,"0","SI","NO","")%>
              <%=MyUtil.ObjChkBox("Camión","CamionOP","", true,true,30,350,"0","SI","NO","")%>
              <%=MyUtil.ObjChkBox("Colectivo/Transporte <br> publico pasajeros","TransporteOP","", true,true,120,350,"0","SI","NO","")%>
              <%=MyUtil.ObjChkBox("Otro","OtroOP","", true,true,30,400,"0","SI","NO","")%>
              
              <%=MyUtil.DoBlock("¿QUIÉNES PARTICIPARÓN EN EL EVENTO?",30,30)%> 
        <% } %>	
        
        <input class='cBtn' id="SMS" name="SMS" type='button' value='Link Documento' onclick="window.open('https://api.atencionike.com.ar/static/Interceptores.xlsx', '', 'scrollbars=no,status=no,width=670,height=170');">
       
       
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

<script> 
  
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
    

    
</script>    
</body>
</html>
