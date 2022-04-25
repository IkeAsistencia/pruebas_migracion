<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="com.ike.helpdeskSP.DAOSoftwareSP,com.ike.helpdeskSP.SoftwareSP,java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>

<html>
    <head>
        <title>SOFTWARE SOPORTE</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
        <script src='../Utilerias/Util.js' ></script>
        <script src='../Utilerias/UtilDireccion.js'></script>
        <script src='../Utilerias/UtilStore.js'></script>
        <script src='../Utilerias/UtilCalendario.js' ></script>
        <link href='../StyleClasses/Calendario.css' rel='stylesheet' type='text/css'>  
        
        <%
        String StrclInventarioSP = "0";
        String StrclUsrApp = "0";
        String StrSoftwareSP = "0";
        String StrclPeriferico = "0";
        String StrclTipoPeriferico = "0";
        
        if (session.getAttribute("clUsrApp")!= null){
            StrclUsrApp = session.getAttribute("clUsrApp").toString();
        }      
 
        if (session.getAttribute("clInventarioSP")!= null) {
            StrclInventarioSP= session.getAttribute("clInventarioSP").toString();
        }
        
        if  (request.getParameter("clInventarioSP")!= null) {
            StrclInventarioSP= request.getParameter("clInventarioSP").toString();
        }
        
         if (session.getAttribute("clSoftwareSP")!= null) {
            StrSoftwareSP = session.getAttribute("clSoftwareSP").toString();
        }
        
        if  (request.getParameter("clSoftwareSP")!= null) {
           StrSoftwareSP = request.getParameter("clSoftwareSP").toString();
        }
        
        if (session.getAttribute("clPeriferico")!= null) {
            StrclPeriferico = session.getAttribute("clPeriferico").toString();
        }
        
        if  (request.getParameter("clPeriferico")!= null) {
           StrclPeriferico = request.getParameter("clPeriferico").toString();
        }
        
          if (session.getAttribute("clTipoPeriferico")!= null) {
           StrclTipoPeriferico  = session.getAttribute("clTipoPeriferico").toString();
        }
        
        session.setAttribute("clPeriferico", StrclPeriferico);
        session.setAttribute("clSoftwareSP",StrSoftwareSP);
        
        if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true){
        %>Fuera de Horario <%
        
        StrclUsrApp=null;
        return;
        }
        
         if (StrclTipoPeriferico.equalsIgnoreCase("5") || StrclTipoPeriferico.equalsIgnoreCase("1") || StrclTipoPeriferico.equalsIgnoreCase("17")){}else{
        %>Imposible Asignar Software, El equipo  no es CPU. <%        
        StrclTipoPeriferico =null;
        return;
        }
    
        DAOSoftwareSP  daoSoftwareSP = null;
        SoftwareSP SSP = null;
        
        daoSoftwareSP = new  DAOSoftwareSP();
        SSP = daoSoftwareSP.getCalificacionSP(StrSoftwareSP.toString());

        String StrclPaginaWeb = "1195";
        session.setAttribute("clPaginaWebP",StrclPaginaWeb);
        %>        
        <%//servlet generico
        String Store="";
        
        Store="st_GuardaSoftwareSP,st_ActualizaSoftwareSP";
        
        session.setAttribute("sp_Stores",Store);
        
        String Commit="";
        Commit="clSoftwareSP";
        
        
        session.setAttribute("Commit",Commit);
        %>
        <script>fnOpenLinks()</script>                   
        
        <%MyUtil.InicializaParametrosC(1195,Integer.parseInt(StrclUsrApp));%>
        <%=MyUtil.doMenuAct("../servlet/com.ike.guarda.EjecutaSP","","fnsp_Guarda();")%>
        
        <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="SoftwareSP.jsp?'>"%>
        <%  int iY = 40; %>
        
        <input id="Secuencia" name="Secuencia" type="hidden" value="">        
        <input id="SecuenciaG" name="SecuenciaG" type="hidden"  VALUE="clPeriferico,clSO,clOffice,clAntivirus,clIE,clVisio,clProject,clAdobe,LicenciaWin,Otros">       
        <input id="SecuenciaA" name="SecuenciaA" type="hidden"  VALUE="clSoftwareSP,clPeriferico,clSO,clOffice,clAntivirus,clIE,clVisio,clProject,clAdobe,LicenciaWin,Otros">  
        
        <INPUT id='clPaginaWeb' name='clPaginaWeb' type='HIDDEN' value='<%=StrclPaginaWeb%>'>
        <INPUT id='clPeriferico' name='clPeriferico' type='HIDDEN' value='<%=StrclPeriferico%>'>    
        <INPUT id='clSoftwareSP' name='clSoftwareSP' type='HIDDEN' value='<%=StrSoftwareSP%>'>                  
        <%=MyUtil.ObjComboC("SO:","clSO",SSP != null ? SSP.getDsSO():"",true,true,20,80,"","Select * from cSOSP ","","",10,false,false)%>        
        <%=MyUtil.ObjComboC("OFFICE:","clOffice",SSP != null ? SSP.getDsOffice():"",true,true,220,80,"","Select * from cOfficeSP ","","",10,false,false)%>        
        <%=MyUtil.ObjComboC("ANTIVIRUS:","clAntivirus",SSP != null ? SSP.getDsAntivirus():"",true,true,420,80,"","select * from cAntivirusSP ","","",10,false,false)%>        
        <%=MyUtil.ObjComboC("IE:","clIE",SSP != null ? SSP.getDsIE():"",true,true,620,80,"","select * from cIESP ","","",10,false,false)%>              
        <%=MyUtil.ObjComboC("VISIO:","clVisio",SSP != null ? SSP.getDsVisio():"",true,true,20,120,"","select * from cVisioSP ","","",10,false,false)%>        
        <%=MyUtil.ObjComboC("PROJECT:","clProject",SSP != null ? SSP.getDsProject():"",true,true,220,120,"","select * from cProjectSP ","","",10,false,false)%>        
        <%=MyUtil.ObjComboC("ADOBE READER:","clAdobe",SSP != null ? SSP.getDsAdobe():"",true,true,420,120,"","select * from cAdobeSP ","","",10,false,false)%>        
        <%=MyUtil.ObjChkBox("LICENCIA WINDOWS:","LicenciaWin",SSP != null ? SSP.getLicenciaWin():"",true,true,620,120,"0","SI","NO","")%>
        <%=MyUtil.ObjTextArea("OTROS:","Otros",SSP != null ? SSP.getOtros():"","90","5",true,true,20,160,"",false,false)%>               
        <%=MyUtil.DoBlock("SOFTWARE",10,40)%>      
        <%=MyUtil.GeneraScripts()%> 
        
        <%
        //Limpiar Variables
        SSP = null;    
        StrclInventarioSP = null;
        StrclUsrApp= null;
        StrclPeriferico= null;
        StrSoftwareSP=null;
        StrclTipoPeriferico=null;
        daoSoftwareSP=null;
        
        %>
     
             
    
     
        
        
    </body>
</html>
