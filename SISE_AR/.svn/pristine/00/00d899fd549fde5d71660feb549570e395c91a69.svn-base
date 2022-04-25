<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<html>
    <head>
        <title></title>
    </head>
    <body class="cssBody">
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
        
        <script src='../../Utilerias/Util.js'></script>
        <script src='../../Utilerias/UtilAuto.js'></script>
        <script src='../../Utilerias/UtilMask.js'></script>
        <script src='../../Utilerias/UtilDireccion.js' ></script>
        
        <%  
        com.ike.util.I18N i18n = com.ike.util.I18N.getInstance("es","AR");
        String strclUsr = "0";
        
        
        
        if (session.getAttribute("clUsrApp")!= null)
        {
            strclUsr = session.getAttribute("clUsrApp").toString();
        }
        
        if (SeguridadC.verificaHorarioC(Integer.parseInt(strclUsr)) != true)
        {
        %><%="Fuera de Horario"%><% 
        strclUsr=null;
        
        return;
        }
        String StrclExpediente = "0";
        
        if (session.getAttribute("clExpediente")!= null)
        {
            StrclExpediente = session.getAttribute("clExpediente").toString();
        }
        
        
        StringBuffer StrSql = new StringBuffer();
        StrSql.append(" Select exped.TieneAsistencia, ");
        
        StrSql.append(" E.dsEntFed, D.dsMunDel , EXPED.CodMD, EXPED.CodEnt ");
        StrSql.append(" From Expediente EXPED");
        StrSql.append(" LEFT JOIN cEntFed E ON(E.CodEnt = EXPED.CodEnt) ");
        StrSql.append(" LEFT JOIN cMunDel D ON(E.CodEnt = D.CodEnt and D.CodMD=EXPED.CodMD) ");
        StrSql.append(" Where exped.clExpediente=").append(StrclExpediente);
        
        ResultSet rs2 = UtileriasBDF.rsSQLNP( StrSql.toString());
        StrSql.delete(0,StrSql.length());
        
        if (rs2.next())
        {
            StrSql.append(" select A.clExpediente, ");
            StrSql.append(" coalesce(A.CalleNum,'') CalleNum, ");
            StrSql.append(" coalesce(A.Colonia,'') Colonia , ");
            StrSql.append(" A.ClaveAMIS,");
            StrSql.append(" E.dsEntFed,");
            StrSql.append(" D.dsMunDel ,");
            StrSql.append(" F.dsTipoFalla,");
            StrSql.append(" coalesce(A.clTipoFalla,0) clTipoFalla, ");
            StrSql.append(" G.dsTipoGrua, ");
            StrSql.append(" A.Modelo, ");
            StrSql.append(" A.Color, ");
            StrSql.append(" A.Placas, ");
            StrSql.append(" LE.dsLugarEvento, ");
            StrSql.append(" M.dsMarcaAuto, ");
            StrSql.append(" T.dsTipoAuto, ");
            StrSql.append(" Exped.CodMD, ");
            StrSql.append(" Exped.CodEnt,  ");
            StrSql.append(" cast(A.Referencias as varchar(8000)) Referencias,");
            StrSql.append(" EFD.dsEntFed dsEntFedDest,");
            StrSql.append(" DD.dsMunDel dsMunDelDest,");
            StrSql.append("  A.CodMDDest, ");
            StrSql.append(" A.CodEntDest, ");
            StrSql.append("  coalesce(A.ColoniaDest,'') ColoniaDest , ");
            StrSql.append(" coalesce(A.CalleNumDest,'') CalleNumDest, ");
            StrSql.append(" cast(A.ReferenciasDest as varchar(8000)) ReferenciasDest,");
            StrSql.append(" coalesce(A.Ajustador,'') Ajustador, ");
            StrSql.append(" coalesce(A.TelAjustador,'') TelAjustador, ");
            StrSql.append(" coalesce(A.NoPoliza,'') NoPoliza, ");
            StrSql.append(" coalesce(A.NoSiniestro,'') NoSiniestro ");
            StrSql.append(" FROM Expediente EXPED ");
            StrSql.append(" INNER JOIN AsistenciaKM0 A on (A.clExpediente = EXPED.clExpediente)");
            StrSql.append(" INNER JOIN cLugarEvento LE on (A.clLugarEvento = LE.clLugarEvento) ");
            StrSql.append(" LEFT JOIN CMARCAAUTO M ON(M.CodigoMarca=A.CodigoMarca) ");
            StrSql.append(" LEFT JOIN CTIPOAUTO  T ON(T.ClaveAMIS=A.ClaveAMIS) ");
            StrSql.append(" LEFT JOIN cTipoFalla F ON (F.clTipoFalla=A.clTipoFalla) ");
            StrSql.append(" LEFT JOIN cTipoGrua G ON(G.clTipoGrua=A.clTipoGrua) ");
            StrSql.append(" LEFT JOIN cEntFed E ON(E.CodEnt = Exped.CodEnt) ");
            StrSql.append(" LEFT JOIN cMunDel D ON(E.CodEnt = D.CodEnt and D.CodMD=Exped.CodMD) ");
            StrSql.append(" LEFT JOIN cEntFed EFD ON(EFD.CodEnt = A.CodEntDest) ");
            StrSql.append(" LEFT JOIN cMunDel DD ON(EFD.CodEnt = DD.CodEnt and DD.CodMD=A.CodMDDest) ");
            StrSql.append(" Where exped.clExpediente= ").append(StrclExpediente);
            
        }
        else
        {
        %><%="El expediente no existe"%><%
        rs2.close();
        rs2=null;
        
        return;
        }
        String StrclPaginaWeb = "219";
        session.setAttribute("clPaginaWebP",StrclPaginaWeb);
        
        %><script>fnOpenLinks()</script><%
        
        
        MyUtil.InicializaParametrosC(219,Integer.parseInt(strclUsr)); 
        
        %><%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist","")%><%
        if(rs2.getString("TieneAsistencia").compareToIgnoreCase("1")==0)
        {
        %><script>document.all.btnAlta.disabled=true;</script><%
        }
        else
        {
        %><script>document.all.btnCambio.disabled=true;</script><%
        }
        
        ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());        
        %><%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="GruaColision.jsp?'>"%><%
        
        
        String StrCalle = "";
        String StrColonia = "";
        String StrClaveAMIS = "";
        String StrdsEntFed = "";
        String StrdsMunDel = "";
        
        if (rs.next())
        {
            
            StrCalle = rs.getString("CalleNum");
            if (StrCalle==null)
            {
                StrCalle="";
            }
            
            StrColonia = rs.getString("Colonia");
            if (StrColonia==null)
            {
                StrColonia="";
            }
            
            StrClaveAMIS = rs.getString("ClaveAMIS");
            if (StrClaveAMIS==null)
            {
                StrClaveAMIS="";
            }
            
            StrdsEntFed =rs.getString("dsEntFed");
            if (StrdsEntFed==null)
            {
                StrdsEntFed = "";
            }
            
            StrdsMunDel =rs.getString("dsMunDel");
            if (StrdsMunDel==null)
            {
                StrdsMunDel = "";
            }
        
        %><INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
        
        <%=MyUtil.ObjComboC("Derivado de","clTipoFalla",rs.getString("dsTipoFalla"),true,true,25,80,"","Select * from cTipoFalla where DerivadoDe = 'B1' or clTipoFalla = " + rs.getString("clTipoFalla") ,"","",50,true,true)%>
        <%=MyUtil.ObjComboC("Tipo de Grua","clTipoGrua",rs.getString("dsTipoGrua"),true,true,200,80,"","Select * from cTipoGrua","","",50,true,true)%>
        <%=MyUtil.ObjInput("Modelo","Modelo",rs.getString("Modelo"),true,true,380,80,"",true,true,6,"if(this.readOnly==false){fnValMask(this,document.all.ModeloMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("Color","Color",rs.getString("Color"),true,true,440,80,"",true,true,10)%>
        <%=MyUtil.ObjInput("Patente","Placas",rs.getString("Placas"),true,true,520,80,"",true,true,8)%>
        <%=MyUtil.ObjComboC("Lugar","clLugarEvento",rs.getString("dsLugarEvento"),true,true,600,80,"","select clLugarEvento, dsLugarEvento from cLugarEvento order by dsLugarEvento","","",20,true,true)%>
        <%=MyUtil.ObjComboC("Marca de Auto","CodigoMarca",rs.getString("dsMarcaAuto"),true,true,25,120,"","select CodigoMarca, dsMarcaAuto from cMarcaAuto order by dsMarcaAuto","fnLlenaAMIS()","",50,true,true)%>
        <%=MyUtil.ObjComboC("Tipo de Auto","ClaveAMIS",rs.getString("dsTipoAuto"),true,true,200,120,"","select ClaveAmis,dsTipoAuto from cTipoAuto where ClaveAmis='" + StrClaveAMIS + "'" ,"","",50,true,true)%>
        <INPUT id='ClaveAMISVTR' name='ClaveAMISVTR' type='hidden' value='<%=StrClaveAMIS%>'>
        <%=MyUtil.DoBlock("Detalle de Grua por Colisión/Salvamento  ",-20,0)%> 
        
        <%=MyUtil.ObjComboC(i18n.getMessage("message.title.entidad"),"CodEntEX",StrdsEntFed,false,false,30,210,StrdsEntFed,"Select CodEnt, dsEntFed from cEntFed order by dsEntFed ","fnLlenaMunicipiosKM()","",40,false,false)%>
        <%=MyUtil.ObjComboC(i18n.getMessage("message.title.municipio"),"CodMDEX",StrdsMunDel,false,false,320,210,StrdsMunDel,"Select CodMD, dsMunDel from cMunDel where CodMD='" + rs.getString("CodMD") + "' and CodEnt='"+ rs.getString("CodEnt") +"' order by dsMunDel ","","",40,false,false)%>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.colonia"),"Colonia",StrColonia,true,true,30,250,"",false,false,50)%>                
        <%=MyUtil.ObjInput("Calle y Número","CalleNum",StrCalle,true,true,320,250,"",false,false,50)%>
        <%=MyUtil.ObjTextArea("Referencias Visuales","Referencias",rs.getString("Referencias"),"105","5",true,true,30,290,"",false,false)%>
        <%=MyUtil.DoBlock("Ubicación del Evento",90,50)%> 
        
        <%=MyUtil.ObjComboC(i18n.getMessage("message.title.entidad"),"CodEntDest",rs.getString("dsEntFedDest"),true,true,30,430,"","Select CodEnt, dsEntFed from cEntFed order by dsEntFed ","fnLlenaMunicipiosKMDest()","",40,true,true)%>
        <%=MyUtil.ObjComboC(i18n.getMessage("message.title.municipio"),"CodMDDest",rs.getString("dsMunDelDest"),true,true,320,430,"","Select CodMD, dsMunDel from cMunDel where CodMD='" + rs.getString("CodMDDest") + "' and CodEnt='"+ rs.getString("CodEntDest") +"' order by dsMunDel ","","",40,true,true)%>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.colonia"),"ColoniaDest",rs.getString("ColoniaDest"),true,true,30,470,"",false,false,50)%>                
        <%=MyUtil.ObjInput("Calle y Número","CalleNumDest",rs.getString("CalleNumDest"),true,true,320,470,"",false,false,50)%> 
        <%=MyUtil.ObjTextArea("Referencias Visuales","ReferenciasDest",rs.getString("ReferenciasDest"),"105","5",true,true,30,510,"",false,false)%>
        <%=MyUtil.DoBlock("Destino",90,50)%> 
        
        <%=MyUtil.ObjInput("Nombre del Ajustador","Ajustador",rs.getString("Ajustador"),true,true,30,650,"",false,false,50)%>       
        <%=MyUtil.ObjInput("Teléfono","TelAjustador",rs.getString("TelAjustador"),true,true,330,650,"",false,false,30)%>       
        <%=MyUtil.ObjInput("Póliza","NoPoliza",rs.getString("NoPoliza"),true,true,30,690,"",false,false,30)%>       
        <%=MyUtil.ObjInput("Siniestro","NoSiniestro",rs.getString("NoSiniestro"),true,true,330,690,"",false,false,30)%>       
        <%=MyUtil.DoBlock("Informe del Ajustador",80,0)%><% //Bloque ubicación de Gerencia Regional
        }
        else
        {
            
            String CodEF = "";
        %><INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
        <%=MyUtil.ObjComboC("Derivado de","clTipoFalla","",true,true,25,80,"","Select * from cTipoFalla where DerivadoDe = 'B1' ","","",50,true,true)%>
        <%=MyUtil.ObjComboC("Tipo de Grua","clTipoGrua","",true,true,200,80,"","Select * from cTipoGrua","","",50,true,true)%>
        <%=MyUtil.ObjInput("Modelo","Modelo","",true,true,380,80,"",true,true,6,"if(this.readOnly==false){fnValMask(this,document.all.ModeloMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("Color","Color","",true,true,440,80,"",true,true,10)%>
        <%=MyUtil.ObjInput("Patente","Placas","",true,true,520,80,"",true,true,8)%>
        <%=MyUtil.ObjComboC("Lugar","clLugarEvento","",true,true,600,80,"","select clLugarEvento, dsLugarEvento from cLugarEvento order by dsLugarEvento","","",20,true,true)%>
        <%=MyUtil.ObjComboC("Marca de Auto","CodigoMarca","",true,true,25,120,"","select CodigoMarca, dsMarcaAuto from cMarcaAuto","fnLlenaAMIS()","",50,true,true)%>
        <%=MyUtil.ObjComboC("Tipo de Auto","ClaveAMIS","",true,true,200,120,"","select ClaveAmis,dsTipoAuto from cTipoAuto where ClaveAmis='0'" ,"","",50,true,true)%>
        <INPUT id='ClaveAMISVTR' name='ClaveAMISVTR' type='hidden' value=''>
        <%=MyUtil.DoBlock("Detalle de Grua por Colisión/Salvamento  ",-20,0)%>
        
        <%=MyUtil.ObjComboC(i18n.getMessage("message.title.entidad"),"CodEntEX",rs2.getString("dsEntFed"),false,false,30,210,"","Select CodEnt, dsEntFed from cEntFed order by dsEntFed ","","",40,false,false)%>
        <%=MyUtil.ObjComboC(i18n.getMessage("message.title.municipio"),"CodMDEX",rs2.getString("dsMunDel"),false,false,320,210,"","Select CodMD, dsMunDel from cMunDel where CodMD='" + rs2.getString("CodMD") + "' and CodEnt='" + rs2.getString("CodEnt") + "' order by dsMunDel ","","",40,false,false)%>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.colonia"),"Colonia","",true,true,30,250,"",false,false,50)%>                
        <%=MyUtil.ObjInput("Calle y Número","CalleNum","",true,true,320,250,"",false,false,50)%>                
        <%=MyUtil.ObjTextArea("Referencias Visuales","Referencias","","105","5",true,true,30,290,"",false,false)%>                
        <%=MyUtil.DoBlock("Ubicación del Evento",90,50)%>  
        
        <%=MyUtil.ObjComboC(i18n.getMessage("message.title.entidad"),"CodEntDest","",true,true,30,430,"","Select CodEnt, dsEntFed from cEntFed order by dsEntFed ","fnLlenaMunicipiosKMDest()","",40,true,true)%>
        <%=MyUtil.ObjComboC(i18n.getMessage("message.title.municipio"),"CodMDDest","",true,true,320,430,"","Select CodMD, dsMunDel from cMunDel where CodMD='' and CodEnt='' order by dsMunDel ","","",40,true,true)%>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.colonia"),"ColoniaDest","",true,true,30,470,"",false,false,50)%>                
        <%=MyUtil.ObjInput("Calle y Número","CalleNumDest","",true,true,320,470,"",false,false,50)%>                
        <%=MyUtil.ObjTextArea("Referencias Visuales","ReferenciasDest","","105","5",true,true,30,510,"",false,false)%>             
        <%=MyUtil.DoBlock("Destino",90,50)%> 
        
        <%=MyUtil.ObjInput("Nombre del Ajustador","Ajustador","",true,true,30,650,"",false,false,50)%>     
        <%=MyUtil.ObjInput("Teléfono","TelAjustador","",true,true,330,650,"",false,false,30)%>       
        <%=MyUtil.ObjInput("Póliza","NoPoliza","",true,true,30,690,"",false,false,30)%>      
        <%=MyUtil.ObjInput("Siniestro","NoSiniestro","",true,true,330,690,"",false,false,30)%>      
        <%=MyUtil.DoBlock("Informe del Ajustador",90,0)%><% //Bloque ubicación de Gerencia Regional
        
        }
        session.setAttribute("Calle",StrCalle);
        session.setAttribute("Colonia",StrColonia);
        %><%=MyUtil.GeneraScripts()%><%
        rs2.close();
        rs.close();
        rs2=null;
        rs=null;
        StrSql=null;
        strclUsr = null;
        StrclExpediente = null;
        StrCalle = null;
        StrColonia = null;
        StrClaveAMIS = null;
        StrdsEntFed = null;
        StrdsMunDel = null;
        StrclPaginaWeb=null;
        
        
        %>
        <input name='ModeloMsk' id='ModeloMsk' type='hidden' value='VN09VN09VN09VN09'>
        <script>document.all.Modelo.maxLength=4;</script>
        
        
    </body>
</html>
