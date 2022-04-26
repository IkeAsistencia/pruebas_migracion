<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%@ page  import="com.ike.asistencias.to.ConsultaOdont,com.ike.asistencias.DAOConsultaOdont,Utilerias.UtileriasBDF,Seguridad.SeguridadC" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head><title>Consulta Teléfonica</title>
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
        
        ConsultaOdont con = null;
        DAOConsultaOdont dao = null;
        
        if (StrclExpediente!=null){
            dao = new DAOConsultaOdont();
            con =  dao.getConsultaOdont(StrclExpediente);
        }else{%>        
        <%="El expediente no existe"%>   <% 
        return;
        }                                
        
        %> <script>fnOpenLinks()</script>
        <%
        StrclPaginaWeb = "5058";
        MyUtil.InicializaParametrosC(5058,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
        
        session.setAttribute("clPaginaWebP",StrclPaginaWeb);
        
                                
        %><%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist","")%>
        <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="ConsultaTelOdonto.jsp?'>"%>
        
        
        <%
        if(con!=null){            
            if (!con.getClExpediente().equalsIgnoreCase("0")){
                %> <script>document.all.btnAlta.disabled=true;</script> <%
            }else{
                %> <script>document.all.btnCambio.disabled=true;</script> <%            
            }
        }
        %>
        
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
        
        <%=MyUtil.ObjInput("Nombre del Paciente","Paciente",con != null ? con.getNombre() : "" , true,true,30,110,"",true,true,60)%>
        <%=MyUtil.ObjInput("Edad","Edad",con != null ? con.getEdad(): "" ,true,true,370,110,"",false,false,10,"fnRango(document.all.Edad,0,150)")%>
        <%=MyUtil.ObjInput("Peso (Kgs.)","PesoKg",con != null ? con.getPeso() : "" ,true,true,450,110,"",false,false,10,"EsNumerico(document.all.PesoKg)")%>
        <%=MyUtil.ObjComboC("Parentesco con N/U","clParentesco",con != null ? con.getParentesco(): "" ,true,true,530,110,"","Select clParentesco, dsParentesco From cParentesco ","","",30,true,true)%>
        <%=MyUtil.DoBlock("Consultoría Odontológica Telefónica",-30,0)%>
        
        <%=MyUtil.ObjInput("Padecimiento","Padecimiento",con != null ? con.getPadecimiento(): "" ,true,true,30,200,"",true,true,50)%>
        <%=MyUtil.ObjInput("Tiempo de Evolucion","TiempoEvolucion",con != null ? con.getTiempoEvol(): "" ,true,true,310,200,"",false,false,50)%>
        <%=MyUtil.ObjTextArea("Antecedentes","Antecedentes",con != null ? con.getantecedentes() : "" ,"105","4",true,true,30,240,"",false,false)%>
        <%=MyUtil.ObjTextArea("Tratamientos Previos","TratamientosPrevios",con != null ? con.getTratamientoPrev() : "" ,"105","2",true,true,30,315,"",false,false)%>
        <%=MyUtil.ObjTextArea("Estudios Previos","EstudiosPrevios",con != null ? con.getEstudiosPrev(): "" ,"105","2",true,true,30,365,"",false,false)%>
        <%=MyUtil.ObjTextArea("Recomenda Medico","RecomendaMedico",con != null ? con.getRecomendacion() : "" ,"105","4",true,true,30,415,"",false,false)%>
        
        <%=MyUtil.DoBlock("Datos de la Evaluación",105,35)%>        
        <%=MyUtil.GeneraScripts()%>
        
        <%
        
        StrclExpediente = null;
        StrclUsrApp=null;
        StrclPaginaWeb=null;
        
        dao=null;
        con = null;
        
        %>
        
        <script>
            document.all.Paciente.maxLength=50; 
            document.all.Edad.maxLength=3;   
            document.all.PesoKg.maxLength=7;   
            document.all.Padecimiento.maxLength=50;   
            document.all.TiempoEvolucion.maxLength=50;      
            document.all.Antecedentes.maxLength=500;      
            document.all.TratamientosPrevios.maxLength=200;          
            document.all.EstudiosPrevios.maxLength=200;      
            document.all.RecomendaMedico.maxLength=500;          
        </script>
        
    </body>
</html>
