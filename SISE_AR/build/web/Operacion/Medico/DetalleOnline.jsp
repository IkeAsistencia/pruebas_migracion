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
<script src='../../Utilerias/UtilDireccion.js'></script>
<%             
        String StrclExpediente = "0";
    	String strclUsr = "0";
        String StrclSubServicio = "0";
        
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
        if (session.getAttribute("clSubServicio")!= null)
      	{
            StrclSubServicio= session.getAttribute("clSubServicio").toString(); 
       	}  
///-------------DEFINICION DE VARIABLES--------------
    String nutricionista = "487";
    String psicologa = "488";
    String personaltrainer = "489";
    String apoyoescolar = "490";
    String titulo="NULL";
/////////////////////////////////////////////
    boolean inputEdad = false;
    boolean inputPeso = false;
    boolean inputAltura = false;
    boolean inputContactoRef = false;
    boolean inputTelefonoRef = false;
    boolean inputAsignatura = false;
    boolean inputNivel = false;
    boolean inputGrado = false;
    boolean inputMotivoConsulta = true;
    boolean inputPlataforma = true;
    boolean reqAltaGrado = true;
    boolean reqAltaNivel = true;
    boolean reqAltaFecha = true;
    boolean reqAltaHora = true;
    String valueNombre = "";
    String valueTele = "";
    String valueMail = "";
    String valueNombreDef = "";
    String valueTeleDef = "";
    String valueMailDef = "";
    String valueEdad = "";
    String valuePeso = "";
    String valueAltura = "";
    String valueMotivoCons = "";
    String valueContactoRef = "";   
    String valueTelefonoRef = "";
    String valueFecha = "";
    String valueHora = "";
    String plataformaDefVal = "";
    String valueSelecPlataforma = "";
    String valueAsignatura = "";
    String valueGrado = "";
    String valueNivel = "";
    boolean editAltaPlataforma = true;
    boolean editCambioPlataforma = true;
    int nivelY4 = 230;
    String tituloCampFecha = "Fecha Consulta (AAAA-MM-DD)";
    String tituloNombre = "Nombre Completo";
//----------------------------------------------

        StringBuffer StrSql = new StringBuffer(); 

        ResultSet rs2 = UtileriasBDF.rsSQLNP( "EXEC st_TieneAsistenciaExp "+StrclExpediente);   
        StrSql.delete(0,StrSql.length());              

         if (rs2.next())  
         {             
            ResultSet rs3 = UtileriasBDF.rsSQLNP("st_GetDataAsistenciaOnline "+StrclExpediente  );
            if (rs3.next())  
            { 
            //----OBTENER DATOS DE PLANTILLAS----
                
                if(rs3.getString(1).equals("1")){
                    valueNombre = rs3.getString("NombreCompleto");
                    valueTele = rs3.getString("Telefono");
                    valueMail = rs3.getString("Email");
                    valueEdad = rs3.getString("Edad");
                    valuePeso = rs3.getString("Peso");
                    valueAltura = rs3.getString("Altura");
                    valueMotivoCons = rs3.getString("MotivoConsulta");
                    valueContactoRef = rs3.getString("ContactoRef");   
                    valueTelefonoRef = rs3.getString("TelefonoRef");
                    valueFecha = rs3.getString("FechaConsulta");
                    valueHora = rs3.getString("Hora");
                    valueSelecPlataforma = rs3.getString("clPlataformaC");
                    valueAsignatura = rs3.getString("Asignatura");
                    valueGrado = rs3.getString("clGradoC");
                    valueNivel = rs3.getString("clNivelC");
                }else{
                    if(!StrclSubServicio.equals(apoyoescolar)){
                        valueNombreDef = rs3.getString("NombreCompleto");
                    }                    
                    valueTeleDef = rs3.getString("Telefono");
                    valueMailDef = rs3.getString("Email");
                }
                
            }
            System.out.print("");
         }else{

             %><%="El expediente no existe"%><%
               rs2.close();
               rs2=null;    
               return;
         }
       	String StrclPaginaWeb = "6179";
	session.setAttribute("clPaginaWebP",StrclPaginaWeb);

