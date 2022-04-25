<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Seguridad.SeguridadC,Utilerias.UtileriasBDF" errorPage="" %>
<html>
<head><title>Imágenes x Expediente </title>
    <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
</head>
<body class="cssBody" topmargin=150>       
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
<script src='../Utilerias/Util.js' ></script>
<script src='../Utilerias/UtilMask.js'></script>
<%
String StrclUsrApp="0";
String StrFechaIni="";
String StrFechaFin="";
String StrclPaginaWeb="1348";
String StrclSolicitud="0";


int iCont =0;
int vTotal=0;

if (session.getAttribute("clUsrApp")!= null) {
    StrclUsrApp = session.getAttribute("clUsrApp").toString();
    session.setAttribute("clUsrApp",StrclUsrApp);
}

if (request.getParameter("FechaIni")!= null) {
    StrFechaIni = request.getParameter("FechaIni").toString();
}

if (request.getParameter("FechaFin")!= null) {
    StrFechaFin = request.getParameter("FechaFin").toString();
}


if (request.getParameter("clSolicitud")!= null) {
    StrclSolicitud = request.getParameter("clSolicitud").toString();
}



if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {%>
Fuera de Horario         

<% 
StrclUsrApp=null;
StrFechaIni=null;
StrFechaFin=null;
StrclPaginaWeb=null;
StrclSolicitud=null;
return;
}

MyUtil.InicializaParametrosC(297,Integer.parseInt(StrclUsrApp));%>   
<center>
    <div style='position:absolute; z-index:303; left:30px; top:10px'>
        <b><font color="#423A9E"><b>Impresión Masiva</b></b>
    </div>             
</center>

<form method='get' action='ImpresionMasivaSP.jsp'>
    
    <%=MyUtil.ObjInput("No. de Solicitud","clSolicitud","",true,true,30,70,"",false,false,15,"EsNumerico(document.all.clSolicitud); fnValidaFiltro();")%>
    <%=MyUtil.ObjInput("Fecha Asignación Inicial<BR>AAAA/MM/DD HH:MM","FechaIni","",true,false,30,110,"",true,true,22,"if(this.readOnly==false){fnValMask(this,FechaMsk.value,this.name)}; fnValidaFiltro();")%>
    <%=MyUtil.ObjInput("Fecha Asignación Final<BR>AAAA/MM/DD HH:MM","FechaFin","",true,false,30,150,"",true,true,22,"if(this.readOnly==false){fnValMask(this,FechaMsk.value,this.name)}; fnValidaFiltro();")%>
         
    <div class='VTable' style='position:absolute; z-index:25; left:30px; top:190px;' id="Buscar">
        <input class='cBtn' type='submit' value='Buscar...'></input>
    </div>
    
    <%=MyUtil.DoBlock("Criterios de Busqueda",50,30)%>
    <script>   
        
        document.all.Buscar.style.visibility = 'hidden';
        
        document.all.clSolicitud.readOnly= false;
        document.all.clSolicitud.disabled= false;
      /*  document.all.chkSeleccionarC.readOnly= false;
        document.all.chkSeleccionarC.disabled= false; */
        document.all.FechaIni.readOnly= false;
        document.all.FechaIni.disabled= false;
        document.all.FechaFin.readOnly= false;
        document.all.FechaFin.disabled= false;     
        
        function fnValidaFiltro(){
            if((document.all.clSolicitud.value != '') || (document.all.FechaIni.value != '' && document.all.FechaFin.value != '')){
               document.all.Buscar.style.visibility = 'visible';
            }else{
                document.all.Buscar.style.visibility = 'hidden';
            }
        }
    </script>
</form>

<input name='FechaMsk' id='FechaMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09'>
<% 

StringBuffer StrSqlImg = new StringBuffer();
StrSqlImg.append("st_BuscaSolicitudSP '").append(StrclSolicitud);
StrSqlImg.append("','" ).append(StrFechaIni).append("','").append(StrFechaFin).append("'");
System.out.println("Qry: "+StrSqlImg.toString());
ResultSet rsSol = UtileriasBDF.rsSQLNP(StrSqlImg.toString());
System.out.println("filas No. " + String.valueOf(rsSol.getRow()));

if(rsSol.next()){
    if(rsSol.getString(1).equalsIgnoreCase("0")){
        System.out.println("Debe elegir un criterio de búsqueda 2");
%>
<div class='VTable' style=' position:absolute; z-index:25; left:230px; top:270px;'>
    <p style="font-family:arial;color:#000066;font-size:20px;">Debe elegir un criterio de búsqueda</p>
</div>        
<%        
return;
    }
    if(rsSol.getString(1).equalsIgnoreCase("1")){
        System.out.println("La búsqueda no regreso Asistencias");
%>
<div class='VTable' style='position:absolute; z-index:25; left:230px; top:270px;'>
    <p style="font-family:arial;color:#000066;font-size:20px;">La búsqueda no regresó Solicitudes</p>
</div>
<%
return;
    }
    rsSol.beforeFirst();
    while(rsSol.next()) {     %>                  

<INPUT type='hidden' disabled='true' id='clSolicitud' name='clSolicitud' value='<%=rsSol.getString("clSolicitud") %>'>
<%
vTotal=vTotal+1;
    }%> 
<br><br><br><br><br><br>
<div   id="Registros" style=' width: 672px; height: 10px;'> <p style="font-family:arial;color:#000066;font-size:20px;">Solicitudes Encontradas: <%=vTotal%> </p></div>               

<form  method='post' action='ImpresionAtencionUsrSP.jsp'>
    <textarea name='Resultados' id='Resultados' cols='80' rows='3' style="visibility:hidden"></textarea>
    <input type='hidden' name='Total' id='Total' value ='<%=vTotal%>'></input><tr><td></tr></td>
    <center><input type='submit' name='Imprime' id="Imprime" value='Imprimir' onclick='fnConcatena()'></input></center>
</form>     
<%}%>

<% //<<<<<<< Limpia Variables >>>>>>>
StrclUsrApp = null;
StrclSolicitud =null;
StrFechaIni = null;
StrFechaFin = null;
StrclPaginaWeb = null;

%>


</body>   
<script>
    document.all.Resultados.style.visibility='hidden';
    


    function fnConcatena(){
        i=0;
        document.all.Resultados.value='';            
        while (i<=document.all.Total.value){               
            if(document.all.Total.value-1==0){                              
                document.all.Resultados.value=document.all.clSolicitud.value;                                                          
            }                     
            if (document.all.Resultados.value ==''){
                document.all.Resultados.value = document.all.clSolicitud(i).value;                              
            }
            else{
                document.all.Resultados.value = document.all.Resultados.value + ',' + document.all.clSolicitud(i).value;
            }                        
            i++;                   
        }    
    }
</script>
</html>