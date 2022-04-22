<%@ page contentType="text/html; charset=iso-8859-1" pageEncoding="iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<html>
    <head>
        <title>Segunda Opinión Médica</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
        <script src='../../Utilerias/Util.js' ></script>
        <script src='../../Utilerias/UtilDireccion.js' ></script>
        <%  
        String StrclUsrApp="0";
        if (session.getAttribute("clUsrApp")!= null)   {
            StrclUsrApp = session.getAttribute("clUsrApp").toString();     }  
        if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true)    {
            %><%="Fuera de Horario"%><% 
            return;  
            }    
        String StrclPaginaWeb="6146";
        String StrclExpediente = "0";   
        if (session.getAttribute("clExpediente")!= null)      {
            StrclExpediente = session.getAttribute("clExpediente").toString();    }  
        StringBuffer StrSql = new StringBuffer();
        StrSql.append(" st_TieneAsistenciaExp ").append(StrclExpediente);
        ResultSet rs2 = UtileriasBDF.rsSQLNP( StrSql.toString());
        StrSql.delete(0,StrSql.length());
        if (rs2.next()){ 
        } else{
            %><%="El expediente no existe"%><%
            rs2.close();
            rs2=null;
            return;      
            } 
        StrSql.append(" st_getMedicaRemota ").append(StrclExpediente);
        ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
        StrSql.delete(0,StrSql.length());
        %> <script>fnOpenLinks()</script>
        <%MyUtil.InicializaParametrosC(6146,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
        session.setAttribute("clPaginaWebP",StrclPaginaWeb);%>
        <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist","")%>
        <input id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'/>
        <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="MedicaRemota.jsp?'>"%><%
        if (rs.next()) { 
            %><script>document.all.btnAlta.disabled=true;</script>
            <%=MyUtil.ObjInput("Médico","Medico",rs.getString("Medico"),true,true,30,110,"",true,true,40)%>
            <%=MyUtil.ObjInput("Especialidad","Especialidad",rs.getString("Especialidad"),true,true,300,110,"",false,false,25)%>
            <%=MyUtil.ObjInput("Matrícula","Matricula",rs.getString("Matricula"),true,true,490,110,"",true,true,15)%>
            <%=MyUtil.ObjInput("Edad Paciente","EdadP",rs.getString("EdadP"),true,true,30,150,"",true,true,3)%>
            <%=MyUtil.ObjInput("CIE 10","CIE10",rs.getString("CIE10"),true,true,300,150,"",true,true,15)%>
            <%=MyUtil.ObjInput("Duración Llamada","DuracionLlamada",rs.getString("DuracionLlamada"),true,true,490,150,"",true,true,5)%>
            <%=MyUtil.ObjTextArea("Diagnóstico","Diagnostico",rs.getString("Diagnostico"),"80","4",true,true,30,190,"",false,false)%>
            <%=MyUtil.ObjInput("Resolución","Resolucion",rs.getString("Resolucion"),true,true,490,190,"",true,true,20)%>        
            <%=MyUtil.DoBlock("Asistencia Médica Remota",-30,50)%>
            
            <%=MyUtil.ObjInput("APP","APP",rs.getString("APP"),true,true,30,340,"",true,true,20)%> 
            <%=MyUtil.ObjTextArea("Comentarios","Comentarios",rs.getString("Comentarios"),"80","4",true,true,170,340,"",false,false)%>
            <%=MyUtil.ObjInput("Médico","MedicoCal",rs.getString("MedicoCal"),true,true,30,380,"",true,true,20)%>                                   
            <%=MyUtil.DoBlock("Calificación",290,0)%><%
        }else{   
            %><script>document.all.btnCambio.disabled=true;</script>
            <%=MyUtil.ObjInput("Médico","Medico","",true,true,30,110,"",true,true,40)%>
            <%=MyUtil.ObjInput("Especialidad","Especialidad","",true,true,300,110,"",true,true,25)%>
            <%=MyUtil.ObjInput("Matrícula","Matricula","",true,true,490,110,"",true,true,15)%>
            <%=MyUtil.ObjInput("Edad Paciente","EdadP","",true,true,30,150,"",true,true,3)%>
            <%=MyUtil.ObjInput("CIE 10","CIE10","",true,true,300,150,"",true,true,15)%>
            <%=MyUtil.ObjInput("Duración Llamada","DuracionLlamada","",true,true,490,150,"",true,true,5)%>
            <%=MyUtil.ObjTextArea("Diagnóstico","Diagnostico","","80","4",true,true,30,190,"",true,true)%>
            <%=MyUtil.ObjInput("Resolución","Resolucion","",true,true,490,190,"",true,true,20)%>        
            <%=MyUtil.DoBlock("Asistencia Médica Remota",-30,50)%>

            <%=MyUtil.ObjInput("APP","APP","",true,true,30,340,"",true,true,20)%> 
            <%=MyUtil.ObjTextArea("Comentarios","Comentarios","","80","4",true,true,170,340,"",true,true)%>
            <%=MyUtil.ObjInput("Médico","MedicoCal","",true,true,30,380,"",true,true,20)%>                                   
            <%=MyUtil.DoBlock("Calificación",290,0)%><%
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
//------------------------------------------------------------------------------
             document.all.Medico.maxLength=50; 
             document.all.EdadP.maxLength=3;
             document.all.Comentarios.maxLength=500;     
             document.all.Diagnostico.maxLength=500;    
             document.all.Resolucion.maxLength=500;          
//------------------------------------------------------------------------------
        </script>
    </body>
</html>