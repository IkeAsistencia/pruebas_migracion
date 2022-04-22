<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
<head><title>Cambio de cuenta para expediente duplicado</title>
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
</head>

<body class="cssBody">
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
<script src='../Utilerias/Util.js' ></script>
<script src='../Utilerias/UtilMask.js'></script>
<%
    String strclExpediente = "0";
    String strNombreCuenta = "";
    String strclCuenta = "0";
    String strclUsrApp = "0";
    String strAutoriza = "0";
    String strCambio = "0";
    
    if (request.getParameter("clExpediente")!=null)
    {
        strclExpediente = request.getParameter("clExpediente").toString();
    }

    if (session.getAttribute("clUsrApp")!=null)
    {
        strclUsrApp = session.getAttribute("clUsrApp").toString();
    }

    if (request.getParameter("clCuenta")!=null)
    {
        strclCuenta = request.getParameter("clCuenta").toString();
    }

    if (request.getParameter("Cambio")!=null)
    {
        strCambio = request.getParameter("Cambio").toString();
    }

    if (SeguridadC.verificaHorarioC(Integer.parseInt(strclUsrApp)) != true) 
   {
%>
<b>Fuera de Horario</b>
<%
        strclUsrApp = null;
        return;       
   } 
 
 
    String StrclPaginaWeb = "683";
    session.setAttribute("clPaginaWebP",StrclPaginaWeb); 
    MyUtil.InicializaParametrosC(683,Integer.parseInt(strclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina 
    
    StringBuffer StrSQL = new StringBuffer();
    StrSQL.append("Select coalesce(sum(cast(PermiteCambCtaDup as tinyint)),0) PermiteCambCtaDup ");
    StrSQL.append(" from PermisoPartxGpoPag PP");
    StrSQL.append(" inner join UsrxGpo UxG on (PP.clGpoUsr = UxG.clGpoUsr)");
    StrSQL.append(" where UxG.clUsrApp = ").append(strclUsrApp);

    ResultSet rsA = UtileriasBDF.rsSQLNP( StrSQL.toString());
    StrSQL.delete(0,StrSQL.length());
    
    if (rsA.next())
    {
       strAutoriza =  rsA.getString("PermiteCambCtaDup");
    }

    //EJECUTA EL CAMBIO DE CUENTA PARA EL EXPEDIENTE DUPLICADO
    if (strCambio.equalsIgnoreCase("1"))
    {
        
        StrSQL.append("st_ObtenExpedienteDuplica '").append(strclExpediente).append("','").append(strclCuenta).append("','").append(strclUsrApp).append("'");
        ResultSet rsC = UtileriasBDF.rsSQLNP( StrSQL.toString() + " Select @@Identity Llave ");
        StrSQL.delete(0,StrSQL.length());

        if (rsC.next())
        {
            out.println("<script> location.href='../Operacion/DetalleExpediente.jsp?clExpediente="+ rsC.getString("Llave") +"';</script>");
        }
    }

    
    if (strAutoriza.equals("1"))    
    {
        //EXTRAE EL NOMBRE DE LA CUENTA QUE TRAE EL EXPEDIENTE.
        //StringBuffer StrSQL = new StringBuffer();
        StrSQL.append("select Cu.clCuenta,Cu.Nombre from Expediente Ex inner join cCuenta Cu on (Cu.clCuenta=Ex.clCuenta) where clExpediente = ").append(strclExpediente);
        ResultSet rsS = UtileriasBDF.rsSQLNP( StrSQL.toString());
        StrSQL.delete(0,StrSQL.length());
        if (rsS.next())
        {
            strclCuenta = rsS.getString("clCuenta");
            strNombreCuenta = rsS.getString("Nombre");
        }
    
%>
    <%=MyUtil.doMenuAct("../servlet/Utilerias.GuardaCambioCuenta","")%>
    <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="CambioCuenta.jsp?'>"%>
    <INPUT id='clUsrApp' name='clUsrApp' type='hidden' value='<%=strclUsrApp%>'>
    <%=MyUtil.ObjInput("Expediente origen","clExpediente",strclExpediente,false,true,30,80,strclExpediente,false,false,11)%>
    <%=MyUtil.ObjInput("Cuenta actual","NombreCuentaActualVTR",strNombreCuenta,false,false,160,80,"strNombreCuenta",false,false,35)%>


    <%
        
%>
        <div class='VTable' style='position:absolute; z-index:25; left:30px; top:120px;'>
        ¿DESEA CAMBIAR LA CUENTA DEL EXPEDIENTE?<BR>
        </div>
        <form Name="CambioCuentaD" action="DuplicaExp.jsp">
        <div class='VTable' style='position:absolute; z-index:25; left:100px; top:150px;'>
        <input id="Cambiar" class='cBtn' type='button' value='CAMBIAR' onClick='fnHabDeshabCambio(1); fnCambio();'></input>
        <input id="Nocambiar" class='cBtn' type='submit' value='NO CAMBIAR' onClick='fnCambio();'>
        </div>
        <div id="lupa" class='VTable' style='position:absolute; z-index:25; left:225px; top:210px;'>
        <IMG SRC='../Imagenes/Lupa.gif' onClick='fnBuscaCuenta();' WIDTH=20 HEIGHT=20></div>
       
    <%=MyUtil.ObjInput("Cuenta nueva","CuentaNuevaVTR","",true,true,30,200,"",false,false,35,"if(this.readOnly==false){fnBuscaCuenta();}")%>
    <%=MyUtil.DoBlock("CAMBIO DE CUENTA PARA EXPEDIENTES DUPLICADOS",10,60)%>
        <div id="CambioDiv" class='VTable' style='position:absolute; z-index:25; left:100px; top:260px;'>
        <INPUT id='clCuenta' name='clCuenta' type='hidden' value=''>
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=strclExpediente%>'>
        <INPUT id='Cambio' name='Cambio' type='hidden' value=''>
        <input id="Aceptar" class='cBtn' type='submit' value='ACEPTAR'></input>
        <input id="Cancelar" class='cBtn' type='button' value='CANCELAR' onClick='fnHabDeshabCambio(0)'>
        </form>
        </div>
<%

    }
    else
    {
        //StringBuffer StrSQL = new StringBuffer();
        StrSQL.append("st_ObtenExpedienteDuplica '").append(strclExpediente).append("','','").append(strclUsrApp).append("'");
        ResultSet rs = UtileriasBDF.rsSQLNP( StrSQL.toString() + " Select @@Identity Llave ");
        StrSQL.delete(0,StrSQL.length());
        
        if (rs.next())
        {
            out.println("<script> location.href='../Operacion/DetalleExpediente.jsp?clExpediente="+ rs.getString("Llave") +"';</script>");
        }
    }
%>
   
    <%=MyUtil.GeneraScripts()%>

<script>
   
<%
   if (strAutoriza.equals("1"))
   {
%>
    fnHabDeshabCambio(0)
    function fnHabDeshabCambio(indica)
    {
     if (indica == 0)
     {
      document.all.Aceptar.style.visibility='hidden'
      document.all.Cancelar.style.visibility='hidden'
      document.all.lupa.style.visibility='hidden'
      document.all.CuentaNuevaVTR.style.visibility='hidden'
      document.all.D5.style.visibility='hidden'
      document.all.Aceptar.disabled=true;
      document.all.Cancelar.disabled=true;
      document.all.Cambiar.disabled=false;
      document.all.Nocambiar.disabled=false;
      document.all.CuentaNuevaVTR.value="";
      document.all.clCuenta.value='';
     }
     else
     {
      document.all.Aceptar.style.visibility=''
      document.all.Cancelar.style.visibility=''
      document.all.lupa.style.visibility=''
      document.all.CuentaNuevaVTR.style.visibility=''
      document.all.D5.style.visibility=''
      document.all.Cambiar.disabled=true;
      document.all.Nocambiar.disabled=true;
      document.all.Aceptar.disabled=false;
      document.all.Cancelar.disabled=false;
      document.all.CuentaNuevaVTR.readOnly=false;
      document.all.CuentaNuevaVTR.disabled=false;
      document.all.CuentaNuevaVTR.focus();
     }
    }

    function fnBuscaCuenta()
    {
     if (document.all.CuentaNuevaVTR.value!='')
     {
       var pstrCadena = "../Utilerias/FiltrosCuenta.jsp?strSQL=sp_WebBuscaCuenta ";
       pstrCadena = pstrCadena + "&Cuenta= " + document.all.CuentaNuevaVTR.value;
       document.all.CuentaNuevaVTR.value='';
       window.open(pstrCadena,'newWin','scrollbars=yes,status=yes,width=700,height=500');
     }
    }

    function fnActualizaDatosCuenta(dsCuenta,clCuenta)
    {
     document.all.CuentaNuevaVTR .value = dsCuenta;			
     document.all.clCuenta.value = clCuenta;
     
     if (document.all.clCuenta.value == <%=strclCuenta%>)
     {
      alert("Ha seleccionado la misma cuenta");
      document.all.clCuenta.value = '';
      document.all.CuentaNuevaVTR .value = '';
      
     }
    }
    
    function fnCambio()
    {
     document.all.Cambio.value = 1;			
    }
    
<%
   }

   strclExpediente = null;
   strNombreCuenta = null;
   strclCuenta  = null;
   strclUsrApp = null;
   strAutoriza = null;
   strCambio = null;

%>
</script>
</body>
</html>

