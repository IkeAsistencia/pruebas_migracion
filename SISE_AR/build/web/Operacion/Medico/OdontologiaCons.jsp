<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%@ page import="com.ike.asistencias.to.OdontologiaCons,com.ike.asistencias.DAOOdontologiaCons,Utilerias.UtileriasBDF,Seguridad.SeguridadC,Combos.cbEntidad" %>
<%@page pageEncoding="iso-8859-1"%> 
<html>
    <head><title>Odontologia en Consultorio</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" />  
        <script src='../../Utilerias/Util.js' ></script>
        <script src='../../Utilerias/UtilDireccion.js' ></script>
        
        <%                  
        String StrclExpediente = "0";
        String StrclUsrApp="0";
        String StrclPaginaWeb="0";
        
        if (session.getAttribute("clUsrApp")!= null) {
            StrclUsrApp = session.getAttribute("clUsrApp").toString();
        }
        
        if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {
        %><%="Fuera de Horario"%><% 
        return;
        }
        
        if (session.getAttribute("clExpediente")!= null) {
            StrclExpediente = session.getAttribute("clExpediente").toString();
        }
        
        DAOOdontologiaCons dao = null;
        OdontologiaCons cons = null;
        
        if (StrclExpediente!=null){
            
            dao = new DAOOdontologiaCons();
            cons= dao.getOdontologiaCons(StrclExpediente);
        }else{%>         
        <%="El expediente no existe"%>   <% 
        return;
        }
        
        %><script>fnOpenLinks()</script><%
        
        StrclPaginaWeb = "5059";
        MyUtil.InicializaParametrosC(5059,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
        
        session.setAttribute("clPaginaWebP",StrclPaginaWeb);
        
        %><%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist","")%>
        <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="OdontologiaCons.jsp?'>"%> 
        
        <%
        if(cons!=null){
            if (!cons.getClExpediente().equalsIgnoreCase("0")){
        %> <script>document.all.btnAlta.disabled=true;</script> <%
            }else{
        %> <script>document.all.btnCambio.disabled=true;</script> <%            
            }
        }
        %>                
        
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
        
        <%=MyUtil.ObjInput("Nombre del Paciente","Paciente",cons != null ? cons.getNombre() : "",true,true,30,110,"",true,true,60)%>
        <%=MyUtil.ObjInput("Edad","Edad",cons != null ? cons.getEdad(): "",true,true,370,110,"",false,false,10,"fnRango(document.all.Edad,0,150)")%>
        <%=MyUtil.ObjInput("Peso (Kgs.)","PesoKg",cons != null ? cons.getPeso(): "",true,true,450,110,"",false,false,10,"EsNumerico(document.all.PesoKg)")%>
        <%=MyUtil.ObjComboC("Parentesco con N/U","clParentesco",cons != null ? cons.getParentesco(): "",true,true,530,110,"","Select clParentesco, dsParentesco From cParentesco ","","",30,true,true)%>
        <%=MyUtil.DoBlock("Consultoría Odontológica en Consultorio",-30,0)%>                
        
        <%        
        String CodEnt = cons != null ? cons.getCodEnt(): "";
        String dsEntFed = cons != null ? cons.getDsEntFed() : "";
        String StrCodMD = cons != null ? cons.getCodMD(): "";
        String dsMunDel = cons != null ? cons.getDsMunDel(): "";                
        %>       
        
        <%=MyUtil.ObjComboMem("Provincia", "CodEnt", dsEntFed, CodEnt, cbEntidad.GeneraHTML(40, dsEntFed), true, true, 30, 200, "", "fnLlenaMunicipiosCS()", "", 50, false, false)%>
        <%=MyUtil.ObjComboMem("Localidad", "CodMD",dsMunDel, StrCodMD, cbEntidad.GeneraHTMLMD(40, CodEnt, dsMunDel), true, true, 350, 200, "", "", "", 50, false, false)%>        
        <%=MyUtil.ObjInput("Código Postal","CP",cons != null ? cons.getCP() : "",true,true,30,240,"",false,false,10)%>
        <%=MyUtil.ObjInput("Calle","Calle",cons != null ? cons.getCalle() : "",true,true,350,240,"",false,false,50)%>        
        <%=MyUtil.DoBlock("Ubicación del Paciente",100,0)%>
        
        <%=MyUtil.ObjInput("Padecimiento","Padecimiento",cons != null ? cons.getPadecimiento() : "",true,true,30,330,"",true,true,50)%> 
        <%=MyUtil.ObjInput("Médico Tratante","MedicoAtendio",cons != null ? cons.getMedicoAtendio() : "",true,true,310,330,"",false,false,50)%>
        <%=MyUtil.ObjTextArea("Diagnóstico","DiagnosticoDx",cons != null ? cons.getDiagnostico(): "","105","2",true,true,30,370,"",false,false)%>
        <%=MyUtil.ObjTextArea("Tratamiento","TratamientoTx",cons != null ? cons.getTratamiento(): "","105","2",true,true,30,430,"",false,false)%>
        
        <%=MyUtil.DoBlock("Datos de la Evaluación",95,20)%><% 
        
        %><%=MyUtil.GeneraScripts()%><%
        
        StrclExpediente = null;
        StrclUsrApp=null;
        StrclPaginaWeb=null;
        
        cons=null;
        dao = null;
        
        CodEnt =  null ;
        dsEntFed = null ;
        StrCodMD = null ;
        dsMunDel = null;
        
        %>
        
        <script>
        document.all.Paciente.maxLength=50; 
        document.all.Edad.maxLength=3;   
        document.all.PesoKg.maxLength=7;   
        document.all.Calle.maxLength=80;   
        document.all.MedicoAtendio.maxLength=50;   
        document.all.Padecimiento.maxLength=50;   
        document.all.DiagnosticoDx.maxLength=200;      
        document.all.TratamientoTx.maxLength=200;           
        </script>
        
    </body>
</html>
