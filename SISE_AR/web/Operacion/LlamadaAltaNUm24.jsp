<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="com.ike.LlamadaAltaNu.DAOLANU,com.ike.LlamadaAltaNu.to.LANUAfiliado,java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
<head><title>LLAMADA DE ALTA DE USUARIOS M24</title>
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
</head>
<body class="cssBody">

<jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj" /> 
<script src='../Utilerias/Util.js' ></script>
<script src='../Utilerias/UtilAuto.js'></script>
<script src='../Utilerias/UtilMask.js' ></script>
<%
   
   String strclUsrApp="0";
   String Clave="0";
   String Cambio = "0";
   String strColonia = "";
   String strCalle = "";
   
   if (session.getAttribute("clUsrApp")!= null)
   {
       strclUsrApp = session.getAttribute("clUsrApp").toString(); 
   }  

   if (SeguridadC.verificaHorarioC(Integer.parseInt(strclUsrApp)) != true) 
   {
%>
Fuera de Horario
<%
       strclUsrApp = null;
       return;  
   }    

   if (request.getParameter("Clave")!= null)
   {
       Clave= request.getParameter("Clave").toString(); 
   }  
   
   DAOLANU daoLANUAfiliado = null;
   LANUAfiliado  Afiliado = null;
   if (Clave.compareToIgnoreCase("0")!=0)
   {
       daoLANUAfiliado = new DAOLANU();
       Afiliado = daoLANUAfiliado.getAfiliado(Clave);
       Cambio = "1";
   }
   
   String StrclPaginaWeb = "688";
   session.setAttribute("clPaginaWebP",StrclPaginaWeb); 
   MyUtil.InicializaParametrosC(688,Integer.parseInt(strclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina 
%>
   <%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaGuardaAfiliadoM24","fnAccionesAlta();","fnAntesGuardar();")%>
   <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%>LlamadaAltaNUm24.jsp?'></input>
   <INPUT id='clUsrApp' name='clUsrApp' type='hidden' value='<%=strclUsrApp%>'>
   <INPUT id='clAfiliadoA' name='clAfiliadoA' type='hidden' value='<%=Afiliado != null ? Afiliado.getclAfiliadoA(): "0"%>'>
   <INPUT id='clAfiliadoJ' name='clAfiliadoJ' type='hidden' value='<%=Afiliado != null ? Afiliado.getclAfiliadoJ(): "0"%>'>
   <%=MyUtil.ObjInput("Clave","Clave",Afiliado != null ? Afiliado.getClave() : "",true,false,30,70,"",false,false,30)%>
   <%=MyUtil.ObjInput("Fecha Alta","FechaAlta",Afiliado != null ? Afiliado.getFechaAltaA() : "",false,false,300,70,"",false,false,15)%>
   <%=MyUtil.ObjInput("Fecha Activacion","FechaIni",Afiliado != null ? Afiliado.getFechaIniA() : "",false,false,400,70,"",false,false,15)%>
   <%=MyUtil.DoBlock("Datos Generales",0,0)%>
   
   <%=MyUtil.ObjInput("Nombre","NombreA",Afiliado != null ? Afiliado.getNombre() : "",true,true,30,172,"",false,false,30)%>
   <%=MyUtil.ObjInput("Apellido Paterno","ApaternoA",Afiliado != null ? Afiliado.getApellidoPat() : "",true,true,200,172,"",false,false,20)%>
   <%=MyUtil.ObjInput("Apellido materno","AmaternoA",Afiliado != null ? Afiliado.getApellidoMat() : "",true,true,320,172,"",false,false,20)%>
   <%=MyUtil.ObjInput(i18n.getMessage("message.title.rfc"),"RFC",Afiliado != null ? Afiliado.getRFC() : "",true,true,30,222,"",false,false,20)%>
   <%=MyUtil.ObjInput("Fecha de Nacimiento<br> aaaa/mm/dd","FechaNacA",Afiliado != null ? Afiliado.getFechaNacA() : "",true,true,200,210,"",false,false,15,"if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)};fnCalculaEdad(1);")%>
   <%=MyUtil.ObjInput("Edad","EdadA",Afiliado != null ? Afiliado.getEdadA() : "",false,false,320,222,"",false,false,15)%>
   <%=MyUtil.DoBlock("Afiliado Adulto ",0,0)%>    
   
   <%=MyUtil.ObjInput("Nombre","NombreJ",Afiliado != null ? Afiliado.getNombreJu() : "",true,true,30,324,"",false,false,30)%>
   <%=MyUtil.ObjInput("Apellido Paterno","ApaternoJ",Afiliado != null ? Afiliado.getApellidoPatJ() : "",true,true,200,324,"",false,false,20)%>
   <%=MyUtil.ObjInput("Apellido materno","AmaternoJ",Afiliado != null ? Afiliado.getApellidoMatJ() : "",true,true,320,324,"",false,false,20)%>   
   <%=MyUtil.ObjInput("Fecha de Nacimiento<br> aaaa/mm/dd","FechaNacJ",Afiliado != null ? Afiliado.getFechaNacJ() : "",true,true,30,360,"",false,false,15,"if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)};fnCalculaEdad(2);")%>
   <%=MyUtil.ObjInput("Edad","EdadJ",Afiliado != null ? Afiliado.getEdadJ() : "",false,false,190,372,"",false,false,15)%>
   <%=MyUtil.DoBlock("Afiliado Junior ",0,0)%>    

   <%=MyUtil.ObjInput(i18n.getMessage("message.title.entidad"),"dsEntFed",Afiliado != null ? Afiliado.getEstado() : "",false,false,30,464,"",false,false,50)%>
   <INPUT id='CodEnt' name='CodEnt' type='hidden' value='<%=Afiliado != null ? Afiliado.getCodEnt() : ""%>'>
   <%=MyUtil.ObjInput(i18n.getMessage("message.title.municipio"),"dsMunDel",Afiliado != null ? Afiliado.getMunDel() : "",false,false,345,464,"",false,false,50)%>                
   <INPUT id='CodMD' name='CodMD' type='hidden' value='<%=Afiliado != null ? Afiliado.getCodMD() : ""%>'>
   <%=MyUtil.ObjInput(i18n.getMessage("message.title.colonia"),"Colonia",Afiliado != null ? Afiliado.getColonia() : "",false,false,30,500,"",false,false,50)%>                
   <%=MyUtil.ObjInput("Calle y Número","Calle",Afiliado != null ? Afiliado.getCalle() : "",true,true,345,500,"",false,false,50)%>
   <%=MyUtil.ObjInput(i18n.getMessage("message.title.cp"),"CP",Afiliado != null ? Afiliado.getCP() : "",false,false,30,540,"",false,false,10)%>
   <div class='VTable' style='position:absolute; z-index:25; left:120px; top:552px;'>
   <INPUT type='button' VALUE='Buscar..' onClick='fnBuscaColoniaN2();' class='cBtn'></div>
   <%=MyUtil.DoBlock("Domicilio",120,0)%>

   <%=MyUtil.ObjInput("Telefono","Telefono",Afiliado != null ? Afiliado.getTelefono() : "",true,true,30,630,"",false,false,20)%>
   <%=MyUtil.ObjInput("Telefono celular","Celular",Afiliado != null ? Afiliado.getCelular() : "",true,true,150,630,"",false,false,25)%>
   <%=MyUtil.ObjInput("Correo electrónico","Correo",Afiliado != null ? Afiliado.getCorreo() : "",true,true,305,630,"",false,false,60,"fnValidaCorreo();")%>
   <%=MyUtil.DoBlock("Contacto",160,0)%>    

<%
   if (Cambio.equalsIgnoreCase("0"))
   {
%>
       <script>document.all.btnCambio.disabled=true;</script>
<%
   }
%>
   <%=MyUtil.GeneraScripts()%>
<%
   strclUsrApp=null;
   strColonia = null;
   strCalle = null;
   daoLANUAfiliado = null;
   Afiliado = null;
%>
   <input name='FechaMsk' id='FechaMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09'>
   <script>
   document.all.btnCambio.disabled=true; 
   document.all.Telefono.maxLength=20;    
   document.all.Celular.maxLength=20;    
   document.all.Correo.maxLength=50;
   
   function fnAccionesAlta()
   {
    if (document.all.Action.value == 1)
    {
     var pstrCadena = "../Utilerias/RegresaFechaActual.jsp";
     window.open(pstrCadena,'newWin','width=10,height=10,left=1500,top=2000');
    }
   }

   function fnAntesGuardar()
   {
    //Validacion de campos obligatorios
    if (document.all.Clave.value=='' || document.all.Clave.value==' ')
    {
     msgVal = msgVal + " Clave."
     document.all.btnGuarda.disabled = false;
     document.all.btnCancela.disabled = false;
    }

    if (document.all.NombreA.value=='' || document.all.NombreA.value==' ')
    {
     msgVal = msgVal + " Nombre del Afiliado Adulto."
     document.all.btnGuarda.disabled = false;
     document.all.btnCancela.disabled = false;   
    }

    if (document.all.ApaternoA.value=='' || document.all.ApaternoA.value==' ')
    {
     msgVal = msgVal + " Apellido paterno del Afiliado Adulto."
     document.all.btnGuarda.disabled = false;
     document.all.btnCancela.disabled = false;   
    }
    
    if (document.all.AmaternoA.value=='' || document.all.AmaternoA.value==' ')
    {
     msgVal = msgVal + " Apellido materno del Afiliado Adulto."
     document.all.btnGuarda.disabled = false;
     document.all.btnCancela.disabled = false;   
    }

    if (document.all.RFC.value=='' || document.all.RFC.value==' ')
    {
     msgVal = msgVal + " RFC."
     document.all.btnGuarda.disabled = false;
     document.all.btnCancela.disabled = false;  
    }

     if (document.all.FechaNacA.value=='')
     {
      msgVal = msgVal + " Fecha de Nacimiento del Afiliado Adulto."
      document.all.btnGuarda.disabled = false;
      document.all.btnCancela.disabled = false;
     }

     if (document.all.EdadA.value=='')
     {
      msgVal = msgVal + " Edad del Afiliado Adulto."
      document.all.btnGuarda.disabled = false;
      document.all.btnCancela.disabled = false;
     }

    if (document.all.NombreJ.value!='' || document.all.ApaternoJ.value!='' || document.all.AmaternoJ.value!='' || document.all.FechaNacJ.value!='' || document.all.EdadJ.value!='')
    {

     if (document.all.NombreJ.value=='')
     {
      msgVal = msgVal + " Nombre del Afiliado Junior."
      document.all.btnGuarda.disabled = false;
      document.all.btnCancela.disabled = false;
     }
     
          if (document.all.ApaternoJ.value=='')
     {
      msgVal = msgVal + " Apellido paterno del Afiliado Junior."
      document.all.btnGuarda.disabled = false;
      document.all.btnCancela.disabled = false;
     }

          if (document.all.AmaternoJ.value=='')
     {
      msgVal = msgVal + " Apellido materno del Afiliado Junior."
      document.all.btnGuarda.disabled = false;
      document.all.btnCancela.disabled = false;
     }


     if (document.all.FechaNacJ.value=='')
     {
      msgVal = msgVal + " Fecha de Nacimiento del Afiliado Junior."
      document.all.btnGuarda.disabled = false;
      document.all.btnCancela.disabled = false;
     }

     if (document.all.EdadJ.value=='')
     {
      msgVal = msgVal + " Edad del Afiliado Junior."
      document.all.btnGuarda.disabled = false;
      document.all.btnCancela.disabled = false;
     }
    }
    
    if (document.all.dsEntFed.value=='' || document.all.dsMunDel.value=='' || document.all.Colonia.value=='' || document.all.Calle.value=='' || document.all.CP.value=='')
    {
     msgVal = msgVal + " Un dato en la direccion del Afiliado."
     document.all.btnGuarda.disabled = false;
     document.all.btnCancela.disabled = false;
    }
    
    if (document.all.Telefono.value=='' || document.all.Telefono.value=='  ')
    {
     msgVal = msgVal + " Telefono."
     document.all.btnGuarda.disabled = false;
     document.all.btnCancela.disabled = false;
    }
     
  }

    


    function fnBuscaColoniaN2()
    {
     if (document.all.btnGuarda.disabled==false)
     { 
      var pstrCadena = "../Utilerias/FiltrosDireccion.jsp?strSQL=sp_WebBuscaDir 1,'" + document.all.CP.value + "'";
      pstrCadena = pstrCadena + "&Colonia=&CodMd=&dsMunDel=&CodEnt=&dsEntFed=&Tipo=1";
      window.open(pstrCadena,'newWin','scrollbars=yes,status=yes,width=1,height=1');
     } 
    }
    
    function fnActualizaDatosCP(pCP, dsColonia, CodMD, dsMunDel, CodEnt, dsEntFed)
    {
     document.all.CP.value = pCP;
     document.all.Colonia.value = dsColonia;			
     document.all.CodMD.value = CodMD;
     document.all.dsMunDel.value = dsMunDel;
     document.all.CodEnt.value = CodEnt;
     document.all.dsEntFed.value = dsEntFed;
     document.all.Calle.focus();
    }

    function fnActualizaFechaActual (pFecha)
    {
     document.all.FechaAlta.value=pFecha;
     //document.all.FechaVTR.value=pFecha;
   }
   
   function fnValidaCorreo()
   {
    var strCorreo = document.all.Correo.value;
    if (document.all.Correo.value !='')
    {
     if (strCorreo.indexOf('@',0) == -1)
     {
      alert("Escriba una direccion de correo valida")
      document.all.Correo.value="";
      document.all.Correo.focus();
     }
    }
   }
   
   function fnValidaError()
   {
    blnAceptar=0;
    document.all.btnGuarda.disabled=false;
    document.all.btnCancela.disabled=false;
    WSave.close();
   }

   function fnCalculaEdad(Afi)
   {
    if (Afi == 1)
    {
     if (document.all.FechaNacA.value < document.all.FechaAlta.value)
     {
      if(document.all.FechaNacA.value != '')
      {
       var FechaActual = document.all.FechaAlta.value
       var FechaNacA = document.all.FechaNacA.value
       FechaActual = FechaActual.slice(0,4)
       FechaNacA = FechaNacA.slice(0,4)
       document.all.EdadA.value =  FechaActual - FechaNacA;
       document.all.EdadA.value =  document.all.EdadA.value;
      }
      else
      {
       document.all.FechaNacA.value="";
       document.all.EdadA.value="";
      }
     }
     else
     {
      alert("La Fecha de nacimiento no puede ser mayor a la fecha actual");
      document.all.FechaNacA.value="";
      document.all.FechaNacA.focus();
     }
    }
    else
    {
     if (document.all.FechaNacJ.value!='')
     {
      if (document.all.FechaNacJ.value < document.all.FechaAlta.value)
      {     
       var FechaActual = document.all.FechaAlta.value
       var FechaNacJ = document.all.FechaNacJ.value
       FechaActual = FechaActual.slice(0,4)
       FechaNacJ = FechaNacJ.slice(0,4)
       document.all.EdadJ.value =  FechaActual - FechaNacJ;
       document.all.EdadJ.value =  document.all.EdadJ.value;
       if (document.all.FechaNacJ.value!='')
       {
        if ( FechaActual - FechaNacJ > 18 && document.all.FechaNacJ.value!='')
        {
         document.all.FechaNacJ.value=""
         document.all.EdadJ.value="";
         document.all.FechaNacJ.focus();
         alert("El Afiliado Junior debe ser menor a 18 años");
        }
       }
      }
      else
      {
       alert("La Fecha de nacimiento no puede ser mayor a la fecha actual");
       document.all.FechaNacJ.value="";
       document.all.FechaNacJ.focus();
      }
     }
     else
     {
      document.all.FechaNacJ.value=='';
      document.all.EdadJ.value="";
     }
    }
   }
</script>
</body>
</html>

