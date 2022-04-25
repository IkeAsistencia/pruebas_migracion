<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<html>
<head>
<title></title>
</head>
<body class="cssBody">
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
<%  
    	String strCuenta = "";
    	String strclCuenta = "";
        StringBuffer strSql= new StringBuffer(); 
    
    

      	if (request.getParameter("Cuenta")!= null)
      	{
             strCuenta = request.getParameter("Cuenta").toString().trim();
        }  
        
        if (!strCuenta.equalsIgnoreCase("")){
            strSql.append(" st_getFiltrosCuentas '").append(strCuenta).append("'");

            ResultSet rsCuenta = UtileriasBDF.rsSQLNP( strSql.toString());
            if(rsCuenta.next()){
                if(rsCuenta.isLast()){
                    %><script>top.opener.fnActualizaDatosCuenta('<%=rsCuenta.getString("Nombre")%>','<%=rsCuenta.getString("clCuenta")%>','<%=rsCuenta.getString("clTipoValidacion")%>','<%=rsCuenta.getString("Mask")%>','<%=rsCuenta.getString("MaskUsr")%>','<%=rsCuenta.getString("TotAgentes")%>');window.close()</script>
                    <%
                    strSql.delete(0,strSql.length());
                    return;
                }
            }
            rsCuenta.close();
        }
        
        strSql.delete(0,strSql.length());
        if (request.getParameter("strSQL")!= null)
      	{
            strSql.append(request.getParameter("strSQL").toString()); 
            strSql.append(" '").append(strCuenta).append("'");
       	}

       	MyUtil.InicializaParametrosC(167,Integer.parseInt("1")); 

	%><form id='Forma' name ='Forma' action='FiltrosCuenta.jsp' method='get'>
	<input type='hidden' id='strSQL' name='strSQL' value="sp_WebBuscaCuenta"></input>
        <%=MyUtil.ObjInput("Cuenta","Cuenta",strCuenta,true,true,25,90,"",false,false,50)%>
        <P align='left'><input type='button' value='BUSCAR...' onClick='document.all.Forma.submit()' class='cBtn'></input></p>
	</form>
        <script>document.all.Cuenta.readOnly=false;window.resizeTo(700,500);</script><br><br><br><br><br>
        <%
        if (strCuenta!="" && (strSql.length()>0)){
            StringBuffer strSalida = new StringBuffer();
            UtileriasBDF.rsTableNP(strSql.toString(),strSalida);
            %>
               <%=strSalida.toString()%>
            <%
            strSalida.delete(0,strSalida.length());
        }
        
        strSql.delete(0,strSql.length());
        
%>

</body>
</html>
