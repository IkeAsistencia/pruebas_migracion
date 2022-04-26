<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<html>
<head>
<title></title>
</head>
<body class="cssBody">
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
<%  
    	String strNombreUsr = "";
    	String strclUsrApp = "";
      StringBuffer strSql= new StringBuffer(); 
      
      
      

      	if (request.getParameter("NombreUsr")!= null)
      	{
             strNombreUsr = request.getParameter("NombreUsr").toString().trim();
        }  
        
        if (!strNombreUsr.equalsIgnoreCase("")){
            strSql.append(" Select U.Nombre, U.clUsrApp ");
            strSql.append(" from cUsrApp U ");
            strSql.append(" where U.nombre like '%").append(strNombreUsr).append("%'");

            ResultSet rsUsr = UtileriasBDF.rsSQLNP( strSql.toString());
            if(rsUsr.next()){
                if(rsUsr.isLast()){
                    %><script>top.opener.fnActualizaDatosUsuario('<%=rsUsr.getString("Nombre")%>',<%=rsUsr.getString("clUsrApp")%>);window.close()</script>
                    <%
                    strSql.delete(0,strSql.length());
                    return;
                }
            }
            rsUsr.close();
        }
        
        strSql.delete(0,strSql.length());
        if (request.getParameter("strSQL")!= null)
      	{
            strSql.append(request.getParameter("strSQL").toString()); 
            strSql.append(" '").append(strNombreUsr).append("'");
       	}

       	MyUtil.InicializaParametrosC(167,Integer.parseInt("1")); 

	%><form id='Forma' name ='Forma' action='FiltroUsuario.jsp' method='get'>
	<input type='hidden' id='strSQL' name='strSQL' value="sp_WebBuscaUsuario"></input>
        <%=MyUtil.ObjInput("NombreUsr","NombreUsr",strNombreUsr,true,true,25,90,"",false,false,50)%>
        <P align='left'><input type='button' value='BUSCAR...' onClick='document.all.Forma.submit()' class='cBtn'></input></p>
	</form>
        <script>document.all.NombreUsr.readOnly=false;window.resizeTo(700,500);</script><br><br><br><br><br>
        <%
        if (strNombreUsr!="" && (strSql.length()>0)){
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
