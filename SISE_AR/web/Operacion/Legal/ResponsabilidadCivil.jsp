<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<html>
<head>
<title></title>
</head>
<body class="cssBody" onload="fnVaciarFechas()" >
<link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
<link href="../../StyleClasses/Calendario.css" rel="stylesheet" type="text/css"> 
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
<script src='../../Utilerias/Util.js' ></script>
<script src='../../Utilerias/UtilAuto.js' ></script>
<script src="../../Utilerias/UtilCalendario.js"></script>
<script src='../../Utilerias/UtilMask.js'></script>
<script src='../Utilerias/UtilDireccion.js'></script>
<%             
        String StrclExpediente = "0";
    	String strclUsr = "0";

      	if (session.getAttribute("clUsrApp")!= null)
      	{
       		strclUsr = session.getAttribute("clUsrApp").toString(); 
        }  

      	if (session.getAttribute("clExpediente")!= null)
      	{
            StrclExpediente= session.getAttribute("clExpediente").toString(); 
       	}  
        StringBuffer StrSql = new StringBuffer();
        StrSql.append(" Select exped.TieneAsistencia, ");
        StrSql.append(" EXPED.CodEnt, E.dsEntFed, EXPED.CodMD, D.dsMunDel, EXPED.clCuenta");
        StrSql.append(" From Expediente EXPED");
        StrSql.append(" LEFT JOIN cEntFed E ON(E.CodEnt = EXPED.CodEnt) ");
        StrSql.append(" LEFT JOIN cMunDel D ON(E.CodEnt = D.CodEnt and D.CodMD=EXPED.CodMD) ");
        StrSql.append(" Where clExpediente=").append(StrclExpediente);

        ResultSet rs2 = UtileriasBDF.rsSQLNP( StrSql.toString());   
        StrSql.delete(0,StrSql.length());
      
         if (rs2.next())  
         { 
            StrSql.append(" select RC.clExpediente, ");
            StrSql.append(" coalesce(convert(varchar(16),RC.FechaSiniestra,120),'') FechaSiniestra, ");
            StrSql.append(" coalesce(RC.Descripcion,'') Descripcion, ");
            StrSql.append(" coalesce(RC.Estimado,'0.00') Estimado,");
            StrSql.append(" FechaCartaRec3OP, coalesce(convert(varchar(16),RC.FechaCartaRec3,120),'') FechaCartaRec3, ");
            StrSql.append(" FechaCartaNaOP, coalesce(convert(varchar(16),RC.FechaCartaNa,120),'') FechaCartaNa, ");
            StrSql.append(" FechaCopiaFotostaticaOP, coalesce(convert(varchar(16),RC.FechaCopiaFotostatica,120),'') FechaCopiaFotostatica, ");
            StrSql.append(" FechaFotografiasOP, coalesce(convert(varchar(16),RC.FechaFotografias,120),'') FechaFotografias, ");
            StrSql.append(" coalesce(RC.NoFotografias,'0') NoFotografias,");
            StrSql.append(" FechaPresupRepOP, coalesce(convert(varchar(16),RC.FechaPresupRep,120),'') FechaPresupRep, ");
            StrSql.append(" FechaFactOriginalNaOP, coalesce(convert(varchar(16),RC.FechaFactOriginalNa,120),'') FechaFactOriginalNa, ");
            StrSql.append(" FechaCopiaUltimoReciboOP, coalesce(convert(varchar(16),RC.FechaCopiaUltimoRecibo,120),'') FechaCopiaUltimoRecibo, ");
            StrSql.append(" coalesce(RC.NoCuenta,'') NoCuenta, ");
            StrSql.append(" coalesce(RC.Otros,'') Otros") ;
            StrSql.append(" FROM ResponsabilidadCivil RC ");
            StrSql.append(" Where RC.clExpediente= ").append(StrclExpediente);

         }else{

             %><%="El expediente no existe"%><%
               rs2.close();
               rs2=null;    
               return;
         }
       	String StrclPaginaWeb = "611";
	session.setAttribute("clPaginaWebP",StrclPaginaWeb);