///------------------CONDICIONAL DE PLATILLAS-----------------------
    if(StrclSubServicio.equals(nutricionista)){
        titulo="Detalle Nutricionista ONLINE";
        inputAltura=true;
        inputEdad=true;
        inputPeso=true;
    }else if(StrclSubServicio.equals(psicologa)){
        titulo="Detalle Psicóloca ONLINE";
        inputEdad=true;
        inputContactoRef=true;
        inputTelefonoRef=true;
    }else if(StrclSubServicio.equals(personaltrainer)){
        titulo="Detalle Personal Trainer";
        plataformaDefVal="1";
        editAltaPlataforma=false;
        editCambioPlataforma=false;
        valueSelecPlataforma="WhatsApp";
    }else if(StrclSubServicio.equals(apoyoescolar)){
        titulo="Detalle Apoyo Escolar";
        inputMotivoConsulta=false;
        inputPlataforma=false;
        inputAsignatura=true;
        inputGrado=true;
        inputNivel=true;
        nivelY4=150;
        reqAltaFecha=true;
        reqAltaHora=true;
        reqAltaGrado=true;
        reqAltaNivel=true;
        tituloCampFecha="Fecha Asesoria (AAAA-MM-DD)";
        tituloNombre="Nombre Completo Alumno";
    }
///----------------------------------------
%> 
        <SCRIPT>fnOpenLinks()</script> 
<% MyUtil.InicializaParametrosC(6179,Integer.parseInt(strclUsr)); %>
<%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist","")%>
<%
        if(rs2.getString("TieneAsistencia").compareToIgnoreCase("1")==0){
            %><script>document.all.btnAlta.disabled=true;</script><%
        }else{
            %><script>document.all.btnCambio.disabled=true</script><%
        }
        if(StrSql.toString()!=""){
            //ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
            StrSql.delete(0,StrSql.length());
        }
        
        StrSql=null;

        //----------UNIFICACION DE PLANTAILLA--------------------
