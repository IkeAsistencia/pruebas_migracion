<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
<head><title>JSP Page</title>
<link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
</head>
<body class="cssBody">

<%-- <jsp:useBean id="beanInstanceName" scope="session" class="beanPackage.BeanClassName" /> --%>
<%-- <jsp:getProperty name="beanInstanceName"  property="propertyName" /> --%>

<jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj" /> 
<script src='../../Utilerias/Util.js' ></script>
<script src='../../Utilerias/UtilMask.js'></script>
<%  
    String StrclExpediente = "0";   
    String StrclUsrApp="0";
    String StrclPaginaWeb="0";
    String StrFecha ="";    
    
    

    if (session.getAttribute("clUsrApp")!= null)
     {
       StrclUsrApp = session.getAttribute("clUsrApp").toString(); 
     }  

    if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) 
     {
       %>Fuera de Horario<%
       
       return;  
     }    
     
    if (session.getAttribute("clExpediente")!= null)
     {
       StrclExpediente = session.getAttribute("clExpediente").toString(); 
     }  

    StringBuffer StrSql = new StringBuffer();
    // checar si ya existe asistencia para el expediente, si existe, ya no procede la alta
    StrSql.append(" Select TieneAsistencia");
    StrSql.append(" From Expediente ");
    StrSql.append(" Where clExpediente=").append(StrclExpediente);
    ResultSet rs2 = UtileriasBDF.rsSQLNP( StrSql.toString());     
    StrSql.delete(0,StrSql.length());

    if (rs2.next())  
     { 
     }   
    else
     {
          %>El expediente no existe<%
          rs2.close();
          
          return;      
     } 

    ResultSet rs3 = UtileriasBDF.rsSQLNP( "Select convert(varchar(20),getdate(),120) FechaApertura ");  
    if (rs3.next()){
       StrFecha = rs3.getString("FechaApertura"); 
    }    
    
    StrSql.append("Select B.clExpediente, coalesce(B.TitularTarjeta,'') as TitularTarjeta, B.clTipoPerReporta, coalesce(P.dsTipoPersonaRep,'') as dsTipoPersonaRep, coalesce(B.PersonaReporta,'') as PersonaReporta, B.clTipoServicioEsp, coalesce(S.dsTipoServicioEsp,'') as dsTipoServicioEsp, ");
    StrSql.append(" coalesce(B.TelContactoEm1,'') as TelContactoEm1, coalesce(B.TelContactoEm2,'') as TelContactoEm2, coalesce(B.TelContactoEm3,'') as TelContactoEm3, ");
    StrSql.append(" coalesce(B.NumTarj1,'') as NumTarj1, coalesce(B.NumTarj2,'') as NumTarj2,coalesce(B.NumTarj3,'') as NumTarj3,coalesce(B.NumTarj4,'') as NumTarj4,coalesce(B.NumTarj5,'') as NumTarj5,coalesce(B.NumTarj6,'') as NumTarj6,coalesce(B.NumTarj7,'') as NumTarj7,coalesce(B.NumTarj8,'') as NumTarj8,coalesce(B.NumTarj9,'') as NumTarj9,coalesce(B.NumTarj10,'') as NumTarj10, ");
    StrSql.append(" coalesce(B.Banco1,'') as Banco1, coalesce(B.Banco2,'') as Banco2,coalesce(B.Banco3,'') as Banco3,coalesce(B.Banco4,'') as Banco4,coalesce(B.Banco5,'') as Banco5,coalesce(B.Banco6,'') as Banco6,coalesce(B.Banco7,'') as Banco7,coalesce(B.Banco8,'') as Banco8,coalesce(B.Banco9,'') as Banco9,coalesce(B.Banco10,'') as Banco10, ");
    StrSql.append(" coalesce(B.MesDiaVence1,'') as MesDiaVence1, coalesce(B.MesDiaVence2,'') as MesDiaVence2,coalesce(B.MesDiaVence3,'') as MesDiaVence3,coalesce(B.MesDiaVence4,'') as MesDiaVence4,coalesce(B.MesDiaVence5,'') as MesDiaVence5,coalesce(B.MesDiaVence6,'') as MesDiaVence6,coalesce(B.MesDiaVence7,'') as MesDiaVence7,coalesce(B.MesDiaVence8,'') as MesDiaVence8,coalesce(B.MesDiaVence9,'') as MesDiaVence9,coalesce(B.MesDiaVence10,'') as MesDiaVence10, ");
    StrSql.append(" coalesce(B.TipoDocto1,'') as TipoDocto1, coalesce(B.TipoDocto2,'') as TipoDocto2,coalesce(B.TipoDocto3,'') as TipoDocto3,coalesce(B.TipoDocto4,'') as TipoDocto4,coalesce(B.TipoDocto5,'') as TipoDocto5, ");
    StrSql.append(" coalesce(B.NumDocto1,'') as NumDocto1, coalesce(B.NumDocto2,'') as NumDocto2,coalesce(B.NumDocto3,'') as NumDocto3,coalesce(B.NumDocto4,'') as NumDocto4,coalesce(B.NumDocto5,'') as NumDocto5, ");
    StrSql.append(" coalesce(B.Observa1,'') as Observa1, coalesce(B.Observa2,'') as Observa2,coalesce(B.Observa3,'') as Observa3,coalesce(B.Observa4,'') as Observa4,coalesce(B.Observa5,'') as Observa5, ");
    StrSql.append(" coalesce(B.CodigoSeg,'') as CodigoSeg, ");
    StrSql.append(" coalesce(convert(varchar(20), B.FechaApertura,120),'') as FechaApertura, coalesce(convert(varchar(20), B.FechaRegistro,120),'') as FechaRegistro ");
    StrSql.append(" From "); 
    StrSql.append(" BloqueoExpress B ");
    StrSql.append(" left join cTipoPersonaReporta P ON (P.clTipoPerReporta=B.clTipoPerReporta) ");
    StrSql.append(" left join cTipoServBloqueoExp S ON (B.clTipoServicioEsp=S.clTipoServicioEsp) ");
    StrSql.append(" Where B.clExpediente =").append(StrclExpediente); 

    ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());     
        
       %><script>fnOpenLinks()</script><%
       
       StrclPaginaWeb = "330";       
       MyUtil.InicializaParametrosC(330,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
 
       session.setAttribute("clPaginaWebP",StrclPaginaWeb); 

       %><%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist","")%>         
       <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="BloqueoExpress.jsp?'>"%><% 
       if (rs.next()) { 
            // El siguiente campo llave no se mete con MyUtil.ObjInput %>
            <script>document.all.btnAlta.disabled=true;</script>
            <script>document.all.btnElimina.disabled=true;</script>
            <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
            
            <%=MyUtil.ObjInput("Titular de la Tarjeta","TitularTarjeta",rs.getString("TitularTarjeta"),true,true,30,70,"",false,false,100)%>
            <%=MyUtil.ObjInput("Persona Reporta","PersonaReporta",rs.getString("PersonaReporta"),true,true,30,110,"",false,false,100)%>

            <%=MyUtil.ObjComboC("Tipo Persona Reporta","clTipoPerReporta",rs.getString("dsTipoPersonaRep"),true,true,30,150,"","Select clTipoPerReporta, dsTipoPersonaRep From cTipoPersonaReporta ","","",100,false,false)%>
            <%=MyUtil.ObjComboC("Tipo de Servicio Requerido","clTipoServicioEsp",rs.getString("dsTipoServicioEsp"),true,true,250,150,"","Select clTipoServicioEsp, dsTipoServicioEsp From cTipoServBloqueoExp ","","",100,false,false)%>
            <%=MyUtil.ObjInput("Teléfono 1 Contacto Emergencia","TelContactoEm1",rs.getString("TelContactoEm1"),true,true,30,190,"",false,false,20)%>
            <%=MyUtil.ObjInput("Teléfono 2 Contacto Emergencia","TelContactoEm2",rs.getString("TelContactoEm2"),true,true,250,190,"",false,false,20)%> 
            <%=MyUtil.ObjInput("Tel. 3 Contacto Emergencia","TelContactoEm3",rs.getString("TelContactoEm3"),true,true,470,190,"",false,false,20)%>
            <%=MyUtil.ObjInput("Código de Seguridad","CodigoSeg",rs.getString("CodigoSeg"),true,true,30,230,"",false,false,50)%>
	    <%=MyUtil.ObjInput("Fecha Apertura","FechaApertura",rs.getString("FechaApertura"),false,false,315,230,StrFecha,true,true,22)%>
            <%=MyUtil.ObjInput("Fecha Registro","FechaRegistroVTR",rs.getString("FechaRegistro"),false,false,450,230,"",false,false,22)%>              
        <%=MyUtil.DoBlock("Detalle de Bloqueo Express",0,0)%>

            <%=MyUtil.ObjInput("Número de Tarjeta 1","NumTarj1",rs.getString("NumTarj1"),true,true,30,310,"",false,false,30)%>
            <%=MyUtil.ObjInput("Banco 1","Banco1",rs.getString("Banco1"),true,true,210,310,"",false,false,50)%> 
            <%=MyUtil.ObjInput("Vencimiento 1 (MM/DD)","MesDiaVence1",rs.getString("MesDiaVence1"),true,true,490,310,"",false,false,6,"if(this.readOnly==false){fnValMask(this,document.all.MesDiaMsk.value,this.name)}")%> 
            <%=MyUtil.ObjInput("Número de Tarjeta 2","NumTarj2",rs.getString("NumTarj2"),true,true,30,340,"",false,false,30)%> 
            <%=MyUtil.ObjInput("Banco 2","Banco2",rs.getString("Banco2"),true,true,210,340,"",false,false,50)%> 
            <%=MyUtil.ObjInput("Vencimiento 2 (MM/DD)","MesDiaVence2",rs.getString("MesDiaVence2"),true,true,490,340,"",false,false,6,"if(this.readOnly==false){fnValMask(this,document.all.MesDiaMsk.value,this.name)}")%> 
            <%=MyUtil.ObjInput("Número de Tarjeta 3","NumTarj3",rs.getString("NumTarj3"),true,true,30,370,"",false,false,30)%> 
            <%=MyUtil.ObjInput("Banco 3","Banco3",rs.getString("Banco3"),true,true,210,370,"",false,false,50)%> 
            <%=MyUtil.ObjInput("Vencimiento 3 (MM/DD)","MesDiaVence3",rs.getString("MesDiaVence3"),true,true,490,370,"",false,false,6,"if(this.readOnly==false){fnValMask(this,document.all.MesDiaMsk.value,this.name)}")%> 
            <%=MyUtil.ObjInput("Número de Tarjeta 4","NumTarj4",rs.getString("NumTarj4"),true,true,30,400,"",false,false,30)%> 
            <%=MyUtil.ObjInput("Banco 4","Banco4",rs.getString("Banco4"),true,true,210,400,"",false,false,50)%> 
            <%=MyUtil.ObjInput("Vencimiento 4 (MM/DD)","MesDiaVence4",rs.getString("MesDiaVence4"),true,true,490,400,"",false,false,6,"if(this.readOnly==false){fnValMask(this,document.all.MesDiaMsk.value,this.name)}")%> 
            <%=MyUtil.ObjInput("Número de Tarjeta 5","NumTarj5",rs.getString("NumTarj5"),true,true,30,430,"",false,false,30)%> 
            <%=MyUtil.ObjInput("Banco 5","Banco5",rs.getString("Banco5"),true,true,210,430,"",false,false,50)%> 
            <%=MyUtil.ObjInput("Vencimiento 5 (MM/DD)","MesDiaVence5",rs.getString("MesDiaVence5"),true,true,490,430,"",false,false,6,"if(this.readOnly==false){fnValMask(this,document.all.MesDiaMsk.value,this.name)}")%> 
            <%=MyUtil.ObjInput("Número de Tarjeta 6","NumTarj6",rs.getString("NumTarj6"),true,true,30,460,"",false,false,30)%> 
            <%=MyUtil.ObjInput("Banco 6","Banco6",rs.getString("Banco6"),true,true,210,460,"",false,false,50)%> 
            <%=MyUtil.ObjInput("Vencimiento 6 (MM/DD)","MesDiaVence6",rs.getString("MesDiaVence6"),true,true,490,460,"",false,false,6,"if(this.readOnly==false){fnValMask(this,document.all.MesDiaMsk.value,this.name)}")%> 
            <%=MyUtil.ObjInput("Número de Tarjeta 7","NumTarj7",rs.getString("NumTarj7"),true,true,30,490,"",false,false,30)%> 
            <%=MyUtil.ObjInput("Banco 7","Banco7",rs.getString("Banco7"),true,true,210,490,"",false,false,50)%> 
            <%=MyUtil.ObjInput("Vencimiento 7 (MM/DD)","MesDiaVence7",rs.getString("MesDiaVence7"),true,true,490,490,"",false,false,6,"if(this.readOnly==false){fnValMask(this,document.all.MesDiaMsk.value,this.name)}")%> 
            <%=MyUtil.ObjInput("Número de Tarjeta 8","NumTarj8",rs.getString("NumTarj8"),true,true,30,520,"",false,false,30)%> 
            <%=MyUtil.ObjInput("Banco 8","Banco8",rs.getString("Banco8"),true,true,210,520,"",false,false,50)%> 
            <%=MyUtil.ObjInput("Vencimiento 8 (MM/DD)","MesDiaVence8",rs.getString("MesDiaVence8"),true,true,490,520,"",false,false,6,"if(this.readOnly==false){fnValMask(this,document.all.MesDiaMsk.value,this.name)}")%> 
            <%=MyUtil.ObjInput("Número de Tarjeta 9","NumTarj9",rs.getString("NumTarj9"),true,true,30,550,"",false,false,30)%> 
            <%=MyUtil.ObjInput("Banco 9","Banco9",rs.getString("Banco9"),true,true,210,550,"",false,false,50)%> 
            <%=MyUtil.ObjInput("Vencimiento 9 (MM/DD)","MesDiaVence9",rs.getString("MesDiaVence9"),true,true,490,550,"",false,false,6,"if(this.readOnly==false){fnValMask(this,document.all.MesDiaMsk.value,this.name)}")%> 
            <%=MyUtil.ObjInput("Número de Tarjeta 10","NumTarj10",rs.getString("NumTarj10"),true,true,30,580,"",false,false,30)%> 
            <%=MyUtil.ObjInput("Banco 10","Banco10",rs.getString("Banco10"),true,true,210,580,"",false,false,50)%>  
            <%=MyUtil.ObjInput("Vencimiento 10 (MM/DD)","MesDiaVence10",rs.getString("MesDiaVence10"),true,true,490,580,"",false,false,6,"if(this.readOnly==false){fnValMask(this,document.all.MesDiaMsk.value,this.name)}")%> 
        <%=MyUtil.DoBlock("Datos de Tarjetas",0,0)%>   

            <%=MyUtil.ObjInput("Tipo Documento 1","TipoDocto1",rs.getString("TipoDocto1"),true,true,30,660,"",false,false,50)%> 
            <%=MyUtil.ObjInput("Número Documento 1","NumDocto1",rs.getString("NumDocto1"),true,true,300,660,"",false,false,20)%> 
            <%=MyUtil.ObjInput("Observaciones 1","Observa1",rs.getString("Observa1"),true,true,30,690,"",false,false,100)%> 
            <%=MyUtil.ObjInput("Tipo Documento 2","TipoDocto2",rs.getString("TipoDocto2"),true,true,30,720,"",false,false,50)%> 
            <%=MyUtil.ObjInput("Número Documento 2","NumDocto2",rs.getString("NumDocto2"),true,true,300,720,"",false,false,20)%> 
            <%=MyUtil.ObjInput("Observaciones 2","Observa2",rs.getString("Observa2"),true,true,30,750,"",false,false,100)%> 
            <%=MyUtil.ObjInput("Tipo Documento 3","TipoDocto3",rs.getString("TipoDocto3"),true,true,30,780,"",false,false,50)%> 
            <%=MyUtil.ObjInput("Número Documento 3","NumDocto3",rs.getString("NumDocto3"),true,true,300,780,"",false,false,20)%> 
            <%=MyUtil.ObjInput("Observaciones 3","Observa3",rs.getString("Observa3"),true,true,30,810,"",false,false,100)%> 
            <%=MyUtil.ObjInput("Tipo Documento 4","TipoDocto4",rs.getString("TipoDocto4"),true,true,30,840,"",false,false,50)%> 
            <%=MyUtil.ObjInput("Número Documento 4","NumDocto4",rs.getString("NumDocto4"),true,true,300,840,"",false,false,20)%> 
            <%=MyUtil.ObjInput("Observaciones 4","Observa4",rs.getString("Observa4"),true,true,30,870,"",false,false,100)%> 
            <%=MyUtil.ObjInput("Tipo Documento 5","TipoDocto5",rs.getString("TipoDocto5"),true,true,30,900,"",false,false,50)%> 
            <%=MyUtil.ObjInput("Número Documento 5","NumDocto5",rs.getString("NumDocto5"),true,true,300,900,"",false,false,20)%> 
            <%=MyUtil.ObjInput("Observaciones 5","Observa5",rs.getString("Observa5"),true,true,30,930,"",false,false,100)%> 
         <%=MyUtil.DoBlock("Resguardo de Documentos",80,0)%><%  
       } 
       else { %>
            <script>document.all.btnCambio.disabled=true;</script>
            <script>document.all.btnElimina.disabled=true;</script>
            <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>

            <%=MyUtil.ObjInput("Titular de la Tarjeta","TitularTarjeta","",true,true,30,70,"",false,false,100)%>
            <%=MyUtil.ObjInput("Persona Reporta","PersonaReporta","",true,true,30,110,"",false,false,100)%> 

            <%=MyUtil.ObjComboC("Tipo Persona Reporta","clTipoPerReporta","",true,true,30,150,"","Select clTipoPerReporta, dsTipoPersonaRep From cTipoPersonaReporta ","","",100,false,false)%>
            <%=MyUtil.ObjComboC("Tipo de Servicio Requerido","clTipoServicioEsp","",true,true,250,150,"","Select clTipoServicioEsp, dsTipoServicioEsp From cTipoServBloqueoExp ","","",100,false,false)%>
            <%=MyUtil.ObjInput("Teléfono 1 Contacto Emergencia","TelContactoEm1","",true,true,30,190,"",false,false,20)%> 
            <%=MyUtil.ObjInput("Teléfono 2 Contacto Emergencia","TelContactoEm2","",true,true,250,190,"",false,false,20)%> 
            <%=MyUtil.ObjInput("Tel. 3 Contacto Emergencia","TelContactoEm3","",true,true,470,190,"",false,false,20)%> 
            <%=MyUtil.ObjInput("Código de Seguridad","CodigoSeg","",true,true,30,230,"",false,false,50)%> 
	    <%=MyUtil.ObjInput("Fecha Apertura","FechaApertura","",false,false,315,230,StrFecha,true,true,22)%>                
            <%=MyUtil.ObjInput("Fecha Registro","FechaRegistroVTR","",false,false,450,230,"",false,false,22)%>                
        <%=MyUtil.DoBlock("Detalle de Bloqueo Express",0,0)%>   

            <%=MyUtil.ObjInput("Número de Tarjeta 1","NumTarj1","",true,true,30,310,"",false,false,30)%> 
            <%=MyUtil.ObjInput("Banco 1","Banco1","",true,true,210,310,"",false,false,50)%> 
            <%=MyUtil.ObjInput("Vencimiento 1 (MM/DD)","MesDiaVence1","",true,true,490,310,"",false,false,6,"if(this.readOnly==false){fnValMask(this,document.all.MesDiaMsk.value,this.name)}")%> 
            <%=MyUtil.ObjInput("Número de Tarjeta 2","NumTarj2","",true,true,30,340,"",false,false,30)%> 
            <%=MyUtil.ObjInput("Banco 2","Banco2","",true,true,210,340,"",false,false,50)%> 
            <%=MyUtil.ObjInput("Vencimiento 2 (MM/DD)","MesDiaVence2","",true,true,490,340,"",false,false,6,"if(this.readOnly==false){fnValMask(this,document.all.MesDiaMsk.value,this.name)}")%> 
            <%=MyUtil.ObjInput("Número de Tarjeta 3","NumTarj3","",true,true,30,370,"",false,false,30)%> 
            <%=MyUtil.ObjInput("Banco 3","Banco3","",true,true,210,370,"",false,false,50)%> 
            <%=MyUtil.ObjInput("Vencimiento 3 (MM/DD)","MesDiaVence3","",true,true,490,370,"",false,false,6,"if(this.readOnly==false){fnValMask(this,document.all.MesDiaMsk.value,this.name)}")%> 
            <%=MyUtil.ObjInput("Número de Tarjeta 4","NumTarj4","",true,true,30,400,"",false,false,30)%> 
            <%=MyUtil.ObjInput("Banco 4","Banco4","",true,true,210,400,"",false,false,50)%> 
            <%=MyUtil.ObjInput("Vencimiento 4 (MM/DD)","MesDiaVence4","",true,true,490,400,"",false,false,6,"if(this.readOnly==false){fnValMask(this,document.all.MesDiaMsk.value,this.name)}")%> 
            <%=MyUtil.ObjInput("Número de Tarjeta 5","NumTarj5","",true,true,30,430,"",false,false,30)%> 
            <%=MyUtil.ObjInput("Banco 5","Banco5","",true,true,210,430,"",false,false,50)%> 
            <%=MyUtil.ObjInput("Vencimiento 5 (MM/DD)","MesDiaVence5","",true,true,490,430,"",false,false,6,"if(this.readOnly==false){fnValMask(this,document.all.MesDiaMsk.value,this.name)}")%> 
            <%=MyUtil.ObjInput("Número de Tarjeta 6","NumTarj6","",true,true,30,460,"",false,false,30)%> 
            <%=MyUtil.ObjInput("Banco 6","Banco6","",true,true,210,460,"",false,false,50)%> 
            <%=MyUtil.ObjInput("Vencimiento 6 (MM/DD)","MesDiaVence6","",true,true,490,460,"",false,false,6,"if(this.readOnly==false){fnValMask(this,document.all.MesDiaMsk.value,this.name)}")%> 
            <%=MyUtil.ObjInput("Número de Tarjeta 7","NumTarj7","",true,true,30,490,"",false,false,30)%> 
            <%=MyUtil.ObjInput("Banco 7","Banco7","",true,true,210,490,"",false,false,50)%> 
            <%=MyUtil.ObjInput("Vencimiento 7 (MM/DD)","MesDiaVence7","",true,true,490,490,"",false,false,6,"if(this.readOnly==false){fnValMask(this,document.all.MesDiaMsk.value,this.name)}")%> 
            <%=MyUtil.ObjInput("Número de Tarjeta 8","NumTarj8","",true,true,30,520,"",false,false,30)%> 
            <%=MyUtil.ObjInput("Banco 8","Banco8","",true,true,210,520,"",false,false,50)%> 
            <%=MyUtil.ObjInput("Vencimiento 8 (MM/DD)","MesDiaVence8","",true,true,490,520,"",false,false,6,"if(this.readOnly==false){fnValMask(this,document.all.MesDiaMsk.value,this.name)}")%> 
            <%=MyUtil.ObjInput("Número de Tarjeta 9","NumTarj9","",true,true,30,550,"",false,false,30)%> 
            <%=MyUtil.ObjInput("Banco 9","Banco9","",true,true,210,550,"",false,false,50)%> 
            <%=MyUtil.ObjInput("Vencimiento 9 (MM/DD)","MesDiaVence9","",true,true,490,550,"",false,false,6,"if(this.readOnly==false){fnValMask(this,document.all.MesDiaMsk.value,this.name)}")%> 
            <%=MyUtil.ObjInput("Número de Tarjeta 10","NumTarj10","",true,true,30,580,"",false,false,30)%> 
            <%=MyUtil.ObjInput("Banco 10","Banco10","",true,true,210,580,"",false,false,50)%>  
            <%=MyUtil.ObjInput("Vencimiento 10 (MM/DD)","MesDiaVence10","",true,true,490,580,"",false,false,6,"if(this.readOnly==false){fnValMask(this,document.all.MesDiaMsk.value,this.name)}")%> 
        <%=MyUtil.DoBlock("Datos de Tarjetas",0,0)%>   

            <%=MyUtil.ObjInput("Tipo Documento 1","TipoDocto1","",true,true,30,660,"",false,false,50)%>
            <%=MyUtil.ObjInput("Número Documento 1","NumDocto1","",true,true,300,660,"",false,false,20)%> 
            <%=MyUtil.ObjInput("Observaciones 1","Observa1","",true,true,30,690,"",false,false,100)%> 
            <%=MyUtil.ObjInput("Tipo Documento 2","TipoDocto2","",true,true,30,720,"",false,false,50)%> 
            <%=MyUtil.ObjInput("Número Documento 2","NumDocto2","",true,true,300,720,"",false,false,20)%> 
            <%=MyUtil.ObjInput("Observaciones 2","Observa2","",true,true,30,750,"",false,false,100)%> 
            <%=MyUtil.ObjInput("Tipo Documento 3","TipoDocto3","",true,true,30,780,"",false,false,50)%> 
            <%=MyUtil.ObjInput("Número Documento 3","NumDocto3","",true,true,300,780,"",false,false,20)%> 
            <%=MyUtil.ObjInput("Observaciones 3","Observa3","",true,true,30,810,"",false,false,100)%> 
            <%=MyUtil.ObjInput("Tipo Documento 4","TipoDocto4","",true,true,30,840,"",false,false,50)%> 
            <%=MyUtil.ObjInput("Número Documento 4","NumDocto4","",true,true,300,840,"",false,false,20)%> 
            <%=MyUtil.ObjInput("Observaciones 4","Observa4","",true,true,30,870,"",false,false,100)%> 
            <%=MyUtil.ObjInput("Tipo Documento 5","TipoDocto5","",true,true,30,900,"",false,false,50)%> 
            <%=MyUtil.ObjInput("Número Documento 5","NumDocto5","",true,true,300,900,"",false,false,20)%> 
            <%=MyUtil.ObjInput("Observaciones 5","Observa5","",true,true,30,930,"",false,false,100)%> 
         <%=MyUtil.DoBlock("Resguardo de Documentos",80,0)%><%  
       }  %>  
        <%=MyUtil.GeneraScripts()%><%    
        rs2.close();
        rs3.close();
        rs.close();
        
 %>
<input name='MesDiaMsk' id='MesDiaMsk' type='hidden' value='VN09VN09F-/-VN09VN09'>
<script>
     document.all.TitularTarjeta.maxLength=100;  
     document.all.PersonaReporta.maxLength=100;   
     document.all.TelContactoEm1.maxLength=20;   
     document.all.TelContactoEm2.maxLength=20;   
     document.all.TelContactoEm3.maxLength=20;   
     document.all.NumTarj1.maxLength=30;   
     document.all.NumTarj2.maxLength=30;   
     document.all.NumTarj3.maxLength=30;   
     document.all.NumTarj4.maxLength=30;   
     document.all.NumTarj5.maxLength=30;   
     document.all.NumTarj6.maxLength=30;   
     document.all.NumTarj7.maxLength=30;   
     document.all.NumTarj8.maxLength=30;   
     document.all.NumTarj9.maxLength=30;   
     document.all.NumTarj10.maxLength=30;   
     document.all.Banco1.maxLength=50;   
     document.all.Banco2.maxLength=50;   
     document.all.Banco3.maxLength=50;   
     document.all.Banco4.maxLength=50;   
     document.all.Banco5.maxLength=50;   
     document.all.Banco6.maxLength=50;   
     document.all.Banco7.maxLength=50;   
     document.all.Banco8.maxLength=50;   
     document.all.Banco9.maxLength=50;   
     document.all.Banco10.maxLength=50;   
     document.all.TipoDocto1.maxLength=50;        
     document.all.TipoDocto2.maxLength=50;        
     document.all.TipoDocto3.maxLength=50;        
     document.all.TipoDocto4.maxLength=50;        
     document.all.TipoDocto5.maxLength=50;        
     document.all.NumDocto1.maxLength=20;        
     document.all.NumDocto2.maxLength=20;        
     document.all.NumDocto3.maxLength=20;        
     document.all.NumDocto4.maxLength=20;        
     document.all.NumDocto5.maxLength=20;        
     document.all.Observa1.maxLength=100;       
     document.all.Observa2.maxLength=100;       
     document.all.Observa3.maxLength=100;       
     document.all.Observa4.maxLength=100;       
     document.all.Observa5.maxLength=100;       
     document.all.CodigoSeg.maxLength=50;       
</script>

</body>
</html>

