<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Seguridad.SeguridadC,Utilerias.UtileriasBDF" errorPage="" %>
<html>
<head>
<title></title>
</head>
<body class="cssBody">
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
<script src='../Utilerias/Util.js' ></script>
<% 
 try{

    String StrclUsrApp="0";
    
    

    if (session.getAttribute("clUsrApp")!= null)
     {
       StrclUsrApp = session.getAttribute("clUsrApp").toString(); 
     } 

    if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) 
     {%>
       Fuera de Horario
       <%return;  
     } 
     
     String cveTipoHrio="";
     if (request.getParameter("clTipoHorario")!=null){
         cveTipoHrio = request.getParameter("clTipoHorario").toString();
      }
     
     ResultSet rs = UtileriasBDF.rsSQLNP( "sp_ConsultaTipoHorario " + cveTipoHrio);
     if(rs.next()){
        MyUtil.InicializaParametrosC(6,1); %>
        <%=MyUtil.doMenuAct("../servlet/Seguridad.ActualizaTipoHrio","")%>
        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1) + "TipoHorario.jsp?"%>'>
        <INPUT type='hidden' value=<%=cveTipoHrio%> id='clTipoHorario' name='clTipoHorario'>
        <%=MyUtil.ObjInput("Tipo de Horario","txtTipoHorario",rs.getString("TipoHrio"),true,true,40,85,"",true,true,25)%>
        <%=MyUtil.DoBlock("Tipo de Horario")%> 
        <%=MyUtil.ObjChkBox("Lunes","chkLunes",rs.getString("Dia1"),true,true,40,175,"","")%> 
        <%=MyUtil.ObjInput("Hora Inicio","txtLunIni",rs.getString("HrIni1"),true,true,150,160,"",false,false,10,"fnValidaCampo(this,\"HoraParcial\")")%>
        <%=MyUtil.ObjInput("Hora Fin","txtLunFin",rs.getString("HrFin1"),true,true,300,160,"",false,false,10,"fnValidaCampo(this,\"HoraParcial\")")%>
        <%=MyUtil.ObjChkBox("Martes","chkMartes",rs.getString("Dia2"),true,true,40,205,"","")%> 
        <%=MyUtil.ObjInput("","txtMarIni",rs.getString("HrIni2"),true,true,150,190,"",false,false,10,"fnValidaCampo(this,\"HoraParcial\")")%>
        <%=MyUtil.ObjInput("","txtMarFin",rs.getString("HrFin2"),true,true,300,190,"",false,false,10,"fnValidaCampo(this,\"HoraParcial\")")%>
        <%=MyUtil.ObjChkBox("Miercoles","chkMiercoles",rs.getString("Dia3"),true,true,40,235,"","")%> 
        <%=MyUtil.ObjInput("","txtMierIni",rs.getString("HrIni3"),true,true,150,220,"",false,false,10,"fnValidaCampo(this,\"HoraParcial\")")%>
        <%=MyUtil.ObjInput("","txtMierFin",rs.getString("HrFin3"),true,true,300,220,"",false,false,10,"fnValidaCampo(this,\"HoraParcial\")")%>
        <%=MyUtil.ObjChkBox("Jueves","chkJueves",rs.getString("Dia4"),true,true,40,265,"","")%> 
        <%=MyUtil.ObjInput("","txtJueIni",rs.getString("HrIni4"),true,true,150,250,"",false,false,10,"fnValidaCampo(this,\"HoraParcial\")")%>
        <%=MyUtil.ObjInput("","txtJueFin",rs.getString("HrFin4"),true,true,300,250,"",false,false,10,"fnValidaCampo(this,\"HoraParcial\")")%>
        <%=MyUtil.ObjChkBox("Viernes","chkViernes",rs.getString("Dia5"),true,true,40,295,"","")%> 
        <%=MyUtil.ObjInput("","txtVieIni",rs.getString("HrIni5"),true,true,150,280,"",false,false,10,"fnValidaCampo(this,\"HoraParcial\")")%>
        <%=MyUtil.ObjInput("","txtVieFin",rs.getString("HrFin5"),true,true,300,280,"",false,false,10,"fnValidaCampo(this,\"HoraParcial\")")%>
        <%=MyUtil.ObjChkBox("Sabado","chkSabado",rs.getString("Dia6"),true,true,40,325,"","")%> 
        <%=MyUtil.ObjInput("","txtSabIni",rs.getString("HrIni6"),true,true,150,310,"",false,false,10,"fnValidaCampo(this,\"HoraParcial\")")%>
        <%=MyUtil.ObjInput("","txtSabFin",rs.getString("HrFin6"),true,true,300,310,"",false,false,10,"fnValidaCampo(this,\"HoraParcial\")")%>
        <%=MyUtil.ObjChkBox("Domingo","chkDomingo",rs.getString("Dia7"),true,true,40,355,"","")%> 
        <%=MyUtil.ObjInput("","txtDomIni",rs.getString("HrIni7"),true,true,150,340,"",false,false,10,"fnValidaCampo(this,\"HoraParcial\")")%>
        <%=MyUtil.ObjInput("","txtDomFin",rs.getString("HrFin7"),true,true,300,340,"",false,false,10,"fnValidaCampo(this,\"HoraParcial\")")%> 
        <%=MyUtil.DoBlock("HORARIO POR DIA")%>
        <%=MyUtil.GeneraScripts()%>
      <% }
     else{
        
        MyUtil.InicializaParametrosC(6,1);
        %>
        <%=MyUtil.doMenuAct("../servlet/Seguridad.ActualizaTipoHrio","")%>  
        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%= request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1) + "TipoHorario.jsp?"%>'>
        <INPUT type='hidden' value=<%=cveTipoHrio%> id='clTipoHorario' name='clTipoHorario'>
        <%=MyUtil.ObjInput("Tipo de Horario","txtTipoHorario","",true,true,40,85,"",true,true,25)%>
        <%=MyUtil.DoBlock("Tipo de Horario")%> 
        <%=MyUtil.ObjChkBox("Lunes","chkLunes","0",true,true,40,175,"","")%> 
        <%=MyUtil.ObjInput("Hora Inicio","txtLunIni","",true,true,150,160,"",false,false,10,"fnValidaCampo(this,\"HoraParcial\")")%>
        <%=MyUtil.ObjInput("Hora Fin","txtLunFin","",true,true,300,160,"",false,false,10,"fnValidaCampo(this,\"HoraParcial\")")%>
        <%=MyUtil.ObjChkBox("Martes","chkMartes","0",true,true,40,205,"","")%> 
        <%=MyUtil.ObjInput("","txtMarIni","",true,true,150,190,"",false,false,10,"fnValidaCampo(this,\"HoraParcial\")")%>
        <%=MyUtil.ObjInput("","txtMarFin","",true,true,300,190,"",false,false,10,"fnValidaCampo(this,\"HoraParcial\")")%>
        <%=MyUtil.ObjChkBox("Miercoles","chkMiercoles","0",true,true,40,235,"","")%> 
        <%=MyUtil.ObjInput("","txtMierIni","",true,true,150,220,"",false,false,10,"fnValidaCampo(this,\"HoraParcial\")")%>
        <%=MyUtil.ObjInput("","txtMierFin","",true,true,300,220,"",false,false,10,"fnValidaCampo(this,\"HoraParcial\")")%>
        <%=MyUtil.ObjChkBox("Jueves","chkJueves","0",true,true,40,265,"","")%> 
        <%=MyUtil.ObjInput("","txtJueIni","",true,true,150,250,"",false,false,10,"fnValidaCampo(this,\"HoraParcial\")")%>
        <%=MyUtil.ObjInput("","txtJueFin","",true,true,300,250,"",false,false,10,"fnValidaCampo(this,\"HoraParcial\")")%>
        <%=MyUtil.ObjChkBox("Viernes","chkViernes","0",true,true,40,295,"","")%> 
        <%=MyUtil.ObjInput("","txtVieIni","",true,true,150,280,"",false,false,10,"fnValidaCampo(this,\"HoraParcial\")")%>
        <%=MyUtil.ObjInput("","txtVieFin","",true,true,300,280,"",false,false,10,"fnValidaCampo(this,\"HoraParcial\")")%>
        <%=MyUtil.ObjChkBox("Sabado","chkSabado","0",true,true,40,325,"","")%> 
        <%=MyUtil.ObjInput("","txtSabIni","",true,true,150,310,"",false,false,10,"fnValidaCampo(this,\"HoraParcial\")")%>
        <%=MyUtil.ObjInput("","txtSabFin","",true,true,300,310,"",false,false,10,"fnValidaCampo(this,\"HoraParcial\")")%>
        <%=MyUtil.ObjChkBox("Domingo","chkDomingo","0",true,true,40,355,"","")%> 
        <%=MyUtil.ObjInput("","txtDomIni","",true,true,150,340,"",false,false,10,"fnValidaCampo(this,\"HoraParcial\")")%>
        <%=MyUtil.ObjInput("","txtDomFin","",true,true,300,340,"",false,false,10,"fnValidaCampo(this,\"HoraParcial\")")%> 
        <%=MyUtil.DoBlock("HORARIO POR DIA")%>
        <%=MyUtil.GeneraScripts()%>
      <%}
      rs.close();
      rs=null; 
      
      }catch(Exception e){
  e.printStackTrace();
 }
%>
<script>
     document.all.txtLunIni.maxLength=5;
     document.all.txtLunFin.maxLength=5;
     document.all.txtMarIni.maxLength=5;
     document.all.txtMarFin.maxLength=5;
     document.all.txtMierIni.maxLength=5;
     document.all.txtMierFin.maxLength=5;
     document.all.txtJueIni.maxLength=5;
     document.all.txtJueFin.maxLength=5;
     document.all.txtVieIni.maxLength=5;
     document.all.txtVieFin.maxLength=5;
     document.all.txtSabIni.maxLength=5;
     document.all.txtSabFin.maxLength=5;
     document.all.txtDomIni.maxLength=5;
     document.all.txtDomFin.maxLength=5;
      
 </script>

</body>
</html>
