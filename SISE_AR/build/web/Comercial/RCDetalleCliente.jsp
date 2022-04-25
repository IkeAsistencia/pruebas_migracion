<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="com.ike.ReuComer.DAORCCliente,com.ike.ReuComer.to.RCCliente,java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
<head><title>Seguimiento de reunion</title>
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
<link href="../StyleClasses/Calendario.css" rel="stylesheet" type="text/css"> 
</head>
<body class="cssBody" >
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
<script src='../Utilerias/Util.js' ></script>
<script src="../Utilerias/UtilCalendario.js"></script>
<script src='../Utilerias/UtilMask.js'></script>
<%
     
    String strclUsrApp = "0";
    String strclCliente = "0";
    String strclUsrAppSession = "0";
//Variables por sistema    
    
    if (session.getAttribute("clUsrApp")!=null)
    {
        strclUsrApp = session.getAttribute("clUsrApp").toString();
        strclUsrAppSession = session.getAttribute("clUsrApp").toString();
    }
    
    if (request.getParameter("clCliente")!=null)
    {
        strclCliente = request.getParameter("clCliente").toString();
    }
    else
    {
        if (session.getAttribute("clCliente")!=null)
        {
            strclCliente = session.getAttribute("clCliente").toString();
        }
                
    }       
    session.setAttribute("clCliente",strclCliente);
    
    if (SeguridadC.verificaHorarioC(Integer.parseInt(strclUsrApp)) != true) 
    {
%>
<b>Fuera de Horario</b>
<%
        strclUsrApp = null;
        return;       
   } 

 
    DAORCCliente daoRCCliente = null;
    
    RCCliente  Cliente = null;
    if (strclCliente.compareToIgnoreCase("0")!=0)
    {
        daoRCCliente = new DAORCCliente();
        Cliente = daoRCCliente.getCliente(strclCliente);
    }

       String StrclPaginaWeb = "675";
       session.setAttribute("clPaginaWebP",StrclPaginaWeb); 
       MyUtil.InicializaParametrosC(675,Integer.parseInt(strclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina 


   
%><script>fnOpenLinks()</script>

    <%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion","","")%>
    <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%>RCDetalleCliente.jsp?'></input>
    <INPUT id='clUsrAppSession' name='clUsrAppSession' type='hidden' value='<%=strclUsrAppSession%>'>
    <%=MyUtil.ObjInput("Clave Cliente","clCliente",Cliente != null ? Cliente.getclCliente() : "",false,false,30,70,"",false,false,30)%>
    <%=MyUtil.ObjInput("Cliente","NombreCliente",Cliente != null ? Cliente.getNombreCliente() : "",true,true,200,70,"",true,true,30)%>
    <%=MyUtil.ObjTextArea("Direccion","Direccion",Cliente != null ? Cliente.getDireccion() : "","65","5",true,true,30,115,"",false,false)%>
    <%=MyUtil.ObjTextArea("Notas","Notas",Cliente != null ? Cliente.getNotas() : "","65","5",true,true,30,195,"",false,false)%>
    <%=MyUtil.DoBlock("Detalle del Cliente ",170,40)%>    
        
    <%=MyUtil.ObjInput("Nombre del contacto 1","NombreContacto1",Cliente != null ? Cliente.getNombreContacto1() : "",true,true,30,330,"",false,false,50)%>
    <%=MyUtil.ObjInput("Puesto","PuestoContacto1",Cliente != null ? Cliente.getPuestoContacto1() : "",true,true,30,365,"",false,false,50)%>
    <%=MyUtil.ObjTextArea("Telefono","TelefonoContacto1",Cliente != null ? Cliente.getTelefonoContacto1() : "","30","3",true,true,300,330,"",false,false)%>    
    <%=MyUtil.ObjInput("Nombre del contacto 2","NombreContacto2",Cliente != null ? Cliente.getNombreContacto2() : "",true,true,30,420,"",false,false,50)%>
    <%=MyUtil.ObjInput("Puesto","PuestoContacto2",Cliente != null ? Cliente.getPuestoContacto2() : "",true,true,30,455,"",false,false,50)%>
    <%=MyUtil.ObjTextArea("Telefono","TelefonoContacto2",Cliente != null ? Cliente.getTelefonoContacto2() : "","30","3",true,true,300,420,"",false,false)%>    
    <%=MyUtil.ObjInput("Nombre del contacto 3","NombreContacto3",Cliente != null ? Cliente.getNombreContacto3() : "",true,true,30,510,"",false,false,50)%>
    <%=MyUtil.ObjInput("Puesto","PuestoContacto3",Cliente != null ? Cliente.getPuestoContacto3() : "",true,true,30,545,"",false,false,50)%>
    <%=MyUtil.ObjTextArea("Telefono","TelefonoContacto3",Cliente != null ? Cliente.getTelefonoContacto3() : "","30","3",true,true,300,510,"",false,false)%>    
    <%=MyUtil.ObjInput("Nombre del contacto 4","NombreContacto4",Cliente != null ? Cliente.getNombreContacto4() : "",true,true,30,590,"",false,false,50)%>
    <%=MyUtil.ObjInput("Puesto","PuestoContacto4",Cliente != null ? Cliente.getPuestoContacto4() : "",true,true,30,625,"",false,false,50)%>
    <%=MyUtil.ObjTextArea("Telefono","TelefonoContacto4",Cliente != null ? Cliente.getTelefonoContacto4() : "","30","3",true,true,300,590,"",false,false)%>     
    <%=MyUtil.DoBlock("Detalle del operativos",0,0)%>

    
    <%=MyUtil.ObjInput("Nombre del contacto 1","NombreContactoD1",Cliente != null ? Cliente.getNombreContactoD1() : "",true,true,30,725,"",false,false,50)%>
    <%=MyUtil.ObjInput("Puesto","PuestoContactoD1",Cliente != null ? Cliente.getPuestoContactoD1() : "",true,true,30,760,"",false,false,50)%>
    <%=MyUtil.ObjTextArea("Telefono","TelefonoContactoD1",Cliente != null ? Cliente.getTelefonoContactoD1() : "","30","3",true,true,300,725,"",false,false)%>    
    <%=MyUtil.ObjInput("Nombre del contacto 2","NombreContactoD2",Cliente != null ? Cliente.getNombreContactoD2() : "",true,true,30,815,"",false,false,50)%>
    <%=MyUtil.ObjInput("Puesto","PuestoContactoD2",Cliente != null ? Cliente.getPuestoContactoD2() : "",true,true,30,850,"",false,false,50)%>
    <%=MyUtil.ObjTextArea("Telefono","TelefonoContactoD2",Cliente != null ? Cliente.getTelefonoContactoD2() : "","30","3",true,true,300,815,"",false,false)%>    
    <%=MyUtil.ObjInput("Nombre del contacto 3","NombreContactoD3",Cliente != null ? Cliente.getNombreContactoD3() : "",true,true,30,905,"",false,false,50)%>
    <%=MyUtil.ObjInput("Puesto","PuestoContactoD3",Cliente != null ? Cliente.getPuestoContactoD3() : "",true,true,30,940,"",false,false,50)%>
    <%=MyUtil.ObjTextArea("Telefono","TelefonoContactoD3",Cliente != null ? Cliente.getTelefonoContactoD3() : "","30","3",true,true,300,905,"",false,false)%>    
    <%=MyUtil.ObjInput("Nombre del contacto 4","NombreContactoD4",Cliente != null ? Cliente.getNombreContactoD4() : "",true,true,30,995,"",false,false,50)%>
    <%=MyUtil.ObjInput("Puesto","PuestoContactoD4",Cliente != null ? Cliente.getPuestoContactoD4() : "",true,true,30,1030,"",false,false,50)%>
    <%=MyUtil.ObjTextArea("Telefono","TelefonoContactoD4",Cliente != null ? Cliente.getTelefonoContactoD4() : "","30","3",true,true,300,995,"",false,false)%>     
    <%=MyUtil.DoBlock("Contactos directivos",0,0)%>
   
    <%=MyUtil.GeneraScripts()%>
<%
     if (Cliente == null)
     {
%>
    <script>document.all.btnCambio.disabled = true;</script>
<%
     }
     strclUsrApp = null;
     strclCliente = null;
     Cliente = null;
%>  

    <input name='FechaMsk' id='FechaMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
<script>
    
 
    function fnAntesGuardar()
    {
     if (document.all.NombreCliente.value ==' ' || document.all.NombreCliente.value =='  ')
     {
      msgVal = msgVal + "Cliente."
      document.all.NombreCliente.value =''
      document.all.btnGuarda.disabled = false;
      document.all.btnCancela.disabled = false;   
     }

     if (document.all.TelefonoOfi.value ==' ' || document.all.TelefonoOfi.value =='  ')
     {
      msgVal = msgVal + "Telefono Conmutador."
      document.all.TelefonoOfi.value ='';
      document.all.btnGuarda.disabled = false;
      document.all.btnCancela.disabled = false;   
     }

     if (document.all.NombreContacto.value ==' ' || document.all.NombreContacto.value =='  ')
     {
      msgVal = msgVal + "Nombre Contacto."
      document.all.NombreContacto.value ='';
      document.all.btnGuarda.disabled = false;
      document.all.btnCancela.disabled = false;   
     }

    }
</script>
</body>
</html>

