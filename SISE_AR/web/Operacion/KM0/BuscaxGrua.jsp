<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
<head><title>Busca por Grúa</title> 
<link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 

</head>
<body class="cssBody">

<%
    String StrclUsrApp="0";
    String StrclExpediente="0";
    String StrclPaginaWeb="0";
    String StrblnPublica="";
    String StrGrua1="0";
    String StrGrua2="0";
    String StrGrua3="0";
    String StrGrua4="0";
    String StrGrua5="0";
    
    

  
    if (session.getAttribute("clUsrApp")!= null)
     {
       StrclUsrApp = session.getAttribute("clUsrApp").toString(); 
     }  
     
    if (session.getAttribute("clExpediente")!= null)
     {
       StrclExpediente = session.getAttribute("clExpediente").toString();  
     }     

    if (request.getParameter("Publica")!= null){  
      if (request.getParameter("Publica").toString().compareToIgnoreCase("")!=0){
        StrblnPublica = request.getParameter("Publica").toString();
      }
    }
    
    StrclPaginaWeb = "189";        
    MyUtil.InicializaParametrosC(189,Integer.parseInt(StrclUsrApp)); 
    session.setAttribute("clPaginaWebP",StrclPaginaWeb); 

    if (StrblnPublica.compareToIgnoreCase("")==0){
    
%>        <form id='Forma' name ='Forma'  action='BuscaxGrua.jsp?' method='get'>
        <input type="hidden" value="" id="Publica" name="Publica"></input>
        <%=MyUtil.ObjInput("Grúa #1","Grua1","",true,true,10,80,"",true,true,10,"")%>
        <%=MyUtil.ObjInput("Grúa #2","Grua2","",true,true,80,80,"",true,true,10,"")%>
        <%=MyUtil.ObjInput("Grúa #3","Grua3","",true,true,150,80,"",true,true,10,"")%>
        <%=MyUtil.ObjInput("Grúa #4","Grua4","",true,true,220,80,"",true,true,10,"")%>
        <%=MyUtil.ObjInput("Grúa #5","Grua5","",true,true,290,80,"",true,true,10,"")%>
        <% MyUtil.DoBlock("Publicar Servicios a Grúas:");
        %>
        <div class='VTable' style='position:absolute; z-index:25; left:10px; top:10px;'>
        <P align='left'><input type='button' value='Publicar...' onClick='document.all.Publica.value="1";submit()' class='cBtn'></input>
        <br><br><th>Nota: El número de grúa deberá corresponder con el número Iké (no del proveedor) </th>
        </p>
        </form>
        <script>
          document.all.Grua1.readOnly=false;
          document.all.Grua2.readOnly=false;
          document.all.Grua3.readOnly=false;
          document.all.Grua4.readOnly=false;
          document.all.Grua5.readOnly=false;
        </script>
<%   }
    else{ %>
        <%
            if (request.getParameter("Grua1")!= null){  
              if (request.getParameter("Grua1").toString().compareToIgnoreCase("")!=0){
                StrGrua1 = request.getParameter("Grua1").toString();
              }
            }

            if (request.getParameter("Grua2")!= null){  
              if (request.getParameter("Grua2").toString().compareToIgnoreCase("")!=0){
                StrGrua2 = request.getParameter("Grua2").toString();
              }
            }

            if (request.getParameter("Grua3")!= null){  
              if (request.getParameter("Grua3").toString().compareToIgnoreCase("")!=0){
                StrGrua3 = request.getParameter("Grua3").toString();
              }
            }

            if (request.getParameter("Grua4")!= null){  
              if (request.getParameter("Grua4").toString().compareToIgnoreCase("")!=0){
                StrGrua4 = request.getParameter("Grua4").toString();
              }
            }

            if (request.getParameter("Grua5")!= null){  
              if (request.getParameter("Grua5").toString().compareToIgnoreCase("")!=0){
                StrGrua5 = request.getParameter("Grua5").toString();
              }
            }

            UtileriasBDF.ejecutaSQLNP("sp_EnviaExpAProvxGrua " + StrclExpediente + "," + StrclUsrApp + "," + StrGrua1 + "," + StrGrua2 + "," + StrGrua3 + "," + StrGrua4 + "," + StrGrua5 ) ;
        %>
          <script>
            location.href='<%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%>CancelaEnvio.jsp?&Apartado=S';
          </script>
<%    }
  
%>
</body>
</html>
