<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head><title>Recuperación de Daños</title>
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



            if (session.getAttribute("clUsrApp")!= null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();
            }

            if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {
        %><%="Fuera de Horario"%><%
            StrclUsrApp=null;
            return;
                }
                String StrclExpediente = "0";
                String StrclPaginaWeb="0";
                String StrclRecupera="0";
                String StrFecha = "";

                if (session.getAttribute("clExpediente")!= null) {
                    StrclExpediente = session.getAttribute("clExpediente").toString();
                }

                if (request.getParameter("clRecuperaDanos")!= null) {
                    StrclRecupera= request.getParameter("clRecuperaDanos").toString();
                }

                StringBuffer Strsql = new StringBuffer();
                Strsql.append("Select clExpediente From AsistenciaLegal Where clExpediente =").append(StrclExpediente);

                ResultSet rs2 = UtileriasBDF.rsSQLNP( Strsql.toString());
                Strsql.delete(0,Strsql.length());

                if (rs2.next()) {
                    // bien, si existe!!!
                } else {
        %><%="No existe Aistencia Legal, debe crearla primero!"%><%
            rs2.close();
            rs2=null;
            StrclExpediente = null;
            StrclPaginaWeb=null;
            StrclRecupera=null;
            StrFecha = null;
            StrclUsrApp=null;
            return;
            }

            Strsql.append("Select convert(varchar(16),getdate(),120) fechaEt ");
            ResultSet rs4 = UtileriasBDF.rsSQLNP( Strsql.toString());
            Strsql.delete(0,Strsql.length());

            if (rs4.next()){
                StrFecha = rs4.getString("fechaEt");
            }
            Strsql.append("Select ");
            Strsql.append(" R.clRecuperaDanos, ");
            Strsql.append(" R.MontoEfectivo, ");
            Strsql.append(" R.MontoOrdRep, ");
            Strsql.append(" R.MontoPasMed, ");
            Strsql.append(" R.MontoCheque, ");
            Strsql.append(" MontoPagare, ");
            Strsql.append(" MontoGaran, ");
            Strsql.append(" R.Folio, ");
            Strsql.append(" (R.MontoEfectivo+R.MontoOrdRep+R.MontoPasMed+R.MontoCheque+MontoPagare+MontoGaran) as MontoRecuperadoVTR, ");
            Strsql.append(" coalesce(Porcentaje,0) as Porcentaje, ");

            Strsql.append(" coalesce(PR.dsPersonaRecupera,'') as dsPersonaRecupera, ");
            Strsql.append(" P.NombreOpe 'dsProveedor',");
            Strsql.append(" coalesce(R.Personal,'') 'Personal', ");
            Strsql.append(" coalesce(convert(varchar(16), R.FechaRecupera,120),'') as FechaRecupera, ");
            Strsql.append(" coalesce(convert(varchar(16), R.FechaIngAseg,120),'') as FechaIngAseg, ");
            Strsql.append(" coalesce (convert(varchar(16),R.FechaRegRecup,120),'') as FechaRegRecup, ");
            Strsql.append(" coalesce(R.Observaciones,'') as Observaciones, coalesce (MR.dsMedioRecuperaDanos,'') as dsMedioRecuperaDanos ");
            //Strsql.append(" R.FormaRecupera ");
            Strsql.append(" From RecuperaDanos R ");
            Strsql.append(" Left Join cPersonaRecupera PR ON (PR.clPersonaRecupera = R.clPersonaRecupera) ");

            Strsql.append( " Left Join cMedioRecuperaDanos MR on (R.clMedioRecuperaDanos=MR.clMedioRecuperaDanos) ");
            Strsql.append(" Inner Join cProveedor P ON(P.clProveedor=R.clProveedor) ");
            Strsql.append(" Where R.clRecuperaDanos =").append(StrclRecupera);

            ResultSet rs = UtileriasBDF.rsSQLNP( Strsql.toString());
            Strsql.delete(0,Strsql.length());

        %><script>fnOpenLinks()</script>

        <%StrclPaginaWeb = "192";
            MyUtil.InicializaParametrosC(192,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina

            session.setAttribute("clPaginaWebP",StrclPaginaWeb);

        %><%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionRecupera","")%>
        <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="RecuperaDanos.jsp?'>"%><%

            if (rs.next()) {

        %><INPUT id='clRecuperaDanos' name='clRecuperaDanos' type='hidden' value='<%=rs.getString("clRecuperaDanos")%>'>
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>       

        <%=MyUtil.ObjInput("Monto <br>Efectivo","MontoEfectivo",rs.getString("MontoEfectivo"),true,true,30,70,"0",false,false,15,"fnActualizaMontos(document.all.MontoEfectivo)")%>
        <%=MyUtil.ObjInput("Monto Orden <br>Reparación","MontoOrdRep",rs.getString("MontoOrdRep"),true,true,130,70,"0",false,false,15,"fnActualizaMontos(document.all.MontoOrdRep)")%>             
        <%=MyUtil.ObjInput("Monto Pase <br>Médico","MontoPasMed",rs.getString("MontoPasMed"),true,true,230,70,"0",false,false,15,"fnActualizaMontos(document.all.MontoPasMed)")%>            
        <%=MyUtil.ObjInput("Monto <br>Cheque","MontoCheque",rs.getString("MontoCheque"),true,true,330,70,"0",false,false,15,"fnActualizaMontos(document.all.MontoCheque)")%>           
        <%=MyUtil.ObjInput("Monto <br>Pagaré","MontoPagare",rs.getString("MontoPagare"),true,true,430,70,"0",false,false,15,"fnActualizaMontos(document.all.MontoPagare)")%>             
        <%=MyUtil.ObjInput("Monto <br>Garantías","MontoGaran",rs.getString("MontoGaran"),true,true,530,70,"0",false,false,15,"fnActualizaMontos(document.all.MontoGaran)")%>             
        
        <%=MyUtil.ObjInput("Folio","Foliox",rs.getString("Folio"),false,false,30,120,"", false,false,5)%>            
        <%=MyUtil.ObjInput("Monto Recuperado","MontoRecuperadoVTR",rs.getString("MontoRecuperadoVTR"),false,false,90,120,"", false,false,20)%>
        <%=MyUtil.ObjInput("Porcentaje %","Porcentaje",rs.getString("Porcentaje"),true,true,260,120,"",false,false,5,"fnRango(document.all.Porcentaje,0,100)")%>
        
        <%=MyUtil.ObjComboC("Persona que Recupera", "clPersonaRecupera",rs.getString("dsPersonaRecupera"),true,true,30,160,"","Select clPersonaRecupera, dsPersonaRecupera From cPersonaRecupera","","",40,true,true)%>                      
        <%=MyUtil.ObjComboC("Proveedor Jurídico", "clProveedor",rs.getString("dsProveedor"),true,true,200,160,"","sp_LlenaComboProvxExp " + StrclExpediente,"","",100,true,true)%>                      
        <%=MyUtil.ObjInput("Abogado que Recupera","Personal",rs.getString("Personal"),true,true,500,160,"", false,false,40)%>           
        <%=MyUtil.ObjInput("Fecha de Registro de Recuperación<br>(AAAA/MM/DD HH:MM)","FechaRecuperax",rs.getString("FechaRecupera"),false,false,30,200,rs4.getString("fechaEt"),false,false,25)%>                     
        <%=MyUtil.ObjInput("Fecha de Ingreso a la Aseguradora<br>(AAAA/MM/DD HH:MM)","FechaIngAseg",rs.getString("FechaIngAseg"),true,true,270,200,"",false,false,25,"if(this.readOnly==false){fnValMask(this,document.all.FechaIngAsegMsk.value,this.name)}")%>                                       
        <%=MyUtil.ObjInput("Fecha de Recuperación<br>(AAAA/MM/DD HH:MM)","FechaRegRecup",rs.getString("FechaRegRecup"),true,true,520,200,"",false,false,25,"if(this.readOnly==false){fnValMask(this,document.all.FechaIngAsegMsk.value,this.name)}")%>                                               
        <%=MyUtil.ObjTextArea("Observaciones","Observaciones",rs.getString("Observaciones"),"90","5",true,true,30,250,"",false,false)%>
        <%=MyUtil.ObjComboC("Medio de Recuperación", "clMedioRecuperaDanos",rs.getString("dsMedioRecuperaDanos"),true,true,520,250,"","Select clMedioRecuperaDanos, dsMedioRecuperaDanos From cMedioRecuperaDanos","","",40,true,true)%>                      
        <%              
            } else {
        %><INPUT id='clRecuperaDanos' name='clRecuperaDanos' type='hidden' value='<%=StrclRecupera%>'>                     
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>                
   
        <%=MyUtil.ObjInput("Monto <br>Efectivo","MontoEfectivo","",true,true,30,70,"0",false,false,15,"fnActualizaMontos(document.all.MontoEfectivo)")%>             
        <%=MyUtil.ObjInput("Monto Orden <br>Reparación","MontoOrdRep","",true,true,130,70,"0",false,false,15,"fnActualizaMontos(document.all.MontoOrdRep)")%>            
        <%=MyUtil.ObjInput("Monto Pase <br>Médico","MontoPasMed","",true,true,230,70,"0",false,false,15,"fnActualizaMontos(document.all.MontoPasMed)")%>             
        <%=MyUtil.ObjInput("Monto <br>Cheque","MontoCheque","",true,true,330,70,"0",false,false,15,"fnActualizaMontos(document.all.MontoCheque)")%>            
        <%=MyUtil.ObjInput("Monto <br>Pagaré","MontoPagare","",true,true,430,70,"0",false,false,15,"fnActualizaMontos(document.all.MontoPagare)")%>            
        <%=MyUtil.ObjInput("Monto <br>Garantías","MontoGaran","",true,true,530,70,"0",false,false,15,"fnActualizaMontos(document.all.MontoGaran)")%>            
        
        <%=MyUtil.ObjInput("Folio","Foliox","",false,false,30,120,"", false,false,5)%>            
        <%=MyUtil.ObjInput("Monto Recuperado","MontoRecuperadoVTR","",false,false,90,120,"", false,false,20)%>
        <%=MyUtil.ObjInput("Porcentaje %","Porcentaje","",true,true,240,120,"",false,false,5,"fnRango(document.all.Porcentaje,0,100)")%>
        
        <%=MyUtil.ObjComboC("Persona que Recupera", "clPersonaRecupera","",true,true,30,160,"","Select clPersonaRecupera, dsPersonaRecupera From cPersonaRecupera","","",40,true,true)%>                      
        <%=MyUtil.ObjComboC("Proveedor Jurídico", "clProveedor","",true,true,200,160,"","sp_LlenaComboProvxExp " + StrclExpediente,"","",100,true,true)%>                      
        <%=MyUtil.ObjInput("Abogado que Recupera","Personal","",true,true,500,160,"", false,false,40)%>           
        <%=MyUtil.ObjInput("Fecha de Registro Recuperación<br>(AAAA/MM/DD HH:MM)","FechaRecuperax","",false,false,30,200,rs4.getString("fechaEt"),false,false,25)%>                      
        <%=MyUtil.ObjInput("Fecha de Ingreso a la Aseguradora<br>(AAAA/MM/DD HH:MM)","FechaIngAseg","",true,true,270,200,"",false,false,25,"if(this.readOnly==false){fnValMask(this,document.all.FechaIngAsegMsk.value,this.name)}")%>                                       
        <%=MyUtil.ObjInput("Fecha de Recuperación<br>(AAAA/MM/DD HH:MM)","FechaRegRecup","",true,true,520,200,"",false,false,25,"if(this.readOnly==false){fnValMask(this,document.all.FechaIngAsegMsk.value,this.name)}")%>                                       
        <%=MyUtil.ObjTextArea("Observaciones","Observaciones","","90","5",true,true,30,250,"",false,false)%>
        <%=MyUtil.ObjComboC("Medio de Recuperación", "clMedioRecuperaDanos","",true,true,520,250,"","Select clMedioRecuperaDanos, dsMedioRecuperaDanos From cMedioRecuperaDanos","","",40,true,true)%>                      
        <%             

                }
        %><%=MyUtil.DoBlock("Recuperación de Daños",0,40)%>   
        <%=MyUtil.GeneraScripts()%>
        
        <div id="boton" style="position:absolute;width:250px;left:400;top:17;visibility:visible">                               
            <input type="button" value="Imprimir..." class="cBtn" onclick="location.href='ImpresionRecuperacionDanos.jsp?clRecuperaDanos=<%=StrclRecupera%>&clExpediente=<%=StrclExpediente%>'">            
        </div>
        
        <%   
            rs4.close();
            rs2.close();
            rs.close();
            rs4=null;
            rs2=null;
            rs=null;
            StrclExpediente = null;
            Strsql = null;
            StrclPaginaWeb=null;
            StrclRecupera=null;
            StrFecha = null;
            StrclUsrApp=null;

        %>
        <input name='FechaIngAsegMsk' id='FechaIngAsegMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>

        <script>
           
            function fnActualizaMontos(Campo){  
            if (isNaN(Campo.value)==true || Campo.value=='')
            {
            alert(Campo.name + ' debe ser numérico');
            Campo.value="0";
            } 
            document.all.MontoRecuperadoVTR.value=0;
            document.all.MontoRecuperadoVTR.value = eval(document.all.MontoEfectivo.value) + eval(document.all.MontoOrdRep.value) + eval(document.all.MontoPasMed.value) + eval(document.all.MontoCheque.value) + eval(document.all.MontoPagare.value) + eval(document.all.MontoGaran.value);
            }	
     
        </script>
    </body>
</html>
