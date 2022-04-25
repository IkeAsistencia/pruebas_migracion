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
<script src='../../Utilerias/UtilDireccion.js' ></script>
<script src='../../Utilerias/UtilMask.js'></script>
<%  
    com.ike.util.I18N i18n = com.ike.util.I18N.getInstance("es","AR");
    String StrclExpediente = "0";
    String StrclUsrApp="0";
    String StrclPaginaWeb="0";
    String StrFecha =""; 
    String StrCodEnt="0";
    String StrdsGerencia = ""; 
    
    

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
    StrSql.append(" Select TieneAsistencia, CodEnt");
    StrSql.append(" From Expediente ");
    StrSql.append(" Where clExpediente=").append(StrclExpediente);
    ResultSet rs2 = UtileriasBDF.rsSQLNP( StrSql.toString());     
    StrSql.delete(0,StrSql.length());

    if (rs2.next())  {   StrCodEnt=rs2.getString("CodEnt"); }   
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
 
    StrSql.append(" select ge.clgerenciareg, gr.dsgerencia from gciaregxentidad ge ");
             StrSql.append(" left join cgerenciaregional gr on (gr.clgerenciareg=ge.clgerenciareg)");
             StrSql.append(" where ge.codEnt ='").append(StrCodEnt).append("'");
    ResultSet rs4 = UtileriasBDF.rsSQLNP( StrSql.toString());  
    StrSql.delete(0,StrSql.length());   
    
    if (rs4.next()){
       StrdsGerencia = rs4.getString("dsgerencia");
    }       
   