%>
<%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="DetalleOnline.jsp?'>"%>
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
        <%=MyUtil.ObjInput(tituloNombre,"NombreCompleto",valueNombre,true,true,30,70,valueNombreDef,true,false,30,"")%>
        <%=MyUtil.ObjInput("Teléfono","Telefono",valueTele,true,true,260,70,valueTeleDef,true,false,20,"fnOnlyNumeric(this);")%>
        <%=MyUtil.ObjInput("E-Mail","Email",valueMail,true,true,450,70,valueMailDef,true,false,30,"")%>
        
        <%  if(inputEdad){ %>
            <%=MyUtil.ObjInput("Edad","Edad",valueEdad,true,true,30,110,"",true,false,30,"fnOnlyNumeric(this);")%>
        <%  }
            if(inputPeso){ %>
            <%=MyUtil.ObjInput("Peso (Kg)","Peso",valuePeso,true,true,260,110,"",true,false,20,"fnReplaceNotNumeric(this);")%>
        <%  }
            if(inputAltura){ %>
            <%=MyUtil.ObjInput("Altura (Mts)","Altura",valueAltura,true,true,450,110,"",true,false,30,"fnReplaceNotNumeric(this);")%>
        <%  }


            if(inputAsignatura){ %>
            <%=MyUtil.ObjInput("Asignatura/Materia","Asignatura",valueAsignatura,true,true,30,110,"",true,false,30,"")%>
        <%  }
            if(inputGrado){ %>            
            <%=MyUtil.ObjComboC("Grado","clGrado",valueGrado,true,true,450,110,"","SELECT clGrado,dsGrado FROM cGradoOnline","","",100,reqAltaGrado,reqAltaGrado)%>
        <%  }
            if(inputNivel){ %>
            <%=MyUtil.ObjComboC("Nivel","clNivel",valueNivel,true,true,260,110,"","SELECT clNivel,dsNivel FROM cNivelOnline","","",100,reqAltaNivel,reqAltaNivel)%>
        <%  }



            if(inputContactoRef){ %>
            <%=MyUtil.ObjInput("Contacto Referencia","ContactoRef",valueContactoRef,true,true,260,110,"",true,false,20,"")%>
        <%  }
            if(inputTelefonoRef){ %>
            <%=MyUtil.ObjInput("Teléfono","TelefonoRef",valueTelefonoRef,true,true,450,110,"",true,false,30,"fnOnlyNumeric(this);")%>
        <%  }
        
            if(inputMotivoConsulta){ %>
            <%=MyUtil.ObjTextArea("Motivo Consulta","MotivoConsulta",valueMotivoCons,"70","4",true,true,30,150,"",true,false)%>
        <%  }
            if(inputPlataforma){ %>
            <%=MyUtil.ObjComboC("Plataforma","clPlataforma",valueSelecPlataforma,editAltaPlataforma,editCambioPlataforma,450,150,plataformaDefVal,"SELECT clPlataforma,dsPlataforma FROM cPlataformaOnline","","",100,true,true)%>
        <%  } %>
        
        <%=MyUtil.ObjInputF(tituloCampFecha, "FechaConsulta",valueFecha, true, true, 30, nivelY4, "", reqAltaFecha, false,20, 2, "fnVerifyDate(this);")%>
        <%=MyUtil.ObjInput("Hora (HH:MM)","Hora",valueHora,true,true,450,nivelY4,"",reqAltaHora,false,15,"fnHrsD(this);")%>
            
        <%=MyUtil.DoBlock(titulo,200,50)%>  
              
             

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
    function fnReplaceNotNumeric(element){
        element.value = element.value.replace(" ","")
        element.value = element.value.replace(/[^\d.]/g,'');
    }
    function fnOnlyNumeric(element){
        element.value = element.value.replace(" ","");
        element.value = element.value.replace(/[^\d]/g,'');
    }
    function fnVerifyDate(element){
        var value = element.value.substring(0,10);
        var dateSearched = value.match('^([0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9])') ;
        
        if(dateSearched!=null && dateSearched.length>0){
            dateSearched = dateSearched[0].substring(0,4) + "-" + dateSearched[0].substring(4,6) + "-" + dateSearched[0].substring(6,10);
        }else{
            dateSearched = element.value.substring(0,10);
        }
        
        if(dateSearched!=null){
            
            try{
                var dateSearched = dateSearched.match('^([0-9][0-9][0-9][0-9])-(0[1-9]|1[0-2])-([0-2][0-9]|3[0-1])') ;
                
                var dateNow =new Date();
                var currentMonth = dateNow.getMonth()+1;
                var currentDay = dateNow.getDate();
                var currentYear = dateNow.getFullYear();
            
                element.value = dateSearched[0];
                if(dateSearched[1]>=currentYear){
                    if( parseInt(dateSearched[2],10)>=currentMonth ){
                   
                        if(parseInt(dateSearched[2],10)==currentMonth){
                    
                            if(!(parseInt(dateSearched[3],10)>=currentDay)){
                                alert("La fecha no puede ser anterior a hoy");
                                element.value="";
                            }
                        }
                    }else{
                        alert("La fecha no puede ser anterior a hoy ");
                        element.value="";
                    }
                }else{
                    alert("La fecha no puede ser anterior a hoy");
                    element.value="";
                }
                
            }catch(e){
                alert("Formato de fecha invalido (AAAA-MM-DD)");
                element.value="";
            }
        }else{
            alert("Formato de fecha invalido (AAAA-MM-DD)");
            element.value="";
        }
    }

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
