<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%> 
<html>
    <head><title>Medico a Domicilio</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        
        <%-- <jsp:useBean id="beanInstanceName" scope="session" class="beanPackage.BeanClassName" /> --%>
        <%-- <jsp:getProperty name="beanInstanceName"  property="propertyName" /> --%>
        
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" />  
        <script src='../../Utilerias/Util.js' ></script>
        <script src='../../Utilerias/UtilDireccion.js' ></script>
        
        <%  
        com.ike.util.I18N i18n = com.ike.util.I18N.getInstance("es","AR");
        
        String StrclExpediente = "0";
        String StrclUsrApp="0";
        String StrclPaginaWeb="0";
        
        
        
        
        if (session.getAttribute("clUsrApp")!= null)
        {
            StrclUsrApp = session.getAttribute("clUsrApp").toString();
        }
        
        if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true)
        {
        %><%="Fuera de Horario"%><% 
        return;
        }
        
        if (session.getAttribute("clExpediente")!= null)
        {
            StrclExpediente = session.getAttribute("clExpediente").toString();
        }
        
        
        StringBuffer StrSql =new StringBuffer();
        StrSql.append(" Select E.TieneAsistencia ");
        StrSql.append(" From Expediente E");
        StrSql.append(" Where E.clExpediente=").append(StrclExpediente);
        
        
        ResultSet rs2 = UtileriasBDF.rsSQLNP( StrSql.toString());
        StrSql.delete(0,StrSql.length());
        if (rs2.next())
        {
            
        }
        else
        {
        %><%="El expediente no existe"%><%
        rs2.close();
        rs2=null;
        return;
        }
        
        StrSql.append("Select MD.clExpediente,coalesce(MD.Paciente,'') as Paciente, coalesce(MD.Edad, 0) Edad, coalesce(MD.PesoKg, 0) PesoKg, ");
        StrSql.append(" coalesce(P.dsParentesco,'') as dsParentesco,  ");
        StrSql.append(" coalesce(MD.CP,'') CP,  ");
        StrSql.append(" coalesce(E.dsEntFed,'') dsEntFed, ");
        StrSql.append(" coalesce(MD.CodEnt,'') CodEnt, ");
        StrSql.append(" coalesce(M.dsMunDel,'') dsMunDel, ");
        StrSql.append(" coalesce(MD.CodMD,'') CodMD, ");
        StrSql.append(" coalesce(MD.Colonia,'') Colonia, ");
        StrSql.append(" coalesce(MD.Calle,'') Calle,  ");
        StrSql.append(" coalesce(MD.Padecimiento,'') Padecimiento, ");
        StrSql.append(" coalesce(MD.MedicoAtendio,'') MedicoAtendio, ");
        StrSql.append(" coalesce(MD.DiagnosticoDx,'') DiagnosticoDx, coalesce(MD.TratamientoTx,'') TratamientoTx ");
        
        StrSql.append(" From MedicoDomicilio MD  ");
        StrSql.append(" Left Join cParentesco P ON (P.clParentesco = MD.clParentesco)  ");
        StrSql.append(" Left Join cMundel M on (MD.CodEnt=M.CodEnt and MD.CodMD=M.CodMD)  ");
        StrSql.append(" Left join cEntFed E on (MD.CodEnt=E.CodEnt) ");
        StrSql.append(" Where MD.clExpediente = ").append(StrclExpediente);
        
        ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
        StrSql.delete(0,StrSql.length());
        
        %><script>fnOpenLinks()</script><%
        
        StrclPaginaWeb = "223";
        MyUtil.InicializaParametrosC(223,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
        
        session.setAttribute("clPaginaWebP",StrclPaginaWeb);
        
        %><%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist","")%>
        <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="MedicoDomicilio.jsp?'>"%> 
        
        <%
        if (rs.next())
        { 
        
        %><script>document.all.btnAlta.disabled=true;</script>
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
        
        <%=MyUtil.ObjInput("Nombre del Paciente","Paciente",rs.getString("Paciente"),true,true,30,110,"",true,true,60)%>
        <%=MyUtil.ObjInput("Edad","Edad",rs.getString("Edad"),true,true,370,110,"",false,false,10,"fnRango(document.all.Edad,0,150)")%>
        <%=MyUtil.ObjInput("Peso (Kgs.)","PesoKg",rs.getString("PesoKg"),true,true,450,110,"",false,false,10,"EsNumerico(document.all.PesoKg)")%>
        <%=MyUtil.ObjComboC("Parentesco con N/U","clParentesco",rs.getString("dsParentesco"),true,true,530,110,"","Select clParentesco, dsParentesco From cParentesco ","","",30,true,true)%>
        <%=MyUtil.DoBlock("Servicio de Médico a Domicilio",-30,0)%>
        
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.cp"),"CP",rs.getString("CP"),true,true,30,200,"",false,false,10)%>
        <div class='VTable' style='position:absolute; z-index:25; left:100px; top:210px;'>
        <INPUT type='button' VALUE='Buscar..' onClick='fnBuscaColoniaN2();' class='cBtn'></div>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.entidad"),"dsEntFed",rs.getString("dsEntFed"),false,false,190,200,"",false,false,50)%>
        <INPUT id='CodEnt' name='CodEnt' type='hidden' value='<%=rs.getString("CodEnt")%>'>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.municipio"),"dsMunDel",rs.getString("dsMunDel"),false,false,30,240,"",false,false,50)%>
        <INPUT id='CodMD' name='CodMD' type='hidden' value='<%=rs.getString("CodMD")%>'>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.colonia"),"Colonia",rs.getString("Colonia"),false,false,300,240,"",false,false,50)%>
        <%=MyUtil.ObjInput("Calle","Calle",rs.getString("Calle"),true,true,30,280,"",false,false,105)%>
        
        <%=MyUtil.DoBlock("Ubicación del Paciente",100,0)%>
        
        <%=MyUtil.ObjInput("Padecimiento","Padecimiento",rs.getString("Padecimiento"),true,true,30,370,"",true,true,50)%> 
        <%=MyUtil.ObjInput("Médico Tratante","MedicoAtendio",rs.getString("MedicoAtendio"),true,true,310,370,"",false,false,50)%>
        <%=MyUtil.ObjTextArea("Diagnóstico","DiagnosticoDx",rs.getString("DiagnosticoDx"),"105","2",true,true,30,410,"",false,false)%>
        <%=MyUtil.ObjTextArea("Tratamiento","TratamientoTx",rs.getString("TratamientoTx"),"105","2",true,true,30,460,"",false,false)%>
        
        <%=MyUtil.DoBlock("Datos de la Evaluación",95,20)%><%
        
        
        }
        else
        {   
        %><script>document.all.btnCambio.disabled=true;</script>
        
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>                                  
        
        <%=MyUtil.ObjInput("Nombre del Paciente","Paciente","",true,true,30,110,"",true,true,60)%>
        <%=MyUtil.ObjInput("Edad","Edad","",true,true,370,110,"",false,false,10,"fnRango(document.all.Edad,0,150)")%>
        <%=MyUtil.ObjInput("Peso (Kgs.)","PesoKg","",true,true,450,110,"",false,false,10,"EsNumerico(document.all.PesoKg)")%>
        <%=MyUtil.ObjComboC("Parentesco con N/U","clParentesco","",true,true,530,110,"","Select clParentesco, dsParentesco From cParentesco ","","",30,true,true)%>
        <%=MyUtil.DoBlock("Servicio de Médico a Domicilio",-30,0)%>               
        
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.cp"),"CP","",true,true,30,200,"",false,false,10)%>
        <div class='VTable' style='position:absolute; z-index:25; left:100px; top:210px;'>
        <INPUT type='button' VALUE='Buscar..' onClick='fnBuscaColoniaN2();' class='cBtn'></div>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.entidad"),"dsEntFed","",false,false,190,200,"",false,false,50)%>
        <INPUT id='CodEnt' name='CodEnt' type='hidden' value=''>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.municipio"),"dsMunDel","",false,false,30,240,"",false,false,50)%>            
        <INPUT id='CodMD' name='CodMD' type='hidden' value=''>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.colonia"),"Colonia","",false,false,300,240,"",false,false,50)%>        
        <%=MyUtil.ObjInput("Calle","Calle","",true,true,30,280,"",false,false,105)%>                       
        
        <%=MyUtil.DoBlock("Ubicación del Paciente",100,0)%>   
        
        <%=MyUtil.ObjInput("Padecimiento","Padecimiento","",true,true,30,370,"",true,true,50)%>
        <%=MyUtil.ObjInput("Médico Tratante","MedicoAtendio","",true,true,310,370,"",false,false,50)%> 
        <%=MyUtil.ObjTextArea("Diagnóstico","DiagnosticoDx","","105","2",true,true,30,410,"",false,false)%>
        <%=MyUtil.ObjTextArea("Tratamiento","TratamientoTx","","105","2",true,true,30,460,"",false,false)%>
        
        <%=MyUtil.DoBlock("Datos de la Evaluación",95,20)%><%
        
        }   
        
        %><%=MyUtil.GeneraScripts()%><%
        rs2.close();
        rs.close();
        rs2=null;
        rs=null;
        StrSql=null;
        StrclExpediente = null;
        StrclUsrApp=null;
        StrclPaginaWeb=null;
        
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
