<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
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
        String StrclExpediente = "0";
        String strclUsr = "0";
        
        
        
        if (session.getAttribute("clUsrApp")!= null)
        {
            strclUsr = session.getAttribute("clUsrApp").toString();
        }
        
        if (session.getAttribute("clExpediente")!= null)
        {
            StrclExpediente = session.getAttribute("clExpediente").toString();
        }
        
        StringBuffer StrSql = new StringBuffer();
        // checar si ya existe asistencia para el expediente, si existe, ya no procede la alta
        StrSql.append(" Select exped.TieneAsistencia, ");
        StrSql.append(" EXPED.CodEnt, E.dsEntFed, EXPED.CodMD, D.dsMunDel ");
        StrSql.append(" From Expediente EXPED");
        StrSql.append(" LEFT JOIN cEntFed E ON(E.CodEnt = EXPED.CodEnt) ");
        StrSql.append(" LEFT JOIN cMunDel D ON(E.CodEnt = D.CodEnt and D.CodMD=EXPED.CodMD) ");
        StrSql.append(" Where clExpediente=").append(StrclExpediente);
        
        ResultSet rs2 = UtileriasBDF.rsSQLNP( StrSql.toString());
        StrSql.delete(0,StrSql.length());
        
        if (rs2.next())
        {
            StrSql.append(" select ");
            StrSql.append(" coalesce(A.CalleNum,'') CalleNum, ");
            StrSql.append(" coalesce(A.Colonia,'') Colonia , ");
            StrSql.append(" A.ClaveAMIS,");
            StrSql.append(" E.dsEntFed,");
            StrSql.append(" D.dsMunDel ,");
            StrSql.append(" EXPED.CodMD, ");
            StrSql.append(" EXPED.CodEnt , ");
            StrSql.append(" cast(A.Referencias as varchar(8000)) Referencias, ");
            StrSql.append(" M.dsMarcaAuto, ");
            StrSql.append(" T.dsTipoAuto,");
            StrSql.append(" A.Modelo,");
            StrSql.append(" A.Color,");
            StrSql.append(" A.Placas,");
            StrSql.append(" LE.dsLugarEvento");
            StrSql.append(" FROM Expediente EXPED ");
            StrSql.append(" INNER JOIN AsistenciaKM0 A on (A.clExpediente = EXPED.clExpediente)");
            StrSql.append(" INNER JOIN cLugarEvento LE on (A.clLugarEvento = LE.clLugarEvento) ");
            StrSql.append(" LEFT JOIN CMARCAAUTO M ON(M.CodigoMarca=A.CodigoMarca) ");
            StrSql.append(" LEFT JOIN CTIPOAUTO  T ON(T.ClaveAMIS=A.ClaveAMIS) ");
            StrSql.append(" LEFT JOIN cEntFed E ON(E.CodEnt = EXPED.CodEnt) ");
            StrSql.append(" LEFT JOIN cMunDel D ON(E.CodEnt = D.CodEnt and D.CodMD=EXPED.CodMD) ");
            StrSql.append(" LEFT JOIN cEntFed EFD ON(EFD.CodEnt = A.CodEntDest) ");
            StrSql.append(" LEFT JOIN cMunDel DD ON(EFD.CodEnt = DD.CodEnt and DD.CodMD=A.CodMDDest) ");
            StrSql.append(" Where exped.clExpediente= ").append(StrclExpediente);
        }
        else
        {%>
        El expediente no existe
        <%
        rs2.close();
        rs2=null;
        
        StrclExpediente = null;
        strclUsr = null;
        StrSql =null;
        return;
        }
        String StrclPaginaWeb = "199";
        session.setAttribute("clPaginaWebP",StrclPaginaWeb);
        %>
        <script>fnOpenLinks()</script>
        <%
        MyUtil.InicializaParametrosC(199,Integer.parseInt(strclUsr)); 
        %>
        <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist","")%>
        <%
        if(rs2.getString("TieneAsistencia").compareToIgnoreCase("1")==0)
        {%>
        <script>document.all.btnAlta.disabled=true;</script>
        <%
        }
        else
        {%>
        <script>document.all.btnCambio.disabled=true;</script>
        <%
        }
        
        
        ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
        StrSql.delete(0,StrSql.length());
        %>
        
        <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="CambioLlanta.jsp?'>"%>
        
        <%
        String StrCalle = "";
        String StrColonia = "";
        String StrClaveAMIS = "";
        String StrdsEntFed = "";
        String StrdsMunDel = "";
        
        if (rs.next())
        {
            StrCalle =rs.getString("CalleNum");
            if (StrCalle==null)
            {
                StrCalle = "";
            }
            
            StrColonia =rs.getString("Colonia");
            if (StrColonia==null)
            {
                StrColonia = "";
            }
            
            StrClaveAMIS =rs.getString("ClaveAMIS");
            if (StrClaveAMIS==null)
            {
                StrClaveAMIS = "";
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
        %>
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
        <%=MyUtil.ObjComboC(i18n.getMessage("message.title.entidad"),"CodEntEX",StrdsEntFed,false,false,30,80,StrdsEntFed,"Select CodEnt, dsEntFed from cEntFed order by dsEntFed ","fnLlenaMunicipiosKM()","",40,false,false)%>
        <%=MyUtil.ObjComboC(i18n.getMessage("message.title.municipio"),"CodMDEX",StrdsMunDel,false,false,320,80,StrdsMunDel,"Select CodMD, dsMunDel from cMunDel where CodMD='" + rs.getString("CodMD") + "' and CodEnt='"+ rs.getString("CodEnt") +"' order by dsMunDel ","","",40,false,false)%>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.colonia"),"Colonia",StrColonia,true,true,30,130,"",false,false,50)%>
        <%=MyUtil.ObjInput("Calle y Número","CalleNum",StrCalle,true,true,320,130,"",false,false,50)%>
        <%=MyUtil.ObjTextArea("Referencias Visuales","Referencias",rs.getString("Referencias"),"105","5",true,true,30,180,"",false,false)%>
        <%=MyUtil.DoBlock("Ubicación del Evento",90,50)%>
        
        <%=MyUtil.ObjComboC("Marca de Auto","CodigoMarca",rs.getString("dsMarcaAuto"),true,true,30,320,"","select CodigoMarca, dsMarcaAuto from cMarcaAuto order by dsMarcaAuto","fnLlenaAMIS()","",50,true,true)%>
        <%=MyUtil.ObjComboC("Tipo de Auto","ClaveAMIS",rs.getString("dsTipoAuto"),true,true,200,320,"","select ClaveAmis,dsTipoAuto from cTipoAuto where ClaveAmis='" + StrClaveAMIS + "'" ,"","",50,true,true)%>
        <INPUT id='ClaveAMISVTR' name='ClaveAMISVTR' type='hidden' value='<%=StrClaveAMIS%>'>
        <%=MyUtil.ObjInput("Modelo","Modelo",rs.getString("Modelo"),true,true,30,370,"",true,true,8,"if(this.readOnly==false){fnValidaModelo(this)}")%>
        <%=MyUtil.ObjInput("Color","Color",rs.getString("Color"),true,true,200,370,"",true,true,10)%>
        <%=MyUtil.ObjInput("Placas","Placas",rs.getString("Placas"),true,true,300,370,"",true,true,8)%>
        <%=MyUtil.ObjComboC("Lugar","clLugarEvento",rs.getString("dsLugarEvento"),true,true,400,370,"","select clLugarEvento, dsLugarEvento from cLugarEvento order by dsLugarEvento","","",20,true,true)%>
        <%=MyUtil.DoBlock("Detalle de Auxilio Vial",140,0)%>
        <%
        }
        else
        {
            String CodEF = "";
        %>
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
        <%=MyUtil.ObjComboC(i18n.getMessage("message.title.entidad"),"CodEntEX",rs2.getString("dsEntFed"),false,false,30,80,"","Select CodEnt, dsEntFed from cEntFed order by dsEntFed ","","",40,false,false)%>
        <%=MyUtil.ObjComboC(i18n.getMessage("message.title.municipio"),"CodMDEX",rs2.getString("dsMunDel"),false,false,320,80,"","Select CodMD, dsMunDel from cMunDel where CodMD='" + rs2.getString("CodMD") + "' and CodEnt='" + rs2.getString("CodEnt") + "' order by dsMunDel ","","",40,false,false)%>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.colonia"),"Colonia","",true,true,30,130,"",false,false,50)%>
        <%=MyUtil.ObjInput("Calle y Número","CalleNum","",true,true,320,130,"",false,false,50)%>
        <%=MyUtil.ObjTextArea("Referencias Visuales","Referencias","","105","5",true,true,30,180,"",false,false)%>
        <%=MyUtil.DoBlock("Ubicación del Evento",90,50)%>
        
        <%=MyUtil.ObjComboC("Marca de Auto","CodigoMarca","",true,true,30,320,"","select CodigoMarca, dsMarcaAuto from cMarcaAuto","fnLlenaAMIS()","",50,true,true)%>
        <%=MyUtil.ObjComboC("Tipo de Auto","ClaveAMIS","",true,true,200,320,"","select ClaveAmis,dsTipoAuto from cTipoAuto where ClaveAmis='0'" ,"","",50,true,true)%>
        <INPUT id='ClaveAMISVTR' name='ClaveAMISVTR' type='hidden' value=''>
        <%=MyUtil.ObjInput("Modelo","Modelo","",true,true,30,370,"",true,true,8,"if(this.readOnly==false){fnValidaModelo(this)}")%>
        <%=MyUtil.ObjInput("Color","Color","",true,true,200,370,"",true,true,10)%>
        <%=MyUtil.ObjInput("Placas","Placas","",true,true,300,370,"",true,true,8)%>
        <%=MyUtil.ObjComboC("Lugar","clLugarEvento","",true,true,400,370,"","select clLugarEvento, dsLugarEvento from cLugarEvento order by dsLugarEvento","","",20,true,true)%>
        <%=MyUtil.DoBlock("Detalle de Auxilio Vial",140,0)%>
        
        <%
        
        }
        session.setAttribute("Calle",StrCalle);
        session.setAttribute("Colonia",StrColonia);
        %>
        <%=MyUtil.GeneraScripts()%>
        <%        
        rs2.close();
        rs.close();
        rs2=null;
        rs=null;
        StrclExpediente = null;
        strclUsr = null;
        StrSql =null;
        StrCalle = null;
        StrColonia = null;
        StrClaveAMIS = null;
        StrdsEntFed = null;
        StrdsMunDel = null;
        
        %>
        <script>
document.all.Modelo.maxLength=4;
document.all.Placas.maxLength=8; 
        </script>
    </body>
</html>


