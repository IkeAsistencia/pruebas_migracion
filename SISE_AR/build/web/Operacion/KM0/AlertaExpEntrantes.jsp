<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
<head><title>BUSCANDO EXPEDIENTES ENTRANTES</title> 
<link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css"> 
</head>   
<body class="cssBody">

<%-- <jsp:useBean id="beanInstanceName" scope="session" class="beanPackage.BeanClassName" /> --%>
<%-- <jsp:getProperty name="beanInstanceName"  property="propertyName" /> --%>

<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
<script src='../../Utilerias/Util.js' ></script>

<%   
 //   String StrSqlGruas="";
    String StrclUsrApp="0";
    String StrclPaginaWeb="0";
    
    

    if (session.getAttribute("clUsrApp")!= null)
     {
       StrclUsrApp = session.getAttribute("clUsrApp").toString(); 
     }  
    
    StrclPaginaWeb = "227";  
    session.setAttribute("clPaginaWebP",StrclPaginaWeb); 
    MyUtil.InicializaParametrosC(227,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
    %>
    <form target='funcion' id='FormaExpEnt' name ='FormaExpEnt' action='AlertaExpEntrantes.jsp?' method='get'>
    <%
    if ( request.getParameter("StrSP")!= null ) 
    {                                                 
       if (request.getParameter("StrSP").length() > 1) 
       { // se ejecutará cada 20 segundos
//            out.println("2222222222222"); 
            if (MyUtil.blnAccess[3]==true)  
            {   //si tiene permisos para tomar expedientes Publicados a Gruas, se activa la funcion automatica (cada 20 segundos se ejecuta)
              %> 
              <INPUT id='StrSP' name='StrSP' type='hidden' value='sp_WebExpedientexAsig'>
              <%
              ResultSet rs = UtileriasBDF.rsSQLNP( "sp_WebExpedientexAsig " + StrclUsrApp);
              if (rs.next()) 
              {    
                  %>
                 <script>window.open('../KM0/MsgExpEntrante.jsp','WinAlert','scrollbars=yes,status=yes,width=500,height=100') </script>
                 <%
              } 
              rs.close();
              rs=null;
            }
            else{
                %>
                 <INPUT id='StrSP' name='StrSP' type='hidden' value='2'>"
                 <%
            }
        } 
     }  
     else
     {  // para que se ejecute la primera vez de inmediado al entrar 
        if (MyUtil.blnAccess[3]==true)    
        {   
//            out.println("11111111111111"); 
            %>
           <INPUT id='StrSP' name='StrSP' type='hidden' value=''>
           <%
        }
        else{
            %>
             <INPUT id='StrSP' name='StrSP' type='hidden' value='2'>
             <%
        }        
     }
    %>
    </form>
    <%
 //   StrSqlGruas=null;
    StrclUsrApp=null;
    StrclPaginaWeb=null; 
    
%>
<script>
    if (document.all.StrSP.value=='')
    {  // para que se ejecute la primera vez de inmediado al entrar
//       alert('StrSP=vacio=Entro la primera vez');
       dnSetTimeD();
    }
    else
    {
       if (document.all.StrSP.value=='sp_WebExpedientexAsig')    
        {  // para que se ejecute cada 20 segundos
    //       alert('StrSP<>vacio=Entró la siguiente vez');
           setTimeout('dnSetTimeD()',20000);  
        }
    }    
    
    function dnSetTimeD() 
    {  
//       alert('definió funcion dnSetTimeD');
           document.all.StrSP.value='sp_WebExpedientexAsig';    
           document.all.FormaExpEnt.submit();
    }  
    

</script>
</body>
</html>

