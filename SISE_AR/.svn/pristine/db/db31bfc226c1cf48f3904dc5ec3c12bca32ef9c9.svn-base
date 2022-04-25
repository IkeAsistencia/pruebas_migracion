<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="Combos.cbEntidad,java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<html>
<head>
<title></title>
</head>
<body class="cssBody">
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
<%  
        StringBuffer strSql= new StringBuffer(); 
        String strTipo=""; 
    
    

      	if (request.getParameter("Tipo")!= null)
      	{
             strTipo = request.getParameter("Tipo").toString();
        }    
        
      	if (request.getParameter("strSQL")!= null)
      	{
            strSql.append(request.getParameter("strSQL").toString()); 
            if (request.getParameter("dsMundel")!="" && request.getParameter("CodEnt")!=""){
                strSql.append(", '").append(request.getParameter("dsMundel")).append("','").append(request.getParameter("CodEnt")).append("'");
                System.out.println(strSql);
            }
       	}

       	MyUtil.InicializaParametrosC(166,Integer.parseInt("1")); 

	%><form id='Forma' name ='Forma' action='FiltrosDireccion.jsp' method='get'>
	<input type='hidden' id='strSQL' name='strSQL' value="sp_WebBuscaDir <%=strTipo%>,''"></input>
        <%=MyUtil.ObjComboMem("Provincia","CodEnt","","",cbEntidad.GeneraHTML(20,""),true,true,25,50,"","","",50,true,true)%>
        <%=MyUtil.ObjInput("Partido/Departamento","dsMundel","",true,true,25,90,"",false,false,50)%>
	<input type='hidden' id='Tipo' name='Tipo' value="<%=strTipo%>"></input>
        <P align='left'><input type='button' value='BUSCAR...' onClick='document.all.Forma.submit()' class='cBtn'></input></p>
	</form><script>document.all.CodEntC.disabled=false;document.all.dsMundel.readOnly=false;window.resizeTo(700,500);</script>
	<br><br><br><br><br>
	<%
        if (strSql.length()>0){
            StringBuffer strSalida = new StringBuffer();
            UtileriasBDF.rsTableNP(strSql.toString(),strSalida);
            %>
               <%=strSalida.toString()%>
            <%
            strSalida.delete(0,strSalida.length());
        }
        strSql.delete(0,strSql.length());
        //
%>

</body>
</html>

