<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<html>
<head>
<title></title>
</head>
<body class="cssBody">
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
<script src='../Utilerias/Util.js'></script>
<%  
    	String StrcvePaginaWeb = "0";
    	String strclUsr = "";
    

      	if (session.getAttribute("clUsrApp")!= null)
      	{
       		strclUsr = session.getAttribute("clUsrApp").toString(); 
        }  
        
      	if (request.getParameter("clPaginaWeb")!= null)
      	{
            StrcvePaginaWeb= request.getParameter("clPaginaWeb").toString(); 
      	}  

        if(StrcvePaginaWeb.compareToIgnoreCase("0")==0){
            if (session.getAttribute("clPaginaWebF")!= null)
            {
                StrcvePaginaWeb= session.getAttribute("clPaginaWebF").toString(); 
            }  
        } 
        
        session.setAttribute("clPaginaWebF",StrcvePaginaWeb);
        
        StringBuffer StrSql = new StringBuffer();
        StringBuffer StrSql2 = new StringBuffer();
        
        StrSql.append( " sp_GetPaginaWeb ").append(StrcvePaginaWeb) ;
        StrSql2.append(" select max(clPaginaWeb) 'clPaginaWeb' from cPaginaWeb ");
        
       
       	String StrclPaginaWeb = "2";
	session.setAttribute("clPaginaWebP",StrclPaginaWeb);
       %>
        
        <script>fnOpenLinks();//fnCloseLinks(</script>
       <%
       	MyUtil.InicializaParametrosC(2,Integer.parseInt(strclUsr)); 
        ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
        ResultSet rs2 = UtileriasBDF.rsSQLNP( StrSql2.toString()); %>
        
        
         
	<%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion","fnAlta();")%>
        
        <%
            String StrclPaginaMAX="0";
            //<<<<<<<<<<<< Obtener la Ultima Pagina Web Registrada >>>>>>>>>>
            if (rs2.next()){
                StrclPaginaMAX=rs2.getString("clPaginaWeb");
            }
        %>
        <INPUT id='clPaginaMAX' name='clPaginaMAX' type='hidden' value='<%=StrclPaginaMAX%>'>
        
        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1) + "PaginasWeb.jsp?"%>'>
       <% if (rs.next()) {%>

                
                <%=MyUtil.ObjInput("clPaginaWeb","clPaginaWeb",rs.getString("clPaginaWeb"),false,false,25,80,"",false,false,5)%>
		<%=MyUtil.ObjInput("Nombre Lógico Web","NombreLogicoWeb",rs.getString("NombreLogicoWeb"),true,true,25,120,"",true,true,45)%>
                <%=MyUtil.ObjChkBox("Lista","Lista",rs.getString("Lista"),true,true,320,120,"0","SI","NO","fnRptLista();")%>
                <%=MyUtil.ObjChkBox("Reporte Excel","RptExcel",rs.getString("RptExcel"),true,true,405,120,"0","SI","NO","fnRptExcel();")%>
                <%=MyUtil.ObjChkBox("Reporte Email","RptEmail",rs.getString("RptEMail"),true,true,500,120,"0","SI","NO","fnRptEmail();")%>
		<%=MyUtil.ObjInput("Nombre Página Web","NombrePaginaWeb",rs.getString("NombrePaginaWeb"),true,true,25,160,"",true,true,45)%>
                <%=MyUtil.ObjInput("Sentencia","SentenciaRPT",rs.getString("SentenciaRPT"),true,true,320,160,"",false,false,45)%>
		<%=MyUtil.ObjInput("Titulo","TituloRPT",rs.getString("TituloRPT"),true,true,25,200,"",true,false,45)%>                
		<%=MyUtil.ObjInput("Página Detalle","PaginaDetalle",rs.getString("PaginaDetalle"),true,true,320,200,"",false,false,45)%>
		<%=MyUtil.ObjInput("Tabla","Tabla",rs.getString("Tabla"),true,true,25,240,"",false,false,45)%>                
                <%=MyUtil.ObjInput("Tabla Bitácora","TablaBitacora",rs.getString("TablaBitacora"),true,true,320,240,"",false,false,45)%> 
                
                <INPUT id='Target' name='Target' type='hidden' value='Contenido'>
                <INPUT id='NombrePaginaWebCSV' name='NombrePaginaWebCSV' type='hidden' value='<%=rs.getString("NombrePaginaWebCSV")%>' SIZE="30">
                <INPUT id='NombrePaginaWebMail' name='NombrePaginaWebMail' type='hidden' value='<%=rs.getString("NombrePaginaWebMail")%>' SIZE="30">
                
                
                <div class='VTable' style='position:absolute; z-index:170; left:320px; top:290px;'>
                    <INPUT id="Reload" type='button' VALUE='Reload Página Web' onClick='fnReloadPagWeb();' class='cBtn'></div>
    
		<%=MyUtil.ObjComboC("Modulo","clModulo",rs.getString("dsModulo"),true,true,25,280,"","SELECT * FROM CMODULO ORDER BY DSMODULO","","",100,true,true)%>
                
       <% }
	else{%>
        
                  <script>
                    if (document.all.Action.value==1){
                        <%%>
                    }
                </script>

                <%=MyUtil.ObjInput("clPaginaWeb","clPaginaWeb","",false,false,25,80,"",false,false,5)%>
		<%=MyUtil.ObjInput("Nombre Lógico Web","NombreLogicoWeb","",true,true,25,120,"",true,true,45)%>
                <%=MyUtil.ObjChkBox("Lista","Lista","",true,true,320,120,"0","SI","NO","fnRptLista();")%>
                <%=MyUtil.ObjChkBox("Reporte Excel","RptExcel","",true,true,405,120,"0","SI","NO","fnRptExcel();")%>
                <%=MyUtil.ObjChkBox("Reporte Email","RptEmail","",true,true,500,120,"0","SI","NO","fnRptEmail();")%>
		<%=MyUtil.ObjInput("Nombre Página Web","NombrePaginaWeb","",true,true,25,160,"",true,true,45)%>
                <%=MyUtil.ObjInput("Sentencia","SentenciaRPT","",true,true,320,160,"",false,false,45)%>
		<%=MyUtil.ObjInput("Titulo","TituloRPT","",true,true,25,200,"",true,false,45)%>                
		<%=MyUtil.ObjInput("Página Detalle","PaginaDetalle","",true,true,320,200,"",false,false,45)%>
		<%=MyUtil.ObjInput("Tabla","Tabla","",true,true,25,240,"",false,false,45)%>                
                <%=MyUtil.ObjInput("Tabla Bitácora","TablaBitacora","",true,true,320,240,"",false,false,45)%> 
                
                <INPUT id='Target' name='Target' type='hidden' value='Contenido'>
                <INPUT id='NombrePaginaWebCSV' name='NombrePaginaWebCSV' type='hidden' value='' SIZE="30">
                <INPUT id='NombrePaginaWebMail' name='NombrePaginaWebMail' type='hidden' value='' SIZE="30">
                
                
                <div class='VTable' style='position:absolute; z-index:170; left:320px; top:290px;'>
                    <INPUT id="Reload" type='button' VALUE='Reload Página Web' onClick='fnReloadPagWeb();' class='cBtn'></div>
    
		<%=MyUtil.ObjComboC("Modulo","clModulo","",true,true,25,280,"","SELECT * FROM CMODULO ORDER BY DSMODULO","","",100,true,true)%>
	<%}%>
			 
        <%=MyUtil.DoBlock("Detalle de Páginas Web",-50,0)%>
	<%=MyUtil.GeneraScripts()%>
	<% 
           rs.close();
           rs2.close();
           
           rs=null;
           rs2= null;
           StrSql=null;
          
          %>
