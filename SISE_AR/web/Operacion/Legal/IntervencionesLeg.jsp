<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
<head><title>Intervenciones</title>
<link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
</head>
<body class="cssBody">

<%-- <jsp:useBean id="beanInstanceName" scope="session" class="beanPackagAL.BeanClassName" /> --%>
<%-- <jsp:getProperty name="beanInstanceName"  property="propertyName" /> --%>

<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
<script src='../../Utilerias/Util.js' ></script>
<script src='../../Utilerias/UtilMask.js' ></script>

<%  

    String StrclUsrApp="0";
    
    
   
    if (session.getAttribute("clUsrApp")!= null)
     {
       StrclUsrApp = session.getAttribute("clUsrApp").toString(); 
     }  

    if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true)
     {
       %>Fuera de Horario<%
       StrclUsrApp=null;
       return;  
     }    
     
    String StrclExpediente = "0";   
    String StrclIntervencion = "0"; 
    String StrclPaginaWeb="0";  
    String StrFecha = "";

    if (session.getAttribute("clExpediente")!= null)
     {
       StrclExpediente = session.getAttribute("clExpediente").toString();        
     }  
  
     if (request.getParameter("clIntervencion")!= null)
      	{
            StrclIntervencion= request.getParameter("clIntervencion").toString(); 
       	}  
    
    ResultSet rs4 = UtileriasBDF.rsSQLNP( "Select convert(varchar(20),getdate(),120) fechaEt ");  
    if (rs4.next()){
       StrFecha = rs4.getString("fechaEt");
    }    
    
    StringBuffer StrSql = new StringBuffer();
    StrSql.append(" Select ");
                 StrSql.append(" coalesce(I.clIntervencion,0) as clIntervencion,");
                 StrSql.append(" coalesce(P.NombreOpe,'') as dsProveedor,");
                 StrSql.append(" coalesce(EP.dsEtapaProcedimiento,'') as dsEtapaProcedimiento,");
                 StrSql.append(" coalesce(convert(varchar(16), I.FechaIntervencion,120),'') as FechaIntervencion,");
                 StrSql.append(" coalesce(I.FolioAbogado,0) as FolioAbogado,");
                 StrSql.append(" coalesce(O.dsObjetivoLegal,'') as dsObjetivoLegal,");
                 StrSql.append(" coalesce(I.ObjetivoCumplido,0) as ObjetivoCumplido,");
                 StrSql.append(" coalesce(I.FolioIntervencion,0) as FolioIntervencion,");
                 StrSql.append(" coalesce(convert(varchar(16), I.FechaTramite,120),'') as FechaTramite, ");
                 StrSql.append(" coalesce(I.QueHice,'') as QueHice, ");
                 StrSql.append(" coalesce(convert(varchar(16), I.FechaProxTramite,120),'') as FechaProxTramite, ");
                 StrSql.append(" coalesce(I.ParaQueHice,'') as ParaQueHice, ");
                 StrSql.append(" coalesce(I.ResultadoObtuve,'') as ResultadoObtuve, ");
                 StrSql.append(" coalesce(I.SucederaDespues,'') as SucederaDespues ");
                 StrSql.append(" From Intervencion I ");
                 StrSql.append(" Left Join cEtapaProcedimiento EP ON (EP.clEtapaProcedimiento = I.clEtapaProcedimiento) ");
                 StrSql.append(" Inner join cProveedor P ON(P.clProveedor=I.clProveedor) ");
                 StrSql.append(" Inner join cObjetivoLegal O ON(O.clObjetivoLegal=I.clObjetivoLegal) ");
                 StrSql.append(" Where I.clIntervencion =").append(StrclIntervencion); 
    
    ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());     
    StrSql.delete(0,StrSql.length());
        
       %><script>fnOpenLinks()</script><%
        
       StrclPaginaWeb = "341";       
       MyUtil.InicializaParametrosC(341,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
 
       session.setAttribute("clPaginaWebP",StrclPaginaWeb); 

       %><%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccion","")%>        
       <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="IntervencionesLeg.jsp?'>"%><%  
       if (rs.next()) { 
            // El siguiente campo llave no se mete con MyUtil.ObjInput %>
            <INPUT id='clIntervencion' name='clIntervencion' type='hidden' value='<%=rs.getString("clIntervencion")%>'>
            <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
            <%=MyUtil.ObjComboC("Proveedor Jurídico","clProveedor",rs.getString("dsProveedor"),true,true,30,80,"","sp_LlenaComboProvxExp " + StrclExpediente,"","",100,true,false)%>                                
            <%=MyUtil.ObjComboC("Etapa","clEtapaProcedimiento",rs.getString("dsEtapaProcedimiento"),true,true,240,80,"","Select clEtapaProcedimiento, dsEtapaProcedimiento From cEtapaProcedimiento","","",100,true,true)%>
            <%=MyUtil.ObjInput("Fecha de Intervención<br>(aaaa/mm/dd hh:mm)","FechaIntervencion",rs.getString("FechaIntervencion"),false,false,440,70,rs4.getString("fechaEt"),true,true,22,"if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)}")%>                
            <%=MyUtil.ObjInput("Folio de Abogado","FolioVtr",rs.getString("FolioAbogado"),false,false,600,80,"",false,false,22)%>
            
            <%=MyUtil.ObjComboC("Objetivo Legal","clObjetivoLegal",rs.getString("dsObjetivoLegal"),true,true,30,120,"","select clObjetivoLegal,dsObjetivoLegal from  cObjetivoLegal","","",100,true,true)%>                                
            <%=MyUtil.ObjChkBox("Objetivo Cumplido","ObjetivoCumplido",rs.getString("ObjetivoCumplido"), true,true,440,120,"1","SI","NO","")%>     
            <%=MyUtil.ObjInput("Folio de Intervencion","FolioInVtr",rs.getString("FolioIntervencion"),false,false,600,120,"",false,false,22)%>
            
            <%=MyUtil.ObjInput("Fecha de Trámite<br>(aaaa/mm/dd hh:mm)","FechaTramite",rs.getString("FechaTramite"),true,true,30,160,"",true,true,22,"if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)}")%>                
            <%=MyUtil.ObjTextArea("¿Que Hice?","QueHice",rs.getString("QueHice"), "100","4",true,true,200,160,"",true,true)%>           
            
            <%=MyUtil.ObjInput("Fecha de Prox Tram<br>(aaaa/mm/dd hh:mm)","FechaProxTramite",rs.getString("FechaProxTramite"),true,true,30,240,"",false,false,22,"if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)}")%>                            
            <%=MyUtil.ObjTextArea("¿Para Que Lo Hice?","ParaQueHice",rs.getString("ParaQueHice"), "100","4",true,true,200,240,"",true,true)%>           
            <%=MyUtil.ObjTextArea("¿Que Resultado Obtuve?","ResultadoObtuve",rs.getString("ResultadoObtuve"), "100","4",true,true,200,320,"",true,true)%>
            <%=MyUtil.ObjTextArea("¿Que Sucedera Despues?","SucederaDespues",rs.getString("SucederaDespues"), "100","4",true,true,200,400,"",true,true)%><%
       } 
       else { %>
            <script>document.all.btnCambio.disabled=true;</script>               
            <INPUT id='clIntervencion' name='clIntervencion' type='hidden' value='0'>
            <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
            <%=MyUtil.ObjComboC("Proveedor Jurídico","clProveedor","",true,true,30,80,"","sp_LlenaComboProvxExp " + StrclExpediente,"","",100,true,false)%>
            <%=MyUtil.ObjComboC("Etapa","clEtapaProcedimiento","",true,true,240,80,"","Select clEtapaProcedimiento, dsEtapaProcedimiento From cEtapaProcedimiento ","","",100,true,true)%>                                
            <%=MyUtil.ObjInput("Fecha de Intervención<br>(aaaa/mm/dd hh:mm)","FechaIntervencion","",false,false,440,70,rs4.getString("fechaEt"),false,false,22,"if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)}")%>                
            <%=MyUtil.ObjInput("Folio de Abogado","FolioVtr","",false,false,600,80,"",false,false,22)%>
            
            <%=MyUtil.ObjComboC("Objetivo Legal","clObjetivoLegal","",true,true,30,120,"","select clObjetivoLegal,dsObjetivoLegal from  cObjetivoLegal","","",100,true,true)%>
            <%=MyUtil.ObjChkBox("Objetivo Cumplido","ObjetivoCumplido","", true,true,440,120,"1","SI","NO","")%>
            <%=MyUtil.ObjInput("Folio de Intervencion","FolioInVtr","",false,false,600,120,"",false,false,22)%>
            
            <%=MyUtil.ObjInput("Fecha de Trámite<br>(aaaa/mm/dd hh:mm)","FechaTramite","",true,true,30,160,"",true,true,22,"if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)}")%>               
            <%=MyUtil.ObjTextArea("¿Que Hice?","QueHice","", "100","4",true,true,200,160,"",true,true)%>           

            <%=MyUtil.ObjInput("Fecha de Prox Tram<br>(aaaa/mm/dd hh:mm)","FechaProxTramite","",true,true,30,240,"",false,false,22,"if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)}")%>                                        
            <%=MyUtil.ObjTextArea("¿Para Que Lo Hice?","ParaQueHice","", "100","4",true,true,200,240,"",true,true)%>           
            <%=MyUtil.ObjTextArea("¿Que Resultado Obtuve?","ResultadoObtuve","", "100","4",true,true,200,320,"",true,true)%>
            <%=MyUtil.ObjTextArea("¿Que Sucedera Despues?","SucederaDespues","", "100","4",true,true,200,400,"",true,true)%><%
       }    
        %><%=MyUtil.DoBlock("Detalle de Intervención",150,30) %>  
        <%=MyUtil.GeneraScripts()%><%    
        rs4.close();
        rs.close();
        rs4=null;
        rs=null;
        StrclUsrApp=null;
        StrclExpediente = null;   
        StrclIntervencion = null; 
        StrSql = null; 
        StrclPaginaWeb=null;  
        StrFecha = null;
        
        
 %>
<input name='FechaMsk' id='FechaMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>  
<script>    
     document.all.QueHice.maxLength=500;   
     document.all.ParaQueHice.maxLength=500;  
     document.all.ResultadoObtuve.maxLength=500;   
     document.all.SucederaDespues.maxLength=500;  
</script>
</body>
</html>


