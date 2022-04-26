<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<html>
<head>
<title>Construye Reporte</title>
</head>
<body class="cssBody" topMargin="70">
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
<script src='../Utilerias/Util.js'></script>
<input type="button" value="Add" onClick="fnAddRow()">

<%  
    String StrclUsrApp = "0";
    
    

    if (session.getAttribute("clUsrApp")!= null){
        StrclUsrApp= session.getAttribute("clUsrApp").toString(); 
    }

    if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true){
        %>
        Fuera de Horario
        <%
        
        return;
        
    }
    
    String StrclPaginaWeb = "442";
    session.setAttribute("clPaginaWebP",StrclPaginaWeb);
   
    MyUtil.InicializaParametrosC(442,Integer.parseInt(StrclUsrApp)); 
    %><%=MyUtil.ObjComboC("Tabla","cTabla","",true,true,30,30,"","Select T.clTabla, T.dsTabla from cTabla T order by T.dsTabla","","",50,false,false)%>
    <%
    
    %>

<table name='ITab' id='ITab'>
</table>

<script>
  document.all.cTablaC.disabled=false;
  
  function fnAddRow(){
		var IT = document.getElementById('ITab');
		
		var NewTR = IT.insertRow();
    
    NewTR.id=document.all.cTablaC[document.all.cTablaC.selectedIndex].text;
		CurrentRow=NewTR.rowIndex;
				
		NewTD = NewTR.insertCell();
		NewInp = document.createElement("<input type='button' value='Quitar' onClick='document.all.ITab.deleteRow(" + CurrentRow + ")'>");
		NewTD.appendChild(NewInp);

		NewTD = NewTR.insertCell();		
		NewInp = document.createElement("<input  type='text' value='"+ document.all.cTablaC[document.all.cTablaC.selectedIndex].text +"'></Input>");		
		NewTD.appendChild(NewInp);
    
    window.open("ObtenCamposTabla.jsp?strclTabla="+document.all.cTablaC[document.all.cTablaC.selectedIndex].value + "&strObject=" + document.all.cTablaC[document.all.cTablaC.selectedIndex].text)

  }
  
  function fnAddFields(strObject, strHTML){
    var ITR = document.getElementById(strObject);
    ITR.outerHTML="<tr><td>" + strHTML + "</td></tr>";
    
		/*NewTD = ITR.insertCell();		
		NewTable = document.createElement(strHTML);		
		NewTD.appendChild(NewTable);*/

  }
  
</script>
</body>
</html>
