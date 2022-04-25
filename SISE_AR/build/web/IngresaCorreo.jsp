<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<html>
    <head><title>Ingresa Correo</title></head>
    <body class="cssBody">
        <link href="StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
        <%
        String StrclUsr="0";
        if (session.getAttribute("clUsrApp")!= null){
            StrclUsr = session.getAttribute("clUsrApp").toString();   }  
        if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsr)) != true) {
            StrclUsr=null;
            %>Fuera de Horario<%
            return;
            }
        String StrCorreo="";
        String StrDominio="";
        String strCorreoSess="";
        ResultSet rsEx = null;
        if(request.getParameter("Correo")!= null){
            StrCorreo=request.getParameter("Correo").toString().trim();  }  
        if(request.getParameter("Correo")!= null){
            StrDominio=request.getParameter("DominioH").toString().trim();  }  
        if(StrCorreo.equalsIgnoreCase("") && StrDominio.equalsIgnoreCase("")){
            rsEx = UtileriasBDF.rsSQLNP("dbo.st_DominioCorreo ");   
            %>
            <form name="forma" action="IngresaCorreo.jsp?"> 
                <input id="DominioH" name="DominioH" type="hidden" value="@ikeasistencia.com.ar"/>
                <table>
                    <tr><td class="TTable" colspan="2">Por favor ingrese su correo electronico: </td></tr>
                    <tr>
                        <td><input type="text" id="Correo" name="Correo"/></td>
                        <td class="VTable">
                            <select id="Dominio" name="Dominio" onChange='document.all.DominioH.value=this.value;'>
                                <% while(rsEx.next()){%>
                                    <option label='<%=rsEx.getString("dsDominioCorreo")%>' value='<%=rsEx.getString("dsDominioCorreo")%>'>
                                        <%=rsEx.getString("dsDominioCorreo")%>
                                    </option>
                                <%}%>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <input type="button" id="btnGuarda" value="Guardar" onClick="fnValida();fnSubmit()"/>
                        </td>
                    </tr>
                </table>
            </form>                
            <%
            rsEx.close();
            rsEx=null;                        
            %>
        <%}else{
            session.setAttribute("Correo",StrCorreo+StrDominio);
            if (session.getAttribute("Correo")!= null){
                strCorreoSess = session.getAttribute("Correo").toString();   }  
            rsEx = UtileriasBDF.rsSQLNP("dbo.st_CambiaCorreo '" + strCorreoSess + "',"+ StrclUsr);
            out.println("<script> alert('Gracias. Su correo es: " + strCorreoSess + "'); window.close();</script>");
            }%>
        <script>
//------------------------------------------------------------------------------    
        function fnValida(){
            msgVal="";
            if (document.all.Correo.value==''){ msgVal= 'Correo Electronico'; }
            if(msgVal!=""){ return(msgVal); }
            }
//------------------------------------------------------------------------------            
        function fnSubmit(){
            if(msgVal==''){
                document.all.forma.submit();
            }else{
                alert('Falta informar: '+msgVal); }
            }
//------------------------------------------------------------------------------
        </script>
    </body>
</html>