//out.println(StrSql);   
    
    StrSql.append(" Select ");
            StrSql.append(" coalesce(SV.PersonaReporta,'') as PersonaReporta,");
            StrSql.append(" coalesce(TP.dsTipoPersonaRep,'') as dsTipoPersonaRep,");
            StrSql.append(" coalesce(convert(varchar(10),SV.FechaDeceso,120),'') as FechaDeceso,");
            StrSql.append(" coalesce(P.dsPais,'') as dsPais,");
            StrSql.append(" coalesce(EF.dsEntFed,'') as dsEntFed,");
            StrSql.append(" coalesce(C.dsCiudad,'') as dsCiudad,");
            StrSql.append(" coalesce(P.clPais,'') as clPais,");
            StrSql.append(" SV.EnvioAbogado,");
            StrSql.append(" coalesce(TR.dsTipoReclamacion,'') as dsTipoReclamacion,");
            StrSql.append(" coalesce(SV.NumCuentaDep,'') as NumCuentaDep,");
            StrSql.append(" coalesce(SV.Sucursal,'') as Sucursal,");
            StrSql.append(" coalesce(SV.Banco,'') as Banco,");
            StrSql.append(" coalesce(SV.NombreTitular,'') as NombreTitular,");
            StrSql.append(" coalesce(SV.Clabe,'') as Clabe,");
            StrSql.append(" coalesce(convert(varchar(10),SV.FechaPago,120),'') as FechaPago,");
            StrSql.append(" coalesce(SV.CostoPagado,'0') as CostoPagado,");
            StrSql.append(" coalesce(convert(varchar(16),SV.FechaApertura,120),'') as FechaApertura,");
            StrSql.append(" coalesce(convert(varchar(16),SV.FechaRegistro,120),'') as FechaRegistro,");
            StrSql.append(" SV.CartaReclama,");
            StrSql.append(" SV.DenunciaCopia,");
            StrSql.append(" SV.ActaDefuncionCopia,");
            StrSql.append(" SV.ComprobanteUso,");
            StrSql.append(" SV.IdentOficialCopia,");
            StrSql.append(" SV.TarjetaReclama,");
            StrSql.append(" coalesce(SV.OtroDocto,'') as OtroDocto");
            StrSql.append(" From SeguroVida SV");
            StrSql.append(" Left Join cTipoPersonaReporta TP ON (SV.clTipoPerReporta=TP.clTipoPerReporta)");
            StrSql.append(" Left Join cPais P ON (SV.clPais=P.clPais)");
            StrSql.append(" Left Join cEntFed EF ON (SV.CodEnt=EF.CodEnt)");
            StrSql.append(" Left Join cCiudad C ON (SV.clCiudad=C.clCiudad)");
            StrSql.append(" Left Join cTipoReclamacion TR ON (SV.clTipoReclamacion=TR.clTipoReclamacion)");
            StrSql.append(" Where clExpediente=").append(StrclExpediente);
       ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());     
       StrSql.delete(0,StrSql.length());   
        
       %><script>fnOpenLinks()</script><%
  
       StrclPaginaWeb = "333";        
       MyUtil.InicializaParametrosC(333,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
       session.setAttribute("clPaginaWebP",StrclPaginaWeb); 

       %><%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist","")%>          
       <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="SeguroVida.jsp?'>"%><% 
   
       if (rs.next()) { 
            // El siguiente campo llave no se mete con MyUtil.ObjInput  %>
            <script>document.all.btnAlta.disabled=true;document.all.btnElimina.disabled=true;</script>   
            <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>  
  
            <%=MyUtil.ObjInput("Persona que Reporta","PersonaReporta",rs.getString("PersonaReporta"),true,true,30,90,"",true,true,50)%>
            <%=MyUtil.ObjComboC("Tipo de Persona que Reporta", "clTipoPerReporta",rs.getString("dsTipoPersonaRep"),true,true,310,90,"","Select clTipoPerReporta,dsTipoPersonaRep from cTipoPersonaReporta","","",140,true,true)%>
            <%=MyUtil.ObjInput("Fecha del Deceso<br>aaaa/mm/dd","FechaDeceso",rs.getString("FechaDeceso"),true,true,510,80,"",false,false,20,"if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)}")%>
            <%=MyUtil.ObjComboC("Pais","clPais",rs.getString("dsPais"),true,true,30,140,"","Select clPais ,dsPais from cPais order by dsPais","fnLlenaCiudadesSeg()","",20,false,false)%>
            <%=MyUtil.ObjComboC(i18n.getMessage("message.title.entidad"),"CodEnt",rs.getString("dsEntFed"),true,true,240,140,"","Select CodEnt,dsEntFed from cEntFed order by dsEntFed","fnPaisMexico()","",20,false,false)%>
            <%=MyUtil.ObjComboC("Ciudad","clCiudad",rs.getString("dsCiudad"),true,true,450,140,"","Select clCiudad, dsCiudad from cCiudad Where clPais=" + rs.getString("clPais") + " order by dsCiudad","","",20,false,false)%>
            <%=MyUtil.ObjChkBox("Envio de Abogado","EnvioAbogado",rs.getString("EnvioAbogado"), true,true,30,190,"0","SI","NO","")%>
            <%=MyUtil.ObjComboC("Reclamación", "clTipoReclamacion",rs.getString("dsTipoReclamacion"),true,true,240,195,"","SELECT clTipoReclamacion,dsTipoReclamacion FROM cTipoReclamacion","","",140,true,true)%>
            <%=MyUtil.ObjInput("No. de Cuenta para pago o deposito","NumCuentaDep",rs.getString("NumCuentaDep"),true,true,450,195,"",false,false,40)%>
            <%=MyUtil.ObjInput("Sucursal","Sucursal",rs.getString("Sucursal"),true,true,30,250,"",false,false,35)%>
            <%=MyUtil.ObjInput("Banco","Banco",rs.getString("Banco"),true,true,240,250,"",false,false,35)%>
            <%=MyUtil.ObjInput("Nombre del Titular","NombreTitular",rs.getString("NombreTitular"),true,true,450,250,"",false,false,40)%>
            <%=MyUtil.ObjInput("Clabe","Clabe",rs.getString("Clabe"),true,true,30,310,"",false,false,30)%>
            <%=MyUtil.ObjInput("Fecha de Pago <br>aaaa/mm/dd","FechaPago",rs.getString("FechaPago"),true,true,240,300,"",false,false,20,"if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)}")%>
            <%=MyUtil.ObjInput("Costo Pagado","CostoPagado",rs.getString("CostoPagado"),true,true,450,310,"",false,false,20,"EsNumerico(document.all.CostoPagado)")%>
            <%=MyUtil.ObjInput("Fecha de Apertura","FechaApertura",rs.getString("FechaApertura"),false,false,30,370,"",false,false,30)%>
            <%=MyUtil.ObjInput("Fecha de Registro","FechaRegistroVTR",rs.getString("FechaRegistro"),false,false,240,370,"",false,false,30)%>
    <%=MyUtil.DoBlock("Detalle de Seguro de Vida",10,0)%> 
     
            <%=MyUtil.ObjChkBox("Carta de solicitud de reclamación","CartaReclama",rs.getString("CartaReclama"), true,true,30,460,"0","SI","NO","")%>
            <%=MyUtil.ObjChkBox("Copia de la Denuncia","DenunciaCopia",rs.getString("DenunciaCopia"), true,true,290,460,"0","SI","NO","")%>
            <%=MyUtil.ObjChkBox("Copia del Acta de Defuncion","ActaDefuncionCopia",rs.getString("ActaDefuncionCopia"), true,true,460,460,"0","SI","NO","")%>
            <%=MyUtil.ObjChkBox("Comprobante de Utilizacion de la Tarjeta","ComprobanteUso",rs.getString("ComprobanteUso"), true,true,30,530,"0","SI","NO","")%>
            <%=MyUtil.ObjChkBox("Copia de Identificacion Oficial","IdentOficialCopia",rs.getString("IdentOficialCopia"), true,true,340,530,"0","SI","NO","")%>
            <%=MyUtil.ObjChkBox("Copia de la Tarjeta que genera reclamacion","TarjetaReclama",rs.getString("TarjetaReclama"), true,true,30,580,"0","SI","NO","")%>
            <%=MyUtil.ObjInput("Otro Documento: Especificar","OtroDocto",rs.getString("OtroDocto"),true,true,340,580,"",false,false,60)%>
         <%=MyUtil.DoBlock("Envio de documentación",50,0)%><%
 } 
       else {   %>
            <script>document.all.btnCambio.disabled=true;</script>
            <script>document.all.btnElimina.disabled=true;</script>
            <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
 
            <%=MyUtil.ObjInput("Persona que Reporta","PersonaReporta","",true,true,30,90,"",true,true,50)%>
            <%=MyUtil.ObjComboC("Tipo de Persona que Reporta", "clTipoPerReporta","",true,true,310,90,"","Select clTipoPerReporta,dsTipoPersonaRep from cTipoPersonaReporta","","",140,true,true)%>
            <%=MyUtil.ObjInput("Fecha del Deceso<br>aaaa/mm/dd","FechaDeceso","",true,true,510,80,"",false,false,20,"if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)}")%>
            <%=MyUtil.ObjComboC("Pais","clPais","",true,true,30,140,"","Select clPais ,dsPais from cPais order by dsPais","fnLlenaCiudadesSeg()","",20,false,false)%>
            <%=MyUtil.ObjComboC(i18n.getMessage("message.title.entidad"),"CodEnt","",true,true,240,140,"","Select CodEnt,dsEntFed from cEntFed order by dsEntFed","fnPaisMexico()","",20,false,false)%>
            <%=MyUtil.ObjComboC("Ciudad","clCiudad","",true,true,450,140,"","Select clCiudad, dsCiudad from cCiudad order by dsCiudad","","",20,false,false)%>
            <%=MyUtil.ObjChkBox("Envio de Abogado","EnvioAbogado","", true,true,30,190,"0","SI","NO","")%>
            <%=MyUtil.ObjComboC("Reclamación", "clTipoReclamacion","",true,true,240,195,"","SELECT clTipoReclamacion,dsTipoReclamacion FROM cTipoReclamacion","","",140,true,true)%>
            <%=MyUtil.ObjInput("No. de Cuenta para pago o deposito","NumCuentaDep","",true,true,450,195,"",false,false,40)%>
            <%=MyUtil.ObjInput("Sucursal","Sucursal","",true,true,30,250,"",false,false,35)%>
            <%=MyUtil.ObjInput("Banco","Banco","",true,true,240,250,"",false,false,35)%>
            <%=MyUtil.ObjInput("Nombre del Titular","NombreTitular","",true,true,450,250,"",false,false,40)%>
            <%=MyUtil.ObjInput("Clabe","Clabe","",true,true,30,310,"",false,false,30)%>
            <%=MyUtil.ObjInput("Fecha de Pago <br>aaaa/mm/dd","FechaPago","",true,true,240,300,"",false,false,20,"if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)}")%>
            <%=MyUtil.ObjInput("Costo Pagado","CostoPagado","",true,true,450,310,"",false,false,20,"EsNumerico(document.all.CostoPagado)")%>
            <%=MyUtil.ObjInput("Fecha de Apertura","FechaApertura","",false,false,30,370,StrFecha,false,false,30)%>
            <%=MyUtil.ObjInput("Fecha de Registro","FechaRegistroVTR","",false,false,240,370,"",false,false,30)%>
    <%=MyUtil.DoBlock("Detalle de Seguro de Vida",10,0)%> 
     
            <%=MyUtil.ObjChkBox("Carta de solicitud de reclamación","CartaReclama","", true,true,30,460,"0","SI","NO","")%>
            <%=MyUtil.ObjChkBox("Copia de la Denuncia","DenunciaCopia","", true,true,290,460,"0","SI","NO","")%>
            <%=MyUtil.ObjChkBox("Copia del Acta de Defuncion","ActaDefuncionCopia","", true,true,460,460,"0","SI","NO","")%>
            <%=MyUtil.ObjChkBox("Comprobante de Utilizacion de la Tarjeta","ComprobanteUso","", true,true,30,530,"0","SI","NO","")%>
            <%=MyUtil.ObjChkBox("Copia de Identificacion Oficial","IdentOficialCopia","", true,true,340,530,"0","SI","NO","")%>
            <%=MyUtil.ObjChkBox("Copia de la Tarjeta que genera reclamacion","TarjetaReclama","", true,true,30,580,"0","SI","NO","")%>
            <%=MyUtil.ObjInput("Otro Documento: Especificar","OtroDocto","",true,true,340,580,"",false,false,60)%>
         <%=MyUtil.DoBlock("Envio de documentación",50,0)%><%
        }  %>
        <%=MyUtil.GeneraScripts()%><%   

        rs2.close();
        rs3.close();
        rs4.close();
        rs.close();
        
        rs2=null;
        rs3=null;
        rs4=null;
        rs=null;
        StrSql=null;
     StrclExpediente = null;
     StrclUsrApp=null;
     StrclPaginaWeb=null;
     StrFecha =null; 
     StrCodEnt=null;
     StrdsGerencia = null; 
 
%>
<input name='FechaMsk' id='FechaMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09'>
<script> 
/*
document.all.dsArticulo.maxLength=100; 
document.all.OtroDocto.maxLength=50; 
document.all.NumCuentaDep.maxLength=50; 
document.all.Sucursal.maxLength=50; 
document.all.Banco.maxLength=50; 
document.all.NombreBenef.maxLength=100; 
document.all.Clabe.maxLength=50; 
*/
  function fnLlenaCiudadesSeg(){ 
            var strConsulta = "sp_GetCiudades " + document.all.clPais.value;
            var pstrCadena = "../../servlet/Utilerias.LlenaCombos?strSQL=" + strConsulta;
            document.all.clCiudad.value = '';
            pstrCadena = pstrCadena + "&strName=clCiudadC";		
            fnOptionxDefault('clCiudadC',pstrCadena);
            document.all.CodEnt.value = '';
            document.all.CodEntC.value = '';                
    }    
    function fnPaisMexico(){  
            document.all.clPais.value = '115';
            document.all.clPaisC.value = '115'; 

            var strConsulta = "sp_GetCiudades " + document.all.clPais.value;
            var pstrCadena = "../../servlet/Utilerias.LlenaCombos?strSQL=" + strConsulta;
            document.all.clCiudad.value = '';
            pstrCadena = pstrCadena + "&strName=clCiudadC";		
            fnOptionxDefault('clCiudadC',pstrCadena);
            
            document.all.clCiudad.value = '0';
            document.all.clCiudadC.value = '0'; 
    }
</script>
</body>
</html>