%> 
        <SCRIPT>fnOpenLinks()</script> 
<% MyUtil.InicializaParametrosC(611,Integer.parseInt(strclUsr)); 
   %>
<%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist","fnNumFts()")%>
<%
        if(rs2.getString("TieneAsistencia").compareToIgnoreCase("1")==0){
            %><script>document.all.btnAlta.disabled=true;</script><%
        }else{
            %><script>document.all.btnCambio.disabled=true</script><%
        }
            ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
            StrSql.delete(0,StrSql.length());
            StrSql=null;

  %>
<%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="ResponsabilidadCivil.jsp?'>"%>

        <%if (rs.next()) {
            %>
            
              <%
                    StringBuffer StrSql2 = new StringBuffer();
                    StrSql2.append(" Select convert(varchar(16),getdate(),120) 'FechaActual' ");
                    ResultSet rs3 = UtileriasBDF.rsSQLNP( StrSql2.toString());   
                    StrSql2.delete(0,StrSql2.length());

                     if (rs3.next())  {
                %>
                <INPUT id='FechaActualVTR' name='FechaActualVTR' type='hidden' value='<%=rs3.getString("FechaActual")%>'>
                <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
                <% } 
                            rs3.close();
                            rs3=null;  %>
              <%=MyUtil.ObjInput("Causa del Siniestro","CausaSiniestro","RESPONSABILIDAD CIVIL",false,false,30,70,"RESPONSABILIDAD CIVIL",false,false,38)%>
              <%=MyUtil.ObjInputF("Fecha del Siniestro (AAAA-MM-DD HH:MM)", "FechaSiniestra",rs.getString("FechaSiniestra"), true, true, 400, 70, "", true, true,20, 2, "if(this.readOnly==false){fnValMask(this,document.all.FechaSiniestraMsk.value,this.name)};")%>
              <%=MyUtil.ObjTextArea("Descripción u Observaciones","Descripcion",rs.getString("Descripcion"),"60","4",true,true,30,110,"",true,true)%>
              <%=MyUtil.ObjInput("Estimado","Estimado",rs.getString("Estimado"),true,true,400,110,"",false,false,20,"EsNumerico(document.all.Estimado)")%>
              <%=MyUtil.DoBlock("Datos Generales",100,50)%>  
              <%=MyUtil.ObjChkBox("Carta de Reclamación del Tercero a N/A","FechaCartaRec3OP",rs.getString("FechaCartaRec3OP"), true,true,30,250,"0","SI","NO","fnfecha('1')")%>
              <%=MyUtil.ObjInput("Fecha (AAAA-MM-DD HH:MM)","FechaCartaRec3",rs.getString("FechaCartaRec3"),true,true,300,250,"",false,false,20,"if(this.readOnly==false){fnValMask(this,document.all.FechaCartaRec3Msk.value,this.name)};")%>
              <%=MyUtil.ObjChkBox("Carta de Reclamación de N/A a Royal","FechaCartaNaOP",rs.getString("FechaCartaNaOP"), true,true,30,290,"0","SI","NO","fnfecha('2')")%>
              <%=MyUtil.ObjInput("Fecha (AAAA-MM-DD HH:MM)","FechaCartaNa",rs.getString("FechaCartaNa"),true,true,300,290,"",false,false,20,"if(this.readOnly==false){fnValMask(this,document.all.FechaCartaNaMsk.value,this.name)};")%>
              <%=MyUtil.ObjChkBox("Copia Fotostática del Tercero y de N/A","FechaCopiaFotostaticaOP",rs.getString("FechaCopiaFotostaticaOP"), true,true,30,330,"0","SI","NO","fnfecha('3')")%>
              <%=MyUtil.ObjInput("Fecha (AAAA-MM-DD HH:MM)","FechaCopiaFotostatica",rs.getString("FechaCopiaFotostatica"),true,true,300,330,"",false,false,20,"if(this.readOnly==false){fnValMask(this,document.all.FechaCopiaFotostaticaMsk.value,this.name)};")%>  
              <%=MyUtil.ObjChkBox("Fotografías","FechaFotografiasOP",rs.getString("FechaFotografiasOP"), true,true,30,370,"0","SI","NO","fnfecha('4');")%>
              <%=MyUtil.ObjInput("Fecha (AAAA-MM-DD HH:MM)","FechaFotografias",rs.getString("FechaFotografias"),true,true,300,370,"",false,false,20,"if(this.readOnly==false){fnValMask(this,document.all.FechaFotografiasMsk.value,this.name)};")%> 
              <%=MyUtil.ObjInput("Número","NoFotografias",rs.getString("NoFotografias"),true,true,500,370,"",false,false,3,"EsNumerico(document.all.NoFotografias);fnNumFts()")%> 
              <%=MyUtil.ObjChkBox("Presupuesto de Reparación","FechaPresupRepOP",rs.getString("FechaPresupRepOP"), true,true,30,410,"0","SI","NO","fnfecha('5')")%>
              <%=MyUtil.ObjInput("Fecha (AAAA-MM-DD HH:MM)","FechaPresupRep",rs.getString("FechaPresupRep"),true,true,300,410,"",false,false,20,"if(this.readOnly==false){fnValMask(this,document.all.FechaPresupRepMsk.value,this.name)};")%> 
              <%=MyUtil.ObjChkBox("Factura Original a nombre de N/A","FechaFactOriginalNaOP",rs.getString("FechaFactOriginalNaOP"), true,true,30,450,"0","SI","NO","fnfecha('6')")%>
              <%=MyUtil.ObjInput("Fecha (AAAA-MM-DD HH:MM)","FechaFactOriginalNa",rs.getString("FechaFactOriginalNa"),true,true,300,450,"",false,false,20,"if(this.readOnly==false){fnValMask(this,document.all.FechaFactOriginalNaMsk.value,this.name)};")%>               
              <%=MyUtil.ObjChkBox("Copia del último recibo donde <br>aparece el cargo de ADT pagado","FechaCopiaUltimoReciboOP",rs.getString("FechaCopiaUltimoReciboOP"), true,true,30,490,"0","SI","NO","fnfecha('7')")%>
              <%=MyUtil.ObjInput("Fecha (AAAA-MM-DD HH:MM)","FechaCopiaUltimoRecibo",rs.getString("FechaCopiaUltimoRecibo"),true,true,300,500,"",false,false,20,"if(this.readOnly==false){fnValMask(this,document.all.FechaCopiaUltimoReciboMsk.value,this.name)};")%>               
              <%=MyUtil.ObjInput("Número de Cuenta en caso de ser Foraneo","NoCuenta",rs.getString("NoCuenta"),true,true,30,545,"",false,false,30,"")%>
              <%=MyUtil.ObjTextArea("Otros","Otros",rs.getString("Otros"),"50","4",true,true,30,585,"",false,false)%>
              <%=MyUtil.DoBlock("Datos Entregados por N/A",0,30)%> 
<%
        }
	    else{
                    StringBuffer StrSql2 = new StringBuffer();
                    StrSql2.append(" Select convert(varchar(16),getdate(),120) 'FechaActual' ");
                    ResultSet rs3 = UtileriasBDF.rsSQLNP( StrSql2.toString());   
                    StrSql2.delete(0,StrSql2.length());

                     if (rs3.next())  {
                %>
                <INPUT id='FechaActualVTR' name='FechaActualVTR' type='hidden' value='<%=rs3.getString("FechaActual")%>'>
                <% } 

                            rs3.close();
                            rs3=null;  %>
              <%=MyUtil.ObjInput("Causa del Siniestro","CausaSiniestro","",false,false,30,70,"RESPONSABILIDAD CIVIL",false,false,38)%>
              <%=MyUtil.ObjInputF("Fecha del Siniestro", "FechaSiniestra","", true, true, 400, 70, "", true, true,20, 2, "if(this.readOnly==false){fnValMask(this,document.all.FechaSiniestraMsk.value,this.name)};")%>
              <%=MyUtil.ObjTextArea("Descripción u Observaciones","Descripcion","","60","4",true,true,30,110,"",true,true)%>
              <%=MyUtil.ObjInput("Estimado","Estimado","",true,true,400,110,"",false,false,20,"EsNumerico(document.all.Estimado)")%>
              <%=MyUtil.DoBlock("Datos Generales",100,50)%> 
                <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
              <%=MyUtil.ObjChkBox("Carta de Reclamación del Tercero a N/A","FechaCartaRec3OP","", true,true,30,250,"0","SI","NO",";fnfecha('1');")%>
              <%=MyUtil.ObjInput("Fecha","FechaCartaRec3","",true,true,300,250,"",false,false,20,"if(this.readOnly==false){fnValMask(this,document.all.FechaCartaRec3Msk.value,this.name)};")%>
              <%=MyUtil.ObjChkBox("Carta de Reclamación de N/A a Royal","FechaCartaNaOP","", true,true,30,290,"0","SI","NO",";fnfecha('2')")%>
              <%=MyUtil.ObjInput("Fecha","FechaCartaNa","",true,true,300,290,"",false,false,20,"if(this.readOnly==false){fnValMask(this,document.all.FechaCartaNaMsk.value,this.name)};")%>
              <%=MyUtil.ObjChkBox("Copia Fotostática del Tercero y de N/A","FechaCopiaFotostaticaOP","", true,true,30,330,"0","SI","NO",";fnfecha('3')")%>
              <%=MyUtil.ObjInput("Fecha","FechaCopiaFotostatica","",true,true,300,330,"",false,false,20,"if(this.readOnly==false){fnValMask(this,document.all.FechaCopiaFotostaticaMsk.value,this.name)};")%> 
              <%=MyUtil.ObjChkBox("Fotografías","FechaFotografiasOP","", true,true,30,370,"0","SI","NO",";fnfecha('4')")%>
              <%=MyUtil.ObjInput("Fecha","FechaFotografias","",true,true,300,370,"",false,false,20,"if(this.readOnly==false){fnValMask(this,document.all.FechaFotografiasMsk.value,this.name)};")%> 
              <%=MyUtil.ObjInput("Número","NoFotografias","",true,true,430,370,"",false,false,3,"EsNumerico(document.all.NoFotografias);fnNumFts()")%> 
              <%=MyUtil.ObjChkBox("Presupuesto de Reparación","FechaPresupRepOP","", true,true,30,410,"0","SI","NO",";fnfecha('5')")%>
              <%=MyUtil.ObjInput("Fecha","FechaPresupRep","",true,true,300,410,"",false,false,20,"if(this.readOnly==false){fnValMask(this,document.all.FechaPresupRepMsk.value,this.name)};")%>               
              <%=MyUtil.ObjChkBox("Factura Original a nombre de N/A","FechaFactOriginalNaOP","", true,true,30,450,"0","SI","NO",";fnfecha('6')")%>
              <%=MyUtil.ObjInput("Fecha","FechaFactOriginalNa","",true,true,300,450,"",false,false,20,"if(this.readOnly==false){fnValMask(this,document.all.FechaFactOriginalNaMsk.value,this.name)};")%>               
              <%=MyUtil.ObjChkBox("Copia del último recibo donde <br>aparece el cargo de ADT pagado","FechaCopiaUltimoReciboOp","", true,true,30,490,"0","SI","NO",";fnfecha('7')")%>
              <%=MyUtil.ObjInput("Fecha","FechaCopiaUltimoRecibo","",true,true,300,500,"",false,false,20,"if(this.readOnly==false){fnValMask(this,document.all.FechaCopiaUltimoReciboMsk.value,this.name)};")%>
              <%=MyUtil.ObjInput("Número de Cuenta en caso de ser Foraneo","NoCuenta","",true,true,30,545,"",false,false,30)%>
              <%=MyUtil.ObjTextArea("Otros","Otros","","50","4",true,true,30,585,"",false,false)%>
              <%=MyUtil.DoBlock("Datos Entregados por N/A",0,30)%> 
        <% } %>	
