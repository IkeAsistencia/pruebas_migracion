<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<html>
<head>
<title>Ingresa Correo</title>
</head>
<body class="cssBody">
<link href="StyleClasses/Global.css" rel="stylesheet" type="text/css">
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
<!--<script src='../Utilerias/Util.js'></script>-->
<%
    String strclUsr="0";
    String strCorreo="";
    ResultSet rsEx = null;
    
    String strCorreoSess="";
    

      
     if (session.getAttribute("clUsrApp")!= null)
      	{
       		strclUsr = session.getAttribute("clUsrApp").toString(); 
        }  
    
     if ( request.getParameter("Correo")!= null)
      	{
             strCorreo = request.getParameter("Correo").toString().trim();
        }  
        
    if (SeguridadC.verificaHorarioC(Integer.parseInt(strclUsr)) != true) {
                %>Fuera de Horario<%
                return;
            }
        
    //if(strCorreo.compareToIgnoreCase("")==0) {

         if(strCorreo.isEmpty() || strclUsr.isEmpty() ){
%>
<form name="forma" action="IngresaCorreoBG.jsp?"> 
<input type="hidden" id="cUsrApp" name="cUsrApp" value="<%= strclUsr %>"></input>

<table><tr><td class="TTable" colspan="2">Por favor ingrese su correo electronico: </td></tr>
<tr><td><input type="text" id="Correo" name="Correo"></input></td><td class="VTable"><font size="+1"><strong>@galicia.com.ar</strong></font></td></tr>
<tr><td colspan="2">
<input type="button" id="btnGuarda" value="Guardar" onClick="fnValida();if(msgVal==''){document.all.forma.submit();}else{alert('Falta informar: ' + msgVal)}" ></input>
</td></tr>
</table>
</form>
<%    }else{
        
        session.setAttribute("Correo",strCorreo+"@galicia.com.ar" );
        
          if (session.getAttribute("Correo")!= null)
      	{
       		strCorreoSess = session.getAttribute("Correo").toString();
        }
        
        rsEx = UtileriasBDF.rsSQLNP("st_CambiaCorreo '" + strCorreoSess + "',"+ strclUsr);
        out.println("<script> alert('Gracias. Su correo es: " + strCorreoSess + "'); window.close();</script>");
        
}
%>

<script>
    function fnValida(){
        msgVal="";
        if (document.all.Correo.value==''){
            msgVal= 'Correo Electronico'
        }

        if(msgVal!=""){
            return(msgVal);
        }
    }
</script>
</body>
</html>
