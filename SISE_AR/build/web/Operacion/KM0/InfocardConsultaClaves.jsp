<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
<head><title>JSP Page</title> 
<link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
</head>
<body class="cssBody">
<%-- <jsp:useBean id="beanInstanceName" scope="session" class="beanPackage.BeanClassName" /> --%>
<%-- <jsp:getProperty name="beanInstanceName"  property="propertyName" /> --%>
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
<script src='../../Utilerias/Util.js' ></script>
<%  
    String StrclExpediente = "0";  
    String StrCodEnt = " ";     
    String StrclUsrApp="0";
    String StrclPaginaWeb="0";    
    String StrclNUInfoCard="0";  
    String StrRFC = "";  
    String StrLugNac = "";      
    String StrNumIntentos="1";  
    
    
    
    int iNumIntentos=0;  
    StringBuffer StrSql = new StringBuffer();
    StringBuffer StrSqlInsert = new StringBuffer();
    
    if (session.getAttribute("clUsrApp")!= null)
     {
       StrclUsrApp = session.getAttribute("clUsrApp").toString(); 
     }  
    if (session.getAttribute("clExpediente")!= null)
     {
       StrclExpediente = session.getAttribute("clExpediente").toString(); 
     }  
    if (session.getAttribute("NumIntentos")!= null)
     {
       StrNumIntentos = session.getAttribute("NumIntentos").toString(); 
     }      
    if (Integer.parseInt(StrNumIntentos)>3)
    {
      session.setAttribute("NumIntentos","1");
      %>
      <script>alert('HA EXCEDIDO EL NÚMERO DE INTENTOS PERMITIDOS');</script>
      <script> location.href='../../Operacion/DetalleExpediente.jsp?Apartado=S&clExpediente=" + StrclExpediente + "';</script>
      <%
      StrclExpediente = null;   
      StrSql = null; 
      StrSqlInsert = null;     
      StrCodEnt = null;     
      StrclUsrApp=null;
      StrclPaginaWeb=null;    
      StrclNUInfoCard=null;  
      StrRFC = null;  
      StrLugNac = null;      
      StrNumIntentos=null;  
      
      return; 
    }
    if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) 
     { %>
       Fuera de Horario
       <%
       StrclExpediente = null;   
       StrSql = null; 
       StrSqlInsert = null;     
       StrCodEnt = null;     
       StrclUsrApp=null;
       StrclPaginaWeb=null;    
       StrclNUInfoCard=null;  
       StrRFC = null;  
       StrLugNac = null;      
       StrNumIntentos=null;  
       
       return; 
     }  %>
    <script>fnCloseLinks(window.parent.frames.InfoRelacionada.height) </script>
    <%
    StrclPaginaWeb = "383";
    MyUtil.InicializaParametrosC(383,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
    session.setAttribute("clPaginaWebP",StrclPaginaWeb);
    
    if (request.getParameter("clNUInfoCard")!= null)   //expediente viene como parámetro aqui
     {
       StrclNUInfoCard = request.getParameter("clNUInfoCard").toString();
     }
    if (request.getParameter("StrRegFed")!= null)   //expediente viene como parámetro aqui
     {
       StrRFC = request.getParameter("StrRegFed").toString();
     }
    if (request.getParameter("StrLugar")!= null)   //expediente viene como parámetro aqui
     {
       StrLugNac = request.getParameter("StrLugar").toString();
     }
    
    if ( request.getParameter("StrSP")!= null && request.getParameter("StrSP")!= "")
     {
          if (request.getParameter("StrSP").length() > 1) {   //toma expediente solo si oprimieron botón de tomar
             
              
              StrSql.append(request.getParameter("StrSP").toString());
              ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
                            
              if (rs.next()){
                  if (rs.getString(1).equals("0"))
                  { %>
                      <script>alert('DEBE INFORMAR EL RFC Y EL LUGAR DE NACIMIENTO EXACTOS');</script>
                      <%
                      iNumIntentos = Integer.parseInt(StrNumIntentos) + 1;
                      StrNumIntentos = Integer.toString(iNumIntentos);
                      session.setAttribute("NumIntentos",StrNumIntentos);
                      StrclNUInfoCard="0";
                  }else { 
                      session.setAttribute("NumIntentos","1");
                      ResultSet rsIns = UtileriasBDF.rsSQLNP( "Select clNUInfoCard From NUInfoCard Where RFC='" + StrRFC + "' and CodEntNacimiento='" +  StrLugNac + "'");  
                      if (rsIns.next()){  
                         StrSqlInsert.append("Insert Into InfocardBitacora(clNUInfoCard,clUsrApp) VALUES (");
                         StrSqlInsert.append(rsIns.getString("clNUInfoCard")).append(",").append(StrclUsrApp).append(")");
                         UtileriasBDF.ejecutaSQLNP( StrSqlInsert.toString());
                         StrSqlInsert.delete(0,StrSqlInsert.length());
                      }
                      StringBuffer strSalida = new StringBuffer();
                      UtileriasBDF.rsTableNP(StrSql.toString(), strSalida);
                      %>
                     <%=strSalida.toString()%>
                      <%
                      strSalida.delete(0,strSalida.length());
                      strSalida=null;
                      StrSql.delete(0,StrSql.length());
                      
                      rs.close();
                      rsIns.close();
                      rs=null;
                      rsIns=null;
                      StrclExpediente = null;   
                      StrSql = null; 
                      StrSqlInsert = null;     
                      StrCodEnt = null;     
                      StrclUsrApp=null;
                      StrclPaginaWeb=null;    
                      StrclNUInfoCard=null;  
                      StrRFC = null;  
                      StrLugNac = null;      
                      StrNumIntentos=null;  
                      
                      return; 
                  }
              }   
         }
     }       
       
    if  (StrclNUInfoCard.equals("0")) 
    {  // Pide las claves para validarlas
        %>
        <form id='Forma' name ='Forma'  action='../KM0/InfocardConsultaClaves.jsp?' method='get'>
        <INPUT id='StrSP' name='StrSP' type='hidden' value=''>
        <INPUT id='StrRegFed' name='StrRegFed' type='hidden' value=''>
        <INPUT id='StrLugar' name='StrLugar' type='hidden' value=''>
       
        <div class='VTable' style='position:absolute; z-index:25; left:10px; top:10px;'>
        <P align='left'><input type='button' value='Buscar' onClick='fnValidaCves();' class='cBtn'></input></p>
        
        <label>RFC:    </label><INPUT id='RFC' name='RFC'  value='' size=20>
        <%=MyUtil.ObjComboHabC("LUGAR DE NACIMIENTO","LugNac","",true,true,200,30,"","Select CodEnt, dsEntFed From cEntFed Order by dsEntFed","","",70,true,true)%>
        <%
    } else {  // Despliega la Información Confidencial
        
       session.setAttribute("clNUInfoCard",StrclNUInfoCard);
       %>
       
       <script> location.href='../../servlet/Utilerias.Lista?P=384&Apartado=S';</script>-
       <%
    }
    StrclExpediente = null;   
    StrSql = null; 
    StrSqlInsert = null;     
    StrCodEnt = null;     
    StrclUsrApp=null;
    StrclPaginaWeb=null;    
    StrclNUInfoCard=null;  
    StrRFC = null;  
    StrLugNac = null;      
    StrNumIntentos=null;  
    
%>
<script>
function fnValidaCves()
{ 
    if (document.all.RFC.value=='')
    {
       alert('Debe proporcionar el RFC');
       return;
    }else{ document.all.StrRegFed.value=document.all.RFC.value;  }

    if (document.all.LugNac.value=='')
    {
       alert('Debe proporcionar el Lugar de Nacimiento');
       return;
    }else{ document.all.StrLugar.value=document.all.LugNac.value;  }
    
    document.all.StrSP.value="sp_ListaValidaCvesSeg '" + document.all.RFC.value + "','" + document.all.LugNac.value + "'";
    document.all.Forma.submit();
}
</script>
</body>
</html>