<%
        rs2.close();
        rs.close();
        rs2=null;
        rs=null;
        StrSql=null;
        StrclExpediente = null;
 	strclUsr = null;
        StrclPaginaWeb=null;
%>
<%=MyUtil.GeneraScripts()%>
<input name='FechaSiniestraMsk' id='FechaSiniestraMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
<input name='FechaCartaRec3Msk' id='FechaCartaRec3Msk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
<input name='FechaCartaNaMsk' id='FechaCartaNaMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
<input name='FechaCopiaFotostaticaMsk' id='FechaCopiaFotostaticaMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
<input name='FechaFotografiasMsk' id='FechaFotografiasMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
<input name='FechaPresupRepMsk' id='FechaPresupRepMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
<input name='FechaFactOriginalNaMsk' id='FechaFactOriginalNaMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
<input name='FechaCopiaUltimoReciboMsk' id='FechaCopiaUltimoReciboMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>

<script> 
    document.all.NoFotografias.maxLength=3;
  
    function fnVaciarFechas() {
   if (document.all.FechaCartaRec3.value=="1900-01-01 00:00") {document.all.FechaCartaRec3.value=""}
   if (document.all.FechaCartaNa.value=="1900-01-01 00:00") {document.all.FechaCartaNa.value=""}
   if (document.all.FechaCopiaFotostatica.value=="1900-01-01 00:00") {document.all.FechaCopiaFotostatica.value=""}
   if (document.all.FechaFotografias.value=="1900-01-01 00:00") {document.all.FechaFotografias.value=""}
   if (document.all.FechaPresupRep.value=="1900-01-01 00:00") {document.all.FechaPresupRep.value=""}
   if (document.all.FechaFactOriginalNa.value=="1900-01-01 00:00") {document.all.FechaFactOriginalNa.value=""}
   if (document.all.FechaCopiaUltimoRecibo.value=="1900-01-01 00:00") {document.all.FechaCopiaUltimoRecibo.value=""}
    }
  
    function fnfecha(objeto){
       switch(objeto)
        {
            case '1' : if (document.all.FechaCartaRec3.value!=""){document.all.FechaCartaRec3.value="";}else {document.all.FechaCartaRec3.value=document.all.FechaActualVTR.value;}; break
            case '2' : if (document.all.FechaCartaNa.value!=""){document.all.FechaCartaNa.value="";}else {document.all.FechaCartaNa.value=document.all.FechaActualVTR.value;}; break
            case '3' : if (document.all.FechaCopiaFotostatica.value!=""){document.all.FechaCopiaFotostatica.value="";}else {document.all.FechaCopiaFotostatica.value=document.all.FechaActualVTR.value;}; break
            case '4' : if (document.all.FechaFotografias.value!=""){document.all.FechaFotografias.value="";document.all.NoFotografias.value="";}else {document.all.FechaFotografias.value=document.all.FechaActualVTR.value;document.all.NoFotografias.value='0';fnNumFts();document.all.FechaFotografias.disabled=false;};break
            case '5' : if (document.all.FechaPresupRep.value!=""){document.all.FechaPresupRep.value="";}else {document.all.FechaPresupRep.value= document.all.FechaActualVTR.value;};break
            case '6' : if (document.all.FechaFactOriginalNa.value!=""){document.all.FechaFactOriginalNa.value="";}else {document.all.FechaFactOriginalNa.value=document.all.FechaActualVTR.value;};break
            case '7' : if (document.all.FechaCopiaUltimoRecibo.value!=""){document.all.FechaCopiaUltimoRecibo.value="";}else {document.all.FechaCopiaUltimoRecibo.value=document.all.FechaActualVTR.value;};break
        }
    }

        function fnNumFts(){
        if ((document.all.FechaFotografiasOPC.value != '0')&&(document.all.NoFotografias.value=='0') )
         { alert("Especifique el número de fotografías entregadas.")
            document.all.NoFotografias.focus()  }
    }
    

    
</script>    
</body>
</html>
