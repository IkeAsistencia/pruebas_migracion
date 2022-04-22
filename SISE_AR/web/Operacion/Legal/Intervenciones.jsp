<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head><title>Intervenciones</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
            <style type="text/css">
                .Mensaje {
                font-family: Verdana, Arial, Helvetica, sans-serif;
                color: #FFFFFF;
                font-size: 12px;
                background-color: #000080
                }
                .Titulo {
                background-color: #e6f2f9;
                border: 2px solid #000066;
                }
            </style>
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
        %>Fuera de Horario<%
            StrclUsrApp=null;

            return;
                }
                String StrclExpediente = "0";
                String StrclIntervencion = "0";
                String StrclPaginaWeb="0";
                String StrFecha = "";

                if (session.getAttribute("clExpediente")!= null) {
                    StrclExpediente = session.getAttribute("clExpediente").toString();
                }

                if (request.getParameter("clIntervencion")!= null) {
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
                StrSql.append(" coalesce(convert(varchar(16), I.FechaTentativa,120),'') as FechaTentativa, ");                
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

            StrclPaginaWeb = "194";
            MyUtil.InicializaParametrosC(194,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina

            session.setAttribute("clPaginaWebP",StrclPaginaWeb);

        %><%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccion","")%>
        <INPUT id='numCar' name='numCar' type='hidden' value='0'>
        <INPUT id='EstatusText' name='EstatusText' type='hidden' value='0'>
        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="Intervenciones.jsp?'>"%><%
           
            if (rs.next()) {
                    // El siguiente campo llave no se mete con MyUtil.ObjInput
        %>
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
            
        <%=MyUtil.ObjTextArea("¿Que Hice?","QueHice",rs.getString("QueHice"), "100","4",true,true,200,160,"",true,true,"textCounter(document.forma.remLen,190);","textCounter(document.forma.remLen,190);")%>                       
        <%=MyUtil.ObjInput("Fecha de Prox Tram<br>(aaaa/mm/dd hh:mm)","FechaProxTramite",rs.getString("FechaProxTramite"),true,true,30,240,"",false,false,22,"if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)}")%>                            
        <%=MyUtil.ObjInput("Fecha tentativa de conclusión<br>(aaaa/mm/dd hh:mm)","FechaTentativa",rs.getString("FechaTentativa"),true,true,30,320,"",false,false,22,"if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)}")%>
        <%=MyUtil.ObjTextArea("¿Para Que Lo Hice?","ParaQueHice",rs.getString("ParaQueHice"), "100","4",true,true,200,240,"",true,true,"textCounter(document.forma.remLen,190);","textCounter(document.forma.remLen,190);")%>           
        <%=MyUtil.ObjTextArea("¿Que Resultado Obtuve?","ResultadoObtuve",rs.getString("ResultadoObtuve"), "100","4",true,true,200,320,"",true,true,"textCounter(document.forma.remLen,190);","textCounter(document.forma.remLen,190);")%>
        <%=MyUtil.ObjTextArea("¿Que Sucedera Despues?","SucederaDespues",rs.getString("SucederaDespues"), "100","4",true,true,200,400,"",true,true,"textCounter(document.forma.remLen,190);","textCounter(document.forma.remLen,190);")%>
        <%=MyUtil.ObjInput("","remLen","0",false,false,200,460,"",false,false,4)%>
        <div class='VTable' style='position:absolute; z-index:3; left:235px; top:478px;'>
            CARACTERES
        </div>
        <%
                } else {
        %><script>document.all.btnCambio.disabled=true;</script>
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
        <%=MyUtil.ObjInput("Fecha tentativa de conclusión<br>(aaaa/mm/dd hh:mm)","FechaTentativa","",true,true,30,320,"",false,false,22,"if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)}")%>            
        <%=MyUtil.ObjTextArea("¿Que Hice?","QueHice","", "100","4",true,true,200,160,"",true,true,"textCounter(document.forma.remLen,190);","textCounter(document.forma.remLen,190);")%>           
        <%=MyUtil.ObjInput("Fecha de Prox Tram<br>(aaaa/mm/dd hh:mm)","FechaProxTramite","",true,true,30,240,"",false,false,22,"if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)}")%>                                        
        <%=MyUtil.ObjTextArea("¿Para Que Lo Hice?","ParaQueHice","", "100","4",true,true,200,240,"",true,true,"textCounter(document.forma.remLen,190);","textCounter(document.forma.remLen,190);")%>           
        <%=MyUtil.ObjTextArea("¿Que Resultado Obtuve?","ResultadoObtuve","", "100","4",true,true,200,320,"",true,true,"textCounter(document.forma.remLen,190);","textCounter(document.forma.remLen,190);")%>
        <%=MyUtil.ObjTextArea("¿Que Sucedera Despues?","SucederaDespues","", "100","4",true,true,200,400,"",true,true,"textCounter(document.forma.remLen,190);","textCounter(document.forma.remLen,190);")%>
        <%=MyUtil.ObjInput("","remLen","0",false,false,200,460,"",false,false,4)%> 
        <div class='VTable' style='position:absolute; z-index:3; left:235px; top:478px;'>
            CARACTERES
        </div>        
        <%
                    }   %>
        <%=MyUtil.DoBlock("Detalle de Intervención",200,0)%>
        <%=MyUtil.GeneraScripts()%>
       
        <div name="M1" id="M1" class='Mensaje' style='position:absolute; z-index:31; left:740px; top:175px; visibility:hidden;border-style:outset ;border-width:medium ;width:240px; height:100px;' align="center">
            <p class='cssTitDet'>Aviso</p>El texto es demasiado grande, se enviara en dos mensajes.            
        </div>
        <div name="M2" id="M2" class='Mensaje' style='position:absolute; z-index:31; left:740px; top:300px; visibility:hidden;border-style:outset ;border-width:medium ;width:240px; height:100px;' align="center">
            <p class='cssTitDet'>Aviso</p>El mensaje es demasiado largo, unicamente se enviaran 190 caracteres.
        </div>
        <%    
            rs4.close();
            rs.close();
            rs4=null;
            rs=null;
            StrclExpediente = null;
            StrclIntervencion = null;
            StrSql = null;
            StrclPaginaWeb=null;
            StrFecha = null;
            StrclUsrApp=null;

        %>
        <input name='FechaMsk' id='FechaMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
        <SCRIPT language="JavaScript" type="text/javascript">
        document.all.QueHice.maxLength=500;
        document.all.ParaQueHice.maxLength=500;
        document.all.ResultadoObtuve.maxLength=500;   
        document.all.SucederaDespues.maxLength=500; 
        
        textCounter(document.forma.remLen,190);        
        
        function textCounter(countfield,maxlimit) {

            document.forma.numCar.value = '0';
            countfield.value ='0';
            document.forma.numCar.value =  parseInt(document.forma.numCar.value) + document.forma.QueHice.value.length+document.forma.ParaQueHice.value.length +document.forma.ResultadoObtuve.value.length+document.forma.SucederaDespues.value.length;                                                          
            countfield.value = parseInt(countfield.value) + parseInt(document.forma.numCar.value);              
            
            if (parseInt(document.forma.numCar.value) <= 43 )
                Oculta(document.all.M1);                           
            if (parseInt(document.forma.numCar.value) <= maxlimit)
                Oculta(document.all.M2);
            
            if (parseInt(document.forma.numCar.value) > 43 )
                Visible(document.all.M1);
            if (parseInt(document.forma.numCar.value) > maxlimit )
                Visible(document.all.M2);
                       
        }
        
        function Visible(me){
           if (me.style.visibility=="hidden"){
               me.style.visibility="visible";
           }
        } 
        
        function Oculta(me){
           if (me.style.visibility=="visible"){
               me.style.visibility="hidden";
           }
        }
        </script>
    </body>
</html>