</body>
    <script>
        
        
        document.all.btnElimina.disabled=true;
        
        function fnAlta(){
            Pag=parseInt(document.all.clPaginaMAX.value);
            document.all.clPaginaWeb.value=Pag+1;
        }
        //<<<<<<<<<< Activar o Inactivación para  el Envio de Reportes en Excel >>>>>>>>>>>>
        function fnRptLista(){
            //<<<<<<<<<<<<<<< Activo >>>>>>>>>>>>>>>>>>
            if(document.all.ListaC.checked==true){
                document.all.NombrePaginaWeb.value='servlet/Utilerias.Lista?P='+document.all.clPaginaWeb.value;
            }
            //<<<<<<<<<<<< Inactivo >>>>>>>>>>>>>>>>
            else{
                document.all.NombrePaginaWeb.value='';
            }
        }
        
        //<<<<<<<<<< Activar o Inactivación para  el Envio de Reportes en Excel >>>>>>>>>>>>
        function fnRptExcel(){
            //<<<<<<<<<<<<<<< Activo >>>>>>>>>>>>>>>>>>
            if(document.all.RptExcelC.checked==true){
                document.all.NombrePaginaWebCSV.value='Utilerias/ListaCSV.jsp?P='+document.all.clPaginaWeb.value;
            }
            //<<<<<<<<<<<< Inactivo >>>>>>>>>>>>>>>>
            else{
                document.all.NombrePaginaWebCSV.value='';
            }
        }
        //<<<<<<<<<< Activar o Inactivación para  el Envio de Reportes en Email >>>>>>>>>>>>
        function fnRptEmail(){
            //<<<<<<<<<<<<<<< Activo >>>>>>>>>>>>>>>>>>
            if(document.all.RptEmailC.checked==true){
                document.all.NombrePaginaWebMail.value='Utilerias/ListaMail.jsp?P='+document.all.clPaginaWeb.value;
            }
            //<<<<<<<<<<<< Inactivo >>>>>>>>>>>>>>>>
            else{
                document.all.NombrePaginaWebMail.value='';
            }
        }
        
        //<<<<<<<<< Realizar un Reload a la Pagina Web >>>>>>>>>>>>>>
        function fnReloadPagWeb(){
              
             if (confirm(' Recarga de la Página Web '+<%=StrcvePaginaWeb%>+' .'+'\n\n'+'')){
                window.open('ReloadPagWeb.jsp?clPaginaWebR='+<%=StrcvePaginaWeb%>,'newWin','scrollbars=yes,status=yes,width=200,height=100');
                return true;
            }
            else{
                return false;
            }
        
        }
    </script>
</html>