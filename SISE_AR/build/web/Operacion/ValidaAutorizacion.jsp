<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<html>
<head><b><center><table><tr><td><font color='#423A9E'></font></td></tr></table></center></b> 
<title>Valida Autorizacion</title>
</head>
<body class="cssBody">
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
<br><br>

<%  
    String strclUsr = "0";
    if (session.getAttribute("clUsrApp") != null) {
        strclUsr = session.getAttribute("clUsrApp").toString();        }
    if(SeguridadC.verificaHorarioC(Integer.parseInt(strclUsr)) != true){
        %><font color="white"  style="font-family:Verdana,Arial,Helvetica,sans-serif; background-color:red;" size=3>LA SESION EXPIRO</font><%  
        strclUsr=null;
        return;
        }
    String StrUsr="";
    String StrPwd="";
    StringBuffer StrSql= new StringBuffer();
    String StrNombrePagina="";
    String StrMensaje="";
    String StrAutoriza="1";   
    String StrclExpediente="0"; 
    String StrclSubServicio="0"; 
     if (request.getParameter("NombrePagina")!= null)     {
       StrNombrePagina = request.getParameter("NombrePagina").toString();      }       
     if (request.getParameter("Usr")!= null)     {
       StrUsr= request.getParameter("Usr").toString();      }   
     if (request.getParameter("Pwd")!= null)     {
       StrPwd= request.getParameter("Pwd").toString();      }   
     if (request.getParameter("Mensaje")!= null)     {
       StrMensaje=request.getParameter("Mensaje").toString();      }   
    if (session.getAttribute("clExpediente")!= null){
        StrclExpediente= session.getAttribute("clExpediente").toString();     }       
    if (session.getAttribute("clSubServicio")!= null){
        StrclSubServicio= session.getAttribute("clSubServicio").toString();     }  
    StrSql.append(" Select coalesce(E.TieneAsistencia,0) TieneAsistencia , P.NombrePaginaWeb, coalesce(S.clServicio,0) clServicio, ");
    StrSql.append(" coalesce(S.dsServicio,'') dsServicio, ");
    StrSql.append(" coalesce(SUB.clSubservicio,0) clSubServicio , " );
    StrSql.append(" coalesce(SUB.dsSubservicio,'') dsSubServicio, getdate() FechaAp " );
    StrSql.append(" from cSubservicio SUB " );
    StrSql.append(" inner join cServicio S on (SUB.clServicio = S.clServicio)  " );
    StrSql.append(" left join Expediente E on (E.clSubservicio = SUB.clSubservicio AND E.clExpediente = ").append(StrclExpediente).append(")  ");
    StrSql.append(" left join cPaginaWeb P on (SUB.clPaginaWeb = P.clPaginaWeb)  " );
    StrSql.append(" where E.clSubservicio is not null or sub.clSubservicio = ").append(StrclSubServicio);
    ResultSet rs2 = UtileriasBDF.rsSQLNP( StrSql.toString()); 
    StrSql.delete(0,StrSql.length());
    if (rs2.next()) {  
        if (request.getParameter("Usr")!= null)      {
            StrSql.append("sp_EncriptDesEncriptPassword '").append(StrUsr.toUpperCase()).append("',0,'',0");  
            ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
            StrSql.delete(0,StrSql.length());
            if (rs.next()){
             if (rs.getString("clUsrApp")!=null){
                if (StrPwd.equalsIgnoreCase(rs.getString("password"))){
                   if (StrAutoriza.equals(rs.getString("AutorizaExp"))){    
                       %><script>location.href='../<%=rs2.getString("NombrePaginaWeb")%>clExpediente=<%=StrclExpediente%>';</script> <%
                   } else  {       StrMensaje="USUARIO NO AUTORIZADO";     }
                } else {    StrMensaje="CONTRASEÑA INCORRECTA";      }
            }  else  {   StrMensaje="USUARIO INCORRECTO";     }
          } 
          rs.close();
          rs = null;
         }
    }
    rs2.close();
    rs2=null;
    %><p class='TTable'>ESTE SERVICIO EXCEDE EL LIMITE DE EVENTOS DE LA COBERTURA DE LA CUENTA. 
    <br><%=StrMensaje%></p>
    <form action='../Operacion/ValidaAutorizacion.jsp?' method='post'>
    <INPUT id='NombrePagina' name='NombrePagina' type='hidden' value='<%=StrNombrePagina%>'>
    <table><tr><td class='cssTitDet' colspan=2>Clave de autorización...</td></tr>
    <tr><td class='FTable'>Usuario:</td><td class='FTable'><input id='Usr' name = 'Usr'></input></td><tr>
    <tr><td class='FTable'>Contraseña:</td><td class='FTable'><input type=password id='Pwd' name = 'Pwd'></input></td><tr>
    <tr><td class='FTable'><input class='cBtn' VALUE='Autorizar' type='submit'></input></td><td class='FTable'><input value ='Cancelar' class='cBtn' type='button' onClick='fnRedirecciona(<%=StrclExpediente%>)'></input></td><tr>
    <script>window.focus();window.resizeTo(350,300);window.moveTo(300,150)</script>
    <BGSOUND SRC='../Music/UTOPIA.WAV'>
<script>
//------------------------------------------------------------------------------
function fnRedirecciona(Exp){
   location.href='../Operacion/DetalleExpediente.jsp?clExpediente=' + Exp;
}
//------------------------------------------------------------------------------
</script>
</body>
</html>

